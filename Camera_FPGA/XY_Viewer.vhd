library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity XY_Viewer is
port(
	nb_sel : in STD_LOGIC;
	number_in : in unsigned(12 downto 0);
	digit0, digit1, digit2, digit3, digit4, digit5 : out STD_LOGIC_VECTOR(3 downto 0)
);
end XY_Viewer;

architecture bhv of XY_Viewer is

signal digit0_ef : unsigned(12 downto 0) := to_unsigned(0,13);
signal digit1_ef : unsigned(12 downto 0) := to_unsigned(0,13);
signal digit2_ef : unsigned(12 downto 0) := to_unsigned(0,13);
signal digit3_ef : unsigned(12 downto 0) := to_unsigned(0,13);
signal digit4_ef : unsigned(12 downto 0) := to_unsigned(0,13);
signal digit5_ef : unsigned(12 downto 0) := to_unsigned(0,13);

begin

digit0_ef <= number_in MOD 10;
digit0 <= STD_LOGIC_VECTOR(digit0_ef(3 downto 0));
digit1_ef <= (number_in MOD 100)/10;
digit1 <= STD_LOGIC_VECTOR(digit1_ef(3 downto 0));
digit2_ef <= (number_in MOD 1000)/100;
digit2 <= STD_LOGIC_VECTOR(digit2_ef(3 downto 0));
digit3_ef <= (number_in MOD 10000)/1000;
digit3 <= STD_LOGIC_VECTOR(digit3_ef(3 downto 0));

digit4 <= "0000";

process(nb_sel)

begin

	if nb_sel = '0' then ---- X selectionné
		digit5 <= "0000";
	else ----- y sélectionné
		digit5 <= "0001";
	end if;
	
end process;


end bhv;