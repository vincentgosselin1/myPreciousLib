-- register.vhd, Vincent Gosselin,2023.
library ieee;
use ieee.std_logic_1164.all;
entity reg32 is
  port(
    clk : in std_logic;
    rst_n : in std_logic;
    d_in : in std_logic_vector(31 downto 0);
    q_out : out std_logic_vector(31 downto 0)
    );
end reg32;

architecture rtl of reg32 is
begin
  process(clk, rst_n)
  begin
    if rising_edge(clk) then
      if(rst_n = '0') then
        q_out <= (others => '0');
      else
        q_out <= d_in;
      end if;
    end if;
  end process;

end rtl;

