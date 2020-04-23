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

-- DATE "04/23/2020 18:39:08"

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
	index_out : OUT IEEE.NUMERIC_STD.unsigned(4 DOWNTO 0);
	busy_out : OUT std_logic
	);
END parity_bit_calc_sm;

-- Design Ports Information
-- p_bit	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p_valid	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[0]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[1]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[2]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- num_of_ones_out[3]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[0]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[1]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[2]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[3]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- index_out[4]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busy_out	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- resetn	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_valid	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[0]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[1]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[2]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[3]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default


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
SIGNAL ww_index_out : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_busy_out : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \resetn~input_o\ : std_logic;
SIGNAL \word_valid~input_o\ : std_logic;
SIGNAL \state.reset_state~feeder_combout\ : std_logic;
SIGNAL \state.reset_state~q\ : std_logic;
SIGNAL \state.s5~q\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \state.idle~q\ : std_logic;
SIGNAL \word_valid_reg~0_combout\ : std_logic;
SIGNAL \word_valid_reg~q\ : std_logic;
SIGNAL \state.idle~DUPLICATE_q\ : std_logic;
SIGNAL \state~22_combout\ : std_logic;
SIGNAL \state.s0~q\ : std_logic;
SIGNAL \Selector20~0_combout\ : std_logic;
SIGNAL \Selector18~0_combout\ : std_logic;
SIGNAL \index[2]~DUPLICATE_q\ : std_logic;
SIGNAL \index[4]~DUPLICATE_q\ : std_logic;
SIGNAL \state.s1~DUPLICATE_q\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \state.s23~q\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \state.s2~q\ : std_logic;
SIGNAL \state.s0~DUPLICATE_q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \state.s1~q\ : std_logic;
SIGNAL \index[0]~DUPLICATE_q\ : std_logic;
SIGNAL \word_in[3]~input_o\ : std_logic;
SIGNAL \Selector7~1_combout\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \word_in[2]~input_o\ : std_logic;
SIGNAL \Selector8~0_combout\ : std_logic;
SIGNAL \word_in[1]~input_o\ : std_logic;
SIGNAL \Selector9~0_combout\ : std_logic;
SIGNAL \word_in[0]~input_o\ : std_logic;
SIGNAL \Selector10~0_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \Selector23~0_combout\ : std_logic;
SIGNAL \target_bit~q\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \state.s3~q\ : std_logic;
SIGNAL \WideOr9~0_combout\ : std_logic;
SIGNAL \Selector19~0_combout\ : std_logic;
SIGNAL \index[1]~DUPLICATE_q\ : std_logic;
SIGNAL \Selector17~0_combout\ : std_logic;
SIGNAL \Add1~0_combout\ : std_logic;
SIGNAL \Selector16~0_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \state.s4~q\ : std_logic;
SIGNAL \state.s5~DUPLICATE_q\ : std_logic;
SIGNAL \Selector15~0_combout\ : std_logic;
SIGNAL \num_of_ones[0]~DUPLICATE_q\ : std_logic;
SIGNAL \Selector21~0_combout\ : std_logic;
SIGNAL \p_bit~reg0_q\ : std_logic;
SIGNAL \Selector22~0_combout\ : std_logic;
SIGNAL \p_valid~reg0_q\ : std_logic;
SIGNAL \Selector14~0_combout\ : std_logic;
SIGNAL \num_of_ones[1]~DUPLICATE_q\ : std_logic;
SIGNAL \Selector13~0_combout\ : std_logic;
SIGNAL \Selector12~0_combout\ : std_logic;
SIGNAL \Selector11~0_combout\ : std_logic;
SIGNAL \busy~q\ : std_logic;
SIGNAL num_of_ones : std_logic_vector(3 DOWNTO 0);
SIGNAL index : std_logic_vector(4 DOWNTO 0);
SIGNAL word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_state.idle~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_state.s1~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_state.s5~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_state.s0~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[4]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[2]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[1]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_num_of_ones[1]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_num_of_ones[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_word_in[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_valid~input_o\ : std_logic;
SIGNAL \ALT_INV_resetn~input_o\ : std_logic;
SIGNAL \ALT_INV_Selector6~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_state.reset_state~q\ : std_logic;
SIGNAL \ALT_INV_state.s23~q\ : std_logic;
SIGNAL \ALT_INV_target_bit~q\ : std_logic;
SIGNAL \ALT_INV_state.idle~q\ : std_logic;
SIGNAL \ALT_INV_word_valid_reg~q\ : std_logic;
SIGNAL \ALT_INV_Selector4~0_combout\ : std_logic;
SIGNAL \ALT_INV_state.s1~q\ : std_logic;
SIGNAL \ALT_INV_Add1~0_combout\ : std_logic;
SIGNAL \ALT_INV_state.s3~q\ : std_logic;
SIGNAL \ALT_INV_state.s2~q\ : std_logic;
SIGNAL \ALT_INV_state.s5~q\ : std_logic;
SIGNAL \ALT_INV_state.s0~q\ : std_logic;
SIGNAL \ALT_INV_state.s4~q\ : std_logic;
SIGNAL \ALT_INV_busy~q\ : std_logic;
SIGNAL ALT_INV_index : std_logic_vector(4 DOWNTO 0);
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
\ALT_INV_state.idle~DUPLICATE_q\ <= NOT \state.idle~DUPLICATE_q\;
\ALT_INV_state.s1~DUPLICATE_q\ <= NOT \state.s1~DUPLICATE_q\;
\ALT_INV_state.s5~DUPLICATE_q\ <= NOT \state.s5~DUPLICATE_q\;
\ALT_INV_state.s0~DUPLICATE_q\ <= NOT \state.s0~DUPLICATE_q\;
\ALT_INV_index[4]~DUPLICATE_q\ <= NOT \index[4]~DUPLICATE_q\;
\ALT_INV_index[2]~DUPLICATE_q\ <= NOT \index[2]~DUPLICATE_q\;
\ALT_INV_index[1]~DUPLICATE_q\ <= NOT \index[1]~DUPLICATE_q\;
\ALT_INV_index[0]~DUPLICATE_q\ <= NOT \index[0]~DUPLICATE_q\;
\ALT_INV_num_of_ones[1]~DUPLICATE_q\ <= NOT \num_of_ones[1]~DUPLICATE_q\;
\ALT_INV_num_of_ones[0]~DUPLICATE_q\ <= NOT \num_of_ones[0]~DUPLICATE_q\;
\ALT_INV_word_in[3]~input_o\ <= NOT \word_in[3]~input_o\;
\ALT_INV_word_in[2]~input_o\ <= NOT \word_in[2]~input_o\;
\ALT_INV_word_in[1]~input_o\ <= NOT \word_in[1]~input_o\;
\ALT_INV_word_in[0]~input_o\ <= NOT \word_in[0]~input_o\;
\ALT_INV_word_valid~input_o\ <= NOT \word_valid~input_o\;
\ALT_INV_resetn~input_o\ <= NOT \resetn~input_o\;
\ALT_INV_Selector6~0_combout\ <= NOT \Selector6~0_combout\;
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
\ALT_INV_Selector4~0_combout\ <= NOT \Selector4~0_combout\;
\ALT_INV_state.s1~q\ <= NOT \state.s1~q\;
\ALT_INV_Add1~0_combout\ <= NOT \Add1~0_combout\;
\ALT_INV_state.s3~q\ <= NOT \state.s3~q\;
\ALT_INV_state.s2~q\ <= NOT \state.s2~q\;
\ALT_INV_state.s5~q\ <= NOT \state.s5~q\;
\ALT_INV_state.s0~q\ <= NOT \state.s0~q\;
\ALT_INV_state.s4~q\ <= NOT \state.s4~q\;
\ALT_INV_busy~q\ <= NOT \busy~q\;
ALT_INV_index(4) <= NOT index(4);
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

-- Location: IOOBUF_X89_Y38_N39
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

-- Location: IOOBUF_X89_Y37_N56
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

-- Location: IOOBUF_X89_Y38_N56
\num_of_ones_out[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \num_of_ones[0]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_num_of_ones_out(0));

-- Location: IOOBUF_X89_Y35_N96
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

-- Location: IOOBUF_X89_Y37_N22
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

-- Location: IOOBUF_X89_Y38_N22
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

-- Location: IOOBUF_X89_Y35_N45
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

-- Location: IOOBUF_X89_Y36_N56
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

-- Location: IOOBUF_X89_Y36_N22
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

-- Location: IOOBUF_X89_Y36_N5
\index_out[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => index(3),
	devoe => ww_devoe,
	o => ww_index_out(3));

-- Location: IOOBUF_X89_Y35_N79
\index_out[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \index[4]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_index_out(4));

-- Location: IOOBUF_X89_Y38_N5
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

-- Location: IOIBUF_X89_Y36_N38
\resetn~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_resetn,
	o => \resetn~input_o\);

-- Location: IOIBUF_X89_Y9_N38
\word_valid~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_valid,
	o => \word_valid~input_o\);

