--Even_parity_detector based on XOR gates.
library ieee;
use ieee.std_logic_1164.all;
entity even_parity_detector is
  port(
    i_clk  : in  std_logic;
    i_rstn : in std_logic;
    i_data : in  std_logic_vector(1 downto 0);
    even   : out std_logic
    );
end even_parity_detector;

architecture rtl of even_parity_detector is
  signal odd : std_logic;
begin
  process(i_clk)
  begin
    if rising_edge(i_clk) then
      if i_rstn = '0' then
        even <= '0';
      else
      odd  <= i_data(0) xor i_data(1);
      even <= not odd;
      end if;
    end if;
  end process;
end rtl;

