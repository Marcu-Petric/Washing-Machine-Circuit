
LIBRARY ieee;
USE ieee.std_logic_1164.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY temp_timer IS
  PORT (
  clk, en, ld:  in std_logic;
  a: in std_logic_vector(7 downto 0);
  h: out std_logic_vector(7 downto 0);
  te : out std_logic
    );
END temp_timer;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF temp_timer IS
signal o : std_logic_vector ( 7 downto 0);
BEGIN
 process (clk, ld)
 begin
 if ( ld = '1' ) then
    o <= a;
 elsif(rising_edge(clk)) then
   if ( en = '1' ) then
    o <= o - '1';
    end if;
   end if;
 end process;
  h <= o;
  te <= not (o(0) or o(1) or o(2) or o(3) or o(4) or o(5) or o(6) or o(7));
END TypeArchitecture;
