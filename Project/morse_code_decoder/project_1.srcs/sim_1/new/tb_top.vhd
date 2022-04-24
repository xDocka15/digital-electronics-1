

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
    signal s_rst     : std_logic;
    signal s_data       : std_logic;

begin
    uut_top : entity work.top
        port map(
           BTNC         => s_data,
           CLK100MHZ    => s_clk_100MHz,
           BTNU          => s_rst
        );
    
    p_clk_gen : process
    begin
        while now < 15 ms loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
        p_s : process
    begin
        report "Stimulus process started" severity note;

        report "Stimulus process finished" severity note;
        wait;
    end process p_s;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_data <= '0';
        s_rst <= '0';
        wait for 100 us;
        s_rst <= '1';
        wait for 100 us;
        s_rst <= '0';
        wait for 0.2 ms;
        s_data <= '1'; wait for 1 ms; s_data <= '0';
        wait for 1 ms;
        s_data <= '1'; wait for 0.3 ms; s_data <= '0';
        wait for 2 ms;
        s_data <= '1'; wait for 0.3 ms; s_data <= '0';
        wait for 3 ms;
        s_data <= '1'; wait for 0.3 ms; s_data <= '0';
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
