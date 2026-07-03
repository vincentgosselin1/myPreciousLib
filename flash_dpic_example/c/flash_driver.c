/*=============================================================================
 * flash_driver.c
 *
 * DPI-C "driver" for a Micron-style SPI NOR flash sitting behind an
 * AHB-Lite-to-SPI controller (ahb_spi_bridge.sv).
 *
 * Layering in this file:
 *   - flash_*()          Flash command layer (opcodes, address framing,
 *                         status polling). Unchanged in spirit from the
 *                         direct-SPI version of this example.
 *   - ahb_spi_*()        AHB register layer: turns "assert CS" / "send
 *                         byte, get byte back" into sv_ahb_write()/
 *                         sv_ahb_read() register pokes against
 *                         ahb_spi_bridge.sv's register map.
 *   - sv_ahb_write/read() Imported "DPI-C" tasks implemented as the AHB
 *                         agent directly inside rtl/tb_top.sv.
 *
 * c_flash_test_main() is exported "DPI-C" and is called once from
 * tb_top.sv's initial block; it exercises RDID, sector erase, page
 * program and read-back / verify -- identical test sequence to before,
 * now traveling over the AHB bus.
 *===========================================================================*/
#include <stdio.h>
#include <string.h>
#include "flash_driver.h"

/*---------------------------------------------------------------------------
 * AHB register layer
 *-------------------------------------------------------------------------*/
static void ahb_spi_cs_assert(void)
{
    sv_ahb_write((int)REG_CS, 1);
}

static void ahb_spi_cs_deassert(void)
{
    sv_ahb_write((int)REG_CS, 0);
}

/* Kick off one SPI byte exchange via REG_TXRX, poll REG_STATUS until the
 * bridge's SPI engine is done, then read back the received byte. */
static uint8_t ahb_spi_xfer_byte(uint8_t tx)
{
    int status = 0;
    int rx = 0;

    sv_ahb_write((int)REG_TXRX, (int)tx);

    do {
        sv_ahb_read((int)REG_STATUS, &status);
    } while (status & (int)STATUS_BUSY);

    sv_ahb_read((int)REG_TXRX, &rx);
    return (uint8_t)(rx & 0xFF);
}

/*---------------------------------------------------------------------------
 * Flash command layer
 *-------------------------------------------------------------------------*/
static void send_addr(uint32_t addr)
{
    (void)ahb_spi_xfer_byte((uint8_t)((addr >> 16) & 0xFFu));
    (void)ahb_spi_xfer_byte((uint8_t)((addr >> 8) & 0xFFu));
    (void)ahb_spi_xfer_byte((uint8_t)(addr & 0xFFu));
}

void flash_write_enable(void)
{
    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_WREN);
    ahb_spi_cs_deassert();
}

void flash_write_disable(void)
{
    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_WRDI);
    ahb_spi_cs_deassert();
}

uint8_t flash_read_status(void)
{
    uint8_t sr;
    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_RDSR);
    sr = ahb_spi_xfer_byte(0x00);
    ahb_spi_cs_deassert();
    return sr;
}

void flash_wait_wip_clear(uint32_t max_polls)
{
    uint32_t i;
    for (i = 0; i < max_polls; i++) {
        uint8_t sr = flash_read_status();
        if ((sr & FLASH_SR_WIP) == 0u) {
            return;
        }
    }
    printf("[flash_driver] WARNING: WIP bit did not clear after %u polls\n",
           max_polls);
}

void flash_read_id(uint8_t *manuf, uint8_t *memtype, uint8_t *capacity)
{
    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_RDID);
    *manuf    = ahb_spi_xfer_byte(0x00);
    *memtype  = ahb_spi_xfer_byte(0x00);
    *capacity = ahb_spi_xfer_byte(0x00);
    ahb_spi_cs_deassert();
}

void flash_page_program(uint32_t addr, const uint8_t *data, uint32_t len)
{
    uint32_t i;

    flash_write_enable();

    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_PP);
    send_addr(addr);
    for (i = 0; i < len; i++) {
        (void)ahb_spi_xfer_byte(data[i]);
    }
    ahb_spi_cs_deassert();

    flash_wait_wip_clear(1000);
}

void flash_read(uint32_t addr, uint8_t *data, uint32_t len)
{
    uint32_t i;

    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_READ);
    send_addr(addr);
    for (i = 0; i < len; i++) {
        data[i] = ahb_spi_xfer_byte(0x00);
    }
    ahb_spi_cs_deassert();
}

void flash_sector_erase(uint32_t addr)
{
    flash_write_enable();

    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_SE);
    send_addr(addr);
    ahb_spi_cs_deassert();

    flash_wait_wip_clear(5000);
}

void flash_chip_erase(void)
{
    flash_write_enable();

    ahb_spi_cs_assert();
    (void)ahb_spi_xfer_byte((uint8_t)CMD_CE);
    ahb_spi_cs_deassert();

    flash_wait_wip_clear(50000);
}

/*---------------------------------------------------------------------------
 * c_flash_test_main - entry point called from tb_top.sv.
 *
 * Sequence:
 *   1. Read Manufacturer/Device ID (RDID)
 *   2. Erase the first 4KB sector
 *   3. Program 16 bytes
 *   4. Read them back and verify
 *
 * Every one of these now travels: flash_*() -> ahb_spi_*() ->
 * sv_ahb_write()/sv_ahb_read() -> AHB bus -> ahb_spi_bridge.sv -> SPI bus
 * -> spi_flash_model.sv.
 *-------------------------------------------------------------------------*/
void c_flash_test_main(void)
{
    uint8_t manuf, memtype, capacity;
    uint8_t wbuf[16];
    uint8_t rbuf[16];
    int i, errors = 0;

    printf("\n===== DPI-C Flash Driver Test (AHB -> SPI bridge) =====\n");

    flash_read_id(&manuf, &memtype, &capacity);
    printf("[flash_driver] RDID -> Manufacturer=0x%02X MemType=0x%02X "
           "Capacity=0x%02X\n", manuf, memtype, capacity);

    printf("[flash_driver] Erasing sector at 0x000000...\n");
    flash_sector_erase(0x000000u);

    for (i = 0; i < 16; i++) {
        wbuf[i] = (uint8_t)(0xA0 + i);
    }

    printf("[flash_driver] Programming 16 bytes at 0x000010...\n");
    flash_page_program(0x000010u, wbuf, sizeof(wbuf));

    memset(rbuf, 0, sizeof(rbuf));
    flash_read(0x000010u, rbuf, sizeof(rbuf));

    printf("[flash_driver] Verifying readback...\n");
    for (i = 0; i < 16; i++) {
        if (rbuf[i] != wbuf[i]) {
            printf("  MISMATCH at byte %d: wrote 0x%02X read 0x%02X\n",
                   i, wbuf[i], rbuf[i]);
            errors++;
        }
    }

    if (errors == 0) {
        printf("[flash_driver] PASS: all %d bytes verified correctly.\n",
               (int)sizeof(wbuf));
    } else {
        printf("[flash_driver] FAIL: %d byte mismatch(es).\n", errors);
    }

    printf("===== Test Complete =====\n\n");
}
