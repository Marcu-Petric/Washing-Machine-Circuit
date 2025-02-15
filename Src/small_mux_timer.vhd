
LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY small_mux_timer IS
  PORT (
  temp: in std_logic_vector(1 downto 0);
  ER: in std_logic;
  PH: in std_logic;
  hours: out std_logic_vector (5 downto 0);
  m: out std_logic_vector (5 downto 0)
    );
END small_mux_timer;


ARCHITECTURE TypeArchitecture OF small_mux_timer IS
signal temp_add :  std_logic_vector(5 downto 0);
BEGIN
process (temp, er, ph)

variable aux_hours, aux_minutes : std_logic_vector (5 downto 0);

begin 
  aux_minutes := "101000";
  
 case temp is
  when "11" => temp_add <= "000011";
  when "10" => temp_add <= "000010";
  when "01" => temp_add <= "000001";
  when "00" => temp_add <= "000001";
  when others => aux_minutes := aux_minutes + "000000";
 end case;
 if (er = '1' ) and (ph = '1') then
   aux_hours := "000001";
   aux_minutes := aux_minutes - "101000";
  elsif (er = '1') or (ph = '1') then
   aux_minutes := aux_minutes + "001010";
   aux_hours := "000000";
  else
   aux_hours := "000000";
  end if;
 hours <= aux_hours;
 m <= aux_minutes;
 end process;

END TypeArchitecture;
