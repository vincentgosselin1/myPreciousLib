-- Quartus Prime VHDL Template
-- Binary Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_counter_v1 is

	generic
	(
		NUM_BITS : natural := 8
	);

	port
	(
		clk		  : in std_logic;
		reset	  : in std_logic;
		enable	  : in std_logic;
		q		  : out std_logic_vector(NUM_BITS-1 downto 0)
	);

end entity;

architecture rtl of binary_counter_v1 is
begin

	process (clk)	
		variable cnt : integer range 0 to (2**NUM_BITS-1);
	begin
		if (rising_edge(clk)) then

			if reset = '1' then
				-- Reset the counter to 0
				cnt := 0;

			elsif enable = '1' then
			
				if(cnt = (2**NUM_BITS-1)) then
					cnt := 0;
				else
					-- Increment the counter if counting is enabled			   
					cnt := cnt + 1;
				end if;

			end if;
		end if;

		-- Output the current count
		q <= std_logic_vector(to_unsigned(cnt, NUM_BITS));
	end process;

end rtl;