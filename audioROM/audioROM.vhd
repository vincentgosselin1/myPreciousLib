library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity AudioROM is
    port (
        clk   : in  std_logic;
        addr  : in  std_logic_vector(7 downto 0);
        data  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of AudioROM is
    type ROM_TYPE is array (0 to 255) of std_logic_vector(7 downto 0);
    constant ROM : ROM_TYPE := (
        -- Fill this array with your audio sample data
        x"00", x"01", x"02", -- Example data
        -- Continue filling the ROM with audio samples
        others => x"00"
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= ROM(to_integer(unsigned(addr)));
        end if;
    end process;
end architecture;
