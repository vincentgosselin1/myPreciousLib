// dma_stream_sg.c — run on Versal PS (Linux)
// v2 (reference skeleton): AXI DMA Scatter-Gather mode with a descriptor
// ring, so the PL counter can stream continuously into DDR4 without the
// CPU re-arming a single-shot transfer for every burst (as in v1's
// Simple mode). The CPU trails behind, reading completed descriptors'
// buffers and streaming them to the PC, then recycling those descriptors
// back onto the ring.
//
// IMPORTANT: Register offsets and descriptor field layout below follow
// the Xilinx/AMD AXI DMA product guide (PG021) for the S2MM (device-to-
// memory) channel in Scatter-Gather mode. Field widths/bit positions can
// vary slightly by IP version/config — cross-check PG021 for your exact
// AXI DMA core version before relying on this in the lab. This file is a
// reference skeleton to build and debug from, not a drop-in final driver.

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <arpa/inet.h>

// ---- Memory map ------------------------------------------------------

#define DMA_BASE_ADDR     0xA0010000UL   // AXI DMA AXI-Lite base
#define DMA_MAP_SIZE      0x1000

// Reserved DDR4 region (see system-user.dtsi) split into:
//   - a descriptor ring
//   - N_DESC data buffers, one per descriptor
#define REGION_PHYS_BASE  0x60000000UL
#define REGION_SIZE       0x10000000UL   // 256MB total reserved

#define N_DESC            64             // ring depth
#define BURST_LEN         256            // samples per descriptor/burst
#define BURST_BYTES       (BURST_LEN * 4)

#define DESC_SIZE         0x40           // 64B aligned, per PG021
#define DESC_RING_BYTES   (N_DESC * DESC_SIZE)
#define DATA_REGION_BASE  (REGION_PHYS_BASE + DESC_RING_BYTES)

// ---- S2MM SGDMA register offsets (PG021) ------------------------------

#define S2MM_DMACR        0x30   // control
#define S2MM_DMASR        0x34   // status
#define S2MM_CURDESC      0x38   // current descriptor pointer (lower 32b)
#define S2MM_CURDESC_MSB  0x3C
#define S2MM_TAILDESC     0x48   // tail descriptor pointer (lower 32b)
#define S2MM_TAILDESC_MSB 0x4C

#define DMACR_RS          (1 << 0)   // run/stop
#define DMACR_RESET       (1 << 2)
#define DMASR_HALTED      (1 << 0)
#define DMASR_IOC_IRQ     (1 << 12)
#define DMASR_ERR_IRQ     (1 << 14)

// ---- SG descriptor layout (64B, PG021 Table 2-x for S2MM) -------------
// Offsets within each descriptor:
//   0x00 NXTDESC       (next descriptor address, lower 32b)
//   0x04 NXTDESC_MSB
//   0x08 BUFFER_ADDRESS (lower 32b)
//   0x0C BUFFER_ADDRESS_MSB
//   0x10 reserved
//   0x14 reserved
//   0x18 CONTROL        [25:0] buffer length in bytes
//   0x1C STATUS         [31] complete, [30] decode err, [29] slave err,
//                        [28] internal err, [25:0] transferred length
typedef struct __attribute__((packed)) {
    uint32_t nxtdesc;
    uint32_t nxtdesc_msb;
    uint32_t buffer_address;
    uint32_t buffer_address_msb;
    uint32_t reserved0;
    uint32_t reserved1;
    uint32_t control;
    uint32_t status;
} sg_desc_t;

#define STATUS_CMPLT (1u << 31)

static inline void reg_write(volatile uint8_t *base, uint32_t off, uint32_t val) {
    *(volatile uint32_t *)(base + off) = val;
}
static inline uint32_t reg_read(volatile uint8_t *base, uint32_t off) {
    return *(volatile uint32_t *)(base + off);
}

#define PC_IP    "192.168.1.100"
#define PC_PORT  5000

