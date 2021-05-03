library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CrossAverager is

	Port(
	
		--Pris de NotreFiltre
		R : in STD_LOGIC_VECTOR(7 downto 0);
		
		filtre : in STD_LOGIC;
		
		--Pris du VGA_Controller
		H : in STD_LOGIC_VECTOR(12 downto 0);
		V : in STD_LOGIC_VECTOR(12 downto 0);
		
		clock : in STD_LOGIC;
		
		blank : in STD_LOGIC;
		
		vsync : in STD_LOGIC;
		
		--Sortie couleurs
		LCDR : out STD_LOGIC_VECTOR(7 downto 0);
		
		X : out STD_LOGIC_VECTOR(29 downto 0);
		Y : out STD_LOGIC_VECTOR(29 downto 0);
		
		--Sortie valide
		valide: out STD_LOGIC;
		
		--Sortie debug
		debug: out std_logic_vector(7 downto 0)
		
	);
end CrossAverager;



architecture CrossAArchi of CrossAverager is

signal nbpix : unsigned(25 downto 0);
signal nbPixRouges : unsigned(29 downto 0) := (others => '0');
signal prev_H : STD_LOGIC_VECTOR(12 downto 0) := (others => '0');
signal x_int : unsigned(29 downto 0) := (others => '0');
signal y_int : unsigned(29 downto 0) := (others => '0');

begin

LCDR<=R;
-- debug <= X"6D";
nbpix <= unsigned(((unsigned(V)*800) + unsigned(H)));

-- PROCESS DE MOYENNE
process (clock)	
	
	begin
	if clock'event and clock = '1' then
		if prev_H /= H then
			--vsync = 0 en fin de frame, et = 1 pendant la frame
			if vsync = '0' then
				x_int <= to_unsigned(0, 30);
				y_int <= to_unsigned(0, 30);
				nbPixRouges <= to_unsigned(1, 30);
			
			else 
				if blank = '1' then
				
					if filtre = '0' then -- le pixel est rouge
						nbPixRouges <= nbPixRouges + 1;
						x_int <= x_int + unsigned(H);
						y_int <= y_int + unsigned(V);
						
					end if;
				end if;
			end if;
			prev_H <= H;
		else 
			prev_H <= prev_H;
		end if;
	end if;
	X <= std_logic_vector(x_int/nbPixRouges);
	Y <= std_logic_vector(y_int/nbPixRouges);	
	
	if nbpix = ((800*480)-2) then
		valide <= '1';
	else 
		valide <= '0';
	end if;

end process;


----Process valide
--process(clock)
--
--	begin
--		-- En début de frame, la croix n'est plus valide
----		if vsync = '0' then
----			valide <= '0';
----		end if;
--
--		--En fin de frame, le calcul de la croix est valide
--		if nbpix = ((800*480)-2) then
--			valide <= '1';
--		else 
--			valide <= '0';
--		end if;
--		
--end process;
	
	
end CrossAArchi;

