
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( BTNC : in STD_LOGIC; -- data input
           CLK100MHZ : in STD_LOGIC;
           BTNU : in STD_LOGIC; -- reset
           clk_led : out std_logic;
           disp_o  : out std_logic_vector(7 - 1 downto 0);
           dc_o : out std_logic_vector(4 - 1 downto 0)
           );
end top;

architecture Behavioral of top is

    signal s_btnc : std_logic;
    signal s_rst : std_logic;
    
    signal s_clk_en  : std_logic;
    signal s_cnt_o : std_logic_vector(4 - 1 downto 0);
    signal s_cnt_ovfl_o : std_logic;
    
    signal s_dcd_shift_o : std_logic;
    signal s_dcd_char_o : std_logic_vector(3 - 1 downto 0);
    signal s_dcd_o : std_logic;
    signal s_dcd_rst_o : std_logic;
    
    signal s_ed_btnc_f : std_logic;
    signal s_ed_btnc_r : std_logic;
    signal s_ed_ovfl_f : std_logic;
    signal s_ed_ovfl_r : std_logic;
    
    signal s_reg5x1bit_o : std_logic_vector(5 - 1 downto 0);
    signal s_bin_7seg_shift_o : std_logic;
    
    signal bin_7seg_o : std_logic_vector(7 - 1 downto 0);
    signal s_reg7bit_0_o : std_logic_vector(7 - 1 downto 0);
    signal s_reg7bit_1_o : std_logic_vector(7 - 1 downto 0);
    signal s_reg7bit_2_o : std_logic_vector(7 - 1 downto 0);
    signal s_reg7bit_3_o : std_logic_vector(7 - 1 downto 0);
    signal s_reg7bit_4_o : std_logic_vector(7 - 1 downto 0);
begin
  clk_en0 : entity work.clock_enable
      generic map(
          g_MAX => 30000 -- 100 000 000irl 30 000 sim
      )
      port map(
            clk  => CLK100MHZ,
            rst  => s_rst,
            ce_o => s_clk_en
      );
   
   counter_time : entity work.counter_time
     generic map(
            g_CNT_WIDTH  => 4
      )
      port map(
            clk          => CLK100MHZ,
            rst          => s_rst,
            btnc_i       => s_btnc,
            dec_rst      => s_dcd_rst_o,
            en_i         => s_clk_en,
            over_flow_o  => s_cnt_ovfl_o,
            cnt_o        => s_cnt_o,
            led          => clk_led
      );
   
   decoder : entity work.decoder
      port map(
            clk          => CLK100MHZ,
            rst          => s_rst,
            btnc_i       => s_btnc,
            over_flow_i  => s_ed_ovfl_r,
            ed_fall_i    => s_ed_btnc_f,
            ed_rise_i    => s_ed_btnc_r,
            cnt_i        => s_cnt_o,
            char_o	     => s_dcd_char_o,
            dcd_o	     => s_dcd_o,
            cnt_rst_o    => s_dcd_rst_o,
            shift_o      => s_dcd_shift_o
            
      );
      
   ed_btnc : entity work.edge_detector

        port map(
             clk     => CLK100MHZ,
             rst     => s_rst,
             ed_i    => s_btnc,
             ris_o   => s_ed_btnc_r,
             fall_o  => s_ed_btnc_f
         );
     
   ed_ovfl : entity work.edge_detector

        port map(
             clk     => CLK100MHZ,
             rst     => s_rst,
             ed_i    => s_cnt_ovfl_o,
             ris_o   => s_ed_ovfl_r,
             fall_o  => s_ed_ovfl_f
         );
     
   shift_reg_5x1bit : entity work.shift_register
      port map(
            clk      => CLK100MHZ,
            rst      => s_rst,
            ovfl_rst => s_ed_ovfl_r,
            data     => s_dcd_o,
            shift    => s_dcd_shift_o,
            q        => s_reg5x1bit_o,
            btnc_i => s_btnc
     );
   
   shift_reg_5x7bit : entity work.shift_register_7bit
      port map(
            clk      => CLK100MHZ,
            rst      => s_rst,
            data_i     => bin_7seg_o,
            shift    => s_bin_7seg_shift_o,
            data_0_o => s_reg7bit_0_o,
            data_1_o => s_reg7bit_1_o,
            data_2_o => s_reg7bit_2_o,
            data_3_o => s_reg7bit_3_o,
            data_4_o => s_reg7bit_4_o
      );
   
   bin_7seg : entity work.bin_7seg
      port map(
          clk          => CLK100MHZ,
          rst          => s_rst,
          btnc_i       => s_btnc,
          bin_i        => s_reg5x1bit_o,
          over_flow_i  => s_ed_ovfl_r,
          char_i       => s_dcd_char_o,
          seg_o        => bin_7seg_o,
          over_flow_o  => s_bin_7seg_shift_o
      );
      
    display_control0 : entity work.display_control
      port map(
          clk       => CLK100MHZ,
          rst       => s_rst,
          data0_i   => s_reg7bit_0_o,
          data1_i   => s_reg7bit_1_o,
          data2_i   => s_reg7bit_2_o,
          data3_i   => s_reg7bit_3_o,
          dc_4bit_o => dc_o,
          dc_7bit_o => disp_O
      );
      
-- synchronization of inputs
  input_reg : process(CLK100MHZ)
    begin
    if rising_edge(CLK100MHZ) then
        s_btnc <= btnc;
        s_rst  <= BTNU;
    end if;
    end process input_reg;

end Behavioral;
