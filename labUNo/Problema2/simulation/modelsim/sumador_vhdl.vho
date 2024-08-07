-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

-- DATE "08/07/2024 13:52:43"

-- 
-- Device: Altera 5CSXFC6D6F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	sumador_vhdl IS
    PORT (
	a : IN std_logic_vector(0 TO 3);
	b : IN std_logic_vector(0 TO 3);
	c : IN std_logic;
	c0 : BUFFER std_logic;
	s0 : BUFFER std_logic;
	c1 : BUFFER std_logic;
	s1 : BUFFER std_logic;
	c2 : BUFFER std_logic;
	s2 : BUFFER std_logic;
	c3 : BUFFER std_logic;
	s3 : BUFFER std_logic;
	s4 : BUFFER std_logic;
	sevenSegment : BUFFER std_logic_vector(0 TO 6)
	);
END sumador_vhdl;

-- Design Ports Information
-- c0	=>  Location: PIN_AH30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s0	=>  Location: PIN_AD26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c1	=>  Location: PIN_AF29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s1	=>  Location: PIN_AF30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c2	=>  Location: PIN_W24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s2	=>  Location: PIN_AG30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c3	=>  Location: PIN_AE28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s3	=>  Location: PIN_AC27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s4	=>  Location: PIN_AA24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sevenSegment[6]	=>  Location: PIN_AH18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sevenSegment[5]	=>  Location: PIN_AG18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sevenSegment[4]	=>  Location: PIN_AH17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sevenSegment[3]	=>  Location: PIN_AG16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sevenSegment[2]	=>  Location: PIN_AG17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sevenSegment[1]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sevenSegment[0]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[0]	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c	=>  Location: PIN_AC29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[0]	=>  Location: PIN_AB30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[1]	=>  Location: PIN_Y27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[1]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[2]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[2]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[3]	=>  Location: PIN_AC30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[3]	=>  Location: PIN_AD30,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF sumador_vhdl IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_a : std_logic_vector(0 TO 3);
SIGNAL ww_b : std_logic_vector(0 TO 3);
SIGNAL ww_c : std_logic;
SIGNAL ww_c0 : std_logic;
SIGNAL ww_s0 : std_logic;
SIGNAL ww_c1 : std_logic;
SIGNAL ww_s1 : std_logic;
SIGNAL ww_c2 : std_logic;
SIGNAL ww_s2 : std_logic;
SIGNAL ww_c3 : std_logic;
SIGNAL ww_s3 : std_logic;
SIGNAL ww_s4 : std_logic;
SIGNAL ww_sevenSegment : std_logic_vector(0 TO 6);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \c~input_o\ : std_logic;
SIGNAL \b[0]~input_o\ : std_logic;
SIGNAL \a[0]~input_o\ : std_logic;
SIGNAL \c0~0_combout\ : std_logic;
SIGNAL \b[1]~input_o\ : std_logic;
SIGNAL \a[1]~input_o\ : std_logic;
SIGNAL \c1~0_combout\ : std_logic;
SIGNAL \a[2]~input_o\ : std_logic;
SIGNAL \b[2]~input_o\ : std_logic;
SIGNAL \c2~0_combout\ : std_logic;
SIGNAL \a[3]~input_o\ : std_logic;
SIGNAL \b[3]~input_o\ : std_logic;
SIGNAL \c3~0_combout\ : std_logic;
SIGNAL \display|Mux6~0_combout\ : std_logic;
SIGNAL \display|Mux5~0_combout\ : std_logic;
SIGNAL \display|Mux4~0_combout\ : std_logic;
SIGNAL \display|Mux3~0_combout\ : std_logic;
SIGNAL \display|Mux2~0_combout\ : std_logic;
SIGNAL \display|Mux1~0_combout\ : std_logic;
SIGNAL \display|Mux0~0_combout\ : std_logic;
SIGNAL LED_in : std_logic_vector(0 TO 3);
SIGNAL ALT_INV_LED_in : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_c1~0_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux6~0_combout\ : std_logic;
SIGNAL \ALT_INV_b[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_c~input_o\ : std_logic;
SIGNAL \ALT_INV_a[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[3]~input_o\ : std_logic;

BEGIN

ww_a <= a;
ww_b <= b;
ww_c <= c;
c0 <= ww_c0;
s0 <= ww_s0;
c1 <= ww_c1;
s1 <= ww_s1;
c2 <= ww_c2;
s2 <= ww_s2;
c3 <= ww_c3;
s3 <= ww_s3;
s4 <= ww_s4;
sevenSegment <= ww_sevenSegment;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
ALT_INV_LED_in(3) <= NOT LED_in(3);
\ALT_INV_c1~0_combout\ <= NOT \c1~0_combout\;
ALT_INV_LED_in(2) <= NOT LED_in(2);
ALT_INV_LED_in(1) <= NOT LED_in(1);
\display|ALT_INV_Mux6~0_combout\ <= NOT \display|Mux6~0_combout\;
ALT_INV_LED_in(0) <= NOT LED_in(0);
\ALT_INV_b[0]~input_o\ <= NOT \b[0]~input_o\;
\ALT_INV_c~input_o\ <= NOT \c~input_o\;
\ALT_INV_a[0]~input_o\ <= NOT \a[0]~input_o\;
\ALT_INV_a[1]~input_o\ <= NOT \a[1]~input_o\;
\ALT_INV_a[2]~input_o\ <= NOT \a[2]~input_o\;
\ALT_INV_b[1]~input_o\ <= NOT \b[1]~input_o\;
\ALT_INV_b[2]~input_o\ <= NOT \b[2]~input_o\;
\ALT_INV_a[3]~input_o\ <= NOT \a[3]~input_o\;
\ALT_INV_b[3]~input_o\ <= NOT \b[3]~input_o\;

-- Location: IOOBUF_X89_Y16_N39
\c0~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \c0~0_combout\,
	devoe => ww_devoe,
	o => ww_c0);

-- Location: IOOBUF_X89_Y16_N5
\s0~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => LED_in(3),
	devoe => ww_devoe,
	o => ww_s0);

