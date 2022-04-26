
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_control is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btnc : in std_logic;
           data0_i : in STD_LOGIC_VECTOR (6 downto 0);
           data1_i : in STD_LOGIC_VECTOR (6 downto 0);
           data2_i : in STD_LOGIC_VECTOR (6 downto 0);
           data3_i : in STD_LOGIC_VECTOR (6 downto 0);
           data4_i : in STD_LOGIC_VECTOR (6 downto 0);
           data5_i : in STD_LOGIC_VECTOR (6 downto 0);
           data6_i : in STD_LOGIC_VECTOR (6 downto 0);
           data7_i : in STD_LOGIC_VECTOR (6 downto 0);
           dc_4bit_o : out STD_LOGIC_VECTOR (7 downto 0);
           dc_7bit_o : out STD_LOGIC_VECTOR (6 downto 0)
           
           );
end display_control;

architecture Behavioral of display_control is

signal s_dc_en : STD_LOGIC;
signal s_dc_cnt : STD_LOGIC_VECTOR (2 downto 0);
signal s_dc_cnt_rst : STD_LOGIC;
begin

  clk_en1 : entity work.clock_enable -- serapate clock enable for switching between displays
      generic map(
          g_MAX => 30000
      )
      port map(
            clk   => clk,
            rst => rst,
            ce_o  => s_dc_en
      );
   
   bin_cnt1 : entity work.counter_time -- separate counter for switching between displays
     generic map(
            g_CNT_WIDTH  => 3
      )
      port map(
            clk      => clk,
            rst      => rst,
            dec_rst  => s_dc_cnt_rst,
            en_i     => s_dc_en,
            over_flow_o => s_dc_cnt_rst,
            cnt_o    => s_dc_cnt,
            led => open
      );
      
      display_control : process(clk)
      begin
      if rising_edge(clk) then
        if rst = '1' then
           dc_4bit_o <= "00000000"; -- to all displays
           dc_7bit_o <= "1111111"; -- display off
        else
            case s_dc_cnt is
                 when "111" => -- counter is 8
                     dc_7bit_o <= data7_i; -- write 8th output to display
                     dc_4bit_o <= "01111111"; -- select 8th display
                 when "110" =>
                     dc_7bit_o <= data6_i;
                     dc_4bit_o <= "10111111";
                 when "101" =>
                     dc_7bit_o <= data5_i;
                     dc_4bit_o <= "11011111";
                 when "100" =>
                     dc_7bit_o <= data4_i;
                     dc_4bit_o <= "11101111";
                 when "011" =>
                     dc_7bit_o <= data3_i;
                     dc_4bit_o <= "11110111";
                 when "010" =>
                     dc_7bit_o <= data2_i;
                     dc_4bit_o <= "11111011";
                 when "001" =>
                     dc_7bit_o <= data1_i;
                     dc_4bit_o <= "11111101";
                 when others =>
                     dc_7bit_o <= data0_i;
                     dc_4bit_o <= "11111110";
                end case;
        end if;
      end if;
      
      end process display_control;

end Behavioral;
