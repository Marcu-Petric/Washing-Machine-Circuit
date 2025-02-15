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

ENTITY bcd IS
  PORT (
  number: in std_logic_vector(3 downto 0);
  segment: out std_logic_vector(6 downto 0)
    );
END bcd;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF bcd IS

signal aux:std_logic_vector (6 downto 0);
BEGIN

with number select
 aux <=
 "1111110" when x"0",
 "0110000" when x"1",
 "1101101" when x"2",
 "1111001" when x"3",
 "0110011" when x"4",
 "1011011" when x"5",
 "1011111" when x"6",
 "1110000" when x"7",
 "1111111" when x"8",
 "1111011" when x"9",
 "0000000" when others;
segment <= aux;

END TypeArchitecture;
