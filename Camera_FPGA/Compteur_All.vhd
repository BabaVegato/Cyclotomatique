library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Compteur_All is 
port(
	clk, reset : in STD_LOGIC;
	digit0, digit1, digit2, digit3, digit4, digit5 : out STD_LOGIC_VECTOR(7 downto 0)
);
end Compteur_All;

architecture bhv of Compteur_All is

signal s_int, m_int, h_int : unsigned(5 downto 0);
signal ds_int, us_int, dm_int, um_int, dh_int, uh_int : unsigned(3 downto 0);

begin
	cpt: entity work.Compteur
		port map(
			clk => clk,
			reset => reset,
			secondes => s_int,
			minutes => m_int,
			heures => h_int
		);
	nbs_s: entity work.Number_Split
		port map(
			number_in => s_int,
			dizaine => ds_int,
			unite => us_int
		);
	nbs_m: entity work.Number_Split
		port map(
			number_in => m_int,
			dizaine => dm_int,
			unite => um_int
		);
	nbs_h: entity work.Number_Split
		port map(
			number_in => h_int,
			dizaine => dh_int,
			unite => uh_int
		);
	nbd_0: entity work.Number_Display
		port map(
			clock => clk,
			number_in => us_int,
			number_out => digit0
		);
	nbd_1: entity work.Number_Display
		port map(
			clock => clk,
			number_in => ds_int,
			number_out => digit1
		);
	nbd_2: entity work.Number_Display
		port map(
			clock => clk,
			number_in => um_int,
			number_out => digit2
		);
	nbd_3: entity work.Number_Display
		port map(
			clock => clk,
			number_in => dm_int,
			number_out => digit3
		);
	nbd_4: entity work.Number_Display
		port map(
			clock => clk,
			number_in => uh_int,
			number_out => digit4
		);
	nbd_5: entity work.Number_Display
		port map(
			clock => clk,
			number_in => dh_int,
			number_out => digit5
		);
end bhv;