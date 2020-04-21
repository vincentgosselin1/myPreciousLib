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
-- Generated on "04/20/2020 21:08:04"
                                                            
-- Vhdl Test Bench template for design  :  parity_bit_calc
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY parity_bit_calc_tb IS
END parity_bit_calc_tb;
ARCHITECTURE parity_bit_calc_arch OF parity_bit_calc_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL p_bit : STD_LOGIC;
SIGNAL resetn : STD_LOGIC;
SIGNAL word_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
COMPONENT parity_bit_calc
	GENERIC ( NUM_BITS : INTEGER := 8 );
	PORT
	(
		clk		:	 IN STD_LOGIC;
		resetn		:	 IN STD_LOGIC;
		word_in		:	 IN STD_LOGIC_VECTOR(num_bits-1 DOWNTO 0);
		p_bit		:	 OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : parity_bit_calc
	generic map (NUM_BITS => 8)
	PORT MAP (
	clk => clk,
	p_bit => p_bit,
	resetn => resetn,
	word_in => word_in
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
		
		 -- code executes for every event on sensitivity list  
		resetn <= '0';
		wait for 1 us;
		
		resetn <= '1';
		
		--FIRST WORD
		word_in <= x"01";
		wait for 1 us;
		
		word_in <= x"02";
		wait for 1 us;
		
		word_in <= x"ff";
		wait for 1 us;
		
		
		
		
		
WAIT;                                                        
END PROCESS always;                                          
END parity_bit_calc_arch;
