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
		
		--output
		p_bit : out std_logic;
		
		--for sim
		check_p_out : out std_logic

	);

end entity;

architecture rtl of parity_bit_calc is

--signals
signal word_in_reg : std_logic_vector(NUM_BITS-1 downto 0);
signal sum_of_ones : integer;
signal check_p : std_logic;

begin

	check_p_out <= check_p;

	process(clk)
	begin
		if(resetn = '0') then 
			word_in_reg <= (others => '0');
		elsif rising_edge(clk) then
			word_in_reg <= word_in;
		end if;
	end process;

	process(clk)
		variable i : integer;
		variable tmp : std_logic;
	begin
		if resetn = '0' then
			sum_of_ones <= 0;
			i := 0;
		elsif rising_edge(clk) then
			if(i = NUM_BITS-1) then
				i := 0;
				sum_of_ones <= 0;
				check_p <= '1';
			else
				i := i + 1;
				check_p <= '0';
				tmp := word_in_reg(i);
				if(tmp = '1') then
					sum_of_ones <= sum_of_ones + 1;
				end if;
			end if;
		end if;
	end process;
	
	--p_bit gen
	process(clk)
	begin
		if(resetn = '0') then
			p_bit <= '0';
		elsif rising_edge(clk) then
			if (check_p = '1') then
				if(sum_of_ones mod 2 = 0) then
					p_bit <= '1';
				else 
					p_bit <= '0';
				end if;
			end if;
		end if;
	end process;




end rtl;