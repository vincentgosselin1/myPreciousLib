# Minimal DPI-C Example (Questa/ModelSim)

The smallest possible DPI-C example: SystemVerilog calls a C function,
passing it a byte; the C function increments a static counter and
returns the new value; SystemVerilog prints it.

## Files

```
dpic_hello_counter/
├── Makefile
├── tb_top.sv     Testbench: imports and calls increment_counter()
├── counter.c     Implements increment_counter(), holds the static counter
└── counter.h     Declares increment_counter() for the C side
```

## How it works

`tb_top.sv`:
```systemverilog
import "DPI-C" function int increment_counter(input byte data);
...
count = increment_counter(data);
$display("HelloWorld, here is the value of the counter %0d", count);
```

`counter.c`:
```c
static int counter = 0;

int increment_counter(char data)
{
    counter++;
    return counter;
}
```

SystemVerilog's `byte` maps to C `char`, and `int` maps to C `int` — this
is the standard, no-fuss DPI-C type mapping, so no `svdpi.h` handles or
`svLogicVecVal` conversions are needed for this simple case.

## Prerequisites

- Questa/ModelSim's `vsim`, `vlog`, `vlib`, `vopt` on your `PATH`:
  ```bash
  source /opt/mentor/questasim/settings.sh   # or your site's setup script
  which vsim
  ```
- GCC (already on your RHEL8 box)

## Build & run

```bash
make run
```

This runs:
1. `vlib work`
2. `vlog -sv tb_top.sv -work work`
3. `gcc -shared -fPIC -I<questa>/include -o counter.so counter.c`
4. `vopt tb_top -o tb_top_opt -work work`
5. `vsim -c -sv_lib counter -do "run -all; quit -f" tb_top_opt`

`make run_gui` does the same but opens the Questa GUI instead of batch
mode. `make clean` removes all generated files.

### Expected output

```
[C] increment_counter() called with data=0xAA, counter now=1
HelloWorld, here is the value of the counter 1
[C] increment_counter() called with data=0x01, counter now=2
HelloWorld, here is the value of the counter 2
[C] increment_counter() called with data=0xFF, counter now=3
HelloWorld, here is the value of the counter 3
```

## Manual (non-Makefile) command reference

```bash
vlib work
vlog -sv tb_top.sv -work work
gcc -shared -fPIC -I$QUESTA_HOME/include -o counter.so counter.c
vopt tb_top -o tb_top_opt -work work
vsim -c -sv_lib counter -work work -do "run -all; quit -f" tb_top_opt
```

`-sv_lib counter` tells Questa to `dlopen()` `counter.so` and resolve the
`import "DPI-C" function int increment_counter(...)` in `tb_top.sv`
against the `increment_counter()` symbol compiled into it.
