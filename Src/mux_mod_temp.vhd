

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_mod_temp IS
  PORT (
  mode: in std_logic_vector(5 downto 0);
  temp_man: in std_logic_vector(1 downto 0);
  temp : out std_logic_vector (1 downto 0)
    );
END mux_mod_temp;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF mux_mod_temp IS

signal te : std_logic_vector (1 downto 0);
BEGIN

 with mode select te <=
 temp_man when "100000",
 "00" when "010000",
 "10" when "001000",
 "11" when "000001",
 "01" when others;
temp <= te;

END TypeArchitecture;
