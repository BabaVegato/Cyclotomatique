library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CrossPainter is

	Port(
		winner : in STD_LOGIC_VECTOR(4 downto 0);
		
		--Pris de CrossAverager
		R : in STD_LOGIC_VECTOR(7 downto 0);
		
		X : in STD_LOGIC_VECTOR(12 downto 0);
		Y : in STD_LOGIC_VECTOR(12 downto 0);
		
		valide : in STD_LOGIC;
		
		--Pris du VGA_Controller
		H : in STD_LOGIC_VECTOR(12 downto 0);
		V : in STD_LOGIC_VECTOR(12 downto 0);
		
		clock, clk_1HZ : in STD_LOGIC;
		
		blank : in STD_LOGIC;
		
		--Sortie couleurs
		LCDR : out STD_LOGIC_VECTOR(7 downto 0);
		LCDG : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
		LCDB : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
		
		-- Sortie XCross et yCross
		xc : out unsigned(12 downto 0);
		yc : out unsigned(12 downto 0)
		
	);
end CrossPainter;



architecture CrossArchi of CrossPainter is

signal xCross : unsigned(12 downto 0);
signal yCross : unsigned(12 downto 0);
signal cpt : unsigned(3 downto 0) := to_unsigned(0,4); -- Affichage xCross yCross
signal long : unsigned(12 downto 0) := to_unsigned(800,13);
signal lar : unsigned(12 downto 0) := to_unsigned(480,13);
signal x_corner, y_corner : unsigned(12 downto 0);
signal winnerInterne : STD_LOGIC_VECTOR(4 downto 0) := "00001";

begin

	-- PROCESS DU DESSIN
	process(clock)
	
	begin
	if clock'event and clock = '1' then	
--		if(clk_1HZ'event and clk_1HZ = '1') then
--			cpt <= cpt + 1;
--		end if;

		case winnerInterne is
			when "00001" => 
				long <= to_unsigned(100,13);
				lar <= to_unsigned(60,13);
			when "00010" => 
				long <= to_unsigned(625,13);
				lar <= to_unsigned(375,13);
			when "00011" =>
				long <= to_unsigned(450,13);
				lar <= to_unsigned(270,13);
			when "00100" => 
				long <= to_unsigned(275,13);
				lar <= to_unsigned(165,13);
			when "00101" => 
				long <= to_unsigned(100,13);
				lar <= to_unsigned(60,13);
			when others =>
				long <= to_unsigned(800,13);
				lar <= to_unsigned(480,13);
		end case;
		
		if valide = '1' then
			xCross <= unsigned(X);
			yCross <= unsigned(Y);
			cpt <= to_unsigned(0,4);
			winnerInterne <= winner;
		
		else
			winnerInterne <= winnerInterne;
			xCross <= xCross;
			yCross <= yCross;
		end if;
		
		if blank = '1' then
			--Détermine si le pixel fait partie de la croix    V : Horizontal   H : Vertical
			if (  unsigned(H) = xCross  )    or    (  unsigned(V) = yCross  ) then
				LCDR <= ( others => '0');
				LCDG <= ( others => '0');
				LCDB <= std_logic_vector(to_unsigned(200, LCDB'length));
				
			elsif ((unsigned(V) = y_corner or unsigned(V) = y_corner + lar) and unsigned(H) > x_corner and unsigned(H) < x_corner + long) or 
					((unsigned(H) = x_corner or unsigned(H) = x_corner + long) and unsigned(V) > y_corner and unsigned(V) < y_corner + lar) then -- Lignes
				LCDG <= std_logic_vector(to_unsigned(255, LCDG'length));
				LCDR <= ( others => '0');
				LCDB <= ( others => '0');
			
			else
				LCDR <= R;
				LCDG <= (others => '0');
				LCDB <= (others => '0');
			end if;
		end if;
	end if;
	xc <= xcross;
	yc <= ycross;
	end process;
x_corner <= xcross - long/2;
y_corner <= ycross - lar/2;
	
end CrossArchi;

