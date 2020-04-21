#clear the main window
#.main clear

# vsim work.binary_counter_v1_tb

# add wave -position insertpoint sim:/binary_counter_v1_tb/*

vsim work.parity_bit_calc_tb
add wave -position insertpoint sim:/parity_bit_calc_tb/i1/*

run 20 us
#run 200000 us
wave zoom full
