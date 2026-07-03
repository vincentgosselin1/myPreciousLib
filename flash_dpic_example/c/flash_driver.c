/*=============================================================================
 * flash_driver.c
 *
 * DPI-C "driver" for a Micron-style SPI NOR flash. This file contains no
 * SystemVerilog and no pin-level timing -- it only issues byte sequences
 * via sv_spi_xfer_byte()/sv_spi_cs_assert()/sv_spi_cs_deassert(), which are
 * exported "DPI-C" tasks implemented in rtl/spi_bfm.sv.
 *
 * c_flash_test_main() is exported "DPI-C" and is called once from
 * tb_top.sv's initial block; it exercises RDID, sector erase, page program
 * and read-back / verify.
 *===========================================================================*/
#include <stdio.h>
#include <string.h>
#include "flash_driver.h"

/*---------------------------------------------------------------------------
 * send_addr - send a 24-bit address, MSB byte first (standard for the
 * Micron command set used here).
 *-------------------------------------------------------------------------*/
static void send_addr(uint32_t addr)
{
    char rx;
    sv_spi_xfer_byte((char)((addr >> 16) & 0xFFu), &rx);
    sv_spi_xfer_byte((char)((addr >> 8) & 0xFFu), &rx);
    sv_spi_xfer_byte((char)(addr & 0xFFu), &rx);
}

void flash_write_enable(void)
{
    char rx;
    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_WREN, &rx);
    sv_spi_cs_deassert();
}

void flash_write_disable(void)
{
    char rx;
    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_WRDI, &rx);
    sv_spi_cs_deassert();
}

uint8_t flash_read_status(void)
{
    char rx = 0;
    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_RDSR, &rx);
    sv_spi_xfer_byte(0x00, &rx);
    sv_spi_cs_deassert();
    return (uint8_t)rx;
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
    char rx;
    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_RDID, &rx);

    sv_spi_xfer_byte(0x00, &rx);
    *manuf = (uint8_t)rx;

    sv_spi_xfer_byte(0x00, &rx);
    *memtype = (uint8_t)rx;

    sv_spi_xfer_byte(0x00, &rx);
    *capacity = (uint8_t)rx;

    sv_spi_cs_deassert();
}

void flash_page_program(uint32_t addr, const uint8_t *data, uint32_t len)
{
    uint32_t i;
    char rx;

    flash_write_enable();

    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_PP, &rx);
    send_addr(addr);
    for (i = 0; i < len; i++) {
        sv_spi_xfer_byte((char)data[i], &rx);
    }
    sv_spi_cs_deassert();

    flash_wait_wip_clear(1000);
}

void flash_read(uint32_t addr, uint8_t *data, uint32_t len)
{
    uint32_t i;
    char rx;

    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_READ, &rx);
    send_addr(addr);
    for (i = 0; i < len; i++) {
        sv_spi_xfer_byte(0x00, &rx);
        data[i] = (uint8_t)rx;
    }
    sv_spi_cs_deassert();
}

void flash_sector_erase(uint32_t addr)
{
    char rx;

    flash_write_enable();

    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_SE, &rx);
    send_addr(addr);
    sv_spi_cs_deassert();

    flash_wait_wip_clear(5000);
}

void flash_chip_erase(void)
{
    char rx;

    flash_write_enable();

    sv_spi_cs_assert();
    sv_spi_xfer_byte((char)CMD_CE, &rx);
    sv_spi_cs_deassert();

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
 *-------------------------------------------------------------------------*/
void c_flash_test_main(void)
{
    uint8_t manuf, memtype, capacity;
    uint8_t wbuf[16];
    uint8_t rbuf[16];
    int i, errors = 0;

    printf("\n===== DPI-C Flash Driver Test =====\n");

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
