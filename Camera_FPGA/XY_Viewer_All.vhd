library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity XY_Viewer_All is
port(
	x,y : in unsigned(12 downto 0);
	btn, clk : in STD_LOGIC;
	digit0, digit1, digit2, digit3, digit4, digit5 : out STD_LOGIC_VECTOR(7 downto 0)
);
end XY_Viewer_All;

architecture bhv of XY_Viewer_All is

signal XYsel_int : unsigned(12 downto 0);
signal nb_sel_int : STD_LOGIC;

signal digit0_r,digit1_r,digit2_r,digit3_r,digit4_r,digit5_r : STD_LOGIC_VECTOR(3 downto 0);

begin

sel : entity work.XY_Selector
	port map(
		x => x,
		y => y,
		btn => btn,
		selected => XYsel_int,
		nb_sel => nb_sel_int,
		clk => clk
	);

vw : entity work.XY_Viewer
	port map(
		nb_sel => nb_sel_int,
		number_in => XYsel_int,
		digit0 => digit0_r,
		digit1 => digit1_r,
		digit2 => digit2_r,
		digit3 => digit3_r,
		digit4 => digit4_r,
		digit5 => digit5_r
	);

nbd0 : entity work.Number_Display
	port map(
		clock => clk,
		number_in => unsigned(digit0_r),
		number_out => digit0
	);
nbd1 : entity work.Number_Display
	port map(
		clock => clk,
		number_in => unsigned(digit1_r),
		number_out => digit1
	);
nbd2 : entity work.Number_Display
	port map(
		clock => clk,
		number_in => unsigned(digit2_r),
		number_out => digit2
	);
nbd3 : entity work.Number_Display
	port map(
		clock => clk,
		number_in => unsigned(digit3_r),
		number_out => digit3
	);
nbd4 : entity work.Number_Display
	port map(
		clock => clk,
		number_in => unsigned(digit4_r),
		number_out => digit4
	);
nbd5 : entity work.Number_Display
	port map(
		clock => clk,
		number_in => unsigned(digit5_r),
		number_out => digit5
	);

end bhv;