library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Vector_Giver is
port(
	vector: out STD_LOGIC_VECTOR(9 downto 0)
);
end Vector_Giver;

architecture bhv of Vector_Giver is

begin

vector <= "0101010101";

end bhv;