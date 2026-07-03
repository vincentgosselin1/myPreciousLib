#==============================================================================
# Makefile - DPI-C SPI Flash driver example (Questa/ModelSim)
#
# Usage:
#   make run        - compile RTL, build C shared lib, elaborate, run batch
#   make run_gui     - same, but opens the Questa GUI instead of batch mode
#   make clean       - remove generated files
#
# Requirements:
#   - `vsim`/`vlog`/`vlib`/`vopt` on PATH (source your Questa setup script
#     or vendor environment module first, e.g.:
#         source /opt/mentor/questasim/settings.sh
#     or whatever your site uses)
#   - gcc on PATH (already present on your RHEL8 box)
#==============================================================================

VLIB = vlib
VLOG = vlog
VOPT = vopt
VSIM = vsim
GCC  = gcc

WORK = work
TOP  = tb_top

RTL_SRCS = rtl/ahb_spi_bridge.sv rtl/spi_flash_model.sv rtl/tb_top.sv
C_SRCS   = c/flash_driver.c
C_HDRS   = c/flash_driver.h

# Locate svdpi.h under the Questa installation (derived from `vsim` on PATH).
QUESTA_BIN := $(shell dirname $(shell which vsim))
QUESTA_INC := $(QUESTA_BIN)/../include

# Questa's `-sv_lib flash_driver` looks for flash_driver.so (it appends the
# platform's shared-object suffix automatically).
C_LIB = flash_driver.so

.PHONY: all compile elaborate run run_gui clean

all: run

$(WORK):
	$(VLIB) $(WORK)

compile: $(WORK)
	$(VLOG) -sv +acc $(RTL_SRCS) -work $(WORK)

$(C_LIB): $(C_SRCS) $(C_HDRS)
	$(GCC) -shared -fPIC -Wall -I$(QUESTA_INC) -o $(C_LIB) $(C_SRCS)

elaborate: compile $(C_LIB)
	$(VOPT) $(TOP) -o $(TOP)_opt -work $(WORK) +acc

run: elaborate
	$(VSIM) -c -sv_lib flash_driver -work $(WORK) \
	    -do "run -all; quit -f" $(TOP)_opt

run_gui: elaborate
	$(VSIM) -sv_lib flash_driver -work $(WORK) $(TOP)_opt

clean:
	rm -rf $(WORK) transcript vsim.wlf $(C_LIB) *.o modelsim.ini
