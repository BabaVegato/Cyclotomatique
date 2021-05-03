library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Clock_Divider is
	Port(
		clk, reset : in STD_LOGIC;
		clock_out : out STD_LOGIC
	);
end Clock_Divider;

architecture bhv of Clock_Divider is

signal count : integer := 1;
signal tmp : std_logic := '0';

begin

process(clk, reset)
begin

	if(reset='1') then
		count <= 1;
		tmp <= '0';
	elsif(clk'event and clk='1') then
		count <= count+1;
	if(count = 25000000) then
		tmp <= NOT tmp;
		count <= 1;
	end if;
	end if;
	clock_out <= tmp;
end process;

end bhv;