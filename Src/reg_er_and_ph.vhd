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

ENTITY reg_er_and_ph IS
  PORT (
  clk, en: in std_logic;
  ld : in std_logic_vector(1 downto 0);
  a: out std_logic_vector(1 downto 0)
  );
END reg_er_and_ph;


ARCHITECTURE TypeArchitecture OF reg_er_and_ph IS

signal aux : std_logic_vector (1 downto 0);
BEGIN
 
process(clk)
 begin 
 if ( rising_edge(clk) ) then
  if (en = '1') then
  aux <= ld;
  else
  aux <= aux;
  end if;
 end if;
 end process;
 a <= aux;
END TypeArchitecture;
