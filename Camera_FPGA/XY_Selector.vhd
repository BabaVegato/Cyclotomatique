library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity XY_Selector is
port(
	x,y : in unsigned(12 downto 0);
	btn, clk : in STD_LOGIC;
	nb_sel : out STD_LOGIC;
	selected : out unsigned(12 downto 0)
);
end XY_Selector;

architecture bhv of XY_Selector is

signal toggle : STD_LOGIC := '0';
signal pushed : STD_LOGIC := '0';

begin

process(clk)
begin
	if(clk'event and clk = '1') then 
		if(btn = '0' and pushed = '0') then
			toggle <= NOT toggle;
			pushed <= '1';
		elsif (btn = '1' and pushed = '1') then
			pushed <= '0';
		else 
			pushed <= pushed;
		end if;

		if(toggle = '0') then
			selected <= x;
		else 
			selected <= y;
		end if;
	end if;
end process;

nb_sel <= toggle;

end bhv;