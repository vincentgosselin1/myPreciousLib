#clear the main window
#.main clear

vsim work.even_parity_detector_tb

add wave -position insertpoint sim:/even_parity_detector_tb/*

run 20 us
#run 200000 us
wave zoom full
