
library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

entity clock_enable is
    generic(
        g_MAX : natural := 10  -- clk pulses to generate one enable pulse

    ); 

    port(
        clk   : in  std_logic; -- Main clock
        rst : in  std_logic; -- Synchronous reset
        ce_o  : out std_logic  -- Clock enable pulse signal
    );
end entity clock_enable;

architecture Behavioral of clock_enable is

    signal s_cnt_local : natural;

begin
    --------------------------------------------------------
    -- Generate clock enable signal. By default, enable signal
    -- is low and generated pulse is always one clock long.
    --------------------------------------------------------
    p_clk_ena : process(clk)
    begin
        if rising_edge(clk) then  

            if (rst = '1') then
                s_cnt_local <= 0;
                ce_o        <= '0';

            -- Test number of clock periods
            elsif (s_cnt_local >= (g_MAX - 1)) then
                s_cnt_local <= 0;   -- Clear local counter
                ce_o        <= '1'; -- Generate clock enable pulse
            else
                s_cnt_local <= s_cnt_local + 1;
                ce_o        <= '0';
            end if;
        end if;
    end process p_clk_ena;

end architecture Behavioral;
