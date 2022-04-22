------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for n-bit counter
------------------------------------------------------------
entity decoder is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
--        btnc_i      : in  std_logic;  -- Enable input
        over_flow_i : in  std_logic;
        cnt_i       : in  std_logic_vector(4 - 1 downto 0);
        ed_fall_i   : in  std_logic;
        ed_rise_i   : in  std_logic;
        char_o	    : out std_logic_vector(3 - 1 downto 0);
        dcd_o	    : out std_logic;
        cnt_rst_o       : out  std_logic;
        shift_o     : out std_logic
    );
end entity decoder;

architecture behavioral of decoder is

signal s_cnt_local : unsigned(3 - 1 downto 0);
signal s_shift_local : std_logic;
signal s_rst_o : std_logic;
begin  

--uut_ce : entity work.edge_detector
--
--    port map(
--         clk   => clk,
--         btnc => btnc_i,
--        ris_o  => open,
--         fall_o  => s_shift_local,
--         rst => rst
--     );
  
    decoder : process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                s_cnt_local <= "000";
                s_rst_o <= '0';
                dcd_o <= '0';
                shift_o <= '0';

            elsif ed_fall_i = '1' then
                if (cnt_i <= "0010") then
                    dcd_o <= '0';
                    s_cnt_local <= s_cnt_local + 1;
                 elsif ("0010" < cnt_i and cnt_i < "0101") then
                    dcd_o <= '1';
                    s_cnt_local <= s_cnt_local + 1;
                 elsif (cnt_i > "1100") then
                 end if;
            end if;
            shift_o <= ed_fall_i;
            cnt_rst_o <= ed_fall_i or ed_rise_i;
            char_o <= std_logic_vector(s_cnt_local);
            end if;
    end process decoder;

    
end architecture behavioral;