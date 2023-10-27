--Even_parity_detector_tb
library ieee;
use ieee.std_logic_1164.all;
entity unsigned_counter_tb is
end unsigned_counter_tb;

architecture tb of unsigned_counter_tb is
  component unsigned_counter is
    generic (
      NUM_BITS : integer);
    port (
      i_clk     : in  std_logic;
      i_rstn    : in  std_logic;
      i_cnt_ena : in  std_logic;
      o_count   : out std_logic_vector(NUM_BITS-1 downto 0));
  end component unsigned_counter;
  
  signal clk : std_logic;
  signal rstn : std_logic;
  signal ena : std_logic;
  signal count : std_logic_vector(7 downto 0);
  
begin

--instantiation of dut
  u0_unsigned_counter: entity work.unsigned_counter
    generic map (
      NUM_BITS => 8
      )
    port map (
      i_clk     => clk,
      i_rstn    => rstn,
      i_cnt_ena => ena,
      o_count   => count
      );

  
  process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;

  --injection of the stimulus.
  -- test vector generator
  process
  begin

    ena <= '0';
    rstn <= '0';
    wait for 200 ns;
    rstn <= '1';
    wait for 200 ns;

    --test starts
    ena <= '1';
    --wait for 20000000 ns;
    wait for 2000 us;
    
  end process;

  
end tb;
  
