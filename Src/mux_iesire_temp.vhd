
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_iesire_temp IS
  PORT (
  temp : in std_logic_vector (1 downto 0);
  segment1, segment2 : out std_logic_vector(6 downto 0)
    );
END mux_iesire_temp;


ARCHITECTURE TypeArchitecture OF mux_iesire_temp IS

signal s1, s2: std_logic_vector(6 downto 0);
BEGIN

 with temp select s1 <=
 "1111001" when "00",
 "0110011" when "01",
 "1011111" when "10",
 "1111011" when "11",
 "0000000" when others;
 s2<="1111110";
 
 segment1 <= s1;
 segment2 <= s2;

END TypeArchitecture;
