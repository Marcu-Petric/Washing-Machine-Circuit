-- Timer for minutes remaining
-- George Rus

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY minute IS
  PORT (
  clk, en, ld:  in std_logic;
  a: in std_logic_vector(5 downto 0);
  m : out std_logic_vector (5 downto 0);
  t: out std_logic
    );
END minute;

ARCHITECTURE TypeArchitecture OF minute IS
signal min : std_logic_vector ( 5 downto 0);
BEGIN

 process (clk)
 begin
 if ( ld = '1' ) then
    min <= a;
  elsif(rising_edge(clk)) then
   if ( en = '1' ) then
    if (min = "000000") then
    min <= "111011";
    else
    min <= min - '1';
    end if;
   end if;
  end if;
 end process;
  t <= min(5) and min(4) and min(3) and (not min(2)) and min(1) and min(0);
  m <= min;
END TypeArchitecture;
