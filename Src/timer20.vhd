

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TIMER20 IS
  PORT (
    clk, reset, en: in std_logic;
    t20: out std_logic
    );
END TIMER20;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF TIMER20 IS

begin
process(clk)
variable  counter_20: std_logic_vector(4 downto 0) := "00000";
variable  td : std_logic := '0';
begin
if(rising_edge(clk)) then
    if(reset='1') then
         counter_20 := "00000";
    elsif (en = '1') then
      if (counter_20 = "10100") then
      counter_20 := "00000";
      td := '1';
      else
      td := '0';
      counter_20 := counter_20 + '1';       
     end if;
    end if;   
end if;
T20 <= td;
end process;

END TypeArchitecture;
