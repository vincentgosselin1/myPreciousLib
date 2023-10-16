--Even_parity_detector_tb
library ieee;
use ieee.std_logic_1164.all;
entity even_parity_detector_tb is
end even_parity_detector_tb;

architecture tb of even_parity_detector_tb is
  component even_parity_detector
    port(
      i_clk  : in std_logic;
      i_rstn : in std_logic;
      i_data : in std_logic_vector(7 downto 0);
      o_even   : out std_logic
      );
  end component;
  signal test_in : std_logic_vector(7 downto 0);
  signal test_out: std_logic;
  signal clk : std_logic;
  signal rstn : std_logic;
begin
  --instantiation of dut
  u0_even_parity_detector: entity work.even_parity_detector
    port map (
      i_clk  => clk,
      i_rstn => rstn,
      i_data => test_in,
      o_even   => test_out
      );
  --clk process
  process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;
  
  -- test vector generator
  process
  begin
    test_in <= X"00";
    rstn <= '0';
    wait for 200 ns;
    rstn <= '1';
    wait for 200 ns;

    --test starts
    test_in <= X"00";
    wait for 200 ns;
    rstn <= '1';
    test_in <= X"01";
    wait for 200 ns;
    test_in <= X"02";
    wait for 200 ns;
    test_in <= X"03";
    wait for 200 ns;
  end process;
end tb;
  
