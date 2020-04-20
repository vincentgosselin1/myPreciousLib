--dff2_sync , synchronizer crossing clock domains

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dff2_sync is
	port
	(
		--inputs
		clk		  : in std_logic;
		resetn	  : in std_logic;
		
		d_in	: in std_logic;
		
		q_out : out std_logic
	);
end entity;

architecture rtl of dff2_sync is
	signal dff1 : std_logic; 
	signal dff2 : std_logic;
	
begin

	process(clk,resetn) 
	begin
		if(resetn = '0') then
			dff1 <= '0';
		elsif rising_edge(clk) then
			dff1 <= d_in;
		end if;
	end process;
	
	process(clk,resetn) 
	begin
		if(resetn = '0') then
			dff2 <= '0';
		elsif rising_edge(clk) then
			dff2 <= dff1;
		end if;
	end process;
	
	q_out <= dff2;

end rtl;
	
	
	