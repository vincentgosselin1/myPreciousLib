#run_sim.sh, Vincent Gosselin 2023.
#needs to be configured once.
#need to update to a new simulator perhaps iverilog
vsim -do run_sim.do -wlf vsim.wlf work.unsigned_counter_tb
#sleep 5