-- Location: LABCELL_X85_Y36_N45
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

-- Location: FF_X85_Y36_N47
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

-- Location: FF_X84_Y36_N22
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

-- Location: MLABCELL_X84_Y36_N6
\Selector0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = ( \state.s5~q\ ) # ( !\state.s5~q\ & ( (!\state.reset_state~q\) # ((!\word_valid_reg~q\ & \state.idle~q\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011111010111100001111101011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_word_valid_reg~q\,
	datac => \ALT_INV_state.reset_state~q\,
	datad => \ALT_INV_state.idle~q\,
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector0~0_combout\);

-- Location: FF_X84_Y36_N8
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

-- Location: LABCELL_X85_Y36_N39
\word_valid_reg~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \word_valid_reg~0_combout\ = ( \word_valid_reg~q\ & ( \state.idle~q\ & ( (!\resetn~input_o\) # (\word_valid~input_o\) ) ) ) # ( !\word_valid_reg~q\ & ( \state.idle~q\ & ( (\resetn~input_o\ & \word_valid~input_o\) ) ) ) # ( \word_valid_reg~q\ & ( 
-- !\state.idle~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000011000000111100111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_resetn~input_o\,
	datac => \ALT_INV_word_valid~input_o\,
	datae => \ALT_INV_word_valid_reg~q\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \word_valid_reg~0_combout\);

-- Location: FF_X85_Y36_N41
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

-- Location: FF_X84_Y36_N7
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

-- Location: MLABCELL_X84_Y36_N9
\state~22\ : cyclonev_lcell_comb
-- Equation(s):
-- \state~22_combout\ = ( \state.idle~DUPLICATE_q\ & ( \word_valid_reg~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_word_valid_reg~q\,
	dataf => \ALT_INV_state.idle~DUPLICATE_q\,
	combout => \state~22_combout\);

-- Location: FF_X84_Y36_N11
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

-- Location: MLABCELL_X84_Y36_N39
\Selector20~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector20~0_combout\ = ( !\state.s5~q\ & ( (!\state.s0~q\ & !index(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000000000000111100000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state.s0~q\,
	datad => ALT_INV_index(0),
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector20~0_combout\);

-- Location: FF_X84_Y36_N40
\index[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector20~0_combout\,
	clrn => \resetn~input_o\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(0));

-- Location: FF_X84_Y36_N56
\index[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector18~0_combout\,
	clrn => \resetn~input_o\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(2));

-- Location: MLABCELL_X84_Y36_N54
\Selector18~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector18~0_combout\ = ( \index[1]~DUPLICATE_q\ & ( (!\state.s5~DUPLICATE_q\ & (!\state.s0~q\ & (!index(0) $ (!index(2))))) ) ) # ( !\index[1]~DUPLICATE_q\ & ( (!\state.s5~DUPLICATE_q\ & (!\state.s0~q\ & index(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010001000000000001000100000001000100000000000100010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datab => \ALT_INV_state.s0~q\,
	datac => ALT_INV_index(0),
	datad => ALT_INV_index(2),
	dataf => \ALT_INV_index[1]~DUPLICATE_q\,
	combout => \Selector18~0_combout\);

-- Location: FF_X84_Y36_N55
\index[2]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector18~0_combout\,
	clrn => \resetn~input_o\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[2]~DUPLICATE_q\);

-- Location: FF_X84_Y36_N34
\index[4]~DUPLICATE\ : dffeas
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
	q => \index[4]~DUPLICATE_q\);

-- Location: FF_X84_Y36_N49
\state.s1~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector1~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s1~DUPLICATE_q\);

-- Location: LABCELL_X85_Y36_N24
\Selector6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = ( \state.s1~DUPLICATE_q\ & ( index(3) ) ) # ( \state.s1~DUPLICATE_q\ & ( !index(3) & ( ((!\index[2]~DUPLICATE_q\) # ((\index[4]~DUPLICATE_q\) # (\index[1]~DUPLICATE_q\))) # (index(0)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110111111111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(0),
	datab => \ALT_INV_index[2]~DUPLICATE_q\,
	datac => \ALT_INV_index[1]~DUPLICATE_q\,
	datad => \ALT_INV_index[4]~DUPLICATE_q\,
	datae => \ALT_INV_state.s1~DUPLICATE_q\,
	dataf => ALT_INV_index(3),
	combout => \Selector6~0_combout\);

-- Location: FF_X84_Y36_N53
\state.s23\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector6~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s23~q\);

