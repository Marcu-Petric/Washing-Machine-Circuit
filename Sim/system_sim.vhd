----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2023 09:23:32 PM
-- Design Name: 
-- Module Name: simm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity system_sim is
--  Port ( );
end system_sim;

architecture Behavioral of system_sim is
component TOP_LAYER is
 Port (
 clock: in std_logic;
 buttons : in std_logic_vector(4 downto 0);
 mods : in std_logic_vector(5 downto 0);
 door : in std_logic;
 ER, PW, cancel: in std_logic;
 segment: out std_logic_vector(6 downto 0);
 an: out std_logic_vector(7 downto 0);
 color1, color2, color3, o_door: out std_logic;
 Z_Rot: out std_logic_vector(2 downto 0);
 modd_reg: out std_logic_vector(5 downto 0);
 erANDpw: out std_logic_vector(1 downto 0)
  );
end component;
signal clock:  std_logic := '0';
 signal buttons :  std_logic_vector(4 downto 0) := "00000";
 signal mods :  std_logic_vector(5 downto 0) := "000000";
 signal door :  std_logic := '0';
 signal ER, PW, cancel: std_logic := '0' ;
 signal segment:  std_logic_vector(6 downto 0);
 signal an:  std_logic_vector(7 downto 0);
 signal color1, color2, color3, o_door:  std_logic;
 signal Z_Rot:  std_logic_vector(2 downto 0);
 signal modd_reg:  std_logic_vector(5 downto 0);
 signal erANDpw:  std_logic_vector(1 downto 0);
 type severity_level is (ERROR, NOTE);
begin
  mods(5) <= '1' after 400us; 
  C1: TOP_LAYER port map ( clock, buttons, mods, door, ER, PW, cancel,  segment, an, color1, color2, color3, o_door, Z_Rot, modd_reg, erANDpw);
 clock <= not clock after 10ns;
end Behavioral;