-- Location: IOOBUF_X89_Y15_N39
\c1~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \c1~0_combout\,
	devoe => ww_devoe,
	o => ww_c1);

-- Location: IOOBUF_X89_Y15_N56
\s1~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => LED_in(2),
	devoe => ww_devoe,
	o => ww_s1);

-- Location: IOOBUF_X89_Y15_N22
\c2~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \c2~0_combout\,
	devoe => ww_devoe,
	o => ww_c2);

-- Location: IOOBUF_X89_Y16_N56
\s2~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => LED_in(1),
	devoe => ww_devoe,
	o => ww_s2);

-- Location: IOOBUF_X89_Y11_N96
\c3~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \c3~0_combout\,
	devoe => ww_devoe,
	o => ww_c3);

-- Location: IOOBUF_X89_Y16_N22
\s3~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => LED_in(0),
	devoe => ww_devoe,
	o => ww_s3);

-- Location: IOOBUF_X89_Y11_N45
\s4~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \c3~0_combout\,
	devoe => ww_devoe,
	o => ww_s4);

-- Location: IOOBUF_X56_Y0_N53
\sevenSegment[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_sevenSegment(6));

-- Location: IOOBUF_X58_Y0_N76
\sevenSegment[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_sevenSegment(5));

-- Location: IOOBUF_X56_Y0_N36
\sevenSegment[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_sevenSegment(4));

-- Location: IOOBUF_X50_Y0_N76
\sevenSegment[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_sevenSegment(3));

-- Location: IOOBUF_X50_Y0_N93
\sevenSegment[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_sevenSegment(2));

-- Location: IOOBUF_X80_Y0_N2
\sevenSegment[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_sevenSegment(1));

-- Location: IOOBUF_X60_Y0_N19
\sevenSegment[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_sevenSegment(0));

-- Location: IOIBUF_X89_Y20_N95
\c~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_c,
	o => \c~input_o\);

-- Location: IOIBUF_X89_Y20_N44
\b[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(0),
	o => \b[0]~input_o\);