-- Location: MLABCELL_X84_Y36_N24
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

-- Location: FF_X84_Y36_N44
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

-- Location: FF_X84_Y36_N10
\state.s0~DUPLICATE\ : dffeas
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
	q => \state.s0~DUPLICATE_q\);

-- Location: MLABCELL_X84_Y36_N27
\Selector1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = ( \state.s0~DUPLICATE_q\ ) # ( !\state.s0~DUPLICATE_q\ & ( (\state.s2~q\) # (\state.s3~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100111111001111110011111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s3~q\,
	datac => \ALT_INV_state.s2~q\,
	dataf => \ALT_INV_state.s0~DUPLICATE_q\,
	combout => \Selector1~0_combout\);

-- Location: FF_X84_Y36_N50
\state.s1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector1~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s1~q\);

-- Location: FF_X84_Y36_N41
\index[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector20~0_combout\,
	clrn => \resetn~input_o\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[0]~DUPLICATE_q\);

-- Location: IOIBUF_X89_Y37_N38
\word_in[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(3),
	o => \word_in[3]~input_o\);

-- Location: LABCELL_X85_Y36_N3
\Selector7~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector7~1_combout\ = ( \state.idle~q\ & ( \word_in[3]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_word_in[3]~input_o\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \Selector7~1_combout\);

-- Location: MLABCELL_X84_Y36_N45
\Selector7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = ( \state.idle~q\ ) # ( !\state.idle~q\ & ( \state.s5~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state.s5~q\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \Selector7~0_combout\);

-- Location: FF_X84_Y36_N28
\word_in_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector7~1_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(3));

