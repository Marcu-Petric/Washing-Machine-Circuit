

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY state_counter IS
  PORT (
           clk: in std_logic; -- clock input
           reset: in std_logic; -- reset input 
           up, down: in std_logic; -- up or down
           counter: out std_logic_vector(1 downto 0) -- output 4-bit counter
    );
END state_counter;


ARCHITECTURE TypeArchitecture OF state_counter IS

signal counter_updown: std_logic_vector(1 downto 0);
BEGIN

process(clk)
variable aux : std_logic_vector (1 downto 0);
begin
if(rising_edge(clk)) then
    if(reset='1') then
         counter_updown <= "00";
    else
    aux := up&down;
    case aux is 
    when "10" => counter_updown <= counter_updown + '1';
    when "01" => counter_updown <= counter_updown - '1';
    when others => counter_updown <= counter_updown;
    end case;
    end if;   
end if;
end process;
 counter <= counter_updown;

END TypeArchitecture;
