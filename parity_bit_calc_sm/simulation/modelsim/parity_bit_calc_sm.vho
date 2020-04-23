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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"

-- DATE "04/23/2020 15:33:52"

-- 
-- Device: Altera 5CGXFC7C7F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	parity_bit_calc_sm IS
    PORT (
	clk : IN std_logic;
	resetn : IN std_logic;
	word_in : IN std_logic_vector(3 DOWNTO 0);
	word_valid : IN std_logic;
	p_bit : BUFFER std_logic;
	p_valid : BUFFER std_logic;
	num_of_ones_out : BUFFER std_logic_vector(3 DOWNTO 0);
	index_out : BUFFER std_logic_vector(31 DOWNTO 0);
	busy_out : BUFFER std_logic
	);
END parity_bit_calc_sm;

-- Design Ports Information
-- p_bit	=>  Location: PIN_W21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p_valid	=>  Location: PIN_V16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[0]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[1]	=>  Location: PIN_AA22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[2]	=>  Location: PIN_AB22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[3]	=>  Location: PIN_W16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[0]	=>  Location: PIN_P22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[1]	=>  Location: PIN_R21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[2]	=>  Location: PIN_T22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[3]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[4]	=>  Location: PIN_U20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[5]	=>  Location: PIN_U17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[6]	=>  Location: PIN_T15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[7]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[8]	=>  Location: PIN_T19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[9]	=>  Location: PIN_T20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[10]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[11]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[12]	=>  Location: PIN_T18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[13]	=>  Location: PIN_U16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[14]	=>  Location: PIN_U21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[15]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[16]	=>  Location: PIN_V20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[17]	=>  Location: PIN_R15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[18]	=>  Location: PIN_AA19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[19]	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[20]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[21]	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[22]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[23]	=>  Location: PIN_Y22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[24]	=>  Location: PIN_Y19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[25]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[26]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[27]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[28]	=>  Location: PIN_Y20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[29]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[30]	=>  Location: PIN_Y21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[31]	=>  Location: PIN_W22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busy_out	=>  Location: PIN_P14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- resetn	=>  Location: PIN_R17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_valid	=>  Location: PIN_V19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[0]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[1]	=>  Location: PIN_V21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[2]	=>  Location: PIN_R14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[3]	=>  Location: PIN_U22,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF parity_bit_calc_sm IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_resetn : std_logic;
SIGNAL ww_word_in : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_word_valid : std_logic;
SIGNAL ww_p_bit : std_logic;
SIGNAL ww_p_valid : std_logic;
SIGNAL ww_num_of_ones_out : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_index_out : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_busy_out : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \word_valid~input_o\ : std_logic;
SIGNAL \resetn~input_o\ : std_logic;
SIGNAL \state.s5~q\ : std_logic;
SIGNAL \state.reset_state~feeder_combout\ : std_logic;
SIGNAL \state.reset_state~q\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \state.idle~q\ : std_logic;
SIGNAL \word_valid_reg~0_combout\ : std_logic;
SIGNAL \word_valid_reg~q\ : std_logic;
SIGNAL \state.idle~DUPLICATE_q\ : std_logic;
SIGNAL \state~22_combout\ : std_logic;
SIGNAL \state.s0~q\ : std_logic;
SIGNAL \Selector48~0_combout\ : std_logic;
SIGNAL \Add1~1_sumout\ : std_logic;
SIGNAL \Selector47~0_combout\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \state.s23~q\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \state.s3~q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \state.s1~q\ : std_logic;
SIGNAL \word_in[2]~input_o\ : std_logic;
SIGNAL \Selector8~0_combout\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \word_in[1]~input_o\ : std_logic;
SIGNAL \Selector9~0_combout\ : std_logic;
SIGNAL \word_in[0]~input_o\ : std_logic;
SIGNAL \Selector10~0_combout\ : std_logic;
SIGNAL \word_in[3]~input_o\ : std_logic;
SIGNAL \Selector7~1_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \Selector50~0_combout\ : std_logic;
SIGNAL \target_bit~q\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \state.s2~q\ : std_logic;
SIGNAL \WideOr9~0_combout\ : std_logic;
SIGNAL \Add1~2\ : std_logic;
SIGNAL \Add1~5_sumout\ : std_logic;
SIGNAL \index[1]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~6\ : std_logic;
SIGNAL \Add1~9_sumout\ : std_logic;
SIGNAL \Add1~10\ : std_logic;
SIGNAL \Add1~13_sumout\ : std_logic;
SIGNAL \Add1~14\ : std_logic;
SIGNAL \Add1~17_sumout\ : std_logic;
SIGNAL \Add1~18\ : std_logic;
SIGNAL \Add1~21_sumout\ : std_logic;
SIGNAL \Add1~22\ : std_logic;
SIGNAL \Add1~25_sumout\ : std_logic;
SIGNAL \Add1~26\ : std_logic;
SIGNAL \Add1~29_sumout\ : std_logic;
SIGNAL \index[7]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~30\ : std_logic;
SIGNAL \Add1~33_sumout\ : std_logic;
SIGNAL \Add1~34\ : std_logic;
SIGNAL \Add1~37_sumout\ : std_logic;
SIGNAL \Add1~38\ : std_logic;
SIGNAL \Add1~41_sumout\ : std_logic;
SIGNAL \Add1~42\ : std_logic;
SIGNAL \Add1~45_sumout\ : std_logic;
SIGNAL \index[11]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~46\ : std_logic;
SIGNAL \Add1~49_sumout\ : std_logic;
SIGNAL \index[12]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~50\ : std_logic;
SIGNAL \Add1~53_sumout\ : std_logic;
SIGNAL \Add1~54\ : std_logic;
SIGNAL \Add1~57_sumout\ : std_logic;
SIGNAL \Add1~58\ : std_logic;
SIGNAL \Add1~61_sumout\ : std_logic;
SIGNAL \index[15]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~62\ : std_logic;
SIGNAL \Add1~65_sumout\ : std_logic;
SIGNAL \Add1~66\ : std_logic;
SIGNAL \Add1~69_sumout\ : std_logic;
SIGNAL \Add1~70\ : std_logic;
SIGNAL \Add1~73_sumout\ : std_logic;
SIGNAL \Add1~74\ : std_logic;
SIGNAL \Add1~77_sumout\ : std_logic;
SIGNAL \index[19]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~78\ : std_logic;
SIGNAL \Add1~81_sumout\ : std_logic;
SIGNAL \index[20]~DUPLICATE_q\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Add1~82\ : std_logic;
SIGNAL \Add1~85_sumout\ : std_logic;
SIGNAL \Add1~86\ : std_logic;
SIGNAL \Add1~89_sumout\ : std_logic;
SIGNAL \Add1~90\ : std_logic;
SIGNAL \Add1~93_sumout\ : std_logic;
SIGNAL \Add1~94\ : std_logic;
SIGNAL \Add1~97_sumout\ : std_logic;
SIGNAL \index[24]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~98\ : std_logic;
SIGNAL \Add1~101_sumout\ : std_logic;
SIGNAL \index[25]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~102\ : std_logic;
SIGNAL \Add1~105_sumout\ : std_logic;
SIGNAL \Add1~106\ : std_logic;
SIGNAL \Add1~109_sumout\ : std_logic;
SIGNAL \index[27]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~110\ : std_logic;
SIGNAL \Add1~113_sumout\ : std_logic;
SIGNAL \Add1~114\ : std_logic;
SIGNAL \Add1~117_sumout\ : std_logic;
SIGNAL \index[29]~DUPLICATE_q\ : std_logic;
SIGNAL \Add1~118\ : std_logic;
SIGNAL \Add1~121_sumout\ : std_logic;
SIGNAL \Add1~122\ : std_logic;
SIGNAL \Add1~125_sumout\ : std_logic;
SIGNAL \Selector16~0_combout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \index[3]~DUPLICATE_q\ : std_logic;
SIGNAL \index[2]~DUPLICATE_q\ : std_logic;
SIGNAL \index[6]~DUPLICATE_q\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Equal0~5_combout\ : std_logic;
SIGNAL \index[8]~DUPLICATE_q\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Equal0~6_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \state.s4~q\ : std_logic;
SIGNAL \Selector15~0_combout\ : std_logic;
SIGNAL \num_of_ones[0]~DUPLICATE_q\ : std_logic;
SIGNAL \Selector48~1_combout\ : std_logic;
SIGNAL \p_bit~reg0_q\ : std_logic;
SIGNAL \Selector49~0_combout\ : std_logic;
SIGNAL \p_valid~reg0_q\ : std_logic;
SIGNAL \Selector14~0_combout\ : std_logic;
SIGNAL \Selector13~0_combout\ : std_logic;
SIGNAL \Selector12~0_combout\ : std_logic;
SIGNAL \Selector11~0_combout\ : std_logic;
SIGNAL \busy~q\ : std_logic;
SIGNAL index : std_logic_vector(31 DOWNTO 0);
SIGNAL num_of_ones : std_logic_vector(3 DOWNTO 0);
SIGNAL word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_state.idle~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_num_of_ones[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[29]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[27]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[25]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[24]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[20]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[19]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[15]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[12]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[11]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[8]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[7]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[6]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[3]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[2]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[1]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_word_in[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_valid~input_o\ : std_logic;
SIGNAL \ALT_INV_resetn~input_o\ : std_logic;
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_state.reset_state~q\ : std_logic;
SIGNAL \ALT_INV_state.s23~q\ : std_logic;
SIGNAL \ALT_INV_target_bit~q\ : std_logic;
SIGNAL \ALT_INV_state.idle~q\ : std_logic;
SIGNAL \ALT_INV_word_valid_reg~q\ : std_logic;
SIGNAL \ALT_INV_Equal0~6_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~5_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~4_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~3_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~2_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_state.s1~q\ : std_logic;
SIGNAL \ALT_INV_state.s3~q\ : std_logic;
SIGNAL \ALT_INV_state.s2~q\ : std_logic;
SIGNAL \ALT_INV_Selector48~0_combout\ : std_logic;
SIGNAL \ALT_INV_state.s5~q\ : std_logic;
SIGNAL \ALT_INV_state.s0~q\ : std_logic;
SIGNAL \ALT_INV_state.s4~q\ : std_logic;
SIGNAL \ALT_INV_busy~q\ : std_logic;
SIGNAL ALT_INV_index : std_logic_vector(31 DOWNTO 0);
SIGNAL ALT_INV_num_of_ones : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_p_valid~reg0_q\ : std_logic;
SIGNAL \ALT_INV_p_bit~reg0_q\ : std_logic;
SIGNAL \ALT_INV_Add1~125_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~1_sumout\ : std_logic;

BEGIN

ww_clk <= clk;
ww_resetn <= resetn;
ww_word_in <= word_in;
ww_word_valid <= word_valid;
p_bit <= ww_p_bit;
p_valid <= ww_p_valid;
num_of_ones_out <= ww_num_of_ones_out;
index_out <= ww_index_out;
busy_out <= ww_busy_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_state.idle~DUPLICATE_q\ <= NOT \state.idle~DUPLICATE_q\;
\ALT_INV_num_of_ones[0]~DUPLICATE_q\ <= NOT \num_of_ones[0]~DUPLICATE_q\;
\ALT_INV_index[29]~DUPLICATE_q\ <= NOT \index[29]~DUPLICATE_q\;
\ALT_INV_index[27]~DUPLICATE_q\ <= NOT \index[27]~DUPLICATE_q\;
\ALT_INV_index[25]~DUPLICATE_q\ <= NOT \index[25]~DUPLICATE_q\;
\ALT_INV_index[24]~DUPLICATE_q\ <= NOT \index[24]~DUPLICATE_q\;
\ALT_INV_index[20]~DUPLICATE_q\ <= NOT \index[20]~DUPLICATE_q\;
\ALT_INV_index[19]~DUPLICATE_q\ <= NOT \index[19]~DUPLICATE_q\;
\ALT_INV_index[15]~DUPLICATE_q\ <= NOT \index[15]~DUPLICATE_q\;
\ALT_INV_index[12]~DUPLICATE_q\ <= NOT \index[12]~DUPLICATE_q\;
\ALT_INV_index[11]~DUPLICATE_q\ <= NOT \index[11]~DUPLICATE_q\;
\ALT_INV_index[8]~DUPLICATE_q\ <= NOT \index[8]~DUPLICATE_q\;
\ALT_INV_index[7]~DUPLICATE_q\ <= NOT \index[7]~DUPLICATE_q\;
\ALT_INV_index[6]~DUPLICATE_q\ <= NOT \index[6]~DUPLICATE_q\;
\ALT_INV_index[3]~DUPLICATE_q\ <= NOT \index[3]~DUPLICATE_q\;
\ALT_INV_index[2]~DUPLICATE_q\ <= NOT \index[2]~DUPLICATE_q\;
\ALT_INV_index[1]~DUPLICATE_q\ <= NOT \index[1]~DUPLICATE_q\;
\ALT_INV_word_in[3]~input_o\ <= NOT \word_in[3]~input_o\;
\ALT_INV_word_in[2]~input_o\ <= NOT \word_in[2]~input_o\;
\ALT_INV_word_in[1]~input_o\ <= NOT \word_in[1]~input_o\;
\ALT_INV_word_in[0]~input_o\ <= NOT \word_in[0]~input_o\;
\ALT_INV_word_valid~input_o\ <= NOT \word_valid~input_o\;
\ALT_INV_resetn~input_o\ <= NOT \resetn~input_o\;
\ALT_INV_Mux0~0_combout\ <= NOT \Mux0~0_combout\;
ALT_INV_word_in_reg(3) <= NOT word_in_reg(3);
ALT_INV_word_in_reg(2) <= NOT word_in_reg(2);
ALT_INV_word_in_reg(1) <= NOT word_in_reg(1);
ALT_INV_word_in_reg(0) <= NOT word_in_reg(0);
\ALT_INV_state.reset_state~q\ <= NOT \state.reset_state~q\;
\ALT_INV_state.s23~q\ <= NOT \state.s23~q\;
\ALT_INV_target_bit~q\ <= NOT \target_bit~q\;
\ALT_INV_state.idle~q\ <= NOT \state.idle~q\;
\ALT_INV_word_valid_reg~q\ <= NOT \word_valid_reg~q\;
\ALT_INV_Equal0~6_combout\ <= NOT \Equal0~6_combout\;
\ALT_INV_Equal0~5_combout\ <= NOT \Equal0~5_combout\;
\ALT_INV_Equal0~4_combout\ <= NOT \Equal0~4_combout\;
\ALT_INV_Equal0~3_combout\ <= NOT \Equal0~3_combout\;
\ALT_INV_Equal0~2_combout\ <= NOT \Equal0~2_combout\;
\ALT_INV_Equal0~1_combout\ <= NOT \Equal0~1_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_state.s1~q\ <= NOT \state.s1~q\;
\ALT_INV_state.s3~q\ <= NOT \state.s3~q\;
\ALT_INV_state.s2~q\ <= NOT \state.s2~q\;
\ALT_INV_Selector48~0_combout\ <= NOT \Selector48~0_combout\;
\ALT_INV_state.s5~q\ <= NOT \state.s5~q\;
\ALT_INV_state.s0~q\ <= NOT \state.s0~q\;
\ALT_INV_state.s4~q\ <= NOT \state.s4~q\;
\ALT_INV_busy~q\ <= NOT \busy~q\;
ALT_INV_index(31) <= NOT index(31);
ALT_INV_index(0) <= NOT index(0);
ALT_INV_num_of_ones(3) <= NOT num_of_ones(3);
ALT_INV_num_of_ones(2) <= NOT num_of_ones(2);
ALT_INV_num_of_ones(1) <= NOT num_of_ones(1);
ALT_INV_num_of_ones(0) <= NOT num_of_ones(0);
\ALT_INV_p_valid~reg0_q\ <= NOT \p_valid~reg0_q\;
\ALT_INV_p_bit~reg0_q\ <= NOT \p_bit~reg0_q\;
\ALT_INV_Add1~125_sumout\ <= NOT \Add1~125_sumout\;
\ALT_INV_Add1~1_sumout\ <= NOT \Add1~1_sumout\;
ALT_INV_index(30) <= NOT index(30);
ALT_INV_index(28) <= NOT index(28);
ALT_INV_index(26) <= NOT index(26);
ALT_INV_index(23) <= NOT index(23);
ALT_INV_index(22) <= NOT index(22);
ALT_INV_index(21) <= NOT index(21);
ALT_INV_index(19) <= NOT index(19);
ALT_INV_index(18) <= NOT index(18);
ALT_INV_index(17) <= NOT index(17);
ALT_INV_index(16) <= NOT index(16);
ALT_INV_index(15) <= NOT index(15);
ALT_INV_index(14) <= NOT index(14);
ALT_INV_index(13) <= NOT index(13);
ALT_INV_index(12) <= NOT index(12);
ALT_INV_index(10) <= NOT index(10);
ALT_INV_index(9) <= NOT index(9);
ALT_INV_index(8) <= NOT index(8);
ALT_INV_index(6) <= NOT index(6);
ALT_INV_index(5) <= NOT index(5);
ALT_INV_index(4) <= NOT index(4);
ALT_INV_index(3) <= NOT index(3);
ALT_INV_index(2) <= NOT index(2);
ALT_INV_index(1) <= NOT index(1);

-- Location: IOOBUF_X68_Y0_N36
\p_bit~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \p_bit~reg0_q\,
	devoe => ww_devoe,
	o => ww_p_bit);

-- Location: IOOBUF_X64_Y0_N19
\p_valid~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \p_valid~reg0_q\,
	devoe => ww_devoe,
	o => ww_p_valid);

