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

-- DATE "04/27/2020 16:06:44"

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

ENTITY 	serializer_v1 IS
    PORT (
	clk_word : IN std_logic;
	clk_bit : IN std_logic;
	resetn : IN std_logic;
	word_in : IN std_logic_vector(3 DOWNTO 0);
	word_valid : IN std_logic;
	bit_out : BUFFER std_logic;
	bit_valid : BUFFER std_logic
	);
END serializer_v1;

-- Design Ports Information
-- bit_out	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- bit_valid	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_bit	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- resetn	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[0]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_word	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_valid	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[1]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[2]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- word_in[3]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF serializer_v1 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk_word : std_logic;
SIGNAL ww_clk_bit : std_logic;
SIGNAL ww_resetn : std_logic;
SIGNAL ww_word_in : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_word_valid : std_logic;
SIGNAL ww_bit_out : std_logic;
SIGNAL ww_bit_valid : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk_bit~input_o\ : std_logic;
SIGNAL \clk_bit~inputCLKENA0_outclk\ : std_logic;
SIGNAL \clk_word~input_o\ : std_logic;
SIGNAL \clk_word~inputCLKENA0_outclk\ : std_logic;
SIGNAL \word_in[1]~input_o\ : std_logic;
SIGNAL \resetn~input_o\ : std_logic;
SIGNAL \busy~feeder_combout\ : std_logic;
SIGNAL \word_valid~input_o\ : std_logic;
SIGNAL \busy~q\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~89_sumout\ : std_logic;
SIGNAL \index[2]~0_combout\ : std_logic;
SIGNAL \Add0~90\ : std_logic;
SIGNAL \Add0~97_sumout\ : std_logic;
SIGNAL \Add0~98\ : std_logic;
SIGNAL \Add0~101_sumout\ : std_logic;
SIGNAL \Add0~102\ : std_logic;
SIGNAL \Add0~105_sumout\ : std_logic;
SIGNAL \Add0~106\ : std_logic;
SIGNAL \Add0~109_sumout\ : std_logic;
SIGNAL \Add0~110\ : std_logic;
SIGNAL \Add0~113_sumout\ : std_logic;
SIGNAL \Add0~114\ : std_logic;
SIGNAL \Add0~117_sumout\ : std_logic;
SIGNAL \Add0~118\ : std_logic;
SIGNAL \Add0~121_sumout\ : std_logic;
SIGNAL \Add0~122\ : std_logic;
SIGNAL \Add0~125_sumout\ : std_logic;
SIGNAL \Add0~126\ : std_logic;
SIGNAL \Add0~65_sumout\ : std_logic;
SIGNAL \Add0~66\ : std_logic;
SIGNAL \Add0~69_sumout\ : std_logic;
SIGNAL \Add0~70\ : std_logic;
SIGNAL \Add0~73_sumout\ : std_logic;
SIGNAL \Add0~74\ : std_logic;
SIGNAL \Add0~77_sumout\ : std_logic;
SIGNAL \Add0~78\ : std_logic;
SIGNAL \Add0~81_sumout\ : std_logic;
SIGNAL \Add0~82\ : std_logic;
SIGNAL \Add0~85_sumout\ : std_logic;
SIGNAL \Add0~86\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \index[17]~feeder_combout\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \index[18]~feeder_combout\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \index[19]~feeder_combout\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~93_sumout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \Equal0~5_combout\ : std_logic;
SIGNAL \Equal0~6_combout\ : std_logic;
SIGNAL \bit_out_done~0_combout\ : std_logic;
SIGNAL \bit_out_done~q\ : std_logic;
SIGNAL \process_0~0_combout\ : std_logic;
SIGNAL \word_in[2]~input_o\ : std_logic;
SIGNAL \word_in_reg[2]~feeder_combout\ : std_logic;
SIGNAL \word_in[3]~input_o\ : std_logic;
SIGNAL \word_in_reg[3]~feeder_combout\ : std_logic;
SIGNAL \word_in[0]~input_o\ : std_logic;
SIGNAL \word_in_reg[0]~feeder_combout\ : std_logic;
SIGNAL \bit_out~0_combout\ : std_logic;
SIGNAL \bit_out~reg0_q\ : std_logic;
SIGNAL \bit_valid~0_combout\ : std_logic;
SIGNAL \bit_valid~reg0_q\ : std_logic;
SIGNAL index : std_logic_vector(31 DOWNTO 0);
SIGNAL word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_word_in[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_word_in[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_resetn~input_o\ : std_logic;
SIGNAL \ALT_INV_process_0~0_combout\ : std_logic;
SIGNAL \ALT_INV_bit_out_done~q\ : std_logic;
SIGNAL \ALT_INV_busy~q\ : std_logic;
SIGNAL \ALT_INV_Equal0~6_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~5_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~4_combout\ : std_logic;
SIGNAL ALT_INV_index : std_logic_vector(31 DOWNTO 0);
SIGNAL \ALT_INV_Equal0~3_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~2_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL ALT_INV_word_in_reg : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_Add0~89_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~1_sumout\ : std_logic;

BEGIN

ww_clk_word <= clk_word;
ww_clk_bit <= clk_bit;
ww_resetn <= resetn;
ww_word_in <= word_in;
ww_word_valid <= word_valid;
bit_out <= ww_bit_out;
bit_valid <= ww_bit_valid;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_word_in[3]~input_o\ <= NOT \word_in[3]~input_o\;
\ALT_INV_word_in[2]~input_o\ <= NOT \word_in[2]~input_o\;
\ALT_INV_word_in[0]~input_o\ <= NOT \word_in[0]~input_o\;
\ALT_INV_resetn~input_o\ <= NOT \resetn~input_o\;
\ALT_INV_process_0~0_combout\ <= NOT \process_0~0_combout\;
\ALT_INV_bit_out_done~q\ <= NOT \bit_out_done~q\;
\ALT_INV_busy~q\ <= NOT \busy~q\;
\ALT_INV_Equal0~6_combout\ <= NOT \Equal0~6_combout\;
\ALT_INV_Equal0~5_combout\ <= NOT \Equal0~5_combout\;
\ALT_INV_Equal0~4_combout\ <= NOT \Equal0~4_combout\;
ALT_INV_index(2) <= NOT index(2);
\ALT_INV_Equal0~3_combout\ <= NOT \Equal0~3_combout\;
\ALT_INV_Equal0~2_combout\ <= NOT \Equal0~2_combout\;
\ALT_INV_Equal0~1_combout\ <= NOT \Equal0~1_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
ALT_INV_word_in_reg(3) <= NOT word_in_reg(3);
ALT_INV_word_in_reg(2) <= NOT word_in_reg(2);
ALT_INV_word_in_reg(1) <= NOT word_in_reg(1);
ALT_INV_word_in_reg(0) <= NOT word_in_reg(0);
\ALT_INV_Add0~89_sumout\ <= NOT \Add0~89_sumout\;
\ALT_INV_Add0~49_sumout\ <= NOT \Add0~49_sumout\;
\ALT_INV_Add0~45_sumout\ <= NOT \Add0~45_sumout\;
\ALT_INV_Add0~41_sumout\ <= NOT \Add0~41_sumout\;
ALT_INV_index(10) <= NOT index(10);
ALT_INV_index(9) <= NOT index(9);
ALT_INV_index(8) <= NOT index(8);
ALT_INV_index(7) <= NOT index(7);
ALT_INV_index(6) <= NOT index(6);
ALT_INV_index(5) <= NOT index(5);
ALT_INV_index(4) <= NOT index(4);
ALT_INV_index(3) <= NOT index(3);
ALT_INV_index(31) <= NOT index(31);
ALT_INV_index(1) <= NOT index(1);
ALT_INV_index(0) <= NOT index(0);
ALT_INV_index(16) <= NOT index(16);
ALT_INV_index(15) <= NOT index(15);
ALT_INV_index(14) <= NOT index(14);
ALT_INV_index(13) <= NOT index(13);
ALT_INV_index(12) <= NOT index(12);
ALT_INV_index(11) <= NOT index(11);
ALT_INV_index(22) <= NOT index(22);
ALT_INV_index(21) <= NOT index(21);
ALT_INV_index(20) <= NOT index(20);
ALT_INV_index(19) <= NOT index(19);
ALT_INV_index(18) <= NOT index(18);
ALT_INV_index(17) <= NOT index(17);
ALT_INV_index(28) <= NOT index(28);
ALT_INV_index(27) <= NOT index(27);
ALT_INV_index(26) <= NOT index(26);
ALT_INV_index(25) <= NOT index(25);
ALT_INV_index(24) <= NOT index(24);
ALT_INV_index(23) <= NOT index(23);
ALT_INV_index(30) <= NOT index(30);
ALT_INV_index(29) <= NOT index(29);
\ALT_INV_Add0~5_sumout\ <= NOT \Add0~5_sumout\;
\ALT_INV_Add0~1_sumout\ <= NOT \Add0~1_sumout\;

-- Location: IOOBUF_X89_Y37_N56
\bit_out~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \bit_out~reg0_q\,
	devoe => ww_devoe,
	o => ww_bit_out);

-- Location: IOOBUF_X89_Y37_N39
\bit_valid~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \bit_valid~reg0_q\,
	devoe => ww_devoe,
	o => ww_bit_valid);

