-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "04/20/2020 17:33:16"
                                                            
-- Vhdl Test Bench template for design  :  binary_counter_v1
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY binary_counter_v1_tb IS
END binary_counter_v1_tb;
ARCHITECTURE binary_counter_v1_arch OF binary_counter_v1_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL cout : STD_LOGIC;
SIGNAL enable : STD_LOGIC;
SIGNAL q : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
COMPONENT binary_counter_v1
	PORT (
	clk : IN STD_LOGIC;
	cout : OUT STD_LOGIC;
	enable : IN STD_LOGIC;
	q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	reset : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : binary_counter_v1
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	cout => cout,
	enable => enable,
	q => q,
	reset => reset
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;  

clock : PROCESS
	--constant init.
	constant clock_period : time := 20 ns; --50mhz

	---clock running
	BEGIN
	CLK <='1';
	wait for clock_period/2;
	CLK <='0';
	wait for clock_period/2;

END PROCESS clock; 
                                         
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
		enable <= '0';
		reset <= '1';
		wait for 1 us;
		
		reset <= '0';
		enable <= '1';
		
WAIT;                                                        
END PROCESS always;                                          
END binary_counter_v1_arch;
