--serializer_v1.vhd by Vincent Gosselin, 2020.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity serializer_v1 is

	generic
	(
		DATA_WIDTH : natural := 4
	);

	port 
	(
		clk			 : in std_logic;
		resetn		: in std_logic;
		word_in		 : in std_logic_vector((DATA_WIDTH-1) downto 0);
		word_valid : in std_logic;
		bit_out		 : out std_logic;
		bit_valid : out std_logic
	);

end entity;

architecture rtl of serializer_v1 is

	signal word_in_reg : std_logic_vector((DATA_WIDTH-1) downto 0);
	signal busy : std_logic;
	signal index : integer;
	
	
begin

	process (clk, resetn)
	begin
		if resetn = '0' then
			word_in_reg <= (others => '0');
			busy <= '0';
			
			bit_out <= '0';
			bit_valid <= '0';
			
			index <= DATA_WIDTH;

		elsif (rising_edge(clk)) then
				if (word_valid = '1') then --send a single clock word_valid;
					word_in_reg <= word_in;
					busy <= '1';
				elsif (busy = '1' and word_valid = '0') then
					if(index = 0) then
						index <= DATA_WIDTH;
						busy <= '0';
						bit_valid <= '0';
						bit_out <= '0';
					else 
						bit_out <= word_in_reg(index-1);
						index <= index - 1;
						bit_valid <= '1';
					end if;
				end if;
		end if;
	end process;
					
end rtl;
