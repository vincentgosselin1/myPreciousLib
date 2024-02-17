--tb_vhdl_fsm_sync_rst, Vincent Gosselin 2024.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_vhdl_fsm_sync_rst is
end tb_vhdl_fsm_sync_rst;

architecture tb of tb_vhdl_fsm_sync_rst is
  component vhdl_fsm_sync_rst is
    port (
      i_clock : in  std_logic;
      i_p     : in  std_logic;
      i_reset : in  std_logic;
      o_r     : out std_logic);
  end component vhdl_fsm_sync_rst;

  signal clk : std_logic;
  signal rst : std_logic;
  signal p   : std_logic;
  signal r   : std_logic;

begin
  --instantiation of dut
  u0_vhdl_fsm_sync : entity work.vhdl_fsm_sync_rst
    port map(
      i_clock => clk,
      i_reset => rst,
      i_p     => p,
      o_r     => r
      );

  --running clock 20ns period -> 50Mhz
  process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;

  --injection of the stimulus
  process
  begin
    rst <= '1';
    wait for 200 ns;
    rst <= '0';
    wait for 200 ns;

    p <= '1';
    wait for 200 ns;
    wait for 200 ns;
    wait for 200 ns;
    wait for 200 ns;
    wait for 200 ns;

  end process;
end tb;

