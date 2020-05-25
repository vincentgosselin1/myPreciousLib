#clear the main window
#.main clear

vsim work.fifo_v1_tb

add wave -position insertpoint sim:/fifo_v1_tb/uut/*

run 20 us
#run 200000 us
wave zoom full
