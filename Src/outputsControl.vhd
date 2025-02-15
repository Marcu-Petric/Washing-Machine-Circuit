

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY outputsControl IS
  PORT (
    done, error, start: in std_logic;
    move1, move2, move3, move4, move5, move6, move7, move8 : in std_logic_vector (6 downto 0);
    minD, minU, secD, secU, rpm1, rpm2, temp1, temp2: in std_logic_vector (6 downto 0);
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: out std_logic_vector (6 downto 0)
    );
END outputsControl;


ARCHITECTURE TypeArchitecture OF outputsControl IS

signal s1, s2, s3, s4, s5, s6, s7, s8: std_logic_vector(6 downto 0);
BEGIN
 process (done, error, start, move1)
 begin 
 if (done = '1') or (error = '1') or (start = '1') then
 s1 <= move1;
 s2 <= move2;
 s3 <= move3;
 s4 <= move4;
 s5 <= move5;
 s6 <= move6;
 s7 <= move7;
 s8 <= move8;
 else
 s1 <= minD;
 s2 <= minU;
 s3 <= secD;
 s4 <= secU;
 s5 <= temp1;
 s6 <= temp2;
 s7 <= rpm1;
 s8 <= rpm2;
 end if;
 end process;
 segment1 <= s1;
 segment2 <= s2;
 segment3 <= s3;
 segment4 <= s4;
 segment5 <= s5;
 segment6 <= s6;
 segment7 <= s7;
 segment8 <= s8;
END TypeArchitecture;