-- Location: IOOBUF_X89_Y36_N5
\num_of_ones_out[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => num_of_ones(0),
	devoe => ww_devoe,
	o => ww_num_of_ones_out(0));

-- Location: IOOBUF_X64_Y0_N36
\num_of_ones_out[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => num_of_ones(1),
	devoe => ww_devoe,
	o => ww_num_of_ones_out(1));

-- Location: IOOBUF_X64_Y0_N53
\num_of_ones_out[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => num_of_ones(2),
	devoe => ww_devoe,
	o => ww_num_of_ones_out(2));

-- Location: IOOBUF_X64_Y0_N2
\num_of_ones_out[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => num_of_ones(3),
	devoe => ww_devoe,
	o => ww_num_of_ones_out(3));

-- Location: IOOBUF_X89_Y8_N56
\index_out[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(0),
	devoe => ww_devoe,
	o => ww_index_out(0));

-- Location: IOOBUF_X89_Y8_N39
\index_out[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(1),
	devoe => ww_devoe,
	o => ww_index_out(1));

-- Location: IOOBUF_X89_Y6_N39
\index_out[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \index[2]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_index_out(2));

-- Location: IOOBUF_X89_Y8_N5
\index_out[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \index[3]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_index_out(3));

-- Location: IOOBUF_X72_Y0_N36
\index_out[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(4),
	devoe => ww_devoe,
	o => ww_index_out(4));

