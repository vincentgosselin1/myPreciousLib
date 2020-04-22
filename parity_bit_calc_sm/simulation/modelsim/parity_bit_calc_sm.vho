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

-- DATE "04/22/2020 17:25:07"

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
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	parity_bit_calc_sm IS
    PORT (
	clk : IN std_logic;
	resetn : IN std_logic;
	word_in : IN std_logic_vector(3 DOWNTO 0);
	word_valid : IN std_logic;
	p_bit : OUT std_logic;
	p_valid : OUT std_logic;
	num_of_ones_out : OUT IEEE.NUMERIC_STD.unsigned(3 DOWNTO 0);
	index_out : OUT IEEE.NUMERIC_STD.unsigned(3 DOWNTO 0);
	busy_out : OUT std_logic
	);
END parity_bit_calc_sm;

-- Design Ports Information
-- p_bit	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p_valid	=>  Location: PIN_T15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[0]	=>  Location: PIN_R21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[1]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[2]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[3]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[0]	=>  Location: PIN_T22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[1]	=>  Location: PIN_R17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[2]	=>  Location: PIN_P22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[3]	=>  Location: PIN_R15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busy_out	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- resetn	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_valid	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[0]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[1]	=>  Location: PIN_T19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[2]	=>  Location: PIN_T18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[3]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default


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
SIGNAL ww_index_out : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_busy_out : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \resetn~input_o\ : std_logic;
SIGNAL \state.s5~DUPLICATE_q\ : std_logic;
SIGNAL \index[3]~DUPLICATE_q\ : std_logic;
SIGNAL \word_valid~input_o\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \state.idle~q\ : std_logic;
SIGNAL \state~18_combout\ : std_logic;
SIGNAL \state.s0~feeder_combout\ : std_logic;
SIGNAL \state.s0~q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \state.s1~q\ : std_logic;
SIGNAL \state.s3~q\ : std_logic;
SIGNAL \Selector15~0_combout\ : std_logic;
SIGNAL \Selector14~0_combout\ : std_logic;
SIGNAL \index[2]~DUPLICATE_q\ : std_logic;
SIGNAL \word_in[2]~input_o\ : std_logic;
SIGNAL \word_in[3]~input_o\ : std_logic;
SIGNAL \word_in[1]~input_o\ : std_logic;
SIGNAL \word_in[0]~input_o\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \Selector17~0_combout\ : std_logic;
SIGNAL \target_bit~q\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \state.s2~DUPLICATE_q\ : std_logic;
SIGNAL \state.s1~DUPLICATE_q\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \state.s3~DUPLICATE_q\ : std_logic;
SIGNAL \Selector16~0_combout\ : std_logic;
SIGNAL \index[1]~DUPLICATE_q\ : std_logic;
SIGNAL \Selector13~0_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \state.s4~q\ : std_logic;
SIGNAL \state.s5~q\ : std_logic;
SIGNAL \Selector12~0_combout\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \p_bit~reg0_q\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \p_valid~reg0_q\ : std_logic;
SIGNAL \Selector11~0_combout\ : std_logic;
SIGNAL \num_of_ones[1]~DUPLICATE_q\ : std_logic;
SIGNAL \Selector10~0_combout\ : std_logic;
SIGNAL \num_of_ones[2]~DUPLICATE_q\ : std_logic;
SIGNAL \state.s2~q\ : std_logic;
SIGNAL \Selector9~0_combout\ : std_logic;
SIGNAL \num_of_ones[3]~DUPLICATE_q\ : std_logic;
SIGNAL \Selector8~0_combout\ : std_logic;
SIGNAL \busy~q\ : std_logic;
SIGNAL num_of_ones : std_logic_vector(3 DOWNTO 0);
SIGNAL index : std_logic_vector(3 DOWNTO 0);
SIGNAL word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_state.s1~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_state.s3~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_state.s2~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_state.s5~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[3]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[2]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[1]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_num_of_ones[2]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_word_valid~input_o\ : std_logic;
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_state~18_combout\ : std_logic;
SIGNAL \ALT_INV_target_bit~q\ : std_logic;
SIGNAL \ALT_INV_state.s1~q\ : std_logic;
SIGNAL \ALT_INV_state.s3~q\ : std_logic;
SIGNAL \ALT_INV_state.s0~q\ : std_logic;
SIGNAL \ALT_INV_state.s2~q\ : std_logic;
SIGNAL \ALT_INV_state.s5~q\ : std_logic;
SIGNAL \ALT_INV_state.idle~q\ : std_logic;
SIGNAL \ALT_INV_state.s4~q\ : std_logic;
SIGNAL \ALT_INV_busy~q\ : std_logic;
SIGNAL ALT_INV_index : std_logic_vector(3 DOWNTO 0);
SIGNAL ALT_INV_num_of_ones : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_p_valid~reg0_q\ : std_logic;
SIGNAL \ALT_INV_p_bit~reg0_q\ : std_logic;

