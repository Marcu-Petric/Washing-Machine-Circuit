-- Timer for minutes remaining
-- George Rus

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY heat_count IS
  PORT (
  clk, en, ld:  in std_logic;
  a: in std_logic_vector(4 downto 0);
  m : out std_logic_vector (4 downto 0);
  t: out std_logic
    );
END heat_count;

ARCHITECTURE TypeArchitecture OF heat_count IS
signal min : std_logic_vector ( 4 downto 0);
BEGIN

 process (clk)
 begin
 if ( ld = '1' ) then
    min <= a;
  elsif(rising_edge(clk)) then
   if ( en = '1' ) then
    if (min = "00000") then
    min <= "11111";
    else
    min <= min - '1';
    end if;
   end if;
  end if;
 end process;
  t <= not min(4) and not min(3) and (not min(2)) and not min(1) and not min(0);
  m <= min;
END TypeArchitecture;
