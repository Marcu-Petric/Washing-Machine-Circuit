LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_UNSIGNED.all;

ENTITY frequencyDEVIDER IS
  PORT (
    CLK, reset : in  std_logic;
    newClock, newclock2   : out std_logic
    );
END frequencyDEVIDER;


ARCHITECTURE devide OF frequencyDEVIDER IS
 
 BEGIN
process (CLK)
   variable counter: std_logic_vector (14 downto 0) := (others => '0');
   variable counter2: std_logic_vector (23 downto 0) := (others => '0');
  begin
   if (CLK = '1') and (CLK'EVENT) then
    if (reset ='1') then
    counter := (others => '0');
    counter2 := (others => '0');
    else
    counter := counter + 1;
    counter2 := counter2 + 1;
    end if;
   end if;
   newClock <= counter (14);
   newClock2 <= counter2 (23);
  end process;
END devide;