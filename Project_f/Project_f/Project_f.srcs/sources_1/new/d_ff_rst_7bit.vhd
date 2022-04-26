
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_rst_7bit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           shift : in std_logic; -- signal from edge detector
           d : in std_logic_vector(7 - 1 downto 0); -- input
           q : out std_logic_vector(7 - 1 downto 0); -- output
           q_bar : out std_logic_vector(7 - 1 downto 0)); -- negative output
end d_ff_rst_7bit;

architecture Behavioral of d_ff_rst_7bit is

begin

    p_d_ff_rst_7bit : process(clk)
    begin
    if rising_edge(clk) then
        if(rst = '1') then -- reset
            q     <= "1111111"; -- 7seg is off
            q_bar <= "0000000";
        elsif shift = '1' then -- writes input do output
            q     <= d; 
            q_bar <= not d;
        end if;
     end if;
    end process p_d_ff_rst_7bit;
end architecture Behavioral;
