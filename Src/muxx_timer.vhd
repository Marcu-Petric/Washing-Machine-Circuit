----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2023 01:49:49 PM
-- Design Name: 
-- Module Name: muxx_timer - Behavioral
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

entity muxx_timer is
  Port (
  temp : in std_logic_vector (1 downto 0);
  mode : in std_logic_vector(5 downto 0);
  ER, PH: in std_logic;
  min, ore: out std_logic_vector (5 downto 0)
   );
end muxx_timer;

architecture Behavioral of muxx_timer is
component  mux_timer IS
  PORT (
    mode : in std_logic_vector (5 downto 0);
    manual_min: in std_logic_vector (5 downto 0);
    manual_ore: in std_logic_vector (5 downto 0);
    out_min: out std_logic_vector (5 downto 0);
    out_ore: out std_logic_vector (5 downto 0)
    );
END component;
component small_mux_timer IS
  PORT (
  temp: in std_logic_vector(1 downto 0);
  ER: in std_logic;
  PH: in std_logic;
  hours: out std_logic_vector (5 downto 0);
  m: out std_logic_vector (5 downto 0)
    );
END component;
signal out_min, out_ore:  std_logic_vector (5 downto 0);
begin
C1: small_mux_timer port map (temp, ER, PH, out_min, out_ore);
C2: mux_timer port map (mode, out_min, out_ore, min, ore);
end Behavioral;