-- Location: IOIBUF_X89_Y21_N4
\a[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(0),
	o => \a[0]~input_o\);

-- Location: LABCELL_X88_Y16_N0
\c0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \c0~0_combout\ = ( \b[0]~input_o\ & ( \a[0]~input_o\ ) ) # ( !\b[0]~input_o\ & ( \a[0]~input_o\ & ( \c~input_o\ ) ) ) # ( \b[0]~input_o\ & ( !\a[0]~input_o\ & ( \c~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011110000111100001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_c~input_o\,
	datae => \ALT_INV_b[0]~input_o\,
	dataf => \ALT_INV_a[0]~input_o\,
	combout => \c0~0_combout\);

-- Location: LABCELL_X88_Y16_N9
\LED_in[3]\ : cyclonev_lcell_comb
-- Equation(s):
-- LED_in(3) = ( \b[0]~input_o\ & ( \a[0]~input_o\ & ( \c~input_o\ ) ) ) # ( !\b[0]~input_o\ & ( \a[0]~input_o\ & ( !\c~input_o\ ) ) ) # ( \b[0]~input_o\ & ( !\a[0]~input_o\ & ( !\c~input_o\ ) ) ) # ( !\b[0]~input_o\ & ( !\a[0]~input_o\ & ( \c~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101101010101010101010101010101010100101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_c~input_o\,
	datae => \ALT_INV_b[0]~input_o\,
	dataf => \ALT_INV_a[0]~input_o\,
	combout => LED_in(3));

-- Location: IOIBUF_X89_Y20_N61
\b[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(1),
	o => \b[1]~input_o\);

-- Location: IOIBUF_X89_Y25_N21
\a[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(1),
	o => \a[1]~input_o\);

-- Location: LABCELL_X88_Y16_N45
\c1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \c1~0_combout\ = ( \b[0]~input_o\ & ( \a[0]~input_o\ & ( (\a[1]~input_o\) # (\b[1]~input_o\) ) ) ) # ( !\b[0]~input_o\ & ( \a[0]~input_o\ & ( (!\b[1]~input_o\ & (\a[1]~input_o\ & \c~input_o\)) # (\b[1]~input_o\ & ((\c~input_o\) # (\a[1]~input_o\))) ) ) ) 
-- # ( \b[0]~input_o\ & ( !\a[0]~input_o\ & ( (!\b[1]~input_o\ & (\a[1]~input_o\ & \c~input_o\)) # (\b[1]~input_o\ & ((\c~input_o\) # (\a[1]~input_o\))) ) ) ) # ( !\b[0]~input_o\ & ( !\a[0]~input_o\ & ( (\b[1]~input_o\ & \a[1]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100000101000001010101111100000101010111110101111101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_b[1]~input_o\,
	datac => \ALT_INV_a[1]~input_o\,
	datad => \ALT_INV_c~input_o\,
	datae => \ALT_INV_b[0]~input_o\,
	dataf => \ALT_INV_a[0]~input_o\,
	combout => \c1~0_combout\);

-- Location: LABCELL_X88_Y16_N18
\LED_in[2]\ : cyclonev_lcell_comb
-- Equation(s):
-- LED_in(2) = ( \b[0]~input_o\ & ( \a[0]~input_o\ & ( !\a[1]~input_o\ $ (\b[1]~input_o\) ) ) ) # ( !\b[0]~input_o\ & ( \a[0]~input_o\ & ( !\c~input_o\ $ (!\a[1]~input_o\ $ (\b[1]~input_o\)) ) ) ) # ( \b[0]~input_o\ & ( !\a[0]~input_o\ & ( !\c~input_o\ $ 
-- (!\a[1]~input_o\ $ (\b[1]~input_o\)) ) ) ) # ( !\b[0]~input_o\ & ( !\a[0]~input_o\ & ( !\a[1]~input_o\ $ (!\b[1]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100011010010110100101101001011010011100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_c~input_o\,
	datab => \ALT_INV_a[1]~input_o\,
	datac => \ALT_INV_b[1]~input_o\,
	datae => \ALT_INV_b[0]~input_o\,
	dataf => \ALT_INV_a[0]~input_o\,
	combout => LED_in(2));

