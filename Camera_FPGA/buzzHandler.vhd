library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity buzzHandler is

	Port(
	
		--Pris de CrossPainter
		X : in unsigned(12 downto 0);
		
		clock: in STD_LOGIC;
		
		-- Sorties
		F1 : out STD_LOGIC;
		F2 : out STD_LOGIC;
		F3 : out STD_LOGIC;
		gnd : out STD_LOGIC
		
	);
end buzzHandler;



architecture buzzArchi of buzzHandler is

begin

	process(clock)
	
	begin
	if clock'event and clock = '1' then	
		-- RIEN
		if (to_integer(X) <= 460  and  to_integer(X) > 370) then
			F1 <= '0';
			F2 <= '0';
			F3 <= '0';
			
		-- DROITE LENT
		elsif (to_integer(X) <= 500  and  to_integer(X) > 460) then
			F1 <= '0';
			F2 <= '0';
			F3 <= '1';
		
		-- DROITE MOYEN
		elsif to_integer(X) <= 650  and ( to_integer(X) > 500) then
			F1 <= '0';
			F2 <= '1';
			F3 <= '0';
			
		-- DROITE RAPIDE
		elsif to_integer(X) <= 800  and ( to_integer(X) > 650) then
			F1 <= '0';
			F2 <= '1';
			F3 <= '1';
			
		-- GAUCHE LENT
		elsif to_integer(X) <= 370  and ( to_integer(X) > 300) then
			F1 <= '1';
			F2 <= '0';
			F3 <= '0';
			
		-- GAUCHE MOYEN
		elsif to_integer(X) <= 300  and ( to_integer(X) > 150) then
			F1 <= '1';
			F2 <= '0';
			F3 <= '1';
			
		-- GAUCHE RAPIDE
		elsif to_integer(X) <= 150  and ( to_integer(X) > 0) then
			F1 <= '1';
			F2 <= '1';
			F3 <= '0';
		
		-- ARRET
		else
			F1 <= '1';
			F2 <= '1';
			F3 <= '1';
			
		end if;
	end if;
	
	gnd <= '0';

	end process;

	
end buzzArchi;