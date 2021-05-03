library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Led_Blink is
port(
	clk : in STD_LOGIC;
	led : out STD_LOGIC
);
end Led_Blink;

architecture bhv of Led_Blink is 

signal led_ef : STD_LOGIC := '0';

begin

process(clk)
begin
	if(clk'event and clk = '1') then
		led_ef <= NOT led_ef;
	end if;
	
	led <= led_ef;
end process;

end bhv;