BEGIN

ww_clk <= clk;
ww_resetn <= resetn;
ww_word_in <= word_in;
ww_word_valid <= word_valid;
p_bit <= ww_p_bit;
p_valid <= ww_p_valid;
num_of_ones_out <= IEEE.NUMERIC_STD.UNSIGNED(ww_num_of_ones_out);
index_out <= IEEE.NUMERIC_STD.UNSIGNED(ww_index_out);
busy_out <= ww_busy_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_state.s1~DUPLICATE_q\ <= NOT \state.s1~DUPLICATE_q\;
\ALT_INV_state.s3~DUPLICATE_q\ <= NOT \state.s3~DUPLICATE_q\;
\ALT_INV_state.s2~DUPLICATE_q\ <= NOT \state.s2~DUPLICATE_q\;
\ALT_INV_state.s5~DUPLICATE_q\ <= NOT \state.s5~DUPLICATE_q\;
\ALT_INV_index[3]~DUPLICATE_q\ <= NOT \index[3]~DUPLICATE_q\;
\ALT_INV_index[2]~DUPLICATE_q\ <= NOT \index[2]~DUPLICATE_q\;
\ALT_INV_index[1]~DUPLICATE_q\ <= NOT \index[1]~DUPLICATE_q\;
\ALT_INV_num_of_ones[2]~DUPLICATE_q\ <= NOT \num_of_ones[2]~DUPLICATE_q\;
\ALT_INV_word_valid~input_o\ <= NOT \word_valid~input_o\;
\ALT_INV_Mux0~0_combout\ <= NOT \Mux0~0_combout\;
ALT_INV_word_in_reg(3) <= NOT word_in_reg(3);
ALT_INV_word_in_reg(2) <= NOT word_in_reg(2);
ALT_INV_word_in_reg(1) <= NOT word_in_reg(1);
ALT_INV_word_in_reg(0) <= NOT word_in_reg(0);
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_state~18_combout\ <= NOT \state~18_combout\;
\ALT_INV_target_bit~q\ <= NOT \target_bit~q\;
\ALT_INV_state.s1~q\ <= NOT \state.s1~q\;
\ALT_INV_state.s3~q\ <= NOT \state.s3~q\;
\ALT_INV_state.s0~q\ <= NOT \state.s0~q\;
\ALT_INV_state.s2~q\ <= NOT \state.s2~q\;
\ALT_INV_state.s5~q\ <= NOT \state.s5~q\;
\ALT_INV_state.idle~q\ <= NOT \state.idle~q\;
\ALT_INV_state.s4~q\ <= NOT \state.s4~q\;
\ALT_INV_busy~q\ <= NOT \busy~q\;
ALT_INV_index(3) <= NOT index(3);
ALT_INV_index(2) <= NOT index(2);
ALT_INV_index(1) <= NOT index(1);
ALT_INV_index(0) <= NOT index(0);
ALT_INV_num_of_ones(3) <= NOT num_of_ones(3);
ALT_INV_num_of_ones(2) <= NOT num_of_ones(2);
ALT_INV_num_of_ones(1) <= NOT num_of_ones(1);
ALT_INV_num_of_ones(0) <= NOT num_of_ones(0);
\ALT_INV_p_valid~reg0_q\ <= NOT \p_valid~reg0_q\;
\ALT_INV_p_bit~reg0_q\ <= NOT \p_bit~reg0_q\;

