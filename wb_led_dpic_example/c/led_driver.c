/*=============================================================================
 * led_driver.c
 *
 * DPI-C driver for the wb_led_blinker.sv RTL peripheral, addressed over a
 * Wishbone B4 classic bus. LED_ON()/LED_OFF()/LED_BLINK()/LED_DEVICE_ID()
 * are the public API; internally they issue register pokes via
 * sv_wb_write()/sv_wb_read(), which are exported "DPI-C" tasks
 * implemented as the Wishbone agent directly inside rtl/tb_top.sv.
 *===========================================================================*/
#include <stdio.h>
#include "led_driver.h"

/*---------------------------------------------------------------------------
 * ms_to_cycles - convert a millisecond duration into wb_clk_i cycles,
 * the way a real embedded driver would convert to a hardware timer's
 * tick count for a peripheral clocked at WB_CLK_FREQ_HZ.
 *-------------------------------------------------------------------------*/
static uint32_t ms_to_cycles(int period_in_milliseconds)
{
    uint64_t cycles;

    if (period_in_milliseconds <= 0) {
        return 1u; /* avoid a zero period, which the RTL treats as "hold" */
    }

    cycles = ((uint64_t)period_in_milliseconds * (uint64_t)WB_CLK_FREQ_HZ)
             / 1000ull;
    if (cycles == 0ull) {
        cycles = 1ull;
    }
    return (uint32_t)cycles;
}

void LED_ON(void)
{
    sv_wb_write((int)REG_CTRL, (int)CTRL_LED_EN);
    printf("[led_driver] LED_ON()\n");
}

void LED_OFF(void)
{
    sv_wb_write((int)REG_CTRL, 0);
    printf("[led_driver] LED_OFF()\n");
}

void LED_BLINK(int period_in_milliseconds)
{
    uint32_t cycles = ms_to_cycles(period_in_milliseconds);

    sv_wb_write((int)REG_PERIOD_CYCLES, (int)cycles);
    sv_wb_write((int)REG_CTRL, (int)CTRL_BLINK_EN);

    printf("[led_driver] LED_BLINK(%d ms) -> period_cycles=%u @ %lu Hz\n",
           period_in_milliseconds, cycles, WB_CLK_FREQ_HZ);
}

uint32_t LED_DEVICE_ID(void)
{
    int data = 0;
    sv_wb_read((int)REG_DEVICE_ID, &data);
    printf("[led_driver] LED_DEVICE_ID() -> 0x%08X\n", (uint32_t)data);
    return (uint32_t)data;
}

/*---------------------------------------------------------------------------
 * c_led_test_main - entry point called from tb_top.sv.
 *-------------------------------------------------------------------------*/
void c_led_test_main(void)
{
    uint32_t id;

    printf("\n===== DPI-C LED Driver Test =====\n");

    id = LED_DEVICE_ID();
    if (id == LED_DEVICE_ID_EXPECTED) {
        printf("[led_driver] Device ID check PASS.\n");
    } else {
        printf("[led_driver] Device ID check FAIL: expected 0x%08X, got 0x%08X\n",
               LED_DEVICE_ID_EXPECTED, id);
    }

    printf("[led_driver] Turning LED solid on for 2ms...\n");
    LED_ON();
    sv_wait_cycles((int)ms_to_cycles(2));

    printf("[led_driver] Turning LED off...\n");
    LED_OFF();
    sv_wait_cycles((int)ms_to_cycles(1));

    printf("[led_driver] Blinking LED at a 1ms period for 10ms...\n");
    LED_BLINK(1);
    sv_wait_cycles((int)ms_to_cycles(10));

    printf("[led_driver] Turning LED off...\n");
    LED_OFF();

    printf("===== Test Complete =====\n\n");
}
