library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity AudioDriver is
    port (
        clk   : in  std_logic;
        ena   : in  std_logic;
        audio_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of AudioDriver is
    signal addr : std_logic_vector(7 downto 0) := (others => '0');
    signal rom_data : std_logic_vector(7 downto 0);
begin
    -- Instantiate the ROM
    U1: entity work.AudioROM
        port map (
            clk  => clk,
            addr => addr,
            data => rom_data
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if ena = '1' then
                addr <= addr + 1;
                audio_out <= rom_data;
            end if;
        end if;
    end process;
end architecture;
