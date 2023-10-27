--unsigned counter, Vincent Gosselin 2023.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity unsigned_counter is
  generic (
    NUM_BITS : integer := 32            -- counter range
    );
  port(
    i_clk     : in  std_logic;
    i_rstn    : in  std_logic;
    i_cnt_ena : in  std_logic;
    o_count   : out std_logic_vector(NUM_BITS-1 downto 0)
    );
end unsigned_counter;

architecture rtl of unsigned_counter is
  signal count : unsigned(NUM_BITS-1 downto 0) := (others => '0');

begin
  process(i_clk)
  begin
    if rising_edge(i_clk) then
      if i_rstn = '0' then
        count <= (others => '0');
      else
        if i_cnt_ena = '1' then
          count <= count + 1; --wraps around
        end if;
      end if;
    end if;
  end process;

  o_count <= std_logic_vector(count);
end rtl;
