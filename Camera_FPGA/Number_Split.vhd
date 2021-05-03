library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Number_Split is
port(
	number_in : in unsigned(5 downto 0);
	dizaine, unite : out unsigned(3 downto 0)
);
end Number_Split;

architecture bhv of Number_Split is

signal unite_ef : unsigned(5 downto 0) := to_unsigned(0,6);
signal dizaine_ef : unsigned(5 downto 0) := to_unsigned(0,6);


begin

unite_ef <= number_in MOD 10;
unite <= unite_ef(3 downto 0);
dizaine_ef <= number_in / 10;
dizaine <= dizaine_ef(3 downto 0);

end bhv;
	