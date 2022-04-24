
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity d_ff_rst_7bit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ed_fall : in std_logic;
           d : in std_logic_vector(7 - 1 downto 0);
           q : out std_logic_vector(7 - 1 downto 0);
           q_bar : out std_logic_vector(7 - 1 downto 0));
end d_ff_rst_7bit;

architecture Behavioral of d_ff_rst_7bit is

begin
    --------------------------------------------------------
    -- p_d_ff_rst:
    -- D type flip-flop with a high-active sync reset,
    -- rising-edge clk.
    -- q(n+1) = d
    --------------------------------------------------------
    p_d_ff_rst_7bit : process(clk)
    begin
    if rising_edge(clk) then
        if(rst = '1') then 
            q     <= "1111111";
            q_bar <= "0000000";
        elsif ed_fall = '1' then
            q     <= d;
            q_bar <= not d;
        end if;
     end if;
    end process p_d_ff_rst_7bit;
end architecture Behavioral;
