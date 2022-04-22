

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------
entity hex_7seg is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        hex_i       : in  std_logic_vector(5 - 1 downto 0);
        char_i      : in std_logic_vector(3 - 1 downto 0);
        over_flow_i : in std_logic;
        seg_o       : out std_logic_vector(7 - 1 downto 0)
    );
end entity hex_7seg;

------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------
architecture Behavioral of hex_7seg is
begin
    --------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common
    -- Anode) decoder. Any time "hex_i" is changed, the process
    -- is "executed". Output pin seg_o(6) controls segment A,
    -- seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        +-+|  |   ...   segment G
    --          ||+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------
    p_7seg_decoder : process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                seg_o <= "0000000";
            elsif (rst = '0') and over_flow_i = '1' then
                case hex_i is
                    when "00000" =>
                        seg_o <= "0000001";-- 0
                    when "00001" =>
                        seg_o <= "1001111";-- 1
                     when "00010" =>
                        seg_o <= "0010010";-- 2
                    when "00011" =>
                        seg_o <= "0000110";-- 3
                    when "00100" =>
                        seg_o <= "1001100";-- 4
                    when "00101" =>
                        seg_o <= "0100100";-- 5
                    when "00110" =>
                        seg_o <= "0100000";-- 6
                    when "00111" =>
                        seg_o <= "0001111";-- 7
                    when "01000" =>
                        seg_o <= "0000000";-- 8
                    when "01001" =>
                        seg_o <= "0000100";-- 9
                    when "01010" =>
                        seg_o <= "0001000";-- A
                    when "01011" =>
                        seg_o <= "1100000";-- b
                    when "01100" =>
                        seg_o <= "0110001";-- C
                    when "01101" =>
                        seg_o <= "1000010";-- d
                    when "01110" =>
                        seg_o <= "0110000";-- E
                    when others =>
                        seg_o <= "0111000";-- F
                end case;
            end if;
        end if;
    end process p_7seg_decoder;

end architecture Behavioral;
