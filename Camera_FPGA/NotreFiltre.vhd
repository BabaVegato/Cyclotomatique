library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NotreFiltre is

	Port(
	
		--Pris de Focus_ADJ
		R : in STD_LOGIC_VECTOR(7 downto 0);
		G : in STD_LOGIC_VECTOR(7 downto 0);
		B : in STD_LOGIC_VECTOR(7 downto 0);
		
		--Pris du VGA_Controller
		H : in STD_LOGIC_VECTOR(12 downto 0);
		V : in STD_LOGIC_VECTOR(12 downto 0);
		
		blank : in STD_LOGIC;
		
		clock : in STD_LOGIC;
		
		--Sortie couleurs
		LCDR : out STD_LOGIC_VECTOR(7 downto 0);
		
		--Sortie filtre
		filtre : out STD_LOGIC
	);
end NotreFiltre;



architecture NotreArchi of NotreFiltre is
signal prev_H : STD_LOGIC_VECTOR(12 downto 0);
begin

process (clock)
	begin
	if clock'event and clock = '1' then
		if prev_H /= H then
			if blank = '1' then	-- Dim : 800x480
				-- Supprime si rouge trop bas et si c'est trop blanc (Noir : filtré = '1')
				if to_integer(unsigned(R)) < 60  or ( to_integer(unsigned(G)) > 80 or to_integer(unsigned(B)) > 80 )then
					LCDR <= ( others => '0');
					filtre <= '1';
				else
					LCDR <= std_logic_vector(to_unsigned(255, LCDR'length));
					filtre <= '0';
				end if;
--				if to_integer(unsigned(H)) < 410 and to_integer(unsigned(H)) > 390 and to_integer(unsigned(V)) < 240 and to_integer(unsigned(V)) > 220 then
--					LCDR <= std_logic_vector(to_unsigned(255, LCDR'length));
--					filtre <= '0';
--				else 
--					LCDR <= ( others => '0');
--					filtre <= '1';
--				end if;
			end if;
			prev_H <= H;
		else 
			prev_H <= prev_H;
		end if;
	end if;
		
end process;

	
end NotreArchi;