-- Location: IOOBUF_X89_Y9_N39
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

-- Location: IOOBUF_X89_Y6_N5
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

-- Location: IOOBUF_X89_Y8_N39
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

-- Location: IOOBUF_X89_Y9_N56
\num_of_ones_out[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \num_of_ones[1]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_num_of_ones_out(1));

-- Location: IOOBUF_X89_Y9_N22
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

-- Location: IOOBUF_X89_Y9_N5
\num_of_ones_out[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \num_of_ones[3]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_num_of_ones_out(3));

-- Location: IOOBUF_X89_Y6_N39
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

-- Location: IOOBUF_X89_Y8_N22
\index_out[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \index[1]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_index_out(1));

-- Location: IOOBUF_X89_Y8_N56
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

-- Location: IOOBUF_X89_Y6_N22
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

-- Location: IOOBUF_X89_Y35_N45
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

-- Location: IOIBUF_X89_Y8_N4
\resetn~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_resetn,
	o => \resetn~input_o\);

-- Location: FF_X87_Y19_N52
\state.s5~DUPLICATE\ : dffeas
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
	q => \state.s5~DUPLICATE_q\);

-- Location: FF_X88_Y19_N1
\index[3]~DUPLICATE\ : dffeas
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
	q => \index[3]~DUPLICATE_q\);

-- Location: IOIBUF_X89_Y4_N61
\word_valid~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_valid,
	o => \word_valid~input_o\);

-- Location: LABCELL_X88_Y19_N54
\Selector0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = (!\state.s5~DUPLICATE_q\ & ((\state.idle~q\) # (\word_valid~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101010101010000010101010101000001010101010100000101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datac => \ALT_INV_word_valid~input_o\,
	datad => \ALT_INV_state.idle~q\,
	combout => \Selector0~0_combout\);

-- Location: FF_X88_Y19_N56
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

-- Location: LABCELL_X88_Y19_N30
\state~18\ : cyclonev_lcell_comb
-- Equation(s):
-- \state~18_combout\ = ( !\state.idle~q\ & ( \word_valid~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_word_valid~input_o\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \state~18_combout\);

-- Location: MLABCELL_X87_Y19_N33
\state.s0~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \state.s0~feeder_combout\ = ( \state~18_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_state~18_combout\,
	combout => \state.s0~feeder_combout\);

-- Location: FF_X87_Y19_N35
\state.s0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \state.s0~feeder_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s0~q\);

-- Location: LABCELL_X88_Y19_N42
\Selector1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = ( \state.s3~DUPLICATE_q\ ) # ( !\state.s3~DUPLICATE_q\ & ( \state.s0~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_state.s0~q\,
	dataf => \ALT_INV_state.s3~DUPLICATE_q\,
	combout => \Selector1~0_combout\);

-- Location: FF_X88_Y19_N44
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

-- Location: FF_X88_Y19_N29
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

-- Location: LABCELL_X88_Y19_N45
\Selector15~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector15~0_combout\ = ( index(0) & ( (!\state.s3~DUPLICATE_q\ & (!\state.s5~DUPLICATE_q\ & (!\state.s0~q\ & index(1)))) # (\state.s3~DUPLICATE_q\ & (((!index(1))))) ) ) # ( !index(0) & ( (index(1) & (((!\state.s5~DUPLICATE_q\ & !\state.s0~q\)) # 
-- (\state.s3~DUPLICATE_q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010110011000000001011001100110011100000000011001110000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datab => \ALT_INV_state.s3~DUPLICATE_q\,
	datac => \ALT_INV_state.s0~q\,
	datad => ALT_INV_index(1),
	dataf => ALT_INV_index(0),
	combout => \Selector15~0_combout\);

-- Location: FF_X88_Y19_N47
\index[1]\ : dffeas
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
	q => index(1));

-- Location: FF_X88_Y19_N7
\index[2]\ : dffeas
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
	q => index(2));