-- Location: IOOBUF_X72_Y0_N2
\index_out[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(5),
	devoe => ww_devoe,
	o => ww_index_out(5));

-- Location: IOOBUF_X89_Y6_N5
\index_out[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \index[6]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_index_out(6));

-- Location: IOOBUF_X89_Y6_N56
\index_out[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(7),
	devoe => ww_devoe,
	o => ww_index_out(7));

-- Location: IOOBUF_X89_Y4_N79
\index_out[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \index[8]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_index_out(8));

-- Location: IOOBUF_X89_Y4_N96
\index_out[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(9),
	devoe => ww_devoe,
	o => ww_index_out(9));

-- Location: IOOBUF_X89_Y35_N79
\index_out[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(10),
	devoe => ww_devoe,
	o => ww_index_out(10));

-- Location: IOOBUF_X89_Y35_N45
\index_out[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(11),
	devoe => ww_devoe,
	o => ww_index_out(11));

-- Location: IOOBUF_X89_Y4_N45
\index_out[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(12),
	devoe => ww_devoe,
	o => ww_index_out(12));

-- Location: IOOBUF_X72_Y0_N19
\index_out[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(13),
	devoe => ww_devoe,
	o => ww_index_out(13));

-- Location: IOOBUF_X72_Y0_N53
\index_out[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(14),
	devoe => ww_devoe,
	o => ww_index_out(14));

-- Location: IOOBUF_X89_Y35_N96
\index_out[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(15),
	devoe => ww_devoe,
	o => ww_index_out(15));

-- Location: IOOBUF_X62_Y0_N19
\index_out[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(16),
	devoe => ww_devoe,
	o => ww_index_out(16));

-- Location: IOOBUF_X89_Y6_N22
\index_out[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(17),
	devoe => ww_devoe,
	o => ww_index_out(17));

-- Location: IOOBUF_X62_Y0_N53
\index_out[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(18),
	devoe => ww_devoe,
	o => ww_index_out(18));

-- Location: IOOBUF_X89_Y4_N62
\index_out[19]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(19),
	devoe => ww_devoe,
	o => ww_index_out(19));

-- Location: IOOBUF_X89_Y9_N5
\index_out[20]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(20),
	devoe => ww_devoe,
	o => ww_index_out(20));

-- Location: IOOBUF_X89_Y9_N39
\index_out[21]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(21),
	devoe => ww_devoe,
	o => ww_index_out(21));

-- Location: IOOBUF_X89_Y36_N22
\index_out[22]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(22),
	devoe => ww_devoe,
	o => ww_index_out(22));

-- Location: IOOBUF_X66_Y0_N93
\index_out[23]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(23),
	devoe => ww_devoe,
	o => ww_index_out(23));

-- Location: IOOBUF_X66_Y0_N42
\index_out[24]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(24),
	devoe => ww_devoe,
	o => ww_index_out(24));

