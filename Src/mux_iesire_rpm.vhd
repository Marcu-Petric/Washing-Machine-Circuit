
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_iesire_rpm IS
  PORT (
  rpm : in std_logic_vector (1 downto 0);
  segment1, segment2 : out std_logic_vector(6 downto 0)
    );
END mux_iesire_rpm;


ARCHITECTURE TypeArchitecture OF mux_iesire_rpm IS

signal s1, s2: std_logic_vector(6 downto 0);
BEGIN

 with rpm select s1 <=
 "1111110" when "00",
 "0110000" when others;
 with rpm select s2 <= 
 "1111111" when "00",
 "1111110" when "01",
 "1101101" when others;
 
 segment1 <= s1;
 segment2 <= s2;

END TypeArchitecture;