-- Location: LABCELL_X88_Y19_N6
\Selector14~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector14~0_combout\ = ( index(2) & ( \state.s5~DUPLICATE_q\ & ( (\state.s3~q\ & ((!index(0)) # (!index(1)))) ) ) ) # ( !index(2) & ( \state.s5~DUPLICATE_q\ & ( (\state.s3~q\ & (index(0) & index(1))) ) ) ) # ( index(2) & ( !\state.s5~DUPLICATE_q\ & ( 
-- (!\state.s3~q\ & (!\state.s0~q\)) # (\state.s3~q\ & (((!index(0)) # (!index(1))))) ) ) ) # ( !index(2) & ( !\state.s5~DUPLICATE_q\ & ( (\state.s3~q\ & (index(0) & index(1))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000101110111011101100000000000000001010101010101010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s3~q\,
	datab => \ALT_INV_state.s0~q\,
	datac => ALT_INV_index(0),
	datad => ALT_INV_index(1),
	datae => ALT_INV_index(2),
	dataf => \ALT_INV_state.s5~DUPLICATE_q\,
	combout => \Selector14~0_combout\);

-- Location: FF_X88_Y19_N8
\index[2]~DUPLICATE\ : dffeas
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
	q => \index[2]~DUPLICATE_q\);

-- Location: IOIBUF_X89_Y4_N44
\word_in[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(2),
	o => \word_in[2]~input_o\);

-- Location: FF_X88_Y19_N32
\word_in_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \word_in[2]~input_o\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \ALT_INV_state.idle~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(2));

-- Location: IOIBUF_X89_Y6_N55
\word_in[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(3),
	o => \word_in[3]~input_o\);

-- Location: FF_X88_Y19_N50
\word_in_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \word_in[3]~input_o\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \ALT_INV_state.idle~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(3));

-- Location: IOIBUF_X89_Y4_N78
\word_in[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(1),
	o => \word_in[1]~input_o\);

-- Location: FF_X88_Y19_N40
\word_in_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \word_in[1]~input_o\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \ALT_INV_state.idle~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(1));

-- Location: IOIBUF_X89_Y35_N95
\word_in[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(0),
	o => \word_in[0]~input_o\);

-- Location: FF_X88_Y19_N35
\word_in_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \word_in[0]~input_o\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \ALT_INV_state.idle~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(0));

-- Location: LABCELL_X88_Y19_N21
\Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = ( word_in_reg(1) & ( word_in_reg(0) & ( (!index(1)) # ((!index(0) & (word_in_reg(2))) # (index(0) & ((word_in_reg(3))))) ) ) ) # ( !word_in_reg(1) & ( word_in_reg(0) & ( (!index(0) & ((!index(1)) # ((word_in_reg(2))))) # (index(0) & 
-- (index(1) & ((word_in_reg(3))))) ) ) ) # ( word_in_reg(1) & ( !word_in_reg(0) & ( (!index(0) & (index(1) & (word_in_reg(2)))) # (index(0) & ((!index(1)) # ((word_in_reg(3))))) ) ) ) # ( !word_in_reg(1) & ( !word_in_reg(0) & ( (index(1) & ((!index(0) & 
-- (word_in_reg(2))) # (index(0) & ((word_in_reg(3)))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001000010011010001100101011110001010100110111100111011011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(0),
	datab => ALT_INV_index(1),
	datac => ALT_INV_word_in_reg(2),
	datad => ALT_INV_word_in_reg(3),
	datae => ALT_INV_word_in_reg(1),
	dataf => ALT_INV_word_in_reg(0),
	combout => \Mux0~0_combout\);

