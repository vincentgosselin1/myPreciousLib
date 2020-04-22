--parity_bit_calc.vhd by VincentGosselin2020.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parity_bit_calc is

	generic
	(
		NUM_BITS : natural := 8
	);
	
	port
	(
		--inputs
		clk		  : in std_logic; --50 MHZ clock input for devkit
		resetn	  : in std_logic;
		word_in : in std_logic_vector(NUM_BITS-1 downto 0);
		word_valid : in std_logic;
		
		--output
		p_bit : out std_logic;
		p_valid : out std_logic;
		
		--for sim
		check_p_out : out std_logic;
		i_out : out integer

	);

end entity;

architecture rtl of parity_bit_calc is

--signals
signal word_in_reg : std_logic_vector(NUM_BITS-1 downto 0);
signal sum_of_ones : integer;
signal check_p : std_logic;
signal i : integer;

signal r_shift_word : unsigned(NUM_BITS-1 downto 0);
signal target_bit : std_logic;

begin

	check_p_out <= check_p;
	i_out <= i;


	--word_in_reg
	process(clk)
	begin
		if(resetn = '0') then 
			word_in_reg <= (others => '0');
		elsif rising_edge(clk) then
			if word_valid = '1' then
				word_in_reg <= word_in;
			end if;
		end if;
	end process;
	
	--is word_in_reg(0) a '1' or a '0'?
	process(clk)
	begin
		if resetn = '0' then
			target_bit <= '0';
		elsif 
	
	
	
	
	process(clk)
		variable tmp : std_logic;
	begin
		if resetn = '0' then
			sum_of_ones <= 0;
			i <= 0;
		elsif rising_edge(clk) then
			if(i = NUM_BITS-1) then
				i <= 0;
				sum_of_ones <= 0;
				check_p <= '1';
			else
				i <= i + 1;
				check_p <= '0';
				tmp := word_in_reg(i);
				if(tmp = '1') then
					sum_of_ones <= sum_of_ones + 1;
				end if;
			end if;
		end if;
	end process;
	
	--shifting word_in_reg by NUM_BITS times
	process(clk, resetn)
	begin
		if resetn = '0' then
			target_bit <= '0';
		elsif rising_edge(clk) then
			r_shift_word <= shift_right(unsigned(word_in_reg),
	
	
	
	--p_bit gen
	process(clk)
	begin
		if(resetn = '0') then
			p_bit <= '0';
			p_valid <= '0';
		elsif rising_edge(clk) then
			if (check_p = '1') then
				if(sum_of_ones mod 2 = 0) then
					p_bit <= '1';
					p_valid <= '1';
				else 
					p_bit <= '0';
					p_valid <= '0';
				end if;
			end if;
		end if;
	end process;




end rtl;