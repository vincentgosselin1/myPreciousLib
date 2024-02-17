library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity vhdl_case is
  port(
    i_p        : in  std_logic_vector(1 downto 0);
    A, B, C, D : out std_logic
    );
end vhdl_case;

architecture rtl of vhdl_case is
begin
  process(i_p)
  begin
    case i_p is
      when "00" =>                      -- Select a single value
        A <= '1';
      when "10" =>
        A <= '1';                       -- More than one statement in a branch
        B <= '1';
      when others =>                    -- Mop up the rest
        C <= '0';                       -- no action, no assignments made
        b <= '0';
        a <= '0';
    end case;
  end process;
end rtl;
