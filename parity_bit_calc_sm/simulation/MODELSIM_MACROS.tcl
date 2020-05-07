#clear the main window
#.main clear


##4 bit version
# vsim work.parity_bit_calc_sm_tb
# add wave -position insertpoint sim:/parity_bit_calc_sm_tb/i1/*

##16bit version
# vsim work.parity_bit_calc_sm_tb16
# add wave -position insertpoint sim:/parity_bit_calc_sm_tb16/i1/*
#add wave

##19bit version
vsim work.parity_bit_calc_sm_tb19
add wave -position insertpoint sim:/parity_bit_calc_sm_tb19/i1/*

run 200 us
#run 200000 us
wave zoom full
