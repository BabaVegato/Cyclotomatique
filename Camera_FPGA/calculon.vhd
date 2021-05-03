library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculon is
	Generic(
		long : unsigned(12 downto 0);
		lar : unsigned(12 downto 0)
	);
	Port(
		clk : in STD_LOGIC;
		--Position de la croix
		x : in unsigned(12 downto 0);
		y : in unsigned(12 downto 0);
		--Detection de pixels
		H : in STD_LOGIC_VECTOR(12 downto 0); -- xPix
		V : in STD_LOGIC_VECTOR(12 downto 0); -- yPix
		blank : in STD_LOGIC; -- blank = '1' si on reçoit des pixels
		filtre : in STD_LOGIC;
		--Detection de fin de frames
		vsync : in STD_LOGIC;
		--Proportion de pixels rouges
		score : out unsigned(8 downto 0)
	);
end calculon;

architecture bhv of calculon is

signal nb_pix_rouge : unsigned(29 downto 0) := to_unsigned(0,30); -- Nombre de pixels rouges
signal nb_pix : unsigned(29 downto 0) := to_unsigned(1,30); -- Nombre total de pixels
signal score_int : unsigned(59 downto 0);
signal prev_H : STD_LOGIC_VECTOR(12 downto 0) := (others => '0');
signal nop : STD_LOGIC := '0';
signal in_range : STD_LOGIC;

begin

process(clk)
begin
	if(clk'event and clk = '1') then
		if(prev_H /= H) then -- Pour la detection de pixels
			if vsync = '0' then -- Si on est en fin de frame, on réinitialise les valeurs
				nb_pix_rouge <= to_unsigned(0,30);
				nb_pix <= to_unsigned(1,30);
			else 
				if(blank = '1') then -- On reçoit un pixel
					if(nop = '0') then -- Si le rectangle ne depasse pas de l'écran
						if(in_range = '1') then -- Si le pixel est dans le rectangle
							nb_pix <= nb_pix + 1;
							if(filtre = '0') then -- Le pixel est rouge
								nb_pix_rouge <= nb_pix_rouge + 1;
							end if;
						end if;
					else 
						nb_pix_rouge <= to_unsigned(0,30);
					end if;
				end if;
			end if;
			prev_H <= H; -- On update H
		end if;
	end if;
end process;

-- Detection de l'impossibilité du rectangle (nop = '1' => le score est = 0)
nop <= '1' when ((x<long/2) or (y<lar/2)) else '0';

-- Si le pixel est dans le rectangle
in_range <= '1' when ((unsigned(H)>(x-long/2)) and (unsigned(H)<(x+long/2)) and (unsigned(V)>(y-lar/2)) and (unsigned(V)<(y+lar/2))) else '0';

-- Calcul du score
score_int <= ((100*nb_pix_rouge) / nb_pix);
score <= score_int(8 downto 0);

end bhv;