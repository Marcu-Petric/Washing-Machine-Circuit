-- Decides that to load on the timer, depending on mode
-- Petric Marcu
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_timer IS
  PORT (
    mode : in std_logic_vector (5 downto 0);
    manual_min: in std_logic_vector (5 downto 0);
    manual_ore: in std_logic_vector (5 downto 0);
    out_min: out std_logic_vector (5 downto 0);
    out_ore: out std_logic_vector (5 downto 0)
    );
END mux_timer;



ARCHITECTURE A OF mux_timer IS

signal min, ore: std_logic_vector (5 downto 0);
BEGIN

with mode select ore <= 
 manual_ore when "100000",
 "000000" when others; 
 
with mode select min <= 
 manual_min when "100000",
 "101001" when "010000",

 "101010" when "001000",
 "110011" when "000100",
 "110011" when "000010",
 "110101" when "000001",
 "000000" when others;

out_min <= min;
out_ore <= ore;
 
END A;
