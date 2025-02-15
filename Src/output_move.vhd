

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY output_move IS
  PORT (
    start, er, done: in std_logic;
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: out std_logic_vector(6 downto 0)
    );
END output_move;



ARCHITECTURE TypeArchitecture OF output_move IS
BEGIN
process (start, er, done)
variable s1, s2, s3, s4, s5, s6, s7, s8: std_logic_vector(6 downto 0) := "0000000";
begin 
 if (start = '1') then
 s1 := "0110111"; -- H
 s2 := "1001111"; -- E
 s3 := "0001110"; -- L
 s4 := "0001110"; -- L
 s5 := "1111110"; -- O
 s6 := "0000000"; -- nothing
 s7 := "0000000"; -- nothing
 s8 := "0000000"; -- nothing
 elsif (er = '1') then

 s1 := "1001111"; -- E
 s2 := "0000101"; -- r
 s3 := "0000101"; -- r
 s4 := "0011101"; -- o
 s5 := "0000101"; -- r
 s6 := "0000000"; -- nothing
 s7 := "0000000"; -- nothing
 s8 := "0000000"; -- nothing
 else 
 s1 := "0111101"; -- d
 s2 := "0011101"; -- o
 s3 := "0010101"; -- n
 s4 := "1001111"; -- E
 s5 := "0000000"; -- nothing
 s6 := "0000000"; -- nothing
 s7 := "0000000"; -- nothing
 s8 := "0000000"; -- nothing
 end if;
 segment1 <= s1;
 segment2 <= s2;
 segment3 <= s3;
 segment4 <= s4;
 segment5 <= s5;
 segment6 <= s6;
 segment7 <= s7;
 segment8 <= s8;
 end process;
END TypeArchitecture;
