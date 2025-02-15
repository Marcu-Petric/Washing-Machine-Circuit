
--------------------------------------------------------------------------------
-- Description : devides 100mHz (50% duty cycle) into 1hz(50% duty cycle) aka 1 second
-- Petric Marcu
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY ONEsec IS
  PORT (
  clk : in std_logic;
  newclk : out std_logic
    );
END ONEsec;


ARCHITECTURE TypeArchitecture OF ONEsec IS

BEGIN

process (clk)
variable count: std_logic_vector(25 downto 0) := (others => '0');
variable D : std_logic := '0';
begin
if (rising_edge(clk)) then
 if (count = "10111110101111000010000000") then 
  count := (others => '0');
  D := not D;
  else
  count := count + '1'; 
 end if;
end if;
newclk <= D;
end process;
END TypeArchitecture;
