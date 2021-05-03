library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Compteur is 
port(
	clk, reset: in std_logic;
	secondes, minutes, heures : out unsigned(5 downto 0)
);
end Compteur;

architecture bhv of Compteur is

signal count_s: unsigned(5 downto 0) := to_unsigned(0,6);
signal count_m: unsigned(5 downto 0) := to_unsigned(0,6);
signal count_h: unsigned(5 downto 0) := to_unsigned(0,6);

begin

process(clk, reset)
begin
	if(reset = '1') then
		count_s <= to_unsigned(0,6);
		count_m <= to_unsigned(0,6);
		count_h <= to_unsigned(0,6);
	elsif(clk'event and clk='1') then
		count_s <= count_s + 1;
		if(count_s = 59) then
			count_s <= to_unsigned(0,6);
			count_m <= count_m + 1;
		end if;
		if(count_m = 59) then
			count_m <= to_unsigned(0,6);
			count_h <= count_h + 1;
		end if;
		if(count_h = 24) then
			count_h <= to_unsigned(0,6);
		end if;
	end if;
	secondes <= count_s;
	minutes <= count_m;
	heures <= count_h;
end process;

end bhv;