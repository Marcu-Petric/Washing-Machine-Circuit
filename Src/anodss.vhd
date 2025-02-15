LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY anodss IS
  PORT (
  
    CLK: in std_logic;
    s: out std_logic_vector (6 downto 0);
    AN: out std_logic_vector (7 downto 0);
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: in std_logic_vector(6 downto 0)
    );
END anodss;

ARCHITECTURE moveanods OF anodss IS

BEGIN
process (CLK)
variable segment:  std_logic_vector (6 downto 0);
variable anozi:  std_logic_vector (7 downto 0);
begin
 if ( CLK = '1') and (CLK'EVENT) then
   case anozi is 
   when "10000000" => anozi := "01000000"; segment := segment2;
   when "01000000" => anozi := "00100000"; segment := segment3;
   when "00100000" => anozi := "00010000"; segment := segment4;
   when "00010000" => anozi := "00001000"; segment := segment5;
   when "00001000" => anozi := "00000100"; segment := segment6;
   when "00000100" => anozi := "00000010"; segment := segment7;
   when "00000010" => anozi := "00000001"; segment := segment8;
   when "00000001" => anozi := "10000000"; segment := segment1;
   when others => anozi := "10000000"; segment := segment1;
   end case;
 end if;
 AN <= anozi;
 s <= Segment;
end process;
END moveanods;