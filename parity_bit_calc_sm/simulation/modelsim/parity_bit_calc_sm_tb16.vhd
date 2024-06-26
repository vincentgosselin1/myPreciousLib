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
-- Generated on "04/22/2020 16:52:57"
                                                            
-- Vhdl Test Bench template for design  :  parity_bit_calc_sm
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;    
use ieee.numeric_std.all;                            

ENTITY parity_bit_calc_sm_tb16 IS
END parity_bit_calc_sm_tb16;
ARCHITECTURE parity_bit_calc_sm_arch OF parity_bit_calc_sm_tb16 IS
-- constants                                                 
-- signals                                                   
SIGNAL busy_out : STD_LOGIC;
SIGNAL clk : STD_LOGIC;
SIGNAL index_out : UNSIGNED(16 DOWNTO 0);
SIGNAL num_of_ones_out : UNSIGNED(15 DOWNTO 0);
SIGNAL p_bit : STD_LOGIC;
SIGNAL p_valid : STD_LOGIC;
SIGNAL resetn : STD_LOGIC;
SIGNAL word_in : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL word_valid : STD_LOGIC;

--constant init.
constant clock_period : time := 20 ns; --50mhz

COMPONENT parity_bit_calc_sm
	GENERIC ( NUM_BITS : INTEGER := 16 );
	PORT
	(
		clk		:	 IN STD_LOGIC;
		resetn		:	 IN STD_LOGIC;
		word_in		:	 IN STD_LOGIC_VECTOR(num_bits-1 DOWNTO 0);
		word_valid		:	 IN STD_LOGIC;
		p_bit		:	 OUT STD_LOGIC;
		p_valid		:	 OUT STD_LOGIC;
		num_of_ones_out		:	 OUT UNSIGNED(num_bits-1 DOWNTO 0);
		index_out		:	 out UNSIGNED(num_bits DOWNTO 0);
		busy_out		:	 OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : parity_bit_calc_sm
	PORT MAP (
-- list connections between master ports and signals
	busy_out => busy_out,
	clk => clk,
	index_out => index_out,
	num_of_ones_out => num_of_ones_out,
	p_bit => p_bit,
	p_valid => p_valid,
	resetn => resetn,
	word_in => word_in,
	word_valid => word_valid
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;  

clock : PROCESS
	

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
begin

										resetn <= '0';
		word_valid <= '0';
		wait for 5 us;
		
		resetn <= '1';
		
		wait for 5 us;
		
		--FIRST WORD
		word_valid <= '1';
		word_in <= x"0000";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;
		
		--SECOND word
		word_valid <= '1';
		word_in <= x"0001";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

		--SECOND word
		word_valid <= '1';
		word_in <= x"0002";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;
		
		
		--THIRD word
		word_valid <= '1';
		word_in <= x"0003";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;
		
		--fourth word
		word_valid <= '1';
		word_in <= x"0004";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

		--fifth word
		word_valid <= '1';
		word_in <= x"00ff";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

		--sixth word
		word_valid <= '1';
		word_in <= x"01ff";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

		--more!!!
		word_valid <= '1';
		word_in <= x"11ff";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

		--more!!!
		word_valid <= '1';
		word_in <= x"dfff";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

		--more!!!
		word_valid <= '1';
		word_in <= x"efff";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

		--more!!!
		word_valid <= '1';
		word_in <= x"ffff";
		wait for clock_period;
		word_valid <= '0';
		--word_in <= x"0";
		wait for 5 us;

WAIT;                                                        
END PROCESS always;                                          
END parity_bit_calc_sm_arch;
