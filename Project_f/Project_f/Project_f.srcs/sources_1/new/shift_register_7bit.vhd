
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_7bit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_i : in std_logic_vector(7 - 1 downto 0);
           shift : in std_logic;
           data_0_o : out std_logic_vector(7 - 1 downto 0);
           data_1_o : out std_logic_vector(7 - 1 downto 0);
           data_2_o : out std_logic_vector(7 - 1 downto 0);
           data_3_o : out std_logic_vector(7 - 1 downto 0);
           data_4_o : out std_logic_vector(7 - 1 downto 0);
           data_5_o : out std_logic_vector(7 - 1 downto 0);
           data_6_o : out std_logic_vector(7 - 1 downto 0);
           data_7_o : out std_logic_vector(7 - 1 downto 0)
           );
           
end shift_register_7bit;

architecture Behavioral of shift_register_7bit is

  -- Internal signals between flip-flops
  signal s_q_0 : std_logic_vector(7 - 1 downto 0);
  signal s_q_1 : std_logic_vector(7 - 1 downto 0);
  signal s_q_2 : std_logic_vector(7 - 1 downto 0);
  signal s_q_3 : std_logic_vector(7 - 1 downto 0);
  signal s_q_4 : std_logic_vector(7 - 1 downto 0);
  signal s_q_5 : std_logic_vector(7 - 1 downto 0);
  signal s_q_6 : std_logic_vector(7 - 1 downto 0);
  signal s_q_7 : std_logic_vector(7 - 1 downto 0);

begin

  d_ff_0 : entity work.d_ff_rst_7bit -- individual 7bit D flip-flops
      port map(
          clk       => clk, -- clock
          rst       => rst, -- reset
          shift   => shift, -- shifts register
          d         => data_i, -- input
          q         => s_q_0, -- output
          q_bar     => open -- negation of output
      );

  d_ff_1 : entity work.d_ff_rst_7bit
      port map(
          clk       => clk,
          rst       => rst,
          d         => s_q_0,
          shift   => shift, 
          q         => s_q_1,
          q_bar     => open
      );
   
    d_ff_2 : entity work.d_ff_rst_7bit
      port map(
          clk       => clk,
          rst       => rst,
          shift   => shift, 
          d         => s_q_1,
          q         => s_q_2,
          q_bar     => open
      );
       
      d_ff_3 : entity work.d_ff_rst_7bit
      port map(
          clk       => clk,
          rst       => rst,
          shift   => shift, 
          d         => s_q_2,
          q         => s_q_3,
          q_bar     => open
      );

      d_ff_4 : entity work.d_ff_rst_7bit
      port map(
          clk       => clk,
          rst       => rst,
          shift   => shift, 
          d         => s_q_3,
          q         => s_q_4,
          q_bar     => open
      );
    d_ff_5 : entity work.d_ff_rst_7bit
      port map(
          clk       => clk,
          rst       => rst,
          shift   => shift, 
          d         => s_q_4,
          q         => s_q_5,
          q_bar     => open
      );
       
      d_ff_6 : entity work.d_ff_rst_7bit
      port map(
          clk       => clk,
          rst       => rst,
          shift   => shift, 
          d         => s_q_5,
          q         => s_q_6,
          q_bar     => open
      );

      d_ff_7 : entity work.d_ff_rst_7bit
      port map(
          clk       => clk,
          rst       => rst,
          shift   => shift, 
          d         => s_q_6,
          q         => s_q_7,
          q_bar     => open
      );  -- paralel output
      data_0_o <= s_q_0;
      data_1_o <= s_q_1;
      data_2_o <= s_q_2;
      data_3_o <= s_q_3;
      data_4_o <= s_q_4;
      data_5_o <= s_q_5;
      data_6_o <= s_q_6;
      data_7_o <= s_q_7;

end architecture Behavioral;