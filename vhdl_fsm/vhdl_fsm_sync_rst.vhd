--vhdl_fsm_sync_rst, Vincent Gosselin 2024.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity vhdl_fsm_sync_rst is
  port(
    i_clock : in  std_logic;
    i_reset : in  std_logic;
    i_p     : in  std_logic;
    o_r     : out std_logic
    );
end vhdl_fsm_sync_rst;

architecture rtl of vhdl_fsm_sync_rst is
  type state_type is (A, B, C, D);      --define states
  signal state : state_type;            --signal for the different states.

begin
  process(i_clock, i_reset)
  begin
    if rising_edge(i_clock) then
      if(i_reset = '1') then
        state <= A;
      else
        case state is
          when A =>
            if i_p = '1' then
              state <= B;
            end if;
          when B =>
            if i_p = '1' then
              state <= C;
            end if;
          when C =>
            if i_p = '1' then
              state <= D;
            end if;
          when D =>
            if i_p = '1' then
              state <= B;
            else
              state <= A;
            end if;
          when others =>
            state <= A;
        end case;
      end if;
    end if;
  end process;

  --decode the current state to create the output
  process(state)
  begin
    case state is
    when D =>
      o_r <= '1';
    when others =>
      o_r <= '0';
  end case;
end process;

end rtl;

