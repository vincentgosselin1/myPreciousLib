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
		p_bit : out std_logic

	);

end entity;

architecture rtl of parity_bit_calc is
begin

	process(clk)
	begin
		if(resetn = '0') then 
			p_bit <= '0';
		elsif rising_edge(clk) then
			--todo
		end if;
	end process;





end rtl;