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
 * Implemented as "export DPI-C" tasks inside rtl/tb_top.sv (the AHB
 * agent). Both use plain 32-bit `int`, which is the standard DPI-C
 * mapping for SystemVerilog's `int` type -- no svLogicVecVal handling
 * needed.
 *-------------------------------------------------------------------------*/
extern void sv_ahb_write(int addr, int data);
extern void sv_ahb_read(int addr, int *data);

/*---------------------------------------------------------------------------
 * ahb_spi_bridge.sv register map (see rtl/ahb_spi_bridge.sv header comment
 * for full protocol description). Single-slave subsystem, no address
 * decoder, so these are simply byte offsets from 0.
 *-------------------------------------------------------------------------*/
#define REG_CS       0x00u  /* [0]   R/W  1 = assert CS (drive low)   */
#define REG_TXRX     0x04u  /* [7:0] W: tx byte (triggers transfer)   */
                             /*       R: last rx byte                 */
#define REG_STATUS   0x08u  /* [0]   R    BUSY                        */

#define STATUS_BUSY  0x1u

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
 * Driver API - flash commands. Internally these go through the AHB
 * register layer (ahb_spi_xfer_byte() etc. in flash_driver.c), which in
 * turn is translated into SPI bus activity by ahb_spi_bridge.sv.
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
