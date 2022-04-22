----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2022 19:31:49
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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
    Port ( BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           LED  : out std_logic_vector(5 - 1 downto 0)
           );
end top;

architecture Behavioral of top is

    signal s_btnc : std_logic;
    signal s_rst : std_logic;
    
    signal s_en  : std_logic;
    signal s_cnt : std_logic_vector(4 - 1 downto 0);
    signal s_over_flow : std_logic;
    signal s_shift : std_logic;
    signal s_char : std_logic_vector(3 - 1 downto 0);
    signal s_dcd : std_logic;
    signal s_cnt_rst : std_logic;
    signal s_ed_fall : std_logic;
    signal s_ed_rise : std_logic;
    signal s_q : std_logic_vector(5 - 1 downto 0);
    signal s_led : std_logic;
    
begin
  clk_en0 : entity work.clock_enable
      generic map(
          g_MAX => 50000 -- 100 000 000irl 50 000 sim
      )
      port map(
            clk   => CLK100MHZ,
            rst => s_rst,
            ce_o  => s_en
      );
   
   bin_cnt0 : entity work.cnt_up_down
     generic map(
            g_CNT_WIDTH  => 4
      )
      port map(
            clk      => CLK100MHZ,
            rst      => s_rst,
            dec_rst  => s_cnt_rst,
            en_i     => s_en,
            cnt_up_i => '1',
            over_flow_o => s_over_flow,
            cnt_o    => s_cnt,
            led => s_led
   );
   
   decod : entity work.decoder
      port map(
            clk          => CLK100MHZ,
            rst          => s_rst,
            over_flow_i  => s_over_flow,
            ed_fall_i    => s_ed_fall,
            ed_rise_i    => s_ed_rise,
            cnt_i        => s_cnt,
            char_o	     => s_char,
            dcd_o	     => s_dcd,
            cnt_rst_o    => s_cnt_rst,
            shift_o      => s_shift
            
      );
      
uut_ce : entity work.edge_detector

    port map(
         clk   => CLK100MHZ,
         rst => s_rst,
         btnc => s_btnc,
         ris_o  => s_ed_rise,
         fall_o  => s_ed_fall
     );
     
shift_register : entity work.shift_register
      port map(
            clk     => CLK100MHZ,
            rst     => s_rst,
            data    => s_dcd,
            shift   => s_shift,
            q       => s_q
   );
   
   hex_7seg : entity work.hex_7seg
      port map(
          clk           => CLK100MHZ,
          rst           => s_rst,
          hex_i         => s_q,
          over_flow_i   => s_over_flow,
          char_i        => s_char

      );
     
  input_reg : process(CLK100MHZ)
    begin
    if rising_edge(CLK100MHZ) then
        s_btnc <= btnc;
        s_rst  <= BTNU;
    end if;
    end process input_reg;

end Behavioral;
