#run_sim.sh, Vincent Gosselin 2023.
#needs to be configured once.
vsim work.even_parity_detector_tb
add wave -position insertpoint sim:/even_parity_detector_tb/*
run 20 us
