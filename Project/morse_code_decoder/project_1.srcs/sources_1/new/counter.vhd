
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for n-bit counter
------------------------------------------------------------
entity counter_time is
    generic(
        g_CNT_WIDTH : natural := 4 -- Number of bits for counter
    );
    port(
        clk      : in  std_logic;  -- Main clock
        rst    : in  std_logic;  -- Synchronous reset
        dec_rst : in std_logic;
        en_i     : in  std_logic;  -- Enable input
        btnc_i : in std_logic;
        over_flow_o : out  std_logic;
        cnt_o    : out std_logic_vector(g_CNT_WIDTH - 1 downto 0);
        led : out  std_logic
    );
end entity counter_time;

------------------------------------------------------------
-- Architecture body for n-bit counter
------------------------------------------------------------
architecture behavioral of counter_time is

    -- Local counter
    signal s_cnt_local : unsigned(g_CNT_WIDTH - 1 downto 0);
    signal s_led : std_logic;

begin
    --------------------------------------------------------
    -- p_counter_time:
    -- Clocked process with synchronous reset which implements
    -- n-bit up/down counter.
    --------------------------------------------------------
    p_counter_time : process(clk)
    begin
        if rising_edge(clk) then
        
            if (rst = '1') then   -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits
                over_flow_o <= '0';
                s_led <= '0';
            elsif dec_rst = '1' then
                s_cnt_local <= (others => '0'); -- Clear all bits
                over_flow_o <= '0';
            elsif (s_cnt_local < "1000") then
                if (en_i = '1') then -- Test if counter is enabled
                        s_cnt_local <= s_cnt_local + 1;
---------------------------------------------------- s_led driver
                        if (s_led = '1') then
                            s_led <= '0';
                        elsif (s_led = '0') then
                            s_led <= '1';
                        end if;
-----------------------------------------------------
                end if;
            elsif (s_cnt_local = "1000") then
                over_flow_o <= '1';
            end if;
        end if;
    end process p_counter_time;

    -- Output must be retyped from "unsigned" to "std_logic_vector"
    cnt_o <= std_logic_vector(s_cnt_local);
    led <= s_led;

end architecture behavioral;
