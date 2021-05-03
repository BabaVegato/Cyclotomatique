library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity button_controller is
port(
	btn: in STD_LOGIC;
	rst: out STD_LOGIC
);
end button_controller;

architecture bhv of button_controller is

begin

BUTTON_PROC : process(btn)

begin

	if(btn = '0') then
		rst <= '1';
	else 
		rst <= '0';
	end if;

end process;

end bhv;