-- Location: IOIBUF_X89_Y21_N38
\a[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(2),
	o => \a[2]~input_o\);

-- Location: IOIBUF_X89_Y20_N78
\b[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(2),
	o => \b[2]~input_o\);

-- Location: LABCELL_X88_Y16_N57
\c2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \c2~0_combout\ = (!\a[2]~input_o\ & (\b[2]~input_o\ & \c1~0_combout\)) # (\a[2]~input_o\ & ((\c1~0_combout\) # (\b[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010101011111000001010101111100000101010111110000010101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[2]~input_o\,
	datac => \ALT_INV_b[2]~input_o\,
	datad => \ALT_INV_c1~0_combout\,
	combout => \c2~0_combout\);

-- Location: LABCELL_X88_Y16_N30
\LED_in[1]\ : cyclonev_lcell_comb
-- Equation(s):
-- LED_in(1) = !\a[2]~input_o\ $ (!\b[2]~input_o\ $ (\c1~0_combout\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011010011001011001101001100101100110100110010110011010011001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[2]~input_o\,
	datab => \ALT_INV_b[2]~input_o\,
	datad => \ALT_INV_c1~0_combout\,
	combout => LED_in(1));

-- Location: IOIBUF_X89_Y25_N55
\a[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(3),
	o => \a[3]~input_o\);

-- Location: IOIBUF_X89_Y25_N38
\b[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(3),
	o => \b[3]~input_o\);

-- Location: LABCELL_X88_Y16_N54
\c3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \c3~0_combout\ = ( \b[3]~input_o\ & ( ((!\a[2]~input_o\ & (\b[2]~input_o\ & \c1~0_combout\)) # (\a[2]~input_o\ & ((\c1~0_combout\) # (\b[2]~input_o\)))) # (\a[3]~input_o\) ) ) # ( !\b[3]~input_o\ & ( (\a[3]~input_o\ & ((!\a[2]~input_o\ & (\b[2]~input_o\ & 
-- \c1~0_combout\)) # (\a[2]~input_o\ & ((\c1~0_combout\) # (\b[2]~input_o\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000111000000010000011100011111011111110001111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[2]~input_o\,
	datab => \ALT_INV_b[2]~input_o\,
	datac => \ALT_INV_a[3]~input_o\,
	datad => \ALT_INV_c1~0_combout\,
	dataf => \ALT_INV_b[3]~input_o\,
	combout => \c3~0_combout\);

-- Location: LABCELL_X88_Y16_N33
\LED_in[0]\ : cyclonev_lcell_comb
-- Equation(s):
-- LED_in(0) = ( \a[3]~input_o\ & ( !\b[3]~input_o\ $ (((!\a[2]~input_o\ & (\b[2]~input_o\ & \c1~0_combout\)) # (\a[2]~input_o\ & ((\c1~0_combout\) # (\b[2]~input_o\))))) ) ) # ( !\a[3]~input_o\ & ( !\b[3]~input_o\ $ (((!\a[2]~input_o\ & ((!\b[2]~input_o\) # 
-- (!\c1~0_combout\))) # (\a[2]~input_o\ & (!\b[2]~input_o\ & !\c1~0_combout\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001111001111000000111100111100011100001100001111110000110000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[2]~input_o\,
	datab => \ALT_INV_b[2]~input_o\,
	datac => \ALT_INV_b[3]~input_o\,
	datad => \ALT_INV_c1~0_combout\,
	dataf => \ALT_INV_a[3]~input_o\,
	combout => LED_in(0));

-- Location: LABCELL_X88_Y16_N36
\display|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \display|Mux6~0_combout\ = ( LED_in(1) & ( (!LED_in(0) & ((!LED_in(3)) # (!LED_in(2)))) # (LED_in(0) & ((LED_in(2)) # (LED_in(3)))) ) ) # ( !LED_in(1) & ( (LED_in(2)) # (LED_in(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111010111110101111110111101101111011011110110111101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_LED_in(0),
	datab => ALT_INV_LED_in(3),
	datac => ALT_INV_LED_in(2),
	dataf => ALT_INV_LED_in(1),
	combout => \display|Mux6~0_combout\);

-- Location: LABCELL_X88_Y16_N12
\display|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \display|Mux5~0_combout\ = ( LED_in(1) & ( (LED_in(3) & (!LED_in(0) $ (!LED_in(2)))) ) ) # ( !LED_in(1) & ( (!LED_in(0) & ((LED_in(2)) # (LED_in(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101000101010001010100010101000010010000100100001001000010010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_LED_in(0),
	datab => ALT_INV_LED_in(3),
	datac => ALT_INV_LED_in(2),
	dataf => ALT_INV_LED_in(1),
	combout => \display|Mux5~0_combout\);

-- Location: LABCELL_X88_Y16_N15
\display|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \display|Mux4~0_combout\ = ( LED_in(1) & ( (!LED_in(0) & ((!LED_in(2)) # (LED_in(3)))) ) ) # ( !LED_in(1) & ( (LED_in(3) & ((!LED_in(0)) # (!LED_in(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001000110010001100100011001010100010101000101010001010100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_LED_in(0),
	datab => ALT_INV_LED_in(3),
	datac => ALT_INV_LED_in(2),
	dataf => ALT_INV_LED_in(1),
	combout => \display|Mux4~0_combout\);

-- Location: LABCELL_X88_Y16_N48
\display|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \display|Mux3~0_combout\ = ( LED_in(1) & ( (!LED_in(2) & (!LED_in(0) & !LED_in(3))) # (LED_in(2) & ((LED_in(3)))) ) ) # ( !LED_in(1) & ( (!LED_in(2) & (!LED_in(0) & LED_in(3))) # (LED_in(2) & (LED_in(0) & !LED_in(3))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001111000000000000111100000011000000001100111100000000110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_LED_in(2),
	datac => ALT_INV_LED_in(0),
	datad => ALT_INV_LED_in(3),
	dataf => ALT_INV_LED_in(1),
	combout => \display|Mux3~0_combout\);

-- Location: LABCELL_X88_Y16_N39
\display|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \display|Mux2~0_combout\ = ( LED_in(1) & ( (LED_in(0) & ((!LED_in(3)) # (LED_in(2)))) ) ) # ( !LED_in(1) & ( (!LED_in(0) & (!LED_in(3) & LED_in(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100000001000000010000000100001000101010001010100010101000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_LED_in(0),
	datab => ALT_INV_LED_in(3),
	datac => ALT_INV_LED_in(2),
	dataf => ALT_INV_LED_in(1),
	combout => \display|Mux2~0_combout\);

-- Location: LABCELL_X88_Y16_N51
\display|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \display|Mux1~0_combout\ = ( LED_in(1) & ( (!LED_in(0) & (!LED_in(2) $ (!LED_in(3)))) # (LED_in(0) & ((!LED_in(3)) # (LED_in(2)))) ) ) # ( !LED_in(1) & ( (LED_in(0) & (LED_in(2) & LED_in(3))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000000010000000101111001011110010111100101111001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_LED_in(0),
	datab => ALT_INV_LED_in(2),
	datac => ALT_INV_LED_in(3),
	dataf => ALT_INV_LED_in(1),
	combout => \display|Mux1~0_combout\);

-- Location: LABCELL_X88_Y16_N24
\display|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \display|Mux0~0_combout\ = ( LED_in(1) & ( (!LED_in(2) & (!LED_in(0) $ (LED_in(3)))) ) ) # ( !LED_in(1) & ( (LED_in(3) & (!LED_in(0) $ (LED_in(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001000010001001000100001000110011001000000001001100100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_LED_in(0),
	datab => ALT_INV_LED_in(3),
	datad => ALT_INV_LED_in(2),
	dataf => ALT_INV_LED_in(1),
	combout => \display|Mux0~0_combout\);

-- Location: MLABCELL_X34_Y21_N3
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


