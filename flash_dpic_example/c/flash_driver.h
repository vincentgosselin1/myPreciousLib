#ifndef FLASH_DRIVER_H
#define FLASH_DRIVER_H

#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------
 * Exported TO SystemVerilog.
 * tb_top.sv calls this via: import "DPI-C" task c_flash_test_main();
 *-------------------------------------------------------------------------*/
extern void c_flash_test_main(void);

/*---------------------------------------------------------------------------
 * Imported FROM SystemVerilog.
 * Implemented as "export DPI-C" tasks inside rtl/spi_bfm.sv.
 *-------------------------------------------------------------------------*/
extern void sv_spi_cs_assert(void);
extern void sv_spi_cs_deassert(void);
extern void sv_spi_xfer_byte(char tx_byte, char *rx_byte);

/*---------------------------------------------------------------------------
 * Micron-style SPI NOR flash opcodes (N25Q/MT25Q family, subset).
 *-------------------------------------------------------------------------*/
#define CMD_WREN      0x06u  /* Write Enable                */
#define CMD_WRDI      0x04u  /* Write Disable                */
#define CMD_RDSR      0x05u  /* Read Status Register         */
#define CMD_WRSR      0x01u  /* Write Status Register        */
#define CMD_READ      0x03u  /* Read Data                    */
#define CMD_FAST_READ 0x0Bu  /* Fast Read                    */
#define CMD_PP        0x02u  /* Page Program                 */
#define CMD_SE        0x20u  /* Sector Erase (4KB)           */
#define CMD_BE        0xD8u  /* Block Erase (64KB)           */
#define CMD_CE        0xC7u  /* Chip Erase                   */
#define CMD_RDID      0x9Fu  /* Read Identification          */

#define FLASH_SR_WIP  0x01u  /* Status Register: Write In Progress bit */
#define FLASH_SR_WEL  0x02u  /* Status Register: Write Enable Latch    */

/*---------------------------------------------------------------------------
 * Driver API - flash commands built on top of the low-level SPI byte
 * transfer primitives exported from spi_bfm.sv.
 *-------------------------------------------------------------------------*/
void    flash_write_enable(void);
void    flash_write_disable(void);
uint8_t flash_read_status(void);
void    flash_wait_wip_clear(uint32_t max_polls);
void    flash_read_id(uint8_t *manuf, uint8_t *memtype, uint8_t *capacity);
void    flash_page_program(uint32_t addr, const uint8_t *data, uint32_t len);
void    flash_read(uint32_t addr, uint8_t *data, uint32_t len);
void    flash_sector_erase(uint32_t addr);
void    flash_chip_erase(void);

#ifdef __cplusplus
}
#endif

#endif /* FLASH_DRIVER_H */
