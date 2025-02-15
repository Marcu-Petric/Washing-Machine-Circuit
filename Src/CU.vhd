
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CU IS
  PORT (
        mods:in std_logic_vector(5 downto 0);
        iStart, iT, iRPM, Up, Down, iDoor, iPW, T3, T10, T20, CHeat, ER, OK1, clock: in std_logic;
        Err, ZBTemp, ZBRPM, ZLock, Cu_RPM, Cd_RPM, Cu_Temp, Reset, Cd_Temp, ZDone: out std_logic;
        Z_Rot: out std_logic_vector (2 downto 0);
        FW, WD, HW, EN3, EN10, EN20, Z_LoadHeat, OK, EN_OK, LOAD, EN_TIMER, EN_reg, en_reg_set, EN_LOCK: out std_logic;
        
        
        HELLO: out std_logic
        
    );
END CU;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF CU IS

type STATE_T is (Idle, ERRor, Manual, QW, SW, DC, DL, An, S1, S2, S3, S4, S5, S6, MW, PW, S7, S8, S9, S9_1, RINSE, S10, S11, S12, S13, S14, S15, SPIN, S16, S17);
signal state, nxstate: STATE_T;
BEGIN

update_state: process(clock)
begin
if(clock'event) and (clock = '1') then
state <= nxstate;
end if;
end process update_state;

Transitions: process(iStart, mods, state, iT, iRPM, Up, Down, iDoor, iPW, T3, T10, T20, CHeat, ER, OK1)
begin
ZBTemp <= '0';
ZBRPM <= '0';
ZLock <= '0';
EN_LOCK <= '0';
Cu_RPM <= '0';
Cd_RPM <= '0';
Cu_Temp <= '0';
Reset <= '0';
Cd_Temp <= '0';
FW <= '0';
WD <= '0';
HW <= '0';
EN3 <= '0';
EN10 <= '0';
EN20 <= '0';
Z_LoadHeat <= '0';
OK <= '0';
EN_OK <= '0';
ZDone <= '0';
Z_Rot <= "000";
HELLO <= '0';
Err <= '0';
Load <= '0';
EN_TIMER <= '0';
EN_reg <= '0';
en_reg_set <= '0';
case state is
   when Idle => HELLO <= '1';
             EN_reg <= '1';
             reset <= '1';
             if(mods = "100000") then nxstate <= Manual;
             elsif (mods = "000001") then nxstate <= QW;
             elsif (mods = "000010") then nxstate <= SW;
             elsif (mods = "000100") then nxstate <= DC;
             elsif (mods = "001000") then nxstate <= DL;
             elsif (mods = "010000") then nxstate <= AN;
             elsif (mods = "000000") then nxstate <= Idle;
             else nxstate <= ERROR;
             end if;

   when ERROR => Err <= '1';
             if(mods = "100000") then nxstate <= Manual;
             elsif (mods = "000001") then nxstate <= QW;
             elsif (mods = "000010") then nxstate <= SW;
             elsif (mods = "000100") then nxstate <= DC;
             elsif (mods = "001000") then nxstate <= DL;
             elsif (mods = "010000") then nxstate <= AN;
             elsif (mods = "000000") then nxstate <= Idle;
             else nxstate <= ERROR;
             end if;

  when Manual => en_reg_set <= '1';
            if(iStart = '0') then nxstate <= S1;
            else
            if(iDoor = '0') then nxstate <= Manual;
            else nxstate <= S6;
            end if;
            end if;
  when S1 =>  en_reg_set <= '1';
             if(IT = '1' and iRPM = '0') then nxstate <= S2;
             elsif (iT = '0' and iRPM = '1') then nxstate <= S4;
             else nxstate <= s1;
             end if;
            
  when S2 => en_reg_set <= '1';
             ZBTemp <='1';
             Load <= '1';
             if (Up = '1') then 
                  Cu_Temp <= '1';
                  nxstate <= S3;
             else nxstate <= S3;
             end if;
 
  when S3 =>en_reg_set <= '1';
            if(Down = '1') then Cd_Temp <= '1';
            end if;
            if(iStart = '1') then nxstate <= Manual;
            else nxstate <= S2;
            end if;

  when S4 =>en_reg_set <= '1';
             Load <= '1';
             ZBRPM <= '1';
             if (Up = '1') then 
                  Cu_RPM <= '1';
                  nxstate <= S5;
             else nxstate <= S5;
             end if;
 
  when S5 =>en_reg_set <= '1';
            if(Down = '1') then Cd_RPM <= '1';
            end if;
            if(iStart = '1') then nxstate <= Manual;
            else nxstate <= S4;
            end if;

  when S6 =>
          if(iPW = '0') then nxstate <= MW;
          else nxstate <= PW;
          end if;

  when QW =>                                         
          if(iDoor = '1') then nxstate <= MW;
          else nxstate <= QW;
          end if;
  
 when SW =>                                         
          if(iDoor = '1') then nxstate <= MW;
          else nxstate <= SW; 
          end if;  

  when DC =>                                         
          if(iDoor = '1') then nxstate <= MW;
          else nxstate <= DC;
          end if;

  when AN =>                                         
          if(iDoor = '1') then  nxstate <= MW;
          else nxstate <= AN;
          end if;

  when DL =>                                         
          if(iDoor = '1') then nxstate <= PW;
          else nxstate <= DL;
          end if;

  when MW => Zlock <= '1';  EN_lock <= '1'; 
             EN3 <= '1';
             FW <= '1';
             if(T3 = '0') then nxstate <= MW;
             else Z_loadheat <= '1';
                  nxstate <= S7;
             end if;
  when S7 =>            HW <= '1';
             if(CHeat = '0') then nxstate <= S7;
             else nxstate <= S8;
             end if;
             
  when S8 => EN20 <='1';
             Z_Rot <= "001";
             EN_TIMER <= '1';
             if(T20 = '0') then nxstate <= S8;
             else nxstate <= S9;
             end if;
             
  when S9 => WD <= '1';
             EN3 <= '1';
             if(T3 = '0') then nxstate <= S9;
             else OK <= '1';
             nxstate <= S9_1;
             end if;

  when S9_1 =>
             if(ER = '0') then nxstate <= RINSE;
             else EN_OK <= '1';
                  OK <= '1';
                  nxstate <= RINSE;
             end if;

  when PW => Zlock <= '1';  EN_lock <= '1'; 
             FW <= '1';
             EN3 <= '1';
             if(T3 = '0') then nxstate <= PW;
             else Z_LoadHeat <= '1';
                  nxstate <= S10;
             end if;
                        
  when S10 =>
              HW <= '1';
              if(CHeat = '0') then nxstate <= S10;
              else nxstate <= S11;
              end if;   
  when S11 => EN10 <= '1';
              Z_Rot <= "001";
              EN_TIMER <= '1';
              if(T10 = '0') then nxstate <= S11;
              else nxstate <= S12;
              end if;

  when S12 => WD <= '1';
              EN3 <= '1';
              if(T3 = '0') then nxstate <= S12;
              else nxstate <= MW;
              end if; 

  when RINSE => FW <= '1';
                EN3 <= '1';
                if(T3 = '0') then nxstate <= RINSE;
                else nxstate <= S13;
                end if;

  when S13 => EN10 <= '1';
              Z_Rot <= "010";  
              EN_TIMER <= '1'; 
              if(T10 = '0') then nxstate <= S13;
              else nxstate <= S14;
              end if;

  when S14 =>  WD <= '1';
               EN3 <= '1';
               if(T3 = '0') then nxstate <= S14;
               else nxstate <= S15;
               end if;

  when S15 =>  
              if(OK1 = '1') then OK <= '0';
              EN_OK <='1';
              nxstate <= RINSE;
              else   nxstate <= SPIN;
              end if;

  when SPIN => Z_Rot <= "100";
               EN10 <= '1';
               EN_TIMER <= '1';
               if(T10 = '0') then nxstate <= SPIN;
               else nxstate <= S16;
               end if;

  when S16 => EN10 <= '1';
              if(T10 = '0') then nxstate <= S16;
              else  Zlock <= '0';
                    EN_lock <= '1';
                    nxstate <= S17;
              end if;

   when S17 => Zdone <= '1';
              if(mods = "000000") then nxstate <= Idle;
              else nxstate <= S17; 
              end if;
   when others => nxstate <= Idle;                                                                   
end case;
end process Transitions;
END behavioral;