-- Location: IOOBUF_X89_Y37_N22
\index_out[25]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(25),
	devoe => ww_devoe,
	o => ww_index_out(25));

-- Location: IOOBUF_X89_Y37_N56
\index_out[26]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(26),
	devoe => ww_devoe,
	o => ww_index_out(26));

-- Location: IOOBUF_X89_Y9_N56
\index_out[27]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(27),
	devoe => ww_devoe,
	o => ww_index_out(27));

-- Location: IOOBUF_X66_Y0_N59
\index_out[28]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(28),
	devoe => ww_devoe,
	o => ww_index_out(28));

-- Location: IOOBUF_X89_Y9_N22
\index_out[29]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(29),
	devoe => ww_devoe,
	o => ww_index_out(29));

-- Location: IOOBUF_X68_Y0_N53
\index_out[30]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(30),
	devoe => ww_devoe,
	o => ww_index_out(30));

-- Location: IOOBUF_X66_Y0_N76
\index_out[31]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(31),
	devoe => ww_devoe,
	o => ww_index_out(31));

-- Location: IOOBUF_X68_Y0_N19
\busy_out~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \busy~q\,
	devoe => ww_devoe,
	o => ww_busy_out);

-- Location: IOIBUF_X89_Y35_N61
\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G10
\clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk~input_o\,
	outclk => \clk~inputCLKENA0_outclk\);

-- Location: IOIBUF_X70_Y0_N18
\word_valid~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_valid,
	o => \word_valid~input_o\);

-- Location: IOIBUF_X89_Y8_N21
\resetn~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_resetn,
	o => \resetn~input_o\);

-- Location: FF_X87_Y13_N50
\state.s5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \state.s4~q\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s5~q\);

-- Location: MLABCELL_X87_Y13_N27
\state.reset_state~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \state.reset_state~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	combout => \state.reset_state~feeder_combout\);

-- Location: FF_X87_Y13_N28
\state.reset_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \state.reset_state~feeder_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.reset_state~q\);

-- Location: MLABCELL_X87_Y13_N24
\Selector0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = ( \state.reset_state~q\ & ( ((!\word_valid_reg~q\ & \state.idle~q\)) # (\state.s5~q\) ) ) # ( !\state.reset_state~q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100001111110011110000111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_word_valid_reg~q\,
	datac => \ALT_INV_state.s5~q\,
	datad => \ALT_INV_state.idle~q\,
	dataf => \ALT_INV_state.reset_state~q\,
	combout => \Selector0~0_combout\);

-- Location: FF_X87_Y13_N25
\state.idle\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector0~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.idle~q\);

-- Location: MLABCELL_X87_Y13_N42
\word_valid_reg~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \word_valid_reg~0_combout\ = ( \word_valid_reg~q\ & ( \state.idle~q\ & ( (!\resetn~input_o\) # (\word_valid~input_o\) ) ) ) # ( !\word_valid_reg~q\ & ( \state.idle~q\ & ( (\word_valid~input_o\ & \resetn~input_o\) ) ) ) # ( \word_valid_reg~q\ & ( 
-- !\state.idle~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000001100111111111100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_word_valid~input_o\,
	datad => \ALT_INV_resetn~input_o\,
	datae => \ALT_INV_word_valid_reg~q\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \word_valid_reg~0_combout\);

-- Location: FF_X87_Y13_N44
word_valid_reg : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \word_valid_reg~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \word_valid_reg~q\);

-- Location: FF_X87_Y13_N26
\state.idle~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector0~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.idle~DUPLICATE_q\);

-- Location: MLABCELL_X87_Y13_N57
\state~22\ : cyclonev_lcell_comb
-- Equation(s):
-- \state~22_combout\ = ( \state.idle~DUPLICATE_q\ & ( \word_valid_reg~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_word_valid_reg~q\,
	dataf => \ALT_INV_state.idle~DUPLICATE_q\,
	combout => \state~22_combout\);

-- Location: FF_X87_Y13_N59
\state.s0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \state~22_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s0~q\);

-- Location: MLABCELL_X87_Y13_N36
\Selector48~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector48~0_combout\ = ( \state.s5~q\ ) # ( !\state.s5~q\ & ( \state.s0~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_state.s0~q\,
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector48~0_combout\);

-- Location: LABCELL_X88_Y14_N0
\Add1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~1_sumout\ = SUM(( index(0) ) + ( VCC ) + ( !VCC ))
-- \Add1~2\ = CARRY(( index(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(0),
	cin => GND,
	sumout => \Add1~1_sumout\,
	cout => \Add1~2\);

-- Location: MLABCELL_X87_Y14_N36
\Selector47~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector47~0_combout\ = ( !\Selector48~0_combout\ & ( \Add1~1_sumout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_Selector48~0_combout\,
	dataf => \ALT_INV_Add1~1_sumout\,
	combout => \Selector47~0_combout\);

-- Location: MLABCELL_X87_Y13_N33
\Selector6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = ( \state.s1~q\ & ( !\Equal0~6_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~6_combout\,
	dataf => \ALT_INV_state.s1~q\,
	combout => \Selector6~0_combout\);

-- Location: FF_X87_Y13_N34
\state.s23\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector6~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s23~q\);

-- Location: MLABCELL_X87_Y13_N18
\Selector3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = ( \state.s23~q\ & ( !\target_bit~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011001100110011001100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_target_bit~q\,
	dataf => \ALT_INV_state.s23~q\,
	combout => \Selector3~0_combout\);

-- Location: FF_X87_Y13_N19
\state.s3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector3~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s3~q\);

-- Location: MLABCELL_X87_Y13_N39
\Selector1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = ( \state.s3~q\ ) # ( !\state.s3~q\ & ( (\state.s0~q\) # (\state.s2~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111010111110101111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s2~q\,
	datac => \ALT_INV_state.s0~q\,
	dataf => \ALT_INV_state.s3~q\,
	combout => \Selector1~0_combout\);

-- Location: FF_X87_Y13_N41
\state.s1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector1~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s1~q\);

-- Location: IOIBUF_X68_Y0_N1
\word_in[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(2),
	o => \word_in[2]~input_o\);

-- Location: MLABCELL_X87_Y14_N12
\Selector8~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector8~0_combout\ = (\state.idle~DUPLICATE_q\ & \word_in[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100000101000001010000010100000101000001010000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.idle~DUPLICATE_q\,
	datac => \ALT_INV_word_in[2]~input_o\,
	combout => \Selector8~0_combout\);

-- Location: MLABCELL_X87_Y14_N0
\Selector7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = ( \state.idle~DUPLICATE_q\ ) # ( !\state.idle~DUPLICATE_q\ & ( \state.s5~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state.s5~q\,
	dataf => \ALT_INV_state.idle~DUPLICATE_q\,
	combout => \Selector7~0_combout\);

-- Location: FF_X87_Y14_N14
\word_in_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector8~0_combout\,
	clrn => \resetn~input_o\,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(2));

-- Location: IOIBUF_X70_Y0_N35
\word_in[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(1),
	o => \word_in[1]~input_o\);

-- Location: MLABCELL_X87_Y14_N33
\Selector9~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector9~0_combout\ = ( \word_in[1]~input_o\ & ( \state.idle~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.idle~DUPLICATE_q\,
	dataf => \ALT_INV_word_in[1]~input_o\,
	combout => \Selector9~0_combout\);

-- Location: FF_X87_Y14_N35
\word_in_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector9~0_combout\,
	clrn => \resetn~input_o\,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(1));

