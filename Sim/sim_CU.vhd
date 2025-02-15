----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2023 10:08:12 PM
-- Design Name: 
-- Module Name: sim_CU - Behavioral
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

entity sim_CU is
--  Port ( );
end sim_CU;

architecture Behavioral of sim_CU is
component CU IS
  PORT (
        mods:in std_logic_vector(5 downto 0);
        iStart, iT, iRPM, Up, Down, iDoor, iPW, T3, T10, T20, CHeat, ER, OK1, clock: in std_logic;
        Err, ZBTemp, ZBRPM, ZLock, Cu_RPM, Cd_RPM, Cu_Temp, Reset, Cd_Temp, ZDone: out std_logic;
        Z_Rot: out std_logic_vector (2 downto 0);
        FW, WD, HW, EN3, EN10, EN20, Z_LoadHeat, OK, EN_OK, LOAD, EN_TIMER, EN_reg, en_reg_set, EN_LOCK: out std_logic;
        
        
        HELLO: out std_logic
        
    );
END component;
signal mods: std_logic_vector(5 downto 0) := "000000";
signal iStart, iT, iRPM, Up, Down, iDoor, iPW, T3, T10, T20, CHeat, ER, OK1, clock : std_logic := '0';
signal Err, ZBTemp, ZBRPM, ZLock, Cu_RPM, Cd_RPM, Cu_Temp, Reset, Cd_Temp, ZDone, FW, WD, HW, EN3, EN10, EN20, Z_LoadHeat, OK, EN_OK, LOAD, EN_TIMER, EN_reg, en_reg_set, EN_LOCK, HELLO: std_logic;
signal Z_rot: std_logic_vector (2 downto 0);
begin
C1: CU port map (mods, iStart, iT, iRPM, Up, Down, iDoor, iPW, T3, T10, T20, CHeat, ER, OK1, clock, Err, ZBTemp, ZBRPM, ZLock, Cu_RPM, Cd_RPM, Cu_Temp, Reset, Cd_Temp, ZDone,Z_Rot,  FW, WD, HW, EN3, EN10, EN20, Z_LoadHeat, OK, EN_OK, LOAD, EN_TIMER, EN_reg, en_reg_set, EN_LOCK, HELLO);
clock <= not clock after 5ns;
end Behavioral;
