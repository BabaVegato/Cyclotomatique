library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Led_Vector is 
port(
	vector: out STD_LOGIC_VECTOR(9 downto 0)
	
);
end Led_Vector;

architecture bhv of Led_Vector is 

begin

vector <= "0101010101";

end bhv;