-- Location: IOIBUF_X70_Y0_N1
\word_in[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(0),
	o => \word_in[0]~input_o\);

-- Location: MLABCELL_X87_Y14_N30
\Selector10~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector10~0_combout\ = ( \word_in[0]~input_o\ & ( \state.idle~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.idle~DUPLICATE_q\,
	dataf => \ALT_INV_word_in[0]~input_o\,
	combout => \Selector10~0_combout\);

-- Location: FF_X87_Y14_N32
\word_in_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector10~0_combout\,
	clrn => \resetn~input_o\,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(0));

-- Location: IOIBUF_X70_Y0_N52
\word_in[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(3),
	o => \word_in[3]~input_o\);

-- Location: MLABCELL_X87_Y14_N15
\Selector7~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector7~1_combout\ = (\state.idle~DUPLICATE_q\ & \word_in[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100000101000001010000010100000101000001010000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.idle~DUPLICATE_q\,
	datac => \ALT_INV_word_in[3]~input_o\,
	combout => \Selector7~1_combout\);

-- Location: FF_X87_Y14_N17
\word_in_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector7~1_combout\,
	clrn => \resetn~input_o\,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(3));

-- Location: MLABCELL_X87_Y14_N18
\Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = ( \index[1]~DUPLICATE_q\ & ( word_in_reg(3) & ( (word_in_reg(2)) # (index(0)) ) ) ) # ( !\index[1]~DUPLICATE_q\ & ( word_in_reg(3) & ( (!index(0) & ((word_in_reg(0)))) # (index(0) & (word_in_reg(1))) ) ) ) # ( \index[1]~DUPLICATE_q\ & ( 
-- !word_in_reg(3) & ( (!index(0) & word_in_reg(2)) ) ) ) # ( !\index[1]~DUPLICATE_q\ & ( !word_in_reg(3) & ( (!index(0) & ((word_in_reg(0)))) # (index(0) & (word_in_reg(1))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010110101111001000100010001000000101101011110111011101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(0),
	datab => ALT_INV_word_in_reg(2),
	datac => ALT_INV_word_in_reg(1),
	datad => ALT_INV_word_in_reg(0),
	datae => \ALT_INV_index[1]~DUPLICATE_q\,
	dataf => ALT_INV_word_in_reg(3),
	combout => \Mux0~0_combout\);

-- Location: MLABCELL_X87_Y13_N30
\Selector50~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector50~0_combout\ = ( \state.s5~q\ & ( (\state.s1~q\ & ((!\Equal0~6_combout\ & (\Mux0~0_combout\)) # (\Equal0~6_combout\ & ((\target_bit~q\))))) ) ) # ( !\state.s5~q\ & ( (!\Equal0~6_combout\ & ((!\state.s1~q\ & ((\target_bit~q\))) # (\state.s1~q\ & 
-- (\Mux0~0_combout\)))) # (\Equal0~6_combout\ & (((\target_bit~q\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001011011111000000101101111100000010000100110000001000010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~6_combout\,
	datab => \ALT_INV_state.s1~q\,
	datac => \ALT_INV_Mux0~0_combout\,
	datad => \ALT_INV_target_bit~q\,
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector50~0_combout\);

-- Location: FF_X87_Y13_N32
target_bit : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector50~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \target_bit~q\);

-- Location: MLABCELL_X87_Y13_N21
\Selector2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = ( \state.s23~q\ & ( \target_bit~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_target_bit~q\,
	dataf => \ALT_INV_state.s23~q\,
	combout => \Selector2~0_combout\);

-- Location: FF_X87_Y13_N23
\state.s2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector2~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s2~q\);

-- Location: MLABCELL_X87_Y13_N48
\WideOr9~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \WideOr9~0_combout\ = ( \state.s3~q\ ) # ( !\state.s3~q\ & ( ((\state.s5~q\) # (\state.s2~q\)) # (\state.s0~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111111111111001111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s0~q\,
	datac => \ALT_INV_state.s2~q\,
	datad => \ALT_INV_state.s5~q\,
	dataf => \ALT_INV_state.s3~q\,
	combout => \WideOr9~0_combout\);

-- Location: FF_X88_Y14_N2
\index[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector47~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(0));

