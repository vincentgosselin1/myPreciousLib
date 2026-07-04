# DPI-C LED Blinker Driver over Wishbone (Questa/ModelSim)

A complete example of a C driver issuing Wishbone bus transactions to
control an LED blinker RTL peripheral, using DPI-C in SystemVerilog.
Targets Questa/ModelSim on RHEL8.

## What's in here

```
wb_led_dpic_example/
├── Makefile
├── README.md
├── c/
│   ├── led_driver.h      Register map + public driver API
│   └── led_driver.c      LED_ON/OFF/BLINK/DEVICE_ID + test sequence
└── rtl/
    ├── tb_top.sv          Top-level testbench AND the Wishbone agent
    │                      (Wishbone B4 classic master tasks, exported to C)
    └── wb_led_blinker.sv  LED blinker peripheral (the RTL / DUT)
```

### Architecture

```
c_led_test_main() [C]
        |
        | LED_ON(), LED_OFF(), LED_BLINK(ms), LED_DEVICE_ID()
        v
led_driver.c [C]  -- command layer
        |
        | sv_wb_write(addr,data) / sv_wb_read(addr,&data) / sv_wait_cycles(n)
        v                          (export "DPI-C")
tb_top.sv [SV] -- Wishbone agent (Wishbone B4 classic master, lives
        |         directly in the top module)
        | wb_adr_i / wb_dat_i / wb_dat_o / wb_we_i / wb_cyc_i / wb_stb_i / wb_ack_o
        v
wb_led_blinker.sv [SV] -- the RTL LED blinker peripheral (the DUT)
        |
        v
      led_o    (observed via a $display monitor in tb_top.sv)
```

- **Command layer** (`LED_ON()`, `LED_OFF()`, `LED_BLINK()`,
  `LED_DEVICE_ID()` in `led_driver.c`) is exactly the API you specified.
  It has no notion of a bus — it just calls the register-level helpers.
- **Wishbone agent** (`sv_wb_write` / `sv_wb_read` / `sv_wait_cycles`) is
  implemented directly inside `tb_top.sv`, as requested — no separate BFM
  file. These run a standard Wishbone B4 classic single-cycle transfer:
  drive address/data/control, then wait for `wb_ack_o`.
- **`wb_led_blinker.sv`** is the RTL peripheral (the "DUT"): a Wishbone
  slave register file plus an LED state machine. Replace this with your
  real LED blinker RTL — the Wishbone agent and C driver don't need to
  change, only the register offsets in `led_driver.h` if your real RTL's
  map differs.

### Register map (`wb_led_blinker.sv`)

Single-slave Wishbone subsystem, byte offsets from 0:

| Offset | Name                | Access | Description                                       |
|--------|---------------------|--------|-----------------------------------------------------|
| 0x00   | `REG_CTRL`          | R/W    | bit0: `LED_EN` (solid on), bit1: `BLINK_EN`         |
| 0x04   | `REG_PERIOD_CYCLES` | R/W    | blink half-period, in `wb_clk_i` cycles             |
| 0x08   | `REG_DEVICE_ID`     | R      | fixed ID, `0xCAFEDEAD`                              |

`LED_BLINK(period_in_milliseconds)` converts milliseconds to
`wb_clk_i` cycles using `WB_CLK_FREQ_HZ` (50MHz, matching `tb_top.sv`'s
20ns clock period) — exactly like a real driver converts a requested
delay into a hardware timer's tick count. If your real clock frequency
differs, update `WB_CLK_FREQ_HZ` in `led_driver.h` to match.

## Prerequisites

- RHEL8 with GCC installed
- Questa/ModelSim installed, with `vsim`, `vlog`, `vlib`, `vopt` on
  `PATH`:
  ```bash
  source /opt/mentor/questasim/settings.sh   # or your site's setup script
  which vsim
  ```

## Build & run

```bash
make run
```

This runs:
1. `vlib work`
2. `vlog -sv` — compiles `wb_led_blinker.sv`, `tb_top.sv`
3. `gcc -shared -fPIC -I<questa>/include -o led_driver.so c/led_driver.c`
4. `vopt tb_top -o tb_top_opt -work work`
5. `vsim -c -sv_lib led_driver -do "run -all; quit -f" tb_top_opt`

`make run_gui` opens the Questa GUI instead of batch mode (useful here —
try adding `led_o`, `wb_adr_i`, `wb_dat_i`/`wb_dat_o`, and `wb_ack_o` to a
wave window to watch the register transactions and the blink toggling).
`make clean` removes generated files.

### Expected output (transcript, abbreviated)

```
[TB] Starting DPI-C LED driver test...

===== DPI-C LED Driver Test =====
[led_driver] LED_DEVICE_ID() -> 0xCAFEDEAD
[led_driver] Device ID check PASS.
[led_driver] Turning LED solid on for 2ms...
[led_driver] LED_ON()
[TB] time=2260 ns : led_o = 1
[led_driver] Turning LED off...
[led_driver] LED_OFF()
[TB] time=2100000 ns : led_o = 0
[led_driver] Blinking LED at a 1ms period for 10ms...
[led_driver] LED_BLINK(1 ms) -> period_cycles=50000 @ 50000000 Hz
[TB] time=3100000 ns : led_o = 1
[TB] time=4100000 ns : led_o = 0
[TB] time=5100000 ns : led_o = 1
...
[led_driver] Turning LED off...
[led_driver] LED_OFF()
===== Test Complete =====

[TB] c_led_test_main() returned.
```

(Exact timestamps depend on simulation timing; the pattern — one ID read,
a solid-on period, then regular 1ms toggles — is what matters.)

## Manual (non-Makefile) command reference

```bash
vlib work
vlog -sv rtl/wb_led_blinker.sv rtl/tb_top.sv -work work
gcc -shared -fPIC -I$QUESTA_HOME/include -o led_driver.so c/led_driver.c
vopt tb_top -o tb_top_opt -work work
vsim -c -sv_lib led_driver -work work -do "run -all; quit -f" tb_top_opt
```

## Adapting this to your real LED blinker RTL

- **Swap the DUT**: replace `wb_led_blinker`'s instantiation in
  `tb_top.sv` with your real RTL. If your register map differs, update
  the `REG_*` / `CTRL_*` defines in `led_driver.h` to match — the
  Wishbone agent and the `LED_*()` API don't need to change.
- **Multiple Wishbone peripherals**: this example has a single slave with
  no address decoder. If you add more, insert a standard Wishbone
  interconnect between the agent in `tb_top.sv` and the slaves.
- **Wait states**: `wb_led_blinker.sv` acks combinationally (zero wait
  states). The agent's `do...while(!wb_ack_o)` loop already handles a
  slave that holds off `wb_ack_o` for extra cycles, so a slower real
  peripheral will work without changing `tb_top.sv`.
- **Reusing the driver against real firmware**: `led_driver.c`'s
  `LED_*()` functions only depend on `sv_wb_write()` / `sv_wb_read()`
  (and `sv_wait_cycles()` for the demo's pacing). On an embedded target,
  reimplement those against real memory-mapped Wishbone bridge registers
  or your SoC's actual bus access functions, and drop `sv_wait_cycles()`
  in favor of a real OS/HAL delay function.