-- Location: LABCELL_X88_Y19_N12
\Selector17~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector17~0_combout\ = ( \Mux0~0_combout\ & ( ((!\state.s5~DUPLICATE_q\ & \target_bit~q\)) # (\state.s1~q\) ) ) # ( !\Mux0~0_combout\ & ( (!\state.s1~q\ & (!\state.s5~DUPLICATE_q\ & \target_bit~q\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011000000000000001100000000110011111100110011001111110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s1~q\,
	datac => \ALT_INV_state.s5~DUPLICATE_q\,
	datad => \ALT_INV_target_bit~q\,
	dataf => \ALT_INV_Mux0~0_combout\,
	combout => \Selector17~0_combout\);

-- Location: FF_X88_Y19_N14
target_bit : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector17~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \target_bit~q\);

-- Location: LABCELL_X88_Y19_N36
\Selector2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = ( index(1) & ( \target_bit~q\ & ( (\state.s1~q\ & (((!index(0)) # (\index[2]~DUPLICATE_q\)) # (index(3)))) ) ) ) # ( !index(1) & ( \target_bit~q\ & ( \state.s1~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000110011001100110011000100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(3),
	datab => \ALT_INV_state.s1~q\,
	datac => ALT_INV_index(0),
	datad => \ALT_INV_index[2]~DUPLICATE_q\,
	datae => ALT_INV_index(1),
	dataf => \ALT_INV_target_bit~q\,
	combout => \Selector2~0_combout\);

-- Location: FF_X88_Y19_N20
\state.s2~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector2~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s2~DUPLICATE_q\);

-- Location: FF_X88_Y19_N43
\state.s1~DUPLICATE\ : dffeas
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
	q => \state.s1~DUPLICATE_q\);

-- Location: LABCELL_X88_Y19_N51
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( index(1) & ( index(0) & ( (!\index[2]~DUPLICATE_q\ & !index(3)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_index[2]~DUPLICATE_q\,
	datad => ALT_INV_index(3),
	datae => ALT_INV_index(1),
	dataf => ALT_INV_index(0),
	combout => \Equal0~0_combout\);

-- Location: LABCELL_X88_Y19_N27
\Selector3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = ( \Equal0~0_combout\ & ( \state.s2~DUPLICATE_q\ ) ) # ( !\Equal0~0_combout\ & ( ((!\target_bit~q\ & \state.s1~DUPLICATE_q\)) # (\state.s2~DUPLICATE_q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010111110101010101011111010101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s2~DUPLICATE_q\,
	datac => \ALT_INV_target_bit~q\,
	datad => \ALT_INV_state.s1~DUPLICATE_q\,
	dataf => \ALT_INV_Equal0~0_combout\,
	combout => \Selector3~0_combout\);

-- Location: FF_X88_Y19_N28
\state.s3~DUPLICATE\ : dffeas
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
	q => \state.s3~DUPLICATE_q\);

-- Location: LABCELL_X88_Y19_N24
\Selector16~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector16~0_combout\ = ( \state.s3~DUPLICATE_q\ & ( !index(0) ) ) # ( !\state.s3~DUPLICATE_q\ & ( (!\state.s0~q\ & (!\state.s5~DUPLICATE_q\ & index(0))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011000000000000001100000011111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s0~q\,
	datac => \ALT_INV_state.s5~DUPLICATE_q\,
	datad => ALT_INV_index(0),
	dataf => \ALT_INV_state.s3~DUPLICATE_q\,
	combout => \Selector16~0_combout\);

-- Location: FF_X88_Y19_N26
\index[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector16~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(0));

-- Location: FF_X88_Y19_N46
\index[1]~DUPLICATE\ : dffeas
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
	q => \index[1]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y19_N0
\Selector13~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector13~0_combout\ = ( !\state.s3~q\ & ( (!\state.s5~DUPLICATE_q\ & (\index[3]~DUPLICATE_q\ & (!\state.s0~q\))) ) ) # ( \state.s3~q\ & ( (!\index[3]~DUPLICATE_q\ $ (((!index(0)) # ((!\index[2]~DUPLICATE_q\) # (!\index[1]~DUPLICATE_q\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "0010000000100000001100110011001100100000001000000011001100111100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datab => \ALT_INV_index[3]~DUPLICATE_q\,
	datac => ALT_INV_index(0),
	datad => \ALT_INV_index[2]~DUPLICATE_q\,
	datae => \ALT_INV_state.s3~q\,
	dataf => \ALT_INV_index[1]~DUPLICATE_q\,
	datag => \ALT_INV_state.s0~q\,
	combout => \Selector13~0_combout\);

-- Location: FF_X88_Y19_N2
\index[3]\ : dffeas
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
	q => index(3));

-- Location: LABCELL_X88_Y19_N15
\Selector4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = ( index(0) & ( (!index(3) & (\state.s1~q\ & (index(1) & !index(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(3),
	datab => \ALT_INV_state.s1~q\,
	datac => ALT_INV_index(1),
	datad => ALT_INV_index(2),
	dataf => ALT_INV_index(0),
	combout => \Selector4~0_combout\);

-- Location: FF_X88_Y19_N17
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

-- Location: FF_X87_Y19_N53
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

-- Location: MLABCELL_X87_Y19_N15
\Selector12~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector12~0_combout\ = ( !num_of_ones(0) & ( \state.s0~q\ & ( \state.s2~DUPLICATE_q\ ) ) ) # ( num_of_ones(0) & ( !\state.s0~q\ & ( (!\state.s2~DUPLICATE_q\ & !\state.s5~q\) ) ) ) # ( !num_of_ones(0) & ( !\state.s0~q\ & ( \state.s2~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111111100000000000000001111000011110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state.s2~DUPLICATE_q\,
	datad => \ALT_INV_state.s5~q\,
	datae => ALT_INV_num_of_ones(0),
	dataf => \ALT_INV_state.s0~q\,
	combout => \Selector12~0_combout\);

-- Location: FF_X87_Y19_N17
\num_of_ones[0]\ : dffeas
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
	q => num_of_ones(0));

-- Location: MLABCELL_X87_Y19_N48
\Selector6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = ( \p_bit~reg0_q\ & ( \state.idle~q\ & ( (!\state.s4~q\ & (!\state.s5~q\)) # (\state.s4~q\ & ((num_of_ones(0)))) ) ) ) # ( !\p_bit~reg0_q\ & ( \state.idle~q\ & ( (\state.s4~q\ & num_of_ones(0)) ) ) ) # ( \p_bit~reg0_q\ & ( 
-- !\state.idle~q\ & ( (\state.s4~q\ & num_of_ones(0)) ) ) ) # ( !\p_bit~reg0_q\ & ( !\state.idle~q\ & ( (\state.s4~q\ & num_of_ones(0)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100000000000011111010000010101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~q\,
	datac => \ALT_INV_state.s4~q\,
	datad => ALT_INV_num_of_ones(0),
	datae => \ALT_INV_p_bit~reg0_q\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \Selector6~0_combout\);

-- Location: FF_X87_Y19_N50
\p_bit~reg0\ : dffeas
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
	q => \p_bit~reg0_q\);

-- Location: LABCELL_X88_Y19_N57
\Selector7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = ( \state.idle~q\ & ( ((!\state.s5~DUPLICATE_q\ & \p_valid~reg0_q\)) # (\state.s4~q\) ) ) # ( !\state.idle~q\ & ( \state.s4~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111101011110000111110101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datac => \ALT_INV_state.s4~q\,
	datad => \ALT_INV_p_valid~reg0_q\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \Selector7~0_combout\);

-- Location: FF_X88_Y19_N58
\p_valid~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector7~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \p_valid~reg0_q\);

-- Location: FF_X87_Y19_N26
\num_of_ones[1]\ : dffeas
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
	q => num_of_ones(1));

-- Location: MLABCELL_X87_Y19_N24
\Selector11~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector11~0_combout\ = ( num_of_ones(1) & ( \state.s2~DUPLICATE_q\ & ( !num_of_ones(0) ) ) ) # ( !num_of_ones(1) & ( \state.s2~DUPLICATE_q\ & ( num_of_ones(0) ) ) ) # ( num_of_ones(1) & ( !\state.s2~DUPLICATE_q\ & ( (!\state.s0~q\ & !\state.s5~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101000001010000000000000111111111111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s0~q\,
	datac => \ALT_INV_state.s5~q\,
	datad => ALT_INV_num_of_ones(0),
	datae => ALT_INV_num_of_ones(1),
	dataf => \ALT_INV_state.s2~DUPLICATE_q\,
	combout => \Selector11~0_combout\);

-- Location: FF_X87_Y19_N25
\num_of_ones[1]~DUPLICATE\ : dffeas
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
	q => \num_of_ones[1]~DUPLICATE_q\);

