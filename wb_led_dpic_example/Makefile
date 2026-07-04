#==============================================================================
# Makefile - Wishbone LED Blinker DPI-C example (Questa/ModelSim)
#
# Usage:
#   make run       - compile, build C shared lib, elaborate, run in batch mode
#   make run_gui   - same, but opens the Questa GUI
#   make clean     - remove generated files
#
# Requirements:
#   - `vsim`/`vlog`/`vlib`/`vopt` on PATH (source your Questa setup script
#     first, e.g.: source /opt/mentor/questasim/settings.sh)
#   - gcc on PATH
#==============================================================================

VLIB = vlib
VLOG = vlog
VOPT = vopt
VSIM = vsim
GCC  = gcc

WORK = work
TOP  = tb_top

RTL_SRCS = rtl/wb_led_blinker.sv rtl/tb_top.sv
C_SRCS   = c/led_driver.c
C_HDRS   = c/led_driver.h

# Locate svdpi.h under the Questa installation (derived from `vsim` on PATH).
QUESTA_BIN := $(shell dirname $(shell which vsim))
QUESTA_INC := $(QUESTA_BIN)/../include

# Questa's `-sv_lib led_driver` looks for led_driver.so (it appends the
# platform's shared-object suffix automatically).
C_LIB = led_driver.so

.PHONY: all compile elaborate run run_gui clean

all: run

$(WORK):
	$(VLIB) $(WORK)

compile: $(WORK)
	$(VLOG) -sv $(RTL_SRCS) -work $(WORK)

$(C_LIB): $(C_SRCS) $(C_HDRS)
	$(GCC) -shared -fPIC -Wall -I$(QUESTA_INC) -o $(C_LIB) $(C_SRCS)

elaborate: compile $(C_LIB)
	$(VOPT) $(TOP) -o $(TOP)_opt -work $(WORK)

run: elaborate
	$(VSIM) -c -sv_lib led_driver -work $(WORK) \
	    -do "run -all; quit -f" $(TOP)_opt

run_gui: elaborate
	$(VSIM) -sv_lib led_driver -work $(WORK) $(TOP)_opt

clean:
	rm -rf $(WORK) transcript vsim.wlf $(C_LIB) *.o modelsim.ini
