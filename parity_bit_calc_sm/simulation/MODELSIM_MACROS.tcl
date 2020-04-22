#clear the main window
#.main clear



vsim work.parity_bit_calc_sm_tb
add wave -position insertpoint sim:/parity_bit_calc_sm_tb/i1/*
#add wave

run 20 us
#run 200000 us
wave zoom full