-- Location: IOIBUF_X89_Y35_N61
\clk_bit~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_bit,
	o => \clk_bit~input_o\);

-- Location: CLKCTRL_G10
\clk_bit~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk_bit~input_o\,
	outclk => \clk_bit~inputCLKENA0_outclk\);

-- Location: IOIBUF_X89_Y35_N44
\clk_word~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_word,
	o => \clk_word~input_o\);

-- Location: CLKCTRL_G8
\clk_word~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk_word~input_o\,
	outclk => \clk_word~inputCLKENA0_outclk\);

-- Location: IOIBUF_X89_Y38_N55
\word_in[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(1),
	o => \word_in[1]~input_o\);

-- Location: IOIBUF_X89_Y37_N4
\resetn~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_resetn,
	o => \resetn~input_o\);

-- Location: LABCELL_X88_Y42_N54
\busy~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \busy~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	combout => \busy~feeder_combout\);

-- Location: IOIBUF_X89_Y38_N38
\word_valid~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_valid,
	o => \word_valid~input_o\);

-- Location: FF_X88_Y42_N56
busy : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_word~inputCLKENA0_outclk\,
	d => \busy~feeder_combout\,
	clrn => \ALT_INV_process_0~0_combout\,
	ena => \word_valid~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \busy~q\);

