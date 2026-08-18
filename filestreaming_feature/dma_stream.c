// dma_stream.c — run on Versal PS (Linux)
// v1: AXI DMA Simple mode (single burst, CPU re-arms each transfer).
// Reads counter samples DMA'd into a reserved DDR4 region and streams
// them to a PC over TCP.

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <arpa/inet.h>

#define DMA_BASE_ADDR   0xA0010000UL   // AXI DMA AXI-Lite base (from Address Editor)
#define DMA_MAP_SIZE    0x1000
#define BUF_PHYS_ADDR   0x60000000UL   // matches reserved-memory node
#define BUF_SIZE        0x10000000UL   // 256MB
#define BURST_LEN       256            // must match RTL parameter
#define BURST_BYTES     (BURST_LEN * 4)

// S2MM register offsets (Xilinx AXI DMA product guide PG021)
#define S2MM_DMACR   0x30
#define S2MM_DMASR   0x34
#define S2MM_DA      0x48
#define S2MM_LENGTH  0x58

#define PC_IP    "192.168.1.100"
#define PC_PORT  5000

static inline void reg_write(volatile uint8_t *base, uint32_t off, uint32_t val) {
    *(volatile uint32_t *)(base + off) = val;
}
static inline uint32_t reg_read(volatile uint8_t *base, uint32_t off) {
    return *(volatile uint32_t *)(base + off);
}

int main(void) {
    int memfd = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd < 0) { perror("open /dev/mem"); return 1; }

    // Map DMA control registers
    volatile uint8_t *dma_regs = mmap(NULL, DMA_MAP_SIZE, PROT_READ | PROT_WRITE,
                                       MAP_SHARED, memfd, DMA_BASE_ADDR);
    if (dma_regs == MAP_FAILED) { perror("mmap dma_regs"); return 1; }

    // Map the DMA target buffer so we can read it from userspace
    volatile uint32_t *buf = mmap(NULL, BUF_SIZE, PROT_READ,
                                   MAP_SHARED, memfd, BUF_PHYS_ADDR);
    if (buf == MAP_FAILED) { perror("mmap buf"); return 1; }

    // Reset the S2MM channel, then bring it out of reset
    reg_write(dma_regs, S2MM_DMACR, 0x4);          // soft reset
    usleep(1000);
    reg_write(dma_regs, S2MM_DMACR, 0x1);          // RS = 1 (run)

    // TCP connect to PC
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in server = {0};
    server.sin_family = AF_INET;
    server.sin_port   = htons(PC_PORT);
    inet_pton(AF_INET, PC_IP, &server.sin_addr);
    if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0) {
        perror("connect"); return 1;
    }

    char msg[32];
    while (1) {
        // Arm a transfer: destination address first, length last (triggers it)
        reg_write(dma_regs, S2MM_DA, (uint32_t)BUF_PHYS_ADDR);
        reg_write(dma_regs, S2MM_LENGTH, BURST_BYTES);

        // Poll for completion (IOC_Irq, bit 12 of DMASR)
        uint32_t status;
        do {
            status = reg_read(dma_regs, S2MM_DMASR);
        } while (!(status & (1 << 12)));

        // Clear the completion flag by writing it back
        reg_write(dma_regs, S2MM_DMASR, status);

        // Buffer now holds BURST_LEN fresh counter samples — send them
        for (int i = 0; i < BURST_LEN; i++) {
            int len = snprintf(msg, sizeof(msg), "%u\n", buf[i]);
            send(sock, msg, len, 0);
        }
    }

    close(sock);
    munmap((void *)dma_regs, DMA_MAP_SIZE);
    munmap((void *)buf, BUF_SIZE);
    close(memfd);
    return 0;
}
