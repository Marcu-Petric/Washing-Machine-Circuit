--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_temp_load IS
  PORT (
    temp : in std_logic_vector(1 downto 0);
    a: out std_logic_vector(7 downto 0)
    );
END mux_temp_load;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF mux_temp_load IS

signal aux : std_logic_vector(7 downto 0);
BEGIN

 with temp select aux <=
 "00011110" when "00",
 "00110010" when "01",
 "01011010" when "10",
 "10010110" when others; 

a <= aux;
END TypeArchitecture;
