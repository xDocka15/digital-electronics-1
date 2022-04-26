
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
    Port ( clk : in STD_LOGIC;
           ed_i : in STD_LOGIC;
           rst : in std_logic;
           ris_o : out STD_LOGIC;
           fall_o : out STD_LOGIC);
end edge_detector;

architecture Behavioral of edge_detector is

signal s_ed_local : std_logic;

begin


edge_detector : process(clk)
begin
if rising_edge(clk) then
    s_ed_local <= ed_i; -- writes input to local signal
    if rst = '1' then -- reset
        ris_o <= '0';
        fall_o <= '0';
        s_ed_local <= '0';
    elsif ed_i = '1' and s_ed_local = '0' then -- input is high and local is low => input changed from low to high
        ris_o <= '1';
    elsif ed_i = '0' and s_ed_local = '1' then -- input is low and local is high => input changed from high to low
        fall_o <= '1';
    else    -- no input
        ris_o <= '0'; 
        fall_o <= '0'; 
    end if ;
end if;

end process edge_detector;

end Behavioral;
