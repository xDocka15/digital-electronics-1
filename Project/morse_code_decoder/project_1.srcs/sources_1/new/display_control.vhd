
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_control is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data0_i : in STD_LOGIC_VECTOR (6 downto 0);
           data1_i : in STD_LOGIC_VECTOR (6 downto 0);
           data2_i : in STD_LOGIC_VECTOR (6 downto 0);
           data3_i : in STD_LOGIC_VECTOR (6 downto 0);
           dc_4bit_o : out STD_LOGIC_VECTOR (3 downto 0);
           dc_7bit_o : out STD_LOGIC_VECTOR (6 downto 0)
           
           );
end display_control;

architecture Behavioral of display_control is
--signal temp_o : STD_LOGIC_VECTOR (4 downto 0);
signal s_dc_en : STD_LOGIC;
signal s_dc_cnt : STD_LOGIC_VECTOR (1 downto 0);
signal s_dc_cnt_rst : STD_LOGIC;
begin

  clk_en1 : entity work.clock_enable
      generic map(
          g_MAX => 30000 -- 400 000
      )
      port map(
            clk   => clk,
            rst => rst,
            ce_o  => s_dc_en
      );
   
   bin_cnt1 : entity work.counter_time
     generic map(
            g_CNT_WIDTH  => 2
      )
      port map(
            clk      => clk,
            rst      => rst,
            dec_rst  => s_dc_cnt_rst,
            btnc_i => '0',
            en_i     => s_dc_en,
            over_flow_o => s_dc_cnt_rst,
            cnt_o    => s_dc_cnt,
            led => open
      );
      
      display_control : process(clk)
      begin
      if rising_edge(clk) then
        if rst = '1' then
           dc_4bit_o <= "0000";
           dc_7bit_o <= "1111111";
        else
            case s_dc_cnt is
                 when "11" =>
                     dc_7bit_o <= data3_i;
                     dc_4bit_o <= "0111";
                 when "10" =>
                     dc_7bit_o <= data2_i;
                     dc_4bit_o <= "1011";
                 when "01" =>
                     dc_7bit_o <= data1_i;
                     dc_4bit_o <= "1101";
                 when others =>
                     dc_7bit_o <= data0_i;
                     dc_4bit_o <= "1110";
                end case;
        end if;
      end if;
      
      end process display_control;

end Behavioral;

-- ff_display_control : process(clk)
--    begin
--        if rising_edge(clk) then
--           if rst = '1' then
--                temp_o <= "0111";
--            elsif pulse = '1' then
--                temp_o ror 1;
--            
--            end if;
--            
--        end if;
--    
--    end process ff_display_control;
--dc_o <= temp_o;