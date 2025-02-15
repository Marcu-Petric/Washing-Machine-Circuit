

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY blink IS
  PORT (
  clk, en: in std_logic;
  in1, in2: in std_logic_vector(6 downto 0);
  seg1, seg2: out std_logic_vector(6 downto 0)
    );
END blink;



ARCHITECTURE TypeArchitecture OF blink IS

BEGIN

    process(clk)
    variable s1, s2: std_logic_vector (6 downto 0);
    begin 
    if (en = '1') then
    if (clk = '1' ) then
    s1 := in1;
    s2 := in2;
    else
    s1 := "0000000";
    s2 := "0000000";
    end if;
    else
    s1 := in1;
    s2 := in2;
    end if;
    seg1 <= s1;
    seg2 <= s2;
    end process;
END TypeArchitecture;