int main(void) {
    int memfd = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd < 0) { perror("open /dev/mem"); return 1; }

    volatile uint8_t *dma_regs = mmap(NULL, DMA_MAP_SIZE, PROT_READ | PROT_WRITE,
                                       MAP_SHARED, memfd, DMA_BASE_ADDR);
    if (dma_regs == MAP_FAILED) { perror("mmap dma_regs"); return 1; }

    // Map the whole reserved region (descriptor ring + data buffers).
    // This region must be configured non-cacheable (see system-user.dtsi)
    // so PL-written data and CPU-written descriptor fields are visible
    // to both sides without manual cache maintenance.
    volatile uint8_t *region = mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE,
                                     MAP_SHARED, memfd, REGION_PHYS_BASE);
    if (region == MAP_FAILED) { perror("mmap region"); return 1; }

    volatile sg_desc_t *ring = (volatile sg_desc_t *)region;

    // Build the descriptor ring: each descriptor points to the next
    // (wrapping at N_DESC-1 -> 0) and to its own data buffer.
    for (int i = 0; i < N_DESC; i++) {
        uint32_t this_desc_phys = REGION_PHYS_BASE + i * DESC_SIZE;
        uint32_t next_desc_phys = REGION_PHYS_BASE + ((i + 1) % N_DESC) * DESC_SIZE;
        uint32_t buf_phys       = DATA_REGION_BASE + i * BURST_BYTES;

        ring[i].nxtdesc            = next_desc_phys;
        ring[i].nxtdesc_msb        = 0;
        ring[i].buffer_address     = buf_phys;
        ring[i].buffer_address_msb = 0;
        ring[i].reserved0          = 0;
        ring[i].reserved1          = 0;
        ring[i].control            = BURST_BYTES & 0x03FFFFFF;
        ring[i].status             = 0;
        (void)this_desc_phys;
    }

    // Reset S2MM channel
    reg_write(dma_regs, S2MM_DMACR, DMACR_RESET);
    usleep(1000);

    // Program current descriptor pointer to the first ring entry, then
    // start the channel, then set the tail descriptor to the LAST entry
    // we want it to process before waiting — since this is a continuous
    // ring, we set tail to the last descriptor in the ring so the engine
    // processes the whole ring once started; as we recycle descriptors
    // we advance the tail pointer to re-arm further entries.
    reg_write(dma_regs, S2MM_CURDESC, REGION_PHYS_BASE);
    reg_write(dma_regs, S2MM_CURDESC_MSB, 0);

    reg_write(dma_regs, S2MM_DMACR, DMACR_RS); // start (RS=1)

    uint32_t last_desc_phys = REGION_PHYS_BASE + (N_DESC - 1) * DESC_SIZE;
    reg_write(dma_regs, S2MM_TAILDESC, last_desc_phys);
    reg_write(dma_regs, S2MM_TAILDESC_MSB, 0);

    // TCP connect to PC
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in server = {0};
    server.sin_family = AF_INET;
    server.sin_port   = htons(PC_PORT);
    inet_pton(AF_INET, PC_IP, &server.sin_addr);
    if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0) {
        perror("connect"); return 1;
    }

    // Trail behind the DMA engine: for each descriptor in order, wait
    // until it's marked complete, drain its buffer, clear/recycle it,
    // then advance the tail pointer to re-arm it for reuse.
    char msg[32];
    int idx = 0;
    while (1) {
        while (!(ring[idx].status & STATUS_CMPLT)) {
            usleep(100); // small backoff; replace with IRQ-driven wait for production
        }

        volatile uint32_t *sample_buf =
            (volatile uint32_t *)(region + (DATA_REGION_BASE - REGION_PHYS_BASE) + idx * BURST_BYTES);

        for (int i = 0; i < BURST_LEN; i++) {
            int len = snprintf(msg, sizeof(msg), "%u\n", sample_buf[i]);
            send(sock, msg, len, 0);
        }

        // Recycle: clear status/control, then push tail pointer forward
        // by one descriptor so the engine treats this slot as available
        // again at the back of the ring.
        ring[idx].status  = 0;
        ring[idx].control = BURST_BYTES & 0x03FFFFFF;

        uint32_t this_desc_phys = REGION_PHYS_BASE + idx * DESC_SIZE;
        reg_write(dma_regs, S2MM_TAILDESC, this_desc_phys);
        reg_write(dma_regs, S2MM_TAILDESC_MSB, 0);

        idx = (idx + 1) % N_DESC;

        // Surface any DMA errors early rather than spinning silently
        uint32_t status = reg_read(dma_regs, S2MM_DMASR);
        if (status & DMASR_ERR_IRQ) {
            fprintf(stderr, "AXI DMA error, DMASR=0x%08x\n", status);
            break;
        }
    }

    close(sock);
    munmap((void *)dma_regs, DMA_MAP_SIZE);
    munmap((void *)region, REGION_SIZE);
    close(memfd);
    return 0;
}