-- Location: IOIBUF_X89_Y9_N21
\word_in[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(2),
	o => \word_in[2]~input_o\);

-- Location: LABCELL_X85_Y36_N6
\Selector8~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector8~0_combout\ = ( \state.idle~q\ & ( \word_in[2]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_word_in[2]~input_o\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \Selector8~0_combout\);

-- Location: FF_X84_Y36_N1
\word_in_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector8~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(2));

-- Location: IOIBUF_X89_Y37_N4
\word_in[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(1),
	o => \word_in[1]~input_o\);

-- Location: LABCELL_X85_Y36_N57
\Selector9~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector9~0_combout\ = ( \word_in[1]~input_o\ & ( \state.idle~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_word_in[1]~input_o\,
	dataf => \ALT_INV_state.idle~q\,
	combout => \Selector9~0_combout\);

-- Location: FF_X84_Y36_N4
\word_in_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector9~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(1));

-- Location: IOIBUF_X84_Y81_N52
\word_in[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(0),
	o => \word_in[0]~input_o\);

-- Location: MLABCELL_X84_Y36_N3
\Selector10~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector10~0_combout\ = ( \state.idle~DUPLICATE_q\ & ( \word_in[0]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_word_in[0]~input_o\,
	dataf => \ALT_INV_state.idle~DUPLICATE_q\,
	combout => \Selector10~0_combout\);

-- Location: FF_X84_Y36_N26
\word_in_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector10~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(0));

