
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_time is
    generic(
        g_CNT_WIDTH : natural := 4 -- Number of bits
    );
    port(
        clk      : in  std_logic;  -- clock
        rst    : in  std_logic;  -- Synchronous reset
        dec_rst : in std_logic;  -- Synchronous reset from decoder
        en_i     : in  std_logic;  -- Enable input
        over_flow_o : out  std_logic;  -- High when counter is full
        cnt_o    : out std_logic_vector(g_CNT_WIDTH - 1 downto 0);  -- Output of the counter
        led : out  std_logic  -- Controls signal LED
    );
end entity counter_time;

architecture behavioral of counter_time is

    signal s_cnt_local : unsigned(g_CNT_WIDTH - 1 downto 0);
    signal s_led : std_logic;

begin

    p_counter_time : process(clk)
    begin
        if rising_edge(clk) then
        
            if (rst = '1') then   -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear counter
                over_flow_o <= '0';  -- reset overflow output
                s_led <= '0';  -- reset control LED
                
            elsif dec_rst = '1' then  -- Synchronous reset from decoder
                s_cnt_local <= (others => '0'); -- Clear all bits
                over_flow_o <= '0';  -- reset overflow output
                
            elsif (s_cnt_local < "1000") then  -- limits number counter counts to
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
            elsif (s_cnt_local >= "1000") then  -- limits number counter counts to
                over_flow_o <= '1';
            end if;
        end if;
    end process p_counter_time;

    -- Output must be retyped from "unsigned" to "std_logic_vector"
    cnt_o <= std_logic_vector(s_cnt_local);
    led <= s_led;

end architecture behavioral;
