# DPI-C SPI Flash Driver Example (Questa/ModelSim)

A self-contained example showing how to drive a Micron-style SPI NOR flash
from C using DPI-C in SystemVerilog, targeting Questa/ModelSim on RHEL8.

## What's in here

```
flash_dpic_example/
├── Makefile
├── README.md
├── c/
│   ├── flash_driver.h      DPI-C prototypes + Micron opcode defines
│   └── flash_driver.c      Flash command driver + test sequence
└── rtl/
    ├── spi_bfm.sv          SPI master BFM (exports DPI-C tasks: cs assert/
    │                       deassert and full-duplex byte transfer)
    ├── spi_flash_model.sv  Behavioral Micron-style SPI NOR flash slave
    └── tb_top.sv           Top-level testbench, imports c_flash_test_main()
```

### Architecture

```
c_flash_test_main() [C]
        |
        | calls flash_read_id(), flash_sector_erase(),
        | flash_page_program(), flash_read(), ...
        v
flash_driver.c [C]  -- issues opcodes/bytes via --> sv_spi_xfer_byte()
                                                     sv_spi_cs_assert()
                                                     sv_spi_cs_deassert()
                                                            | (export "DPI-C")
                                                            v
                                                    spi_bfm.sv [SV]
                                                            |
                                              sclk / cs_n / mosi / miso
                                                            v
                                                spi_flash_model.sv [SV]
```

- All **command sequencing** (WREN, PP, READ, SE, RDID, status polling,
  address framing) lives in **C** (`c/flash_driver.c`) so it's easy to read,
  port, and reuse against real firmware/driver code.
- All **pin-level SPI timing** (SCLK toggling, CS assertion, bit shifting)
  lives in **SystemVerilog** (`rtl/spi_bfm.sv`), which is where clock/timing
  accuracy belongs in a simulation environment.
- `spi_flash_model.sv` is a small behavioral model that responds to the
  standard Micron N25Q/MT25Q-style opcode set (WREN, WRDI, RDSR, RDID,
  READ/FAST_READ, PP, SE, CE). **Replace this module's instantiation in
  `tb_top.sv` with your real DUT/vendor flash model** — nothing else needs
  to change, since the C driver only talks to the BFM.

## Prerequisites

- RHEL8 with GCC installed (already have this)
- Questa/ModelSim installed, with `vsim`, `vlog`, `vlib`, `vopt` available
  on your `PATH`. Typically this means sourcing your tool's setup script
  first, e.g.:
  ```bash
  source /opt/mentor/questasim/settings.sh
  # or whatever your site's module/env script is called, e.g.:
  # module load questa/2024.x
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
2. `vlog -sv` — compile the SystemVerilog sources
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
[TB] Starting DPI-C flash driver test...

===== DPI-C Flash Driver Test =====
[flash_driver] RDID -> Manufacturer=0x20 MemType=0xBA Capacity=0x18
[flash_driver] Erasing sector at 0x000000...
[flash_driver] Programming 16 bytes at 0x000010...
[flash_driver] Verifying readback...
[flash_driver] PASS: all 16 bytes verified correctly.
===== Test Complete =====

[TB] c_flash_test_main() returned.
```

## Manual (non-Makefile) command reference

If you'd rather run the steps by hand:

```bash
vlib work

vlog -sv +acc rtl/spi_bfm.sv rtl/spi_flash_model.sv rtl/tb_top.sv -work work

# Locate svdpi.h under your Questa install, e.g.:
#   $QUESTA_HOME/include/svdpi.h
gcc -shared -fPIC -I$QUESTA_HOME/include -o flash_driver.so c/flash_driver.c

vopt tb_top -o tb_top_opt -work work +acc

vsim -c -sv_lib flash_driver -work work -do "run -all; quit -f" tb_top_opt
```

`-sv_lib flash_driver` tells Questa to `dlopen()` `flash_driver.so` and
resolve the `import "DPI-C" task c_flash_test_main();` declared in
`tb_top.sv` against the `c_flash_test_main()` symbol compiled into it.

## Adapting this to real hardware/your DUT

- **Swap the flash model**: replace the `spi_flash_model` instance in
  `tb_top.sv` with your real DUT (an SPI controller RTL block driving a
  vendor-supplied Micron flash model, or your actual chip in an
  emulation/FPGA-prototyping flow). The BFM and C driver are DUT-agnostic.
- **Multiple flash devices / multiple CS lines**: add another `cs_n`-style
  signal and a second pair of `sv_spi_csN_assert/deassert` exports, or
  parameterize the existing tasks with a chip-select index.
- **Timing accuracy**: `HALF_PERIOD` in `spi_bfm.sv` controls SCLK
  frequency; the behavioral flash model treats erase/program as
  instantaneous (status register's WIP bit is tied low). If you need
  realistic `tPP`/`tSE`/`tCE` erase/program latencies, add delays before
  clearing WIP in `spi_flash_model.sv`, or, better, swap in a
  vendor-accurate flash model and rely on its native timing.
- **Reusing the driver against real firmware**: `c/flash_driver.c` has no
  simulation-specific code beyond the three DPI primitives it calls; the
  opcode-level logic (`flash_page_program`, `flash_sector_erase`, etc.) is
  portable to an embedded target if you re-implement
  `sv_spi_xfer_byte`/`sv_spi_cs_assert`/`sv_spi_cs_deassert` against real
  SPI peripheral registers instead of DPI-C.

## Notes / limitations of the included behavioral flash model

- 64KB memory array (configurable via `MEM_SIZE` parameter) to keep
  simulation fast; increase if you need to exercise higher addresses.
- Implements a subset of the full Micron command set (no Quad I/O, no
  Deep Power-Down, no OTP/security registers, no 4-byte address mode).
  These can be added to `spi_flash_model.sv`'s `handle_byte()` task
  following the same pattern.
- Program operations correctly emulate NOR flash semantics (`AND`s in new
  data, since a real program can only clear bits — an erase is required to
  set them back to `1`).
