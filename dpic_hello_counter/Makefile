#==============================================================================
# Makefile - minimal DPI-C example (Questa/ModelSim)
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

SV_SRCS = tb_top.sv
C_SRCS  = counter.c
C_HDRS  = counter.h

# Locate svdpi.h under the Questa installation (derived from `vsim` on PATH).
QUESTA_BIN := $(shell dirname $(shell which vsim))
QUESTA_INC := $(QUESTA_BIN)/../include

# Questa's `-sv_lib counter` looks for counter.so (it appends the
# platform's shared-object suffix automatically).
C_LIB = counter.so

.PHONY: all compile elaborate run run_gui clean

all: run

$(WORK):
	$(VLIB) $(WORK)

compile: $(WORK)
	$(VLOG) -sv $(SV_SRCS) -work $(WORK)

$(C_LIB): $(C_SRCS) $(C_HDRS)
	$(GCC) -shared -fPIC -Wall -I$(QUESTA_INC) -o $(C_LIB) $(C_SRCS)

elaborate: compile $(C_LIB)
	$(VOPT) $(TOP) -o $(TOP)_opt -work $(WORK)

run: elaborate
	$(VSIM) -c -sv_lib counter -work $(WORK) \
	    -do "run -all; quit -f" $(TOP)_opt

run_gui: elaborate
	$(VSIM) -sv_lib counter -work $(WORK) $(TOP)_opt

clean:
	rm -rf $(WORK) transcript vsim.wlf $(C_LIB) *.o modelsim.ini
