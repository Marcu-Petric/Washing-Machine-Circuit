

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TIMER10 IS
  PORT (
    clk, reset, en: in std_logic;
    t10: out std_logic
    );
END TIMER10;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF TIMER10 IS

begin
process(clk)
variable  counter_10: std_logic_vector(3 downto 0) := "0000";
variable  td : std_logic := '0';
begin
if(rising_edge(clk)) then
    if(reset='1') then
         counter_10 := "0000";
    elsif (en = '1') then
      if (counter_10 = "1010") then
      counter_10 := "0000";
      td := '1';
      else
      td := '0';
      counter_10 := counter_10 + '1';       
     end if;
    end if;   
end if;
T10 <= td;
end process;

END TypeArchitecture;