-- Location: MLABCELL_X87_Y42_N0
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( index(0) ) + ( VCC ) + ( !VCC ))
-- \Add0~2\ = CARRY(( index(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(0),
	cin => GND,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: FF_X87_Y42_N2
\index[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(0));

-- Location: MLABCELL_X87_Y42_N3
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( index(1) ) + ( VCC ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( index(1) ) + ( VCC ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(1),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X87_Y42_N5
\index[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(1));

-- Location: MLABCELL_X87_Y42_N6
\Add0~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~89_sumout\ = SUM(( !index(2) ) + ( VCC ) + ( \Add0~6\ ))
-- \Add0~90\ = CARRY(( !index(2) ) + ( VCC ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(2),
	cin => \Add0~6\,
	sumout => \Add0~89_sumout\,
	cout => \Add0~90\);

-- Location: LABCELL_X88_Y42_N30
\index[2]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \index[2]~0_combout\ = ( !\Add0~89_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~89_sumout\,
	combout => \index[2]~0_combout\);

-- Location: FF_X87_Y42_N8
\index[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	asdata => \index[2]~0_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(2));

-- Location: MLABCELL_X87_Y42_N9
\Add0~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~97_sumout\ = SUM(( index(3) ) + ( VCC ) + ( \Add0~90\ ))
-- \Add0~98\ = CARRY(( index(3) ) + ( VCC ) + ( \Add0~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(3),
	cin => \Add0~90\,
	sumout => \Add0~97_sumout\,
	cout => \Add0~98\);

-- Location: FF_X87_Y42_N11
\index[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~97_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(3));

-- Location: MLABCELL_X87_Y42_N12
\Add0~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~101_sumout\ = SUM(( index(4) ) + ( VCC ) + ( \Add0~98\ ))
-- \Add0~102\ = CARRY(( index(4) ) + ( VCC ) + ( \Add0~98\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(4),
	cin => \Add0~98\,
	sumout => \Add0~101_sumout\,
	cout => \Add0~102\);

-- Location: FF_X87_Y42_N14
\index[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~101_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(4));

-- Location: MLABCELL_X87_Y42_N15
\Add0~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~105_sumout\ = SUM(( index(5) ) + ( VCC ) + ( \Add0~102\ ))
-- \Add0~106\ = CARRY(( index(5) ) + ( VCC ) + ( \Add0~102\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(5),
	cin => \Add0~102\,
	sumout => \Add0~105_sumout\,
	cout => \Add0~106\);

-- Location: FF_X87_Y42_N17
\index[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~105_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(5));

-- Location: MLABCELL_X87_Y42_N18
\Add0~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~109_sumout\ = SUM(( index(6) ) + ( VCC ) + ( \Add0~106\ ))
-- \Add0~110\ = CARRY(( index(6) ) + ( VCC ) + ( \Add0~106\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(6),
	cin => \Add0~106\,
	sumout => \Add0~109_sumout\,
	cout => \Add0~110\);

-- Location: FF_X87_Y42_N20
\index[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~109_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(6));

-- Location: MLABCELL_X87_Y42_N21
\Add0~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~113_sumout\ = SUM(( index(7) ) + ( VCC ) + ( \Add0~110\ ))
-- \Add0~114\ = CARRY(( index(7) ) + ( VCC ) + ( \Add0~110\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(7),
	cin => \Add0~110\,
	sumout => \Add0~113_sumout\,
	cout => \Add0~114\);

-- Location: FF_X87_Y42_N23
\index[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~113_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(7));

-- Location: MLABCELL_X87_Y42_N24
\Add0~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~117_sumout\ = SUM(( index(8) ) + ( VCC ) + ( \Add0~114\ ))
-- \Add0~118\ = CARRY(( index(8) ) + ( VCC ) + ( \Add0~114\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(8),
	cin => \Add0~114\,
	sumout => \Add0~117_sumout\,
	cout => \Add0~118\);

-- Location: FF_X87_Y42_N26
\index[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~117_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(8));

-- Location: MLABCELL_X87_Y42_N27
\Add0~121\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~121_sumout\ = SUM(( index(9) ) + ( VCC ) + ( \Add0~118\ ))
-- \Add0~122\ = CARRY(( index(9) ) + ( VCC ) + ( \Add0~118\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(9),
	cin => \Add0~118\,
	sumout => \Add0~121_sumout\,
	cout => \Add0~122\);

-- Location: FF_X87_Y42_N29
\index[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~121_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(9));

-- Location: MLABCELL_X87_Y42_N30
\Add0~125\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~125_sumout\ = SUM(( index(10) ) + ( VCC ) + ( \Add0~122\ ))
-- \Add0~126\ = CARRY(( index(10) ) + ( VCC ) + ( \Add0~122\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(10),
	cin => \Add0~122\,
	sumout => \Add0~125_sumout\,
	cout => \Add0~126\);

-- Location: FF_X87_Y42_N32
\index[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~125_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(10));

-- Location: MLABCELL_X87_Y42_N33
\Add0~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~65_sumout\ = SUM(( index(11) ) + ( VCC ) + ( \Add0~126\ ))
-- \Add0~66\ = CARRY(( index(11) ) + ( VCC ) + ( \Add0~126\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(11),
	cin => \Add0~126\,
	sumout => \Add0~65_sumout\,
	cout => \Add0~66\);

-- Location: FF_X87_Y42_N35
\index[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~65_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(11));

-- Location: MLABCELL_X87_Y42_N36
\Add0~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~69_sumout\ = SUM(( index(12) ) + ( VCC ) + ( \Add0~66\ ))
-- \Add0~70\ = CARRY(( index(12) ) + ( VCC ) + ( \Add0~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(12),
	cin => \Add0~66\,
	sumout => \Add0~69_sumout\,
	cout => \Add0~70\);

-- Location: FF_X87_Y42_N38
\index[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~69_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(12));

-- Location: MLABCELL_X87_Y42_N39
\Add0~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~73_sumout\ = SUM(( index(13) ) + ( VCC ) + ( \Add0~70\ ))
-- \Add0~74\ = CARRY(( index(13) ) + ( VCC ) + ( \Add0~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(13),
	cin => \Add0~70\,
	sumout => \Add0~73_sumout\,
	cout => \Add0~74\);

-- Location: FF_X87_Y42_N41
\index[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~73_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(13));

-- Location: MLABCELL_X87_Y42_N42
\Add0~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~77_sumout\ = SUM(( index(14) ) + ( VCC ) + ( \Add0~74\ ))
-- \Add0~78\ = CARRY(( index(14) ) + ( VCC ) + ( \Add0~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(14),
	cin => \Add0~74\,
	sumout => \Add0~77_sumout\,
	cout => \Add0~78\);

-- Location: FF_X87_Y42_N44
\index[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~77_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(14));

-- Location: MLABCELL_X87_Y42_N45
\Add0~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~81_sumout\ = SUM(( index(15) ) + ( VCC ) + ( \Add0~78\ ))
-- \Add0~82\ = CARRY(( index(15) ) + ( VCC ) + ( \Add0~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(15),
	cin => \Add0~78\,
	sumout => \Add0~81_sumout\,
	cout => \Add0~82\);

-- Location: FF_X87_Y41_N50
\index[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	asdata => \Add0~81_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	sload => VCC,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(15));

-- Location: MLABCELL_X87_Y42_N48
\Add0~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~85_sumout\ = SUM(( index(16) ) + ( VCC ) + ( \Add0~82\ ))
-- \Add0~86\ = CARRY(( index(16) ) + ( VCC ) + ( \Add0~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(16),
	cin => \Add0~82\,
	sumout => \Add0~85_sumout\,
	cout => \Add0~86\);

-- Location: FF_X87_Y42_N50
\index[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~85_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(16));

-- Location: MLABCELL_X87_Y42_N51
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( index(17) ) + ( VCC ) + ( \Add0~86\ ))
-- \Add0~42\ = CARRY(( index(17) ) + ( VCC ) + ( \Add0~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(17),
	cin => \Add0~86\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: LABCELL_X88_Y41_N51
\index[17]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \index[17]~feeder_combout\ = ( \Add0~41_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~41_sumout\,
	combout => \index[17]~feeder_combout\);

-- Location: FF_X88_Y41_N53
\index[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \index[17]~feeder_combout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(17));

-- Location: MLABCELL_X87_Y42_N54
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( index(18) ) + ( VCC ) + ( \Add0~42\ ))
-- \Add0~46\ = CARRY(( index(18) ) + ( VCC ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(18),
	cin => \Add0~42\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: LABCELL_X88_Y41_N42
\index[18]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \index[18]~feeder_combout\ = ( \Add0~45_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~45_sumout\,
	combout => \index[18]~feeder_combout\);

-- Location: FF_X88_Y41_N44
\index[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \index[18]~feeder_combout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(18));

-- Location: MLABCELL_X87_Y42_N57
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( index(19) ) + ( VCC ) + ( \Add0~46\ ))
-- \Add0~50\ = CARRY(( index(19) ) + ( VCC ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(19),
	cin => \Add0~46\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

-- Location: LABCELL_X88_Y41_N0
\index[19]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \index[19]~feeder_combout\ = ( \Add0~49_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~49_sumout\,
	combout => \index[19]~feeder_combout\);

-- Location: FF_X88_Y41_N2
\index[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \index[19]~feeder_combout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(19));

-- Location: MLABCELL_X87_Y41_N0
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( index(20) ) + ( VCC ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( index(20) ) + ( VCC ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(20),
	cin => \Add0~50\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X87_Y41_N2
\index[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(20));

-- Location: MLABCELL_X87_Y41_N3
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( index(21) ) + ( VCC ) + ( \Add0~54\ ))
-- \Add0~58\ = CARRY(( index(21) ) + ( VCC ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(21),
	cin => \Add0~54\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X87_Y41_N5
\index[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(21));

-- Location: MLABCELL_X87_Y41_N6
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( index(22) ) + ( VCC ) + ( \Add0~58\ ))
-- \Add0~62\ = CARRY(( index(22) ) + ( VCC ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(22),
	cin => \Add0~58\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\);

-- Location: FF_X87_Y41_N8
\index[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(22));

-- Location: MLABCELL_X87_Y41_N9
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( index(23) ) + ( VCC ) + ( \Add0~62\ ))
-- \Add0~18\ = CARRY(( index(23) ) + ( VCC ) + ( \Add0~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(23),
	cin => \Add0~62\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X87_Y41_N11
\index[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(23));

-- Location: MLABCELL_X87_Y41_N12
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( index(24) ) + ( VCC ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( index(24) ) + ( VCC ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(24),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X87_Y41_N14
\index[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(24));

-- Location: MLABCELL_X87_Y41_N15
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( index(25) ) + ( VCC ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( index(25) ) + ( VCC ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(25),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X87_Y41_N17
\index[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(25));

-- Location: MLABCELL_X87_Y41_N18
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( index(26) ) + ( VCC ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( index(26) ) + ( VCC ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(26),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X87_Y41_N20
\index[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(26));

-- Location: MLABCELL_X87_Y41_N21
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( index(27) ) + ( VCC ) + ( \Add0~30\ ))
-- \Add0~34\ = CARRY(( index(27) ) + ( VCC ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(27),
	cin => \Add0~30\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X87_Y41_N23
\index[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(27));

-- Location: MLABCELL_X87_Y41_N24
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( index(28) ) + ( VCC ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( index(28) ) + ( VCC ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(28),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X87_Y41_N26
\index[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(28));

-- Location: MLABCELL_X87_Y41_N36
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( !index(27) & ( !index(24) & ( (!index(26) & (!index(23) & (!index(28) & !index(25)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(26),
	datab => ALT_INV_index(23),
	datac => ALT_INV_index(28),
	datad => ALT_INV_index(25),
	datae => ALT_INV_index(27),
	dataf => ALT_INV_index(24),
	combout => \Equal0~1_combout\);

-- Location: MLABCELL_X87_Y41_N27
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( index(29) ) + ( VCC ) + ( \Add0~38\ ))
-- \Add0~10\ = CARRY(( index(29) ) + ( VCC ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(29),
	cin => \Add0~38\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X87_Y41_N29
\index[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(29));

-- Location: MLABCELL_X87_Y41_N30
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( index(30) ) + ( VCC ) + ( \Add0~10\ ))
-- \Add0~14\ = CARRY(( index(30) ) + ( VCC ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(30),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X87_Y41_N32
\index[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(30));

-- Location: MLABCELL_X87_Y41_N45
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( !index(29) & ( !index(30) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => ALT_INV_index(29),
	dataf => ALT_INV_index(30),
	combout => \Equal0~0_combout\);

-- Location: LABCELL_X88_Y41_N36
\Equal0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = ( !index(16) & ( !index(14) & ( (!index(15) & (!index(11) & (!index(13) & !index(12)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(15),
	datab => ALT_INV_index(11),
	datac => ALT_INV_index(13),
	datad => ALT_INV_index(12),
	datae => ALT_INV_index(16),
	dataf => ALT_INV_index(14),
	combout => \Equal0~3_combout\);

-- Location: LABCELL_X88_Y41_N30
\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ( !index(21) & ( !index(17) & ( (!index(19) & (!index(22) & (!index(20) & !index(18)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(19),
	datab => ALT_INV_index(22),
	datac => ALT_INV_index(20),
	datad => ALT_INV_index(18),
	datae => ALT_INV_index(21),
	dataf => ALT_INV_index(17),
	combout => \Equal0~2_combout\);

-- Location: MLABCELL_X87_Y41_N33
\Add0~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~93_sumout\ = SUM(( index(31) ) + ( VCC ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(31),
	cin => \Add0~14\,
	sumout => \Add0~93_sumout\);

-- Location: FF_X87_Y41_N35
\index[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \Add0~93_sumout\,
	clrn => \resetn~input_o\,
	sclr => \Equal0~6_combout\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(31));

-- Location: LABCELL_X88_Y42_N51
\Equal0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = ( !index(0) & ( !index(31) & ( (!index(1) & (!index(3) & (!index(4) & index(2)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(1),
	datab => ALT_INV_index(3),
	datac => ALT_INV_index(4),
	datad => ALT_INV_index(2),
	datae => ALT_INV_index(0),
	dataf => ALT_INV_index(31),
	combout => \Equal0~4_combout\);

-- Location: LABCELL_X88_Y41_N18
\Equal0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~5_combout\ = ( !index(10) & ( !index(8) & ( (!index(7) & (!index(5) & (!index(9) & !index(6)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(7),
	datab => ALT_INV_index(5),
	datac => ALT_INV_index(9),
	datad => ALT_INV_index(6),
	datae => ALT_INV_index(10),
	dataf => ALT_INV_index(8),
	combout => \Equal0~5_combout\);

-- Location: LABCELL_X88_Y41_N12
\Equal0~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~6_combout\ = ( \Equal0~4_combout\ & ( \Equal0~5_combout\ & ( (\Equal0~1_combout\ & (\Equal0~0_combout\ & (\Equal0~3_combout\ & \Equal0~2_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~1_combout\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~3_combout\,
	datad => \ALT_INV_Equal0~2_combout\,
	datae => \ALT_INV_Equal0~4_combout\,
	dataf => \ALT_INV_Equal0~5_combout\,
	combout => \Equal0~6_combout\);

-- Location: LABCELL_X88_Y42_N27
\bit_out_done~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \bit_out_done~0_combout\ = ( \Equal0~6_combout\ & ( \busy~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busy~q\,
	dataf => \ALT_INV_Equal0~6_combout\,
	combout => \bit_out_done~0_combout\);

-- Location: FF_X88_Y42_N28
bit_out_done : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \bit_out_done~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bit_out_done~q\);

-- Location: LABCELL_X88_Y42_N21
\process_0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \process_0~0_combout\ = ( \resetn~input_o\ & ( \bit_out_done~q\ ) ) # ( !\resetn~input_o\ & ( \bit_out_done~q\ ) ) # ( !\resetn~input_o\ & ( !\bit_out_done~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_resetn~input_o\,
	dataf => \ALT_INV_bit_out_done~q\,
	combout => \process_0~0_combout\);

-- Location: FF_X88_Y42_N16
\word_in_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_word~inputCLKENA0_outclk\,
	asdata => \word_in[1]~input_o\,
	clrn => \ALT_INV_process_0~0_combout\,
	sload => VCC,
	ena => \word_valid~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(1));

-- Location: IOIBUF_X89_Y38_N4
\word_in[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(2),
	o => \word_in[2]~input_o\);

-- Location: LABCELL_X88_Y42_N42
\word_in_reg[2]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \word_in_reg[2]~feeder_combout\ = ( \word_in[2]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_word_in[2]~input_o\,
	combout => \word_in_reg[2]~feeder_combout\);

-- Location: FF_X88_Y42_N43
\word_in_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_word~inputCLKENA0_outclk\,
	d => \word_in_reg[2]~feeder_combout\,
	clrn => \ALT_INV_process_0~0_combout\,
	ena => \word_valid~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(2));

-- Location: IOIBUF_X89_Y38_N21
\word_in[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(3),
	o => \word_in[3]~input_o\);

-- Location: LABCELL_X88_Y42_N39
\word_in_reg[3]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \word_in_reg[3]~feeder_combout\ = ( \word_in[3]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_word_in[3]~input_o\,
	combout => \word_in_reg[3]~feeder_combout\);

-- Location: FF_X88_Y42_N40
\word_in_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_word~inputCLKENA0_outclk\,
	d => \word_in_reg[3]~feeder_combout\,
	clrn => \ALT_INV_process_0~0_combout\,
	ena => \word_valid~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(3));

-- Location: IOIBUF_X89_Y37_N21
\word_in[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_word_in(0),
	o => \word_in[0]~input_o\);

-- Location: LABCELL_X88_Y42_N12
\word_in_reg[0]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \word_in_reg[0]~feeder_combout\ = ( \word_in[0]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_word_in[0]~input_o\,
	combout => \word_in_reg[0]~feeder_combout\);

-- Location: FF_X88_Y42_N14
\word_in_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_word~inputCLKENA0_outclk\,
	d => \word_in_reg[0]~feeder_combout\,
	clrn => \ALT_INV_process_0~0_combout\,
	ena => \word_valid~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => word_in_reg(0));

-- Location: LABCELL_X88_Y41_N57
\bit_out~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \bit_out~0_combout\ = ( !\Add0~5_sumout\ & ( (!\Equal0~6_combout\ & ((!\Add0~1_sumout\ & (((word_in_reg(0))))) # (\Add0~1_sumout\ & (word_in_reg(1))))) ) ) # ( \Add0~5_sumout\ & ( ((!\Equal0~6_combout\ & ((!\Add0~1_sumout\ & (word_in_reg(2))) # 
-- (\Add0~1_sumout\ & ((word_in_reg(3))))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "0000110001000100000011000000000000001100010001000000110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_word_in_reg(1),
	datab => \ALT_INV_Equal0~6_combout\,
	datac => ALT_INV_word_in_reg(2),
	datad => \ALT_INV_Add0~1_sumout\,
	datae => \ALT_INV_Add0~5_sumout\,
	dataf => ALT_INV_word_in_reg(3),
	datag => ALT_INV_word_in_reg(0),
	combout => \bit_out~0_combout\);

-- Location: FF_X88_Y41_N58
\bit_out~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \bit_out~0_combout\,
	clrn => \resetn~input_o\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bit_out~reg0_q\);

-- Location: LABCELL_X88_Y41_N27
\bit_valid~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \bit_valid~0_combout\ = ( !\Equal0~6_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Equal0~6_combout\,
	combout => \bit_valid~0_combout\);

-- Location: FF_X88_Y41_N28
\bit_valid~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_bit~inputCLKENA0_outclk\,
	d => \bit_valid~0_combout\,
	clrn => \resetn~input_o\,
	ena => \busy~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bit_valid~reg0_q\);

-- Location: MLABCELL_X65_Y35_N0
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


