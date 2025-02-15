

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TIMER3 IS
  PORT (
    clk, reset, en: in std_logic;
    t3: out std_logic
    );
END TIMER3;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF TIMER3 IS

begin
process(clk)
variable  counter_3: std_logic_vector(1 downto 0) := "00";
variable  td : std_logic := '0';
begin 
if(rising_edge(clk)) then
    if(reset='1') then
         counter_3 := "00";
    elsif (en = '1') then
      if (counter_3 = "11") then
      counter_3 := "00";
      td := '1';
      else
      td := '0';
      counter_3 := counter_3 + '1';       
     end if;
    end if;   
end if;
t3 <= td;
end process;

END TypeArchitecture;
