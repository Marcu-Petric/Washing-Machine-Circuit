-- Timer for hours remaining
-- It's different from the one for minutes because this one remains 0 when it finishes while the otherone starts again from 59
-- George Rus
LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ore IS
  PORT (
  clk, en, ld:  in std_logic;
  a: in std_logic_vector(5 downto 0);
  h : out std_logic_vector (5 downto 0)
    );
END ore;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF ore IS
signal o : std_logic_vector ( 5 downto 0);
BEGIN

 process (clk)
 begin
 if ( ld = '1' ) then
    o <= a;
  elsif(rising_edge(clk)) then
   if ( en = '1' ) then
    if (o = "000000") then
    o <= "000000";
    else
    o <= o - '1';
    end if;
   end if;
  end if;
 end process;
  h <= o;
END TypeArchitecture;
