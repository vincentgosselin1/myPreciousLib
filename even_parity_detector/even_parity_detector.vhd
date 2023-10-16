--Even_parity_detector based on XOR gates.
library ieee;
use ieee.std_logic_1164.all;
entity even_parity_detector is
  port(
    i_clk  : in  std_logic;
    i_rstn : in std_logic;
    i_data : in  std_logic_vector(7 downto 0);
    o_even   : out std_logic
    );
end even_parity_detector;

architecture rtl of even_parity_detector is
  signal odd : std_logic;
  signal odd_dff : std_logic;
  signal data_in_dff : std_logic_vector(7 downto 0);
  signal even_dff : std_logic;
  signal even : std_logic;
begin
  
  p_data_in_dff : process(i_clk)
  begin
    if rising_edge(i_clk) then
      if i_rstn = '0' then
        data_in_dff <= (others => '0');
      else
        data_in_dff <= i_data;
      end if;
    end if;
  end process;

  --combinatorial logic
  p_xor_network : process(data_in_dff)
    variable tmp : std_logic;
  begin
    tmp := '0';
    for i in 7 downto 0 loop
      tmp := tmp xor data_in_dff(i);
    end loop;
      odd <= tmp;
  end process;

  p_odd_dff : process(i_clk)
  begin
    if i_rstn = '0' then
      odd_dff <= '0';
    else
      odd_dff <= odd;
    end if;
  end process;

  --combinatorial logic
  even <= not odd_dff;

    
  p_even_dff : process(i_clk)
  begin
    if i_rstn = '0' then
      even_dff <= '0';
    else
      even_dff <= even;
    end if;
  end process;

  o_even <= even_dff;
  
end rtl;

