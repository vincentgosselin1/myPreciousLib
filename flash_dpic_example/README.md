# DPI-C SPI Flash Driver Example, over an AHB-Lite Bridge (Questa/ModelSim)

A self-contained example showing how to drive a Micron-style SPI NOR flash
from C using DPI-C in SystemVerilog, going through an AHB-Lite register
interface (representing a real "SPI flash controller" peripheral),
targeting Questa/ModelSim on RHEL8.

## What's in here

```
flash_dpic_example/
├── Makefile
├── README.md
├── c/
│   ├── flash_driver.h      DPI-C prototypes, register map, Micron opcodes
│   └── flash_driver.c      Flash command layer + AHB register layer
└── rtl/
    ├── tb_top.sv           Top-level testbench AND the AHB agent
    │                       (AHB-Lite master tasks, exported to C)
    ├── ahb_spi_bridge.sv   AHB-Lite slave -> SPI master bridge (the DUT)
    └── spi_flash_model.sv  Behavioral Micron-style SPI NOR flash slave
```

### Architecture

```
c_flash_test_main() [C]
        |
        | flash_read_id(), flash_sector_erase(), flash_page_program(), ...
        v
flash_driver.c [C] -- flash command layer -----------------+
        |                                                   |
        | ahb_spi_cs_assert/deassert(), ahb_spi_xfer_byte()  |
        v                                                   |
flash_driver.c [C] -- AHB register layer                    |
        |                                                   |
        | sv_ahb_write(addr,data) / sv_ahb_read(addr,&data)  |
        v                          (export "DPI-C")          |
tb_top.sv [SV] -- AHB agent (AHB-Lite master, lives directly |
        |          in the top module)                        |
        | HADDR / HWDATA / HRDATA / HWRITE / HTRANS / HREADY  |
        v                                                     |
ahb_spi_bridge.sv [SV] -- AHB-Lite slave register file        |
        |                 that drives a bit-banged SPI master |
        | sclk / cs_n / mosi / miso                            |
        v
spi_flash_model.sv [SV] -- behavioral Micron SPI NOR flash
```

- **Flash command layer** (`flash_*()` in `flash_driver.c`) is unchanged in
  spirit from a "direct SPI" driver: it knows about WREN, PP, READ, SE,
  RDID, status polling, and 24-bit address framing. It has no idea an AHB
  bus exists underneath it.
- **AHB register layer** (`ahb_spi_*()` static helpers in `flash_driver.c`)
  is the new piece: it turns "assert CS" / "transfer one SPI byte" into
  writes/reads of `ahb_spi_bridge.sv`'s three registers
  (`REG_CS`, `REG_TXRX`, `REG_STATUS`), polling `STATUS.BUSY` the way
  software would poll a real peripheral.
- **AHB agent** (`sv_ahb_write` / `sv_ahb_read`) is implemented directly
  inside `tb_top.sv` as requested — there is no separate AHB BFM file.
  These are `export "DPI-C" task`s that run a standard two-phase
  (address-phase / data-phase) AHB-Lite single transfer, honoring
  `HREADY` wait states.
- **`ahb_spi_bridge.sv`** is the DUT-like peripheral: an AHB-Lite slave
  register file on one side, and on the other side the same bit-banged
  SPI master engine that previously lived in a standalone `spi_bfm.sv`
  (mode 0, MSB-first, one byte per `REG_TXRX` write). **This is the module
  you'd replace with your real synthesizable AHB-to-SPI controller RTL**
  — the AHB agent in `tb_top.sv` and the flash model don't need to change.
- **`spi_flash_model.sv`** is unchanged from the direct-SPI version of
  this example — it only ever sees SPI bus activity and doesn't know an
  AHB bus exists.

### Register map (`ahb_spi_bridge.sv`)

Single-slave AHB-Lite subsystem (no interconnect/address decoder — `HSEL`
is tied high by `tb_top.sv`), byte offsets from 0:

| Offset | Name         | Access | Description                                            |
|--------|--------------|--------|----------------------------------------------------------|
| 0x00   | `REG_CS`     | R/W    | bit0: 1 = assert CS (drive low), 0 = deassert            |
| 0x04   | `REG_TXRX`   | R/W    | W: byte to transmit, triggers 8 SCLK pulses. R: last received byte (valid once `BUSY==0`) |
| 0x08   | `REG_STATUS` | R      | bit0: `BUSY` — 1 while a byte exchange is in flight       |

Typical sequence (exactly what `ahb_spi_xfer_byte()` in `flash_driver.c`
does):
```
write REG_CS    = 1        // assert CS
write REG_TXRX  = opcode   // e.g. 0x9F (RDID)
poll  REG_STATUS until BUSY == 0
read  REG_TXRX              // received byte
...                         // repeat write/poll/read for each byte
write REG_CS    = 0        // deassert CS
```

## Prerequisites

