library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Cervotron is

	Port(
		
		--Résultats de l'armée des calculon
		calculon1 : in unsigned(8 downto 0);
		calculon2 : in unsigned(8 downto 0);
		calculon3 : in unsigned(8 downto 0);
		calculon4 : in unsigned(8 downto 0);
		calculon5 : in unsigned(8 downto 0);
		
		--Utiles
		clock : in STD_LOGIC;
		
		--Sortie winner
		Winner : out unsigned(4 downto 0)
		
	);
end Cervotron;



architecture CervotronArchi of Cervotron is

signal nbpix : unsigned(25 downto 0);

begin

-- PROCESS DE MOYENNE
process (clock)	
	
	begin
	if clock'event and clock = '1' then
		-- si n et n' ont le même ratio, ça veut dire qu'ils sont tous les deux dans la tâche
		-- donc on prend le plus grand (ex : dans le cas '1 pareil que 2' on prend 1)
		
		--1 est pareil que 2
		if ( (to_integer(calculon1) + 1 > to_integer(calculon2))) then  
			
			Winner<="00001"; -- calculon1
			
		--2 est pareil que 3
		elsif ( (to_integer(calculon2) + 1 > to_integer(calculon3))) then
		
			Winner<="00010"; -- calculon2
		
		--3 est pareil que 4
		elsif ( (to_integer(calculon3) + 1 > to_integer(calculon4))) then
		
			Winner<="00011"; --calculon3
			
		--4 est pareil que 5
		elsif ( (to_integer(calculon4) + 1 > to_integer(calculon5))) then
		
			Winner<="00100"; --calculon4
		--Ils sont tous différents 
		else
			Winner<="00101"; --calculon5
		end if;
	end if;

end process;
	
end CervotronArchi;