-- Location: MLABCELL_X87_Y19_N39
\Selector10~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector10~0_combout\ = ( num_of_ones(2) & ( \state.s5~q\ & ( (\state.s2~DUPLICATE_q\ & ((!num_of_ones(0)) # (!num_of_ones(1)))) ) ) ) # ( !num_of_ones(2) & ( \state.s5~q\ & ( (\state.s2~DUPLICATE_q\ & (num_of_ones(0) & num_of_ones(1))) ) ) ) # ( 
-- num_of_ones(2) & ( !\state.s5~q\ & ( (!\state.s2~DUPLICATE_q\ & (!\state.s0~q\)) # (\state.s2~DUPLICATE_q\ & (((!num_of_ones(0)) # (!num_of_ones(1))))) ) ) ) # ( !num_of_ones(2) & ( !\state.s5~q\ & ( (\state.s2~DUPLICATE_q\ & (num_of_ones(0) & 
-- num_of_ones(1))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000011101110111011100000000000000000110011001100110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s0~q\,
	datab => \ALT_INV_state.s2~DUPLICATE_q\,
	datac => ALT_INV_num_of_ones(0),
	datad => ALT_INV_num_of_ones(1),
	datae => ALT_INV_num_of_ones(2),
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector10~0_combout\);

-- Location: FF_X87_Y19_N40
\num_of_ones[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector10~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => num_of_ones(2));

-- Location: FF_X87_Y19_N55
\num_of_ones[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector9~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => num_of_ones(3));

-- Location: FF_X87_Y19_N41
\num_of_ones[2]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector10~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \num_of_ones[2]~DUPLICATE_q\);

-- Location: FF_X88_Y19_N19
\state.s2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector2~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s2~q\);

-- Location: MLABCELL_X87_Y19_N54
\Selector9~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector9~0_combout\ = ( !\state.s2~q\ & ( ((num_of_ones(3) & (!\state.s5~DUPLICATE_q\ & ((!\state.s0~q\))))) ) ) # ( \state.s2~q\ & ( !num_of_ones(3) $ (((!num_of_ones(1)) # ((!num_of_ones(0)) # ((!\num_of_ones[2]~DUPLICATE_q\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "0011000000110000001100110011011000000000000000000011001100110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_num_of_ones(1),
	datab => ALT_INV_num_of_ones(3),
	datac => ALT_INV_num_of_ones(0),
	datad => \ALT_INV_num_of_ones[2]~DUPLICATE_q\,
	datae => \ALT_INV_state.s2~q\,
	dataf => \ALT_INV_state.s0~q\,
	datag => \ALT_INV_state.s5~DUPLICATE_q\,
	combout => \Selector9~0_combout\);

-- Location: FF_X87_Y19_N56
\num_of_ones[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector9~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \num_of_ones[3]~DUPLICATE_q\);

-- Location: MLABCELL_X87_Y19_N45
\Selector8~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector8~0_combout\ = ( \busy~q\ & ( \state.s5~q\ & ( \state.s0~q\ ) ) ) # ( !\busy~q\ & ( \state.s5~q\ & ( \state.s0~q\ ) ) ) # ( \busy~q\ & ( !\state.s5~q\ ) ) # ( !\busy~q\ & ( !\state.s5~q\ & ( \state.s0~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111111111111111111100000000111111110000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_state.s0~q\,
	datae => \ALT_INV_busy~q\,
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector8~0_combout\);

-- Location: FF_X87_Y19_N46
busy : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector8~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \busy~q\);

-- Location: LABCELL_X17_Y39_N3
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