-- Location: MLABCELL_X84_Y36_N15
\Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = ( word_in_reg(1) & ( word_in_reg(0) & ( (!\index[1]~DUPLICATE_q\) # ((!\index[0]~DUPLICATE_q\ & ((word_in_reg(2)))) # (\index[0]~DUPLICATE_q\ & (word_in_reg(3)))) ) ) ) # ( !word_in_reg(1) & ( word_in_reg(0) & ( (!\index[1]~DUPLICATE_q\ 
-- & (!\index[0]~DUPLICATE_q\)) # (\index[1]~DUPLICATE_q\ & ((!\index[0]~DUPLICATE_q\ & ((word_in_reg(2)))) # (\index[0]~DUPLICATE_q\ & (word_in_reg(3))))) ) ) ) # ( word_in_reg(1) & ( !word_in_reg(0) & ( (!\index[1]~DUPLICATE_q\ & (\index[0]~DUPLICATE_q\)) 
-- # (\index[1]~DUPLICATE_q\ & ((!\index[0]~DUPLICATE_q\ & ((word_in_reg(2)))) # (\index[0]~DUPLICATE_q\ & (word_in_reg(3))))) ) ) ) # ( !word_in_reg(1) & ( !word_in_reg(0) & ( (\index[1]~DUPLICATE_q\ & ((!\index[0]~DUPLICATE_q\ & ((word_in_reg(2)))) # 
-- (\index[0]~DUPLICATE_q\ & (word_in_reg(3))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000101000101001000110110011110001001110011011010101111101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_index[1]~DUPLICATE_q\,
	datab => \ALT_INV_index[0]~DUPLICATE_q\,
	datac => ALT_INV_word_in_reg(3),
	datad => ALT_INV_word_in_reg(2),
	datae => ALT_INV_word_in_reg(1),
	dataf => ALT_INV_word_in_reg(0),
	combout => \Mux0~0_combout\);

-- Location: MLABCELL_X84_Y36_N18
\Selector23~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector23~0_combout\ = ( \target_bit~q\ & ( \Selector6~0_combout\ & ( (((!\state.s1~q\ & !\state.s5~q\)) # (\Mux0~0_combout\)) # (\Selector4~0_combout\) ) ) ) # ( !\target_bit~q\ & ( \Selector6~0_combout\ & ( \Mux0~0_combout\ ) ) ) # ( \target_bit~q\ & 
-- ( !\Selector6~0_combout\ & ( ((!\state.s1~q\ & !\state.s5~q\)) # (\Selector4~0_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100011111000111100000000111111111000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s1~q\,
	datab => \ALT_INV_state.s5~q\,
	datac => \ALT_INV_Selector4~0_combout\,
	datad => \ALT_INV_Mux0~0_combout\,
	datae => \ALT_INV_target_bit~q\,
	dataf => \ALT_INV_Selector6~0_combout\,
	combout => \Selector23~0_combout\);

-- Location: FF_X84_Y36_N20
target_bit : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector23~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \target_bit~q\);

-- Location: MLABCELL_X84_Y36_N36
\Selector3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = ( \state.s23~q\ & ( !\target_bit~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_target_bit~q\,
	dataf => \ALT_INV_state.s23~q\,
	combout => \Selector3~0_combout\);

-- Location: FF_X84_Y36_N14
\state.s3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector3~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s3~q\);

-- Location: MLABCELL_X84_Y36_N0
\WideOr9~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \WideOr9~0_combout\ = ( \state.s2~q\ ) # ( !\state.s2~q\ & ( ((\state.s0~DUPLICATE_q\) # (\state.s3~q\)) # (\state.s5~DUPLICATE_q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111111101111111011111110111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datab => \ALT_INV_state.s3~q\,
	datac => \ALT_INV_state.s0~DUPLICATE_q\,
	dataf => \ALT_INV_state.s2~q\,
	combout => \WideOr9~0_combout\);

-- Location: FF_X84_Y36_N32
\index[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector19~0_combout\,
	clrn => \resetn~input_o\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(1));

-- Location: MLABCELL_X84_Y36_N30
\Selector19~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector19~0_combout\ = ( index(0) & ( (!\state.s0~q\ & (!\state.s5~DUPLICATE_q\ & !index(1))) ) ) # ( !index(0) & ( (!\state.s0~q\ & (!\state.s5~DUPLICATE_q\ & index(1))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011000000000000001100000011000000000000001100000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s0~q\,
	datac => \ALT_INV_state.s5~DUPLICATE_q\,
	datad => ALT_INV_index(1),
	dataf => ALT_INV_index(0),
	combout => \Selector19~0_combout\);

-- Location: FF_X84_Y36_N31
\index[1]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector19~0_combout\,
	clrn => \resetn~input_o\,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[1]~DUPLICATE_q\);

-- Location: LABCELL_X85_Y36_N48
\Selector17~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector17~0_combout\ = ( \index[2]~DUPLICATE_q\ & ( index(3) & ( (!\state.s5~q\ & (!\state.s0~DUPLICATE_q\ & ((!\index[1]~DUPLICATE_q\) # (!index(0))))) ) ) ) # ( !\index[2]~DUPLICATE_q\ & ( index(3) & ( (!\state.s5~q\ & !\state.s0~DUPLICATE_q\) ) ) ) # 
-- ( \index[2]~DUPLICATE_q\ & ( !index(3) & ( (\index[1]~DUPLICATE_q\ & (!\state.s5~q\ & (index(0) & !\state.s0~DUPLICATE_q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000001000000000011001100000000001100100000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_index[1]~DUPLICATE_q\,
	datab => \ALT_INV_state.s5~q\,
	datac => ALT_INV_index(0),
	datad => \ALT_INV_state.s0~DUPLICATE_q\,
	datae => \ALT_INV_index[2]~DUPLICATE_q\,
	dataf => ALT_INV_index(3),
	combout => \Selector17~0_combout\);

-- Location: FF_X84_Y36_N38
\index[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector17~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \WideOr9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(3));

-- Location: MLABCELL_X84_Y36_N42
\Add1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~0_combout\ = ( \index[0]~DUPLICATE_q\ & ( (index(3) & (index(1) & index(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000001000000010000000100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(3),
	datab => ALT_INV_index(1),
	datac => ALT_INV_index(2),
	dataf => \ALT_INV_index[0]~DUPLICATE_q\,
	combout => \Add1~0_combout\);

-- Location: MLABCELL_X84_Y36_N33
\Selector16~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector16~0_combout\ = ( !\state.s5~q\ & ( (!\state.s0~q\ & (!\Add1~0_combout\ $ (!index(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110011000000000011001100000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s0~q\,
	datac => \ALT_INV_Add1~0_combout\,
	datad => ALT_INV_index(4),
	dataf => \ALT_INV_state.s5~q\,
	combout => \Selector16~0_combout\);

-- Location: FF_X84_Y36_N35
\index[4]\ : dffeas
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
	q => index(4));

-- Location: MLABCELL_X84_Y36_N51
\Selector4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = ( !index(3) & ( !\index[0]~DUPLICATE_q\ & ( (!index(4) & (\state.s1~DUPLICATE_q\ & (!index(1) & index(2)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000100000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(4),
	datab => \ALT_INV_state.s1~DUPLICATE_q\,
	datac => ALT_INV_index(1),
	datad => ALT_INV_index(2),
	datae => ALT_INV_index(3),
	dataf => \ALT_INV_index[0]~DUPLICATE_q\,
	combout => \Selector4~0_combout\);

-- Location: FF_X84_Y36_N17
\state.s4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector4~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.s4~q\);

-- Location: FF_X84_Y36_N23
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

-- Location: FF_X88_Y36_N55
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

-- Location: LABCELL_X88_Y36_N54
\Selector15~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector15~0_combout\ = ( !num_of_ones(0) & ( \state.s0~DUPLICATE_q\ & ( \state.s2~q\ ) ) ) # ( num_of_ones(0) & ( !\state.s0~DUPLICATE_q\ & ( (!\state.s2~q\ & !\state.s5~DUPLICATE_q\) ) ) ) # ( !num_of_ones(0) & ( !\state.s0~DUPLICATE_q\ & ( 
-- \state.s2~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011110000001100000000110011001100110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s2~q\,
	datac => \ALT_INV_state.s5~DUPLICATE_q\,
	datae => ALT_INV_num_of_ones(0),
	dataf => \ALT_INV_state.s0~DUPLICATE_q\,
	combout => \Selector15~0_combout\);

-- Location: FF_X88_Y36_N56
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

-- Location: LABCELL_X88_Y36_N33
\Selector21~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector21~0_combout\ = ( \p_bit~reg0_q\ & ( \num_of_ones[0]~DUPLICATE_q\ & ( ((!\state.s5~DUPLICATE_q\ & !\state.s0~DUPLICATE_q\)) # (\state.s4~q\) ) ) ) # ( !\p_bit~reg0_q\ & ( \num_of_ones[0]~DUPLICATE_q\ & ( \state.s4~q\ ) ) ) # ( \p_bit~reg0_q\ & ( 
-- !\num_of_ones[0]~DUPLICATE_q\ & ( (!\state.s5~DUPLICATE_q\ & (!\state.s0~DUPLICATE_q\ & !\state.s4~q\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100000001000000000001111000011111000111110001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datab => \ALT_INV_state.s0~DUPLICATE_q\,
	datac => \ALT_INV_state.s4~q\,
	datae => \ALT_INV_p_bit~reg0_q\,
	dataf => \ALT_INV_num_of_ones[0]~DUPLICATE_q\,
	combout => \Selector21~0_combout\);

-- Location: FF_X88_Y36_N34
\p_bit~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector21~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \p_bit~reg0_q\);

-- Location: LABCELL_X88_Y36_N36
\Selector22~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector22~0_combout\ = ( \p_valid~reg0_q\ & ( \state.s4~q\ ) ) # ( !\p_valid~reg0_q\ & ( \state.s4~q\ ) ) # ( \p_valid~reg0_q\ & ( !\state.s4~q\ & ( (!\state.s0~DUPLICATE_q\ & !\state.s5~DUPLICATE_q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110000001100000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s0~DUPLICATE_q\,
	datac => \ALT_INV_state.s5~DUPLICATE_q\,
	datae => \ALT_INV_p_valid~reg0_q\,
	dataf => \ALT_INV_state.s4~q\,
	combout => \Selector22~0_combout\);

-- Location: FF_X88_Y36_N37
\p_valid~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Selector22~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \p_valid~reg0_q\);

-- Location: LABCELL_X88_Y36_N48
\Selector14~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector14~0_combout\ = ( num_of_ones(1) & ( \num_of_ones[0]~DUPLICATE_q\ & ( (!\state.s0~DUPLICATE_q\ & (!\state.s5~DUPLICATE_q\ & !\state.s2~q\)) ) ) ) # ( !num_of_ones(1) & ( \num_of_ones[0]~DUPLICATE_q\ & ( \state.s2~q\ ) ) ) # ( num_of_ones(1) & ( 
-- !\num_of_ones[0]~DUPLICATE_q\ & ( ((!\state.s0~DUPLICATE_q\ & !\state.s5~DUPLICATE_q\)) # (\state.s2~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110000001111111100000000111111111100000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_state.s0~DUPLICATE_q\,
	datac => \ALT_INV_state.s5~DUPLICATE_q\,
	datad => \ALT_INV_state.s2~q\,
	datae => ALT_INV_num_of_ones(1),
	dataf => \ALT_INV_num_of_ones[0]~DUPLICATE_q\,
	combout => \Selector14~0_combout\);

-- Location: FF_X88_Y36_N49
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

-- Location: FF_X88_Y36_N50
\num_of_ones[1]~DUPLICATE\ : dffeas
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
	q => \num_of_ones[1]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y36_N42
\Selector13~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector13~0_combout\ = ( num_of_ones(2) & ( num_of_ones(0) & ( (!\state.s2~q\ & (!\state.s5~DUPLICATE_q\ & (!\state.s0~DUPLICATE_q\))) # (\state.s2~q\ & (((!\num_of_ones[1]~DUPLICATE_q\)))) ) ) ) # ( !num_of_ones(2) & ( num_of_ones(0) & ( 
-- (\num_of_ones[1]~DUPLICATE_q\ & \state.s2~q\) ) ) ) # ( num_of_ones(2) & ( !num_of_ones(0) & ( ((!\state.s5~DUPLICATE_q\ & !\state.s0~DUPLICATE_q\)) # (\state.s2~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100010001111111100000000000011111000100011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state.s5~DUPLICATE_q\,
	datab => \ALT_INV_state.s0~DUPLICATE_q\,
	datac => \ALT_INV_num_of_ones[1]~DUPLICATE_q\,
	datad => \ALT_INV_state.s2~q\,
	datae => ALT_INV_num_of_ones(2),
	dataf => ALT_INV_num_of_ones(0),
	combout => \Selector13~0_combout\);

-- Location: FF_X88_Y36_N44
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

-- Location: LABCELL_X88_Y36_N12
\Selector12~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector12~0_combout\ = ( !\state.s2~q\ & ( (num_of_ones(3) & (!\state.s0~DUPLICATE_q\ & (!\state.s5~DUPLICATE_q\))) ) ) # ( \state.s2~q\ & ( !num_of_ones(3) $ ((((!\num_of_ones[0]~DUPLICATE_q\) # ((!num_of_ones(2)) # (!\num_of_ones[1]~DUPLICATE_q\))))) 
-- ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "0100000001000000010101010101010101000000010000000101010101011010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_num_of_ones(3),
	datab => \ALT_INV_state.s0~DUPLICATE_q\,
	datac => \ALT_INV_num_of_ones[0]~DUPLICATE_q\,
	datad => ALT_INV_num_of_ones(2),
	datae => \ALT_INV_state.s2~q\,
	dataf => \ALT_INV_num_of_ones[1]~DUPLICATE_q\,
	datag => \ALT_INV_state.s5~DUPLICATE_q\,
	combout => \Selector12~0_combout\);

-- Location: FF_X88_Y36_N13
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

-- Location: MLABCELL_X84_Y36_N57
\Selector11~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Selector11~0_combout\ = ( \busy~q\ & ( (!\state.s5~DUPLICATE_q\) # (\state.s0~q\) ) ) # ( !\busy~q\ & ( \state.s0~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111111111111000011111111111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state.s0~q\,
	datad => \ALT_INV_state.s5~DUPLICATE_q\,
	dataf => \ALT_INV_busy~q\,
	combout => \Selector11~0_combout\);

-- Location: FF_X84_Y36_N47
busy : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Selector11~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \busy~q\);

-- Location: LABCELL_X71_Y79_N3
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


