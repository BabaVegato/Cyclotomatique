library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Number_Display is
port(
	clock : in STD_LOGIC;
	number_in : in unsigned(3 downto 0);
	number_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end Number_Display;

architecture bhv of Number_Display is

begin

process(clock)
begin
	case number_in is
	when "0000" => number_out <= X"40";
	when "0001" => number_out <= X"79";
	when "0010" => number_out <= X"24";
	when "0011" => number_out <= X"30";
	when "0100" => number_out <= X"19";
	when "0101" => number_out <= X"12";
	when "0110" => number_out <= X"02";
	when "0111" => number_out <= X"78";
	when "1000" => number_out <= X"00";
	when "1001" => number_out <= X"10";
	when others => number_out <= X"41";
	end case;
end process;

end bhv;