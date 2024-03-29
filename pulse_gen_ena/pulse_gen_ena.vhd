--pulse_gen.vhd by Vincent Gosselin, 2020.
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;  

entity pulse_gen_ena is

	port
	(
		-- Input ports
		input	: in std_logic;
		clk : in std_logic; 
		resetn : in std_logic;
		ena : in std_logic;
		
		-- Output ports
		pulse	:	out std_logic
	);
end pulse_gen_ena;



architecture rtl of pulse_gen_ena is

	-- Declarations (optional)
	signal dff1 : std_logic;
	signal dff2 : std_logic;

begin

	process(clk, resetn, input, dff1, dff2, ena)
	begin
		if resetn = '0' then
			dff1 <= '0';
			dff2 <= '0';
		elsif rising_edge(clk) then
			if ena = '1' then
				dff1 <= input;
				dff2 <= dff1;
			end if;
		end if;
		
		--logic
		pulse <= dff1 and not(dff2);
	end process;

end rtl;

