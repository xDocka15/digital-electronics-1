------------------------------------------------------------
--
-- Testbench for N-bit Up/Down binary counter.
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
entity tb_decoder is
    -- Entity of testbench is always empty
end entity tb_decoder; 

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_decoder is
    constant c_CNT_WIDTH         : natural := 4;
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
    --Local signals
    signal s_clk_100MHz        : std_logic;
    signal s_rst         :  std_logic;
    signal s_btnc_i      :  std_logic;  -- Enable input
    signal s_over_flow_i :  std_logic;
    signal s_cnt_i       :  std_logic_vector(4 - 1 downto 0);
    signal s_shift_o     :  std_logic;
    signal s_char_o	   :  std_logic_vector(3 - 1 downto 0);
    signal s_dcd_o	   :  std_logic;
    signal s_rst_o       :  std_logic;

begin
    -- Connecting testbench signals with cnt_up_down entity
    -- (Unit Under Test)
    uut_dec : entity work.decoder
        port map(
        clk         =>  s_clk_100MHz,
        rst         =>  s_rst,
        btnc_i      =>  s_btnc_i,
        over_flow_i =>  s_over_flow_i,
        cnt_i       =>  s_cnt_i,
        shift_o     =>  s_shift_o,
        char_o	    =>  s_char_o,
        dcd_o	    =>  s_dcd_o,
        rst_o       =>  s_rst_o
        ); 


    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    p_reset_gen : process
    begin
        s_rst <= '0'; wait for 12 ns;
        -- Reset activated
        s_rst <= '1'; wait for 73 ns;
        -- Reset deactivated
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_btnc_i <= '0';
        s_over_flow_i <= '0';
        
        s_cnt_i <= "0011";
        wait for 10 ns;
        s_btnc_i <= '1';
        wait for 90 ns;
        s_btnc_i <= '0';


        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
