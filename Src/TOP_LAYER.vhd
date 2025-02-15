library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TOP_LAYER is
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
end TOP_LAYER;

architecture Behavioral of TOP_LAYER is
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

component EU is
  Port ( 
   clk, reset, ER, PH, ld_timer, en_timer, en_reg, en_reg_set, start, err, done, uptemp, downtemp, uprpm ,downrpm, EN3, EN10, EN20, HW, DW, IW,  Z_LoadHeat, EN_OK, OK, ZTB, ZTRPM, Z_lock , EN_LOCK: in std_logic;
   buttons: in std_logic_vector(4 downto 0);
   mode: in std_logic_vector (5 downto 0);
   segment: out std_logic_vector (6 downto 0);
   anods: out std_logic_vector (7 downto 0);
   t3, t10, t20: out std_logic;
   b: out std_logic_vector (4 downto 0);
   c1, c2, c3, CHeat, iPH,iER, Ok1, lock: out std_logic;
   mod_out : out std_logic_vector(5 downto 0)
  );
end component;
signal mods_sig: std_logic_vector(5 downto 0);
signal iStart, iT, iRPM, Up, Down, T3, T10, T20, CHeat,iPW, iER, OK1, T1, en_reg_set: std_logic;
signal ZTime, Err, ZRPM, ZTemp, ZBTemp, ZBRPM, ZLock, Cu_RPM, Cd_RPM, Cu_Temp, Reset, Cd_Temp,ZDone: std_logic;
signal FW, WD, HW, EN3, EN10,EN1,EN20, Z_LoadHeat, OK, EN_OK, LOAD, EN_TIMER, EN_reg,  HELLO, en_lock, lock: std_logic;
signal debounced_but: std_logic_vector (4 downto 0);
begin
iT <= debounced_but(0);
iStart <= debounced_but(1);
iRPM <= debounced_but(2);
Up <= debounced_but(3);
Down <= debounced_but(4);
modd_reg <= mods_sig;
C1: CU port map(mods_sig, iStart, iT, iRPM, Up, Down, Door, iPW, T3, T10, T20, CHeat, iER, OK1, clock, Err, ZBTemp, ZBRPM, ZLock, Cu_RPM, Cd_RPM, Cu_Temp, Reset, Cd_Temp,ZDone, Z_Rot, FW, WD, HW, EN3, EN10, EN20, Z_LoadHeat, OK, EN_OK, LOAD, EN_TIMER, EN_reg, en_reg_set, EN_LOCK, HELLO);
C2: EU port map(clock, reset, ER, PW, LOAD, EN_TIMER, EN_reg, en_reg_set, HELLO, ERR, Zdone, Cu_Temp, Cd_temp, Cu_RPM, Cd_RPM, EN3, EN10, EN20, HW, WD, FW, Z_LoadHeat,  EN_OK, OK,ZBTemp, ZBRPM, Zlock , EN_LOCK, buttons, mods, segment, an, t3, t10, t20, debounced_but, color1, color2, color3, lock, CHeat, iPW, iER, Ok1, mods_sig);
o_door <= lock or door;
erANDpw <= iER & iPW;
end Behavioral;
