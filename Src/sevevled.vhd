LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sevevled IS
  PORT (
  
    CLK: in std_logic;
    s1, s2, s3, s4, s5, s6, s7, s8: in std_logic_vector(6 downto 0);
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: out std_logic_vector(6 downto 0)
    );
END sevevled;

ARCHITECTURE TypeArchitecture OF sevevled IS
begin
process (CLK)
variable f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, seg1, seg2, seg3, seg4 : std_logic_vector(6 downto 0) := "0000000";

begin
 if ( CLK = '1') and (CLK'EVENT) then
 if (seg1 = s1 ) and (seg2 = s2) and (seg3 = s3) and (seg4 = s4) then
  f14 := f13;
  f13 := f12;
  f12 := f11;
  f11 := f10;
  f10 := f9;
  f9 := f8;
  f8 := f7;
  f7 := f6;
  f6 := f5;
  f5 := f4;
  f4 := f3;
  f3 := f2;
  f2 := f1;
  f1 := f14;
  else
  f1 := s1;
  f2 := s2;
  f3 := s3;
  f4 := s4;
  f5 := s5;
  f6 := s6;
  f7 := s7;
  f8 := s8;
  f9 := "0000000";
  f10 := "0000000";
  f11 := "0000000";
  f12 := "0000000";
  f13 := "0000000";
  f14 := "0000000";
  seg1 := s1;
  seg2 := s2;
  seg3 := s3;
  seg4 := s4;
  end if;
 end if;
 segment1 <= f1;
 segment2 <= f2;
 segment3 <= f3;
 segment4 <= f4;
 segment5 <= f5;
 segment6 <= f6;
 segment7 <= f7;
 segment8 <= f8;
end process;
end TypeArchitecture;
