
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
           pulse : in STD_LOGIC;
           dc_o : out STD_LOGIC_VECTOR (4 downto 0));
end display_control;

architecture Behavioral of display_control is
--signal temp_o : STD_LOGIC_VECTOR (4 downto 0);


begin



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