-- Location: LABCELL_X88_Y14_N3
\Add1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~5_sumout\ = SUM(( \index[1]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~2\ ))
-- \Add1~6\ = CARRY(( \index[1]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[1]~DUPLICATE_q\,
	cin => \Add1~2\,
	sumout => \Add1~5_sumout\,
	cout => \Add1~6\);

-- Location: FF_X88_Y14_N5
\index[1]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~5_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[1]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y14_N6
\Add1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~9_sumout\ = SUM(( index(2) ) + ( GND ) + ( \Add1~6\ ))
-- \Add1~10\ = CARRY(( index(2) ) + ( GND ) + ( \Add1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(2),
	cin => \Add1~6\,
	sumout => \Add1~9_sumout\,
	cout => \Add1~10\);

-- Location: FF_X88_Y14_N7
\index[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~9_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(2));

-- Location: LABCELL_X88_Y14_N9
\Add1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~13_sumout\ = SUM(( index(3) ) + ( GND ) + ( \Add1~10\ ))
-- \Add1~14\ = CARRY(( index(3) ) + ( GND ) + ( \Add1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(3),
	cin => \Add1~10\,
	sumout => \Add1~13_sumout\,
	cout => \Add1~14\);

-- Location: FF_X88_Y14_N11
\index[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~13_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(3));

-- Location: LABCELL_X88_Y14_N12
\Add1~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~17_sumout\ = SUM(( index(4) ) + ( GND ) + ( \Add1~14\ ))
-- \Add1~18\ = CARRY(( index(4) ) + ( GND ) + ( \Add1~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(4),
	cin => \Add1~14\,
	sumout => \Add1~17_sumout\,
	cout => \Add1~18\);

-- Location: FF_X88_Y14_N14
\index[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~17_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(4));

-- Location: LABCELL_X88_Y14_N15
\Add1~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~21_sumout\ = SUM(( index(5) ) + ( GND ) + ( \Add1~18\ ))
-- \Add1~22\ = CARRY(( index(5) ) + ( GND ) + ( \Add1~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(5),
	cin => \Add1~18\,
	sumout => \Add1~21_sumout\,
	cout => \Add1~22\);

-- Location: FF_X88_Y14_N17
\index[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~21_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(5));

-- Location: LABCELL_X88_Y14_N18
\Add1~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~25_sumout\ = SUM(( index(6) ) + ( GND ) + ( \Add1~22\ ))
-- \Add1~26\ = CARRY(( index(6) ) + ( GND ) + ( \Add1~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(6),
	cin => \Add1~22\,
	sumout => \Add1~25_sumout\,
	cout => \Add1~26\);

-- Location: FF_X88_Y14_N20
\index[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~25_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(6));

-- Location: LABCELL_X88_Y14_N21
\Add1~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~29_sumout\ = SUM(( \index[7]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~26\ ))
-- \Add1~30\ = CARRY(( \index[7]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[7]~DUPLICATE_q\,
	cin => \Add1~26\,
	sumout => \Add1~29_sumout\,
	cout => \Add1~30\);

-- Location: FF_X88_Y14_N23
\index[7]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~29_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[7]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y14_N24
\Add1~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~33_sumout\ = SUM(( index(8) ) + ( GND ) + ( \Add1~30\ ))
-- \Add1~34\ = CARRY(( index(8) ) + ( GND ) + ( \Add1~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(8),
	cin => \Add1~30\,
	sumout => \Add1~33_sumout\,
	cout => \Add1~34\);

-- Location: FF_X88_Y14_N26
\index[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~33_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(8));

-- Location: LABCELL_X88_Y14_N27
\Add1~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~37_sumout\ = SUM(( index(9) ) + ( GND ) + ( \Add1~34\ ))
-- \Add1~38\ = CARRY(( index(9) ) + ( GND ) + ( \Add1~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(9),
	cin => \Add1~34\,
	sumout => \Add1~37_sumout\,
	cout => \Add1~38\);

-- Location: FF_X88_Y14_N29
\index[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~37_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(9));

-- Location: LABCELL_X88_Y14_N30
\Add1~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~41_sumout\ = SUM(( index(10) ) + ( GND ) + ( \Add1~38\ ))
-- \Add1~42\ = CARRY(( index(10) ) + ( GND ) + ( \Add1~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(10),
	cin => \Add1~38\,
	sumout => \Add1~41_sumout\,
	cout => \Add1~42\);

-- Location: FF_X88_Y14_N31
\index[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~41_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(10));

-- Location: LABCELL_X88_Y14_N33
\Add1~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~45_sumout\ = SUM(( \index[11]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~42\ ))
-- \Add1~46\ = CARRY(( \index[11]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_index[11]~DUPLICATE_q\,
	cin => \Add1~42\,
	sumout => \Add1~45_sumout\,
	cout => \Add1~46\);

-- Location: FF_X88_Y14_N35
\index[11]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~45_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[11]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y14_N36
\Add1~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~49_sumout\ = SUM(( \index[12]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~46\ ))
-- \Add1~50\ = CARRY(( \index[12]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[12]~DUPLICATE_q\,
	cin => \Add1~46\,
	sumout => \Add1~49_sumout\,
	cout => \Add1~50\);

-- Location: FF_X88_Y14_N38
\index[12]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~49_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[12]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y14_N39
\Add1~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~53_sumout\ = SUM(( index(13) ) + ( GND ) + ( \Add1~50\ ))
-- \Add1~54\ = CARRY(( index(13) ) + ( GND ) + ( \Add1~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(13),
	cin => \Add1~50\,
	sumout => \Add1~53_sumout\,
	cout => \Add1~54\);

-- Location: FF_X88_Y14_N41
\index[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~53_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(13));

-- Location: LABCELL_X88_Y14_N42
\Add1~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~57_sumout\ = SUM(( index(14) ) + ( GND ) + ( \Add1~54\ ))
-- \Add1~58\ = CARRY(( index(14) ) + ( GND ) + ( \Add1~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(14),
	cin => \Add1~54\,
	sumout => \Add1~57_sumout\,
	cout => \Add1~58\);

-- Location: FF_X88_Y14_N43
\index[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~57_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(14));

-- Location: LABCELL_X88_Y14_N45
\Add1~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~61_sumout\ = SUM(( \index[15]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~58\ ))
-- \Add1~62\ = CARRY(( \index[15]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[15]~DUPLICATE_q\,
	cin => \Add1~58\,
	sumout => \Add1~61_sumout\,
	cout => \Add1~62\);

-- Location: FF_X88_Y14_N47
\index[15]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~61_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[15]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y14_N48
\Add1~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~65_sumout\ = SUM(( index(16) ) + ( GND ) + ( \Add1~62\ ))
-- \Add1~66\ = CARRY(( index(16) ) + ( GND ) + ( \Add1~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(16),
	cin => \Add1~62\,
	sumout => \Add1~65_sumout\,
	cout => \Add1~66\);

-- Location: FF_X88_Y14_N50
\index[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~65_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(16));

-- Location: LABCELL_X88_Y14_N51
\Add1~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~69_sumout\ = SUM(( index(17) ) + ( GND ) + ( \Add1~66\ ))
-- \Add1~70\ = CARRY(( index(17) ) + ( GND ) + ( \Add1~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(17),
	cin => \Add1~66\,
	sumout => \Add1~69_sumout\,
	cout => \Add1~70\);

-- Location: FF_X88_Y14_N52
\index[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~69_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(17));

-- Location: LABCELL_X88_Y14_N54
\Add1~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~73_sumout\ = SUM(( index(18) ) + ( GND ) + ( \Add1~70\ ))
-- \Add1~74\ = CARRY(( index(18) ) + ( GND ) + ( \Add1~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(18),
	cin => \Add1~70\,
	sumout => \Add1~73_sumout\,
	cout => \Add1~74\);

-- Location: FF_X88_Y14_N56
\index[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~73_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(18));

-- Location: LABCELL_X88_Y14_N57
\Add1~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~77_sumout\ = SUM(( \index[19]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~74\ ))
-- \Add1~78\ = CARRY(( \index[19]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[19]~DUPLICATE_q\,
	cin => \Add1~74\,
	sumout => \Add1~77_sumout\,
	cout => \Add1~78\);

-- Location: FF_X88_Y14_N59
\index[19]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~77_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[19]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y13_N0
\Add1~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~81_sumout\ = SUM(( \index[20]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~78\ ))
-- \Add1~82\ = CARRY(( \index[20]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[20]~DUPLICATE_q\,
	cin => \Add1~78\,
	sumout => \Add1~81_sumout\,
	cout => \Add1~82\);

-- Location: FF_X88_Y13_N2
\index[20]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~81_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[20]~DUPLICATE_q\);

-- Location: FF_X88_Y14_N58
\index[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~77_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(19));

-- Location: LABCELL_X88_Y13_N51
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( !index(19) & ( !\index[20]~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_index[20]~DUPLICATE_q\,
	dataf => ALT_INV_index(19),
	combout => \Equal0~0_combout\);

-- Location: LABCELL_X88_Y13_N3
\Add1~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~85_sumout\ = SUM(( index(21) ) + ( GND ) + ( \Add1~82\ ))
-- \Add1~86\ = CARRY(( index(21) ) + ( GND ) + ( \Add1~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(21),
	cin => \Add1~82\,
	sumout => \Add1~85_sumout\,
	cout => \Add1~86\);

-- Location: FF_X88_Y13_N5
\index[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~85_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(21));

-- Location: LABCELL_X88_Y13_N6
\Add1~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~89_sumout\ = SUM(( index(22) ) + ( GND ) + ( \Add1~86\ ))
-- \Add1~90\ = CARRY(( index(22) ) + ( GND ) + ( \Add1~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(22),
	cin => \Add1~86\,
	sumout => \Add1~89_sumout\,
	cout => \Add1~90\);

-- Location: FF_X88_Y13_N7
\index[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~89_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(22));

-- Location: LABCELL_X88_Y13_N9
\Add1~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~93_sumout\ = SUM(( index(23) ) + ( GND ) + ( \Add1~90\ ))
-- \Add1~94\ = CARRY(( index(23) ) + ( GND ) + ( \Add1~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(23),
	cin => \Add1~90\,
	sumout => \Add1~93_sumout\,
	cout => \Add1~94\);

-- Location: FF_X88_Y13_N11
\index[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~93_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(23));

-- Location: LABCELL_X88_Y13_N12
\Add1~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~97_sumout\ = SUM(( \index[24]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~94\ ))
-- \Add1~98\ = CARRY(( \index[24]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~94\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_index[24]~DUPLICATE_q\,
	cin => \Add1~94\,
	sumout => \Add1~97_sumout\,
	cout => \Add1~98\);

-- Location: FF_X88_Y13_N14
\index[24]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~97_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[24]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y13_N15
\Add1~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~101_sumout\ = SUM(( \index[25]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~98\ ))
-- \Add1~102\ = CARRY(( \index[25]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~98\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_index[25]~DUPLICATE_q\,
	cin => \Add1~98\,
	sumout => \Add1~101_sumout\,
	cout => \Add1~102\);

-- Location: FF_X88_Y13_N17
\index[25]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~101_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[25]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y13_N18
\Add1~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~105_sumout\ = SUM(( index(26) ) + ( GND ) + ( \Add1~102\ ))
-- \Add1~106\ = CARRY(( index(26) ) + ( GND ) + ( \Add1~102\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(26),
	cin => \Add1~102\,
	sumout => \Add1~105_sumout\,
	cout => \Add1~106\);

-- Location: FF_X88_Y13_N20
\index[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~105_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(26));

-- Location: LABCELL_X88_Y13_N21
\Add1~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~109_sumout\ = SUM(( \index[27]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~106\ ))
-- \Add1~110\ = CARRY(( \index[27]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~106\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[27]~DUPLICATE_q\,
	cin => \Add1~106\,
	sumout => \Add1~109_sumout\,
	cout => \Add1~110\);

-- Location: FF_X88_Y13_N23
\index[27]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~109_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[27]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y13_N24
\Add1~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~113_sumout\ = SUM(( index(28) ) + ( GND ) + ( \Add1~110\ ))
-- \Add1~114\ = CARRY(( index(28) ) + ( GND ) + ( \Add1~110\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(28),
	cin => \Add1~110\,
	sumout => \Add1~113_sumout\,
	cout => \Add1~114\);

-- Location: FF_X88_Y13_N26
\index[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~113_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(28));

-- Location: LABCELL_X88_Y13_N27
\Add1~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~117_sumout\ = SUM(( \index[29]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~114\ ))
-- \Add1~118\ = CARRY(( \index[29]~DUPLICATE_q\ ) + ( GND ) + ( \Add1~114\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_index[29]~DUPLICATE_q\,
	cin => \Add1~114\,
	sumout => \Add1~117_sumout\,
	cout => \Add1~118\);

-- Location: FF_X88_Y13_N29
\index[29]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~117_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[29]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y13_N30
\Add1~121\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~121_sumout\ = SUM(( index(30) ) + ( GND ) + ( \Add1~118\ ))
-- \Add1~122\ = CARRY(( index(30) ) + ( GND ) + ( \Add1~118\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(30),
	cin => \Add1~118\,
	sumout => \Add1~121_sumout\,
	cout => \Add1~122\);

-- Location: FF_X88_Y13_N31
\index[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~121_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(30));

-- Location: LABCELL_X88_Y13_N33
\Add1~125\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~125_sumout\ = SUM(( index(31) ) + ( GND ) + ( \Add1~122\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(31),
	cin => \Add1~122\,
	sumout => \Add1~125_sumout\);

-- Location: LABCELL_X88_Y13_N48
\Selector16~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector16~0_combout\ = ( \Add1~125_sumout\ & ( !\Selector48~0_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Selector48~0_combout\,
	dataf => \ALT_INV_Add1~125_sumout\,
	combout => \Selector16~0_combout\);

-- Location: FF_X88_Y13_N50
\index[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector16~0_combout\,
	clrn => \resetn~input_o\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(31));

-- Location: LABCELL_X88_Y13_N36
\Equal0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = ( !index(21) & ( !index(0) & ( (!index(31) & (!\index[24]~DUPLICATE_q\ & (!index(22) & !index(23)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(31),
	datab => \ALT_INV_index[24]~DUPLICATE_q\,
	datac => ALT_INV_index(22),
	datad => ALT_INV_index(23),
	datae => ALT_INV_index(21),
	dataf => ALT_INV_index(0),
	combout => \Equal0~4_combout\);

-- Location: FF_X88_Y14_N10
\index[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~13_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[3]~DUPLICATE_q\);

-- Location: FF_X88_Y14_N8
\index[2]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~9_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[2]~DUPLICATE_q\);

-- Location: FF_X88_Y14_N19
\index[6]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~25_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[6]~DUPLICATE_q\);

-- Location: FF_X88_Y14_N4
\index[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~5_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(1));

-- Location: MLABCELL_X87_Y13_N6
\Equal0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = ( !index(1) & ( !index(5) & ( (!\index[3]~DUPLICATE_q\ & (\index[2]~DUPLICATE_q\ & (!index(4) & !\index[6]~DUPLICATE_q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_index[3]~DUPLICATE_q\,
	datab => \ALT_INV_index[2]~DUPLICATE_q\,
	datac => ALT_INV_index(4),
	datad => \ALT_INV_index[6]~DUPLICATE_q\,
	datae => ALT_INV_index(1),
	dataf => ALT_INV_index(5),
	combout => \Equal0~3_combout\);

-- Location: LABCELL_X88_Y13_N42
\Equal0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~5_combout\ = ( !\index[29]~DUPLICATE_q\ & ( !index(26) & ( (!index(30) & (!\index[25]~DUPLICATE_q\ & (!index(28) & !\index[11]~DUPLICATE_q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(30),
	datab => \ALT_INV_index[25]~DUPLICATE_q\,
	datac => ALT_INV_index(28),
	datad => \ALT_INV_index[11]~DUPLICATE_q\,
	datae => \ALT_INV_index[29]~DUPLICATE_q\,
	dataf => ALT_INV_index(26),
	combout => \Equal0~5_combout\);

-- Location: FF_X88_Y14_N37
\index[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~49_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(12));

-- Location: FF_X88_Y14_N25
\index[8]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~33_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[8]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y13_N54
\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ( !\index[8]~DUPLICATE_q\ & ( !index(9) & ( (!index(12) & (!index(10) & (!\index[27]~DUPLICATE_q\ & !\index[7]~DUPLICATE_q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(12),
	datab => ALT_INV_index(10),
	datac => \ALT_INV_index[27]~DUPLICATE_q\,
	datad => \ALT_INV_index[7]~DUPLICATE_q\,
	datae => \ALT_INV_index[8]~DUPLICATE_q\,
	dataf => ALT_INV_index(9),
	combout => \Equal0~2_combout\);

-- Location: FF_X88_Y14_N46
\index[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~61_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(15));

-- Location: MLABCELL_X87_Y13_N12
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( !index(16) & ( !index(13) & ( (!index(17) & (!index(15) & (!index(18) & !index(14)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(17),
	datab => ALT_INV_index(15),
	datac => ALT_INV_index(18),
	datad => ALT_INV_index(14),
	datae => ALT_INV_index(16),
	dataf => ALT_INV_index(13),
	combout => \Equal0~1_combout\);

-- Location: MLABCELL_X87_Y13_N0
\Equal0~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~6_combout\ = ( \Equal0~2_combout\ & ( \Equal0~1_combout\ & ( (\Equal0~0_combout\ & (\Equal0~4_combout\ & (\Equal0~3_combout\ & \Equal0~5_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datab => \ALT_INV_Equal0~4_combout\,
	datac => \ALT_INV_Equal0~3_combout\,
	datad => \ALT_INV_Equal0~5_combout\,
	datae => \ALT_INV_Equal0~2_combout\,
	dataf => \ALT_INV_Equal0~1_combout\,
	combout => \Equal0~6_combout\);

-- Location: MLABCELL_X87_Y13_N54
\Selector4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = ( \state.s1~q\ & ( \Equal0~6_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Equal0~6_combout\,
	dataf => \ALT_INV_state.s1~q\,
	combout => \Selector4~0_combout\);

-- Location: FF_X87_Y13_N56
\state.s4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector4~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s4~q\);

-- Location: FF_X87_Y14_N26
\num_of_ones[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector15~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => num_of_ones(0));

-- Location: MLABCELL_X87_Y14_N24
\Selector15~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector15~0_combout\ = ( !num_of_ones(0) & ( \state.s2~q\ ) ) # ( num_of_ones(0) & ( !\state.s2~q\ & ( !\Selector48~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Selector48~0_combout\,
	datae => ALT_INV_num_of_ones(0),
	dataf => \ALT_INV_state.s2~q\,
	combout => \Selector15~0_combout\);

-- Location: FF_X87_Y14_N25
\num_of_ones[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector15~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \num_of_ones[0]~DUPLICATE_q\);

-- Location: MLABCELL_X87_Y14_N3
\Selector48~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector48~1_combout\ = ( \num_of_ones[0]~DUPLICATE_q\ & ( ((!\Selector48~0_combout\ & \p_bit~reg0_q\)) # (\state.s4~q\) ) ) # ( !\num_of_ones[0]~DUPLICATE_q\ & ( (!\state.s4~q\ & (!\Selector48~0_combout\ & \p_bit~reg0_q\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011000000000000001100000000110011111100110011001111110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s4~q\,
	datac => \ALT_INV_Selector48~0_combout\,
	datad => \ALT_INV_p_bit~reg0_q\,
	dataf => \ALT_INV_num_of_ones[0]~DUPLICATE_q\,
	combout => \Selector48~1_combout\);

-- Location: FF_X87_Y14_N5
\p_bit~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector48~1_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \p_bit~reg0_q\);

-- Location: MLABCELL_X87_Y14_N54
\Selector49~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector49~0_combout\ = ( \p_valid~reg0_q\ & ( \state.s4~q\ ) ) # ( !\p_valid~reg0_q\ & ( \state.s4~q\ ) ) # ( \p_valid~reg0_q\ & ( !\state.s4~q\ & ( !\Selector48~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Selector48~0_combout\,
	datae => \ALT_INV_p_valid~reg0_q\,
	dataf => \ALT_INV_state.s4~q\,
	combout => \Selector49~0_combout\);

-- Location: FF_X87_Y14_N55
\p_valid~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector49~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \p_valid~reg0_q\);

-- Location: MLABCELL_X87_Y14_N42
\Selector14~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector14~0_combout\ = ( num_of_ones(1) & ( \num_of_ones[0]~DUPLICATE_q\ & ( (!\Selector48~0_combout\ & !\state.s2~q\) ) ) ) # ( !num_of_ones(1) & ( \num_of_ones[0]~DUPLICATE_q\ & ( \state.s2~q\ ) ) ) # ( num_of_ones(1) & ( !\num_of_ones[0]~DUPLICATE_q\ 
-- & ( (!\Selector48~0_combout\) # (\state.s2~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011111100111100001111000011111100000011000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Selector48~0_combout\,
	datac => \ALT_INV_state.s2~q\,
	datae => ALT_INV_num_of_ones(1),
	dataf => \ALT_INV_num_of_ones[0]~DUPLICATE_q\,
	combout => \Selector14~0_combout\);

-- Location: FF_X87_Y14_N44
\num_of_ones[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector14~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => num_of_ones(1));

-- Location: MLABCELL_X87_Y14_N51
\Selector13~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector13~0_combout\ = ( num_of_ones(2) & ( \num_of_ones[0]~DUPLICATE_q\ & ( (!\state.s2~q\ & ((!\Selector48~0_combout\))) # (\state.s2~q\ & (!num_of_ones(1))) ) ) ) # ( !num_of_ones(2) & ( \num_of_ones[0]~DUPLICATE_q\ & ( (\state.s2~q\ & 
-- num_of_ones(1)) ) ) ) # ( num_of_ones(2) & ( !\num_of_ones[0]~DUPLICATE_q\ & ( (!\Selector48~0_combout\) # (\state.s2~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111101011111010100010001000100011110010011100100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s2~q\,
	datab => ALT_INV_num_of_ones(1),
	datac => \ALT_INV_Selector48~0_combout\,
	datae => ALT_INV_num_of_ones(2),
	dataf => \ALT_INV_num_of_ones[0]~DUPLICATE_q\,
	combout => \Selector13~0_combout\);

-- Location: FF_X87_Y14_N53
\num_of_ones[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector13~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => num_of_ones(2));

-- Location: MLABCELL_X87_Y14_N6
\Selector12~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector12~0_combout\ = ( num_of_ones(3) & ( \num_of_ones[0]~DUPLICATE_q\ & ( (!\state.s2~q\ & (!\Selector48~0_combout\)) # (\state.s2~q\ & (((!num_of_ones(2)) # (!num_of_ones(1))))) ) ) ) # ( !num_of_ones(3) & ( \num_of_ones[0]~DUPLICATE_q\ & ( 
-- (\state.s2~q\ & (num_of_ones(2) & num_of_ones(1))) ) ) ) # ( num_of_ones(3) & ( !\num_of_ones[0]~DUPLICATE_q\ & ( (!\Selector48~0_combout\) # (\state.s2~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110111011101110100000000000001011101110111011000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s2~q\,
	datab => \ALT_INV_Selector48~0_combout\,
	datac => ALT_INV_num_of_ones(2),
	datad => ALT_INV_num_of_ones(1),
	datae => ALT_INV_num_of_ones(3),
	dataf => \ALT_INV_num_of_ones[0]~DUPLICATE_q\,
	combout => \Selector12~0_combout\);

-- Location: FF_X87_Y14_N7
\num_of_ones[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector12~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => num_of_ones(3));

-- Location: FF_X88_Y14_N22
\index[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~29_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(7));

-- Location: FF_X88_Y14_N34
\index[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~45_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(11));

-- Location: FF_X88_Y13_N1
\index[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~81_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(20));

-- Location: FF_X88_Y13_N13
\index[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~97_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(24));

-- Location: FF_X88_Y13_N16
\index[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~101_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(25));

-- Location: FF_X88_Y13_N22
\index[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~109_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(27));

-- Location: FF_X88_Y13_N28
\index[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~117_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Selector48~0_combout\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(29));

-- Location: MLABCELL_X87_Y13_N51
\Selector11~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector11~0_combout\ = ( \state.s5~q\ & ( \state.s0~q\ ) ) # ( !\state.s5~q\ & ( (\busy~q\) # (\state.s0~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111111111111000011111111111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state.s0~q\,
	datad => \ALT_INV_busy~q\,
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector11~0_combout\);

-- Location: FF_X87_Y13_N52
busy : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector11~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \busy~q\);

-- Location: LABCELL_X53_Y41_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


