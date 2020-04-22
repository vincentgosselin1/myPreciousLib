--parity_bit_calc.vhd with sm by Vincent Gosselin 2020
--even parity, number of ones in a word must be even number for parity to be 0.



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parity_bit_calc_sm is

	generic
	(
		NUM_BITS : natural := 4
	);
	
	port
	(
		--inputs
		clk		  : in std_logic; --50 MHZ clock input from devkit
		resetn	  : in std_logic;
		word_in : in std_logic_vector(NUM_BITS-1 downto 0);
		word_valid : in std_logic;
		
		--output
		p_bit : out std_logic;
		p_valid : out std_logic;
		
		--for sim
		num_of_ones_out : out  unsigned(NUM_BITS-1 downto 0);
		index_out : out unsigned(NUM_BITS-1 downto 0);
		busy_out : out std_logic

	);

end entity;

architecture rtl of parity_bit_calc_sm is

	-- Build an enumerated type for the state machine
	type state_type is (idle, s0, s1, s2, s3, s4, s5);
	
	--idle, waits for valid
	--s0 sets busy, clear num_of_ones
	--s1 is for CHECK_WORD
	--s2 is for Incr num_of_ones
	--s3 is for Incr index.
	--s4 is for set p_bit, set p_valid.
	--s5 clears busy.
	
	
	-- Register to hold the current state
	signal state   : state_type;
	signal busy : std_logic;
	signal num_of_ones : unsigned(NUM_BITS-1 downto 0);
	signal word_in_reg : std_logic_vector(NUM_BITS-1 downto 0);
	signal index : unsigned(NUM_BITS-1 downto 0);
	signal target_bit : std_logic;

	
begin

	--assign
	busy_out <= busy;
	num_of_ones_out <= num_of_ones;
	index_out <= index;	

	-- Logic to advance to the next state
	process (clk, resetn)
	begin
		if resetn = '0' then
			state <= idle;
		elsif (rising_edge(clk)) then
			case state is
				when idle =>
					--wait for word_valid to start. word_in should align.
					if word_valid = '1' then
						state <= s0;
					end if;	
				when s0 =>	
					state <= s1;
				when s1 =>
					if index = NUM_BITS-1 then
						state <= s4;
					elsif target_bit = '1' then
						state <= s2;
					else 
						state <= s3;
					end if;
				when s2 =>
					state <= s3;
				when s3 => 
					state <= s1;
				when s4 =>
					state <= s5;
				when s5 =>
					state <= idle;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state,clk,resetn)
	begin
	if resetn = '0' then
		--outputs are cleared
		p_bit <= '0';
		p_valid <= '0';
		--all registers are cleared
		num_of_ones <= to_unsigned(0, NUM_BITS);
		index <= to_unsigned(0, NUM_BITS);
		word_in_reg <= (others => '0');
		target_bit <= '0';
		
		busy <= '0';
		
	elsif rising_edge(clk) then
		case state is
			when idle =>
				--outputs are cleared, sample word_in.
					p_bit <= '0';
					p_valid <= '0';
					word_in_reg <= word_in;
					
			when s0 =>
				---set busy, clear num_of_ones, clear checked move to s1.
					busy <= '1';
					num_of_ones <= to_unsigned(0, NUM_BITS);
					index <= to_unsigned(0, NUM_BITS);
					

					
			when s1 =>
					--check word_in_reg(0), move to s2 or s3 or s4
					target_bit <= word_in_reg(to_integer(index));
			when s2 =>
				--Incr num_of_ones, move to s3
					num_of_ones <= num_of_ones + 1;
			when s3 =>
				--incr index. move to s1.
					index <= index + 1; 
			when s4 =>
					--is num_of_ones an even number?
					if(to_integer(num_of_ones) mod 2 = 0) then
						p_bit <= '0';
						p_valid <= '1';
					else
						p_bit <= '1';
						p_valid <= '1';
					end if;
					
			when s5 =>
					--clear busy, index, num_of_ones
					busy <= '0';
					index <= to_unsigned(0, NUM_BITS);
					num_of_ones <= to_unsigned(0, NUM_BITS);
					
					p_bit <= '0';
					p_valid <= '0';
					target_bit <= '0';
		end case;
	end if;
	end process;

end rtl;
