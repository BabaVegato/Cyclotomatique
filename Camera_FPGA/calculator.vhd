library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator is
	Port(
		clk : in STD_LOGIC;
		xCross : in unsigned(12 downto 0);
		yCross : in unsigned(12 downto 0);
		H : in STD_LOGIC_VECTOR(12 downto 0);
		V : in STD_LOGIC_VECTOR(12 downto 0);
		blank : in STD_LOGIC;
		filtre : in STD_LOGIC;
		vsync : in STD_LOGIC;
		winner : out unsigned(4 downto 0)
	);
end calculator;

architecture bhv of calculator is

signal score1, score2, score3, score4, score5 : unsigned(8 downto 0) := to_unsigned(0, 9);

begin

cal1 : entity work.calculon
	generic map(
		long => to_unsigned(800,13),
		lar => to_unsigned(480,13)
	)
	port map(
		clk => clk,
		x => xCross,
		y => yCross,
		H => H,
		V => V,
		blank => blank,
		filtre => filtre,
		vsync => vsync,
		score => score1
	);

cal2 : entity work.calculon
	generic map(
		long => to_unsigned(625,13),
		lar => to_unsigned(375,13)
	)
	port map(
		clk => clk,
		x => xCross,
		y => yCross,
		H => H,
		V => V,
		blank => blank,
		filtre => filtre,
		vsync => vsync,
		score => score2
	);

cal3 : entity work.calculon
	generic map(
		long => to_unsigned(450,13),
		lar => to_unsigned(270,13)
	)
	port map(
		clk => clk,
		x => xCross,
		y => yCross,
		H => H,
		V => V,
		blank => blank,
		filtre => filtre,
		vsync => vsync,
		score => score3
	);

cal4 : entity work.calculon
	generic map(
		long => to_unsigned(275,13),
		lar => to_unsigned(165,13)
	)
	port map(
		clk => clk,
		x => xCross,
		y => yCross,
		H => H,
		V => V,
		blank => blank,
		filtre => filtre,
		vsync => vsync,
		score => score4
	);

cal5 : entity work.calculon
	generic map(
		long => to_unsigned(100,13),
		lar => to_unsigned(60,13)
	)
	port map(
		clk => clk,
		x => xCross,
		y => yCross,
		H => H,
		V => V,
		blank => blank,
		filtre => filtre,
		vsync => vsync,
		score => score5
	);
cer : entity work.cervotron
	port map(
		calculon1 => score1,
		calculon2 => score2,
		calculon3 => score3,
		calculon4 => score4,
		calculon5 => score5,
		clock => clk,
		Winner => winner
	);

end bhv;