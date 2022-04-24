----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2022 07:43:29 PM
-- Design Name: 
-- Module Name: edge_detector - Behavioral
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

entity edge_detector is
    Port ( clk : in STD_LOGIC;
           ed_i : in STD_LOGIC;
           rst : in std_logic;
           ris_o : out STD_LOGIC;
           fall_o : out STD_LOGIC);
end edge_detector;

architecture Behavioral of edge_detector is

signal s2 : std_logic;

begin


edge_detector : process(clk)
begin
if rising_edge(clk) then
    s2 <= ed_i;
    if rst = '1' then
        ris_o <= '0';
        fall_o <= '0';
        s2 <= '0';
    elsif ed_i = '1' and s2 = '0' then
        ris_o <= '1';
    elsif ed_i = '0' and s2 = '1' then
        fall_o <= '1';
    else
        ris_o <= '0'; 
        fall_o <= '0'; 
    end if ;
end if;

end process edge_detector;

end Behavioral;
