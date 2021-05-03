library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity draw_rect is
	port(
		winner : in STD_LOGIC_VECTOR(4 downto 0);
		
		--Couleurs in
		Rin : in STD_LOGIC_VECTOR(7 downto 0);
		Bin : in STD_LOGIC_VECTOR(7 downto 0);
		Gin : in STD_LOGIC_VECTOR(7 downto 0);
		
		H : in STD_LOGIC_VECTOR(12 downto 0);
		V : in STD_LOGIC_VECTOR(12 downto 0);
		xcross : in unsigned(12 downto 0);
		ycross : in unsigned(12 downto 0);
		clock : in STD_LOGIC;
		
		--Couleurs out
		Rout : out STD_LOGIC_VECTOR(7 downto 0);
		Bout : out STD_LOGIC_VECTOR(7 downto 0);
		Gout : out STD_LOGIC_VECTOR(7 downto 0)
		
		
	);
end draw_rect;

architecture bhv of draw_rect is 

-- On determine les dimensions du rectangle correspondant au winner
signal long : unsigned(12 downto 0) := to_unsigned(800,13);
signal lar : unsigned(12 downto 0) := to_unsigned(480,13);
signal x_corner, y_corner : unsigned(12 downto 0);

begin
process(clock)
begin
if(clock'event and clock = '1') then
	case winner is
		when "00001" => 
			long <= to_unsigned(800,13);
			lar <= to_unsigned(480,13);
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
	-- On trace le rectangle
--	if((unsigned(H) = x_corner or unsigned(H) = x_corner + long) and unsigned(V) > y_corner and unsigned(V) < y_corner + lar) then -- Colonnes
--		if((unsigned(V) = y_corner or unsigned(V) = y_corner + lar) and unsigned(H) > x_corner and unsigned(H) < x_corner + long) then -- Lignes
--			Gout <= std_logic_vector(to_unsigned(255, Gout'length));
--			Rout <= ( others => '0');
--			Bout <= ( others => '0');
--		else 
--			Gout <= Gin;
--			Bout <= Bin;
--			Rout <= Rin;
--		end if;
--	else 
--		Gout <= Gin;
--		Bout <= Bin;
--		Rout <= Rin;
--	end if;
end if;
end process;
-- Position du coin supérieur gauche du rectangle
x_corner <= xcross - long/2;
y_corner <= ycross - lar/2;

Gout <= Gin;
Rout <= Rin;
Bout <= Bin;

end bhv;