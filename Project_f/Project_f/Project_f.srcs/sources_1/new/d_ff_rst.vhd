
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_rst is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btnc_i : in std_logic; -- input button
           ovfl_rst : in STD_LOGIC; -- signal from edge detector
           shift : in std_logic;  
           d : in STD_LOGIC;  -- input
           q : out STD_LOGIC; -- output
           q_bar : out STD_LOGIC);  -- negative output
end d_ff_rst;

architecture Behavioral of d_ff_rst is

begin

    p_d_ff_rst : process(clk)
    begin
    if rising_edge(clk) then
        if(rst = '1' or (ovfl_rst = '1' and btnc_i = '0')) then -- reset and prevents reset if input is held high for too long
            q     <= '0';
            q_bar <= '1';
        elsif shift = '1' then  -- writes input do output
            q     <= d; 
            q_bar <= not d;
        end if;
    end if;
    end process p_d_ff_rst;
end architecture Behavioral;
