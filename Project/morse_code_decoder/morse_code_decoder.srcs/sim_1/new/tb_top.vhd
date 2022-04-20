------------------------------------------------------------
--
-- Testbench for clock enable circuit.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_top is
    -- Entity of testbench is always empty
end entity tb_top; 

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_top is
    --Local signals
    constant c_CNT_WIDTH         : natural := 4;
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_data       : std_logic;

begin
    uut_top : entity work.top
        port map(
           BTNC         => s_data,
           CLK100MHZ    => s_clk_100MHz,
           rst          => s_reset
        );
    
    p_clk_gen : process
    begin
        while now < 10 ms loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_data <= '0';
        s_reset <= '0';
        wait for 100 us;
        s_reset <= '1';
        wait for 100 us;
        s_reset <= '0';
        wait for 1 ms;
        s_data <= '1';
        wait for 3 ms;
        s_data <= '0';
        wait for 3 ms;
        s_data <= '1';
        wait for 1.5 ms;
        s_data <= '0';
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
