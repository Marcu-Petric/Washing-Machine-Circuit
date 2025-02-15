
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_ctemp IS
  PORT (
  temp : in std_logic_vector (1 downto 0);
  o : out std_logic_vector(4 downto 0)
    );
END mux_ctemp;


ARCHITECTURE TypeArchitecture OF mux_ctemp IS

signal s1: std_logic_vector(4 downto 0);
BEGIN

 with temp select s1 <=
 "00101" when "00",
 "01010" when "01",
 "01111" when "10",
 "10100" when "11",
 "00000" when others;

 
 o <= s1;

END TypeArchitecture;
