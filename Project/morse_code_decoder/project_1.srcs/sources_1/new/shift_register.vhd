
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ovfl_rst : in STD_LOGIC;
           data : in STD_LOGIC;
           shift : in std_logic;
           btnc_i : in std_logic;
           q : out std_logic_vector(5 - 1 downto 0));
           
           
end shift_register;

architecture Behavioral of shift_register is

  -- Internal signals between flip-flops
  signal s_q_0 : std_logic;
  signal s_q_1 : std_logic;
  signal s_q_2 : std_logic;
  signal s_q_3 : std_logic;
  signal s_q_4 : std_logic;

begin

  --------------------------------------------------------------------
  -- Four instances (copies) of D-type FF entity
  d_ff_0 : entity work.d_ff_rst
      port map(
          clk   => clk,
          rst   => rst,
          btnc_i => btnc_i,
          ovfl_rst => ovfl_rst,
          ed_fall => shift, 
          d     => data,
          q     => s_q_0,
          q_bar => open
          
      );

  d_ff_1 : entity work.d_ff_rst
      port map(
          clk   => clk,
          rst   => rst,
          btnc_i => btnc_i,
          ovfl_rst => ovfl_rst,
          d     => s_q_0,
          ed_fall => shift, 
          q     => s_q_1,
          q_bar => open
      );
   
    d_ff_2 : entity work.d_ff_rst
      port map(
          clk   => clk,
          rst   => rst,
          btnc_i => btnc_i,
          ovfl_rst => ovfl_rst,
          ed_fall => shift, 
          d     => s_q_1,
          q     => s_q_2,
          q_bar => open
      );
       
      d_ff_3 : entity work.d_ff_rst
      port map(
          clk   => clk,
          rst   => rst,
          btnc_i => btnc_i,
          ovfl_rst => ovfl_rst,
          ed_fall => shift, 
          d     => s_q_2,
          q     => s_q_3,
          q_bar => open
      );

      d_ff_4 : entity work.d_ff_rst
      port map(
          clk   => clk,
          rst   => rst,
          btnc_i => btnc_i,
          ovfl_rst => ovfl_rst,
          ed_fall => shift, 
          d     => s_q_3,
          q     => s_q_4,
          q_bar => open
      );
      q(0) <= s_q_0;
      q(1) <= s_q_1;
      q(2) <= s_q_2;
      q(3) <= s_q_3;
      q(4) <= s_q_4;

end architecture Behavioral;