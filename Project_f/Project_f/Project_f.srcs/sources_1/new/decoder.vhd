------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port(
        clk         : in std_logic;  -- clocl
        rst         : in std_logic;  -- Synchronous reset
        btnc_i      : in  std_logic;  -- Enable input
        over_flow_i : in  std_logic;  -- overflow isnal from counter
        cnt_i       : in  std_logic_vector(4 - 1 downto 0);  -- number from counter
        ed_fall_i   : in  std_logic;  -- signal from input edge detector
        ed_rise_i   : in  std_logic;  

        char_o	    : out std_logic_vector(3 - 1 downto 0);  -- counts number of dots or dashes
        dcd_o	    : out std_logic;  -- outputs 0 for dot and 1 for dash
        cnt_rst_o       : out  std_logic;  -- resets counter
        shift_o     : out std_logic  -- shifts memory of dots and dashes
    );
end entity decoder;

architecture behavioral of decoder is

signal s_cnt_local : unsigned(3 - 1 downto 0);
signal s_shift_local : std_logic;
signal s_rst_o : std_logic;
begin  
  
    decoder : process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1' or (over_flow_i = '1' and btnc_i = '0'))  then -- reset and prevents reset if input is held high for too long
                s_cnt_local <= "000";
                s_rst_o <= '0';
                dcd_o <= '0';
                shift_o <= '0';

            elsif ed_fall_i = '1' then -- input changed high to low
                if (cnt_i <= "0010") then -- counter outpus is smaller than 3
                    dcd_o <= '0'; -- decoder outputs 0 for dot
                    s_cnt_local <= s_cnt_local + 1; -- increments number of characters
                 elsif ("0010" < cnt_i and cnt_i < "0110") then -- counter is between 3 and 5
                    dcd_o <= '1'; -- decoder outputs 1 for dash
                    s_cnt_local <= s_cnt_local + 1;
                 end if;
            end if;
            if cnt_i < "1000" then -- counter is under 8
                shift_o <= ed_fall_i; -- outputs falling edge pulse input to output (slowing it by 1 clock pulse)
            end if;
            cnt_rst_o <= ed_fall_i or ed_rise_i; -- resets counter of rising and falling edge of button
            char_o <= std_logic_vector(s_cnt_local); -- writes number of characters to output
        end if;
    end process decoder;

    
end architecture behavioral;