- RHEL8 with GCC installed (already have this)
- Questa/ModelSim installed, with `vsim`, `vlog`, `vlib`, `vopt` available
  on your `PATH`:
  ```bash
  source /opt/mentor/questasim/settings.sh
  # or your site's module/env script, e.g.: module load questa/2024.x
  ```
  Confirm with:
  ```bash
  which vsim
  ```

## Build & run

From the `flash_dpic_example/` directory:

```bash
make run
```

This will:
1. `vlib work` — create the Questa work library
2. `vlog -sv` — compile `ahb_spi_bridge.sv`, `spi_flash_model.sv`,
   `tb_top.sv`
3. `gcc -shared -fPIC` — compile `flash_driver.c` into `flash_driver.so`,
   linking against Questa's own `svdpi.h` (auto-located from `vsim` on
   `PATH`)
4. `vopt` — elaborate/optimize the design
5. `vsim -c -sv_lib flash_driver -do "run -all; quit -f"` — run in batch
   mode, loading the compiled C shared library as the DPI-C implementation

To open the waveform/GUI instead of batch mode:

```bash
make run_gui
```

To clean generated artifacts:

```bash
make clean
```

### Expected output (transcript)

```
[TB] Starting DPI-C flash driver test (AHB -> SPI bridge)...

===== DPI-C Flash Driver Test (AHB -> SPI bridge) =====
[flash_driver] RDID -> Manufacturer=0x20 MemType=0xBA Capacity=0x18
[flash_driver] Erasing sector at 0x000000...
[flash_driver] Programming 16 bytes at 0x000010...
[flash_driver] Verifying readback...
[flash_driver] PASS: all 16 bytes verified correctly.
===== Test Complete =====

[TB] c_flash_test_main() returned.
```

## Manual (non-Makefile) command reference

```bash
vlib work

vlog -sv +acc rtl/ahb_spi_bridge.sv rtl/spi_flash_model.sv rtl/tb_top.sv -work work

# Locate svdpi.h under your Questa install, e.g. $QUESTA_HOME/include/svdpi.h
gcc -shared -fPIC -I$QUESTA_HOME/include -o flash_driver.so c/flash_driver.c

vopt tb_top -o tb_top_opt -work work +acc

vsim -c -sv_lib flash_driver -work work -do "run -all; quit -f" tb_top_opt
```

## Adapting this to real hardware/your DUT

- **Swap the bridge**: replace `ahb_spi_bridge`'s instantiation in
  `tb_top.sv` with your real AHB-to-SPI controller RTL (or its netlist).
  Keep the register map the same (or update `flash_driver.h`'s `REG_*`
  defines to match your real controller), and the AHB agent + flash
  command layer don't need to change at all.
- **Swap the flash model**: replace `spi_flash_model`'s instantiation with
  a vendor-supplied Micron flash model or real silicon in an
  emulation/prototyping flow. Nothing above the SPI bus needs to change.
- **Multiple AHB peripherals**: this example ties `HSEL` high because
  `ahb_spi_bridge` is the only slave. If you add more peripherals, insert
  a standard AHB interconnect/address decoder between the AHB agent in
  `tb_top.sv` and the slaves, and generate per-slave `HSEL` from the
  decoded address there.
- **Wait states**: `ahb_spi_bridge.sv` ties `HREADY` high (zero-wait-state
  slave); software instead polls `REG_STATUS.BUSY` after kicking off a
  transfer. The AHB agent's tasks already handle `HREADY==0` correctly if
  you want a future controller to insert real wait states on the register
  write/read itself instead.
- **Timing accuracy**: the SPI engine's `SCLK_HALF_PERIOD` parameter in
  `ahb_spi_bridge.sv` controls SCLK frequency; the flash model treats
  erase/program as instantaneous (status register's WIP bit is tied low).
  Add real `tPP`/`tSE`/`tCE` latencies in `spi_flash_model.sv` if you need
  them, or swap in a vendor-accurate flash model.
- **Reusing the driver against real firmware**: `flash_driver.c`'s flash
  command layer and AHB register layer only depend on `sv_ahb_write()` /
  `sv_ahb_read()`. On an embedded target, reimplement those two functions
  against real memory-mapped AHB peripheral registers (e.g. plain pointer
  writes/reads) and the rest of the driver is unchanged.

## Notes / limitations of the included behavioral flash model

- 64KB memory array (configurable via `MEM_SIZE` parameter) to keep
  simulation fast; increase if you need to exercise higher addresses.
- Implements a subset of the full Micron command set (no Quad I/O, no
  Deep Power-Down, no OTP/security registers, no 4-byte address mode).
  Add these to `spi_flash_model.sv`'s `handle_byte()` task following the
  same pattern.
- Program operations correctly emulate NOR flash semantics (`AND`s in new
  data, since a real program can only clear bits — an erase is required to
  set them back to `1`).
