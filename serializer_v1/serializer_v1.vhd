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
		clk_word			 : in std_logic;--used for sampling word_in
		clk_bit			:in std_logic; --used for outputting bits on serial pin.
		resetn		: in std_logic;
		word_in		 : in std_logic_vector((DATA_WIDTH-1) downto 0);
		word_valid : in std_logic;
		bit_out		 : out std_logic; -- serial pin
		bit_valid : out std_logic
	);

end entity;

architecture rtl of serializer_v1 is

	signal word_in_reg : std_logic_vector((DATA_WIDTH-1) downto 0);
	signal busy : std_logic;
	signal index : integer := DATA_WIDTH;
	signal bit_out_done : std_logic;
	
	
begin

	--word_in_reg
	process(clk_word, resetn, bit_out_done)
	begin
		if resetn = '0' or bit_out_done = '1' then
			word_in_reg <= (others => '0');
			busy <= '0';
		elsif rising_edge(clk_word) then
			if (word_valid = '1') then --send a single clock word_valid;
					word_in_reg <= word_in;
					busy <= '1';
			end if;
		end if;
	end process;
	
	--bit_out
	process (clk_bit, resetn, busy)
	begin
		if resetn = '0' or busy = '0' then
			bit_out <= '0';
			bit_valid <= '0';
			index <= DATA_WIDTH;
			bit_out_done <= '0';
			

		elsif (rising_edge(clk_bit)) then
				if (busy = '1') then
					if(index = 0) then
						index <= DATA_WIDTH;
						bit_valid <= '0';
						bit_out <= '0';
						bit_out_done <= '1';
					else 
						bit_out <= word_in_reg(index-1);
						index <= index - 1;
						bit_valid <= '1';
						bit_out_done <= '0';
					end if;
				end if;
		end if;
	end process;
					
end rtl;
