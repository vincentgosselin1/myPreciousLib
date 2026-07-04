#ifndef LED_DRIVER_H
#define LED_DRIVER_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------
 * Exported TO SystemVerilog.
 * tb_top.sv calls this via: import "DPI-C" task c_led_test_main();
 *-------------------------------------------------------------------------*/
extern void c_led_test_main(void);

/*---------------------------------------------------------------------------
 * Imported FROM SystemVerilog.
 * Implemented as "export DPI-C" tasks inside rtl/tb_top.sv (the Wishbone
 * agent). All use plain 32-bit `int`, the standard DPI-C mapping for
 * SystemVerilog's `int` type.
 *-------------------------------------------------------------------------*/
extern void sv_wb_write(int addr, int data);
extern void sv_wb_read(int addr, int *data);
extern void sv_wait_cycles(int n);

/*---------------------------------------------------------------------------
 * wb_led_blinker.sv register map (see rtl/wb_led_blinker.sv header for
 * full description). Single-slave subsystem, byte offsets from 0.
 *-------------------------------------------------------------------------*/
#define REG_CTRL          0x00u
#define REG_PERIOD_CYCLES 0x04u
#define REG_DEVICE_ID     0x08u

#define CTRL_LED_EN_BIT    0u
#define CTRL_BLINK_EN_BIT  1u
#define CTRL_LED_EN        (1u << CTRL_LED_EN_BIT)
#define CTRL_BLINK_EN      (1u << CTRL_BLINK_EN_BIT)

#define LED_DEVICE_ID_EXPECTED 0xCAFEDEADu

/* Must match wb_clk_i's frequency in tb_top.sv (20ns period => 50MHz),
 * since LED_BLINK() converts the caller's milliseconds into wb_clk_i
 * cycles using this value -- exactly like a real driver converts a
 * requested delay into a hardware timer's tick count. */
#define WB_CLK_FREQ_HZ 50000000ul

/*---------------------------------------------------------------------------
 * Public driver API
 *-------------------------------------------------------------------------*/
void     LED_ON(void);
void     LED_OFF(void);
void     LED_BLINK(int period_in_milliseconds);
uint32_t LED_DEVICE_ID(void);

#ifdef __cplusplus
}
#endif

#endif /* LED_DRIVER_H */
