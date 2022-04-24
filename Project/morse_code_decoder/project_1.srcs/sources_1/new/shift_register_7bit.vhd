
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register_7bit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_i : in std_logic_vector(7 - 1 downto 0);
           shift : in std_logic;
           data_0_o : out std_logic_vector(7 - 1 downto 0);
           data_1_o : out std_logic_vector(7 - 1 downto 0);
           data_2_o : out std_logic_vector(7 - 1 downto 0);
           data_3_o : out std_logic_vector(7 - 1 downto 0);
           data_4_o : out std_logic_vector(7 - 1 downto 0));
           
end shift_register_7bit;

architecture Behavioral of shift_register_7bit is

  -- Internal signals between flip-flops
  signal s_q_0 : std_logic_vector(7 - 1 downto 0);
  signal s_q_1 : std_logic_vector(7 - 1 downto 0);
  signal s_q_2 : std_logic_vector(7 - 1 downto 0);
  signal s_q_3 : std_logic_vector(7 - 1 downto 0);
  signal s_q_4 : std_logic_vector(7 - 1 downto 0);

begin

  --------------------------------------------------------------------
  -- Four instances (copies) of D-type FF entity
  d_ff_0 : entity work.d_ff_rst_7bit
      port map(
          clk   => clk,
          rst   => rst,
          ed_fall => shift, 
          d     => data_i,
          q     => s_q_0,
          q_bar => open
      );

  d_ff_1 : entity work.d_ff_rst_7bit
      port map(
          clk   => clk,
          rst   => rst,
          d     => s_q_0,
          ed_fall => shift, 
          q     => s_q_1,
          q_bar => open
      );
   
    d_ff_2 : entity work.d_ff_rst_7bit
      port map(
          clk   => clk,
          rst   => rst,
          ed_fall => shift, 
          d     => s_q_1,
          q     => s_q_2,
          q_bar => open
      );
       
      d_ff_3 : entity work.d_ff_rst_7bit
      port map(
          clk   => clk,
          rst   => rst,
          ed_fall => shift, 
          d     => s_q_2,
          q     => s_q_3,
          q_bar => open
      );

      d_ff_4 : entity work.d_ff_rst_7bit
      port map(
          clk   => clk,
          rst   => rst,
          ed_fall => shift, 
          d     => s_q_3,
          q     => s_q_4,
          q_bar => open
      );
      data_0_o <= s_q_0;
      data_1_o <= s_q_1;
      data_2_o <= s_q_2;
      data_3_o <= s_q_3;
      data_4_o <= s_q_4;

end architecture Behavioral;