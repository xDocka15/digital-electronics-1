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
entity tb_shift_register is
    -- Entity of testbench is always empty
end entity tb_shift_register;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_shift_register is
    --Local signals
    signal s_shift_i  : std_logic;
    signal s_reset    : std_logic;
    signal s_data     : std_logic;
    signal s_q0       : std_logic;
    signal s_q1       : std_logic;
    signal s_q2       : std_logic;
    signal s_q3       : std_logic;
    signal s_q4       : std_logic;

begin
    uut_sf : entity work.shift_register
        port map(
           shift_i => s_shift_i,
           reset   => s_reset,
           data    => s_data,
           q_out_0 => s_q0,
           q_out_1 => s_q1,
           q_out_2 => s_q2,
           q_out_3 => s_q3,
           q_out_4 => s_q4
        );

    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_reset <= '0';
        wait for 50 ns;
        s_reset <= '1';
        wait for 50 ns;
        s_reset <= '0';
        
        s_shift_i <= '0';
        
        s_data <= '1';
        wait for 10 ns;
        s_shift_i <= '1';
        wait for 10 ns;
        s_data <= '0';
        wait for 20 ns;
        s_shift_i <= '0';
        wait for 20 ns;
        s_shift_i <= '1';
        
        s_reset <= '1';
        wait for 50 ns;
        s_reset <= '0';
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
