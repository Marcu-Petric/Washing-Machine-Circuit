-- Debouncer
-- This resource was taken from internet 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity mpg is
  Port ( clk: in STD_LOGIC;
         btn : in STD_LOGIC_VECTOR(4 downto 0); 
         enable : out STD_LOGIC_VECTOR(4 downto 0));
end mpg;

architecture pulsegen of mpg is

signal cnt : STD_LOGIC_VECTOR(15 downto 0);
signal en : STD_LOGIC;
signal q1 : STD_LOGIC_VECTOR(4 downto 0);
signal q2 : STD_LOGIC_VECTOR(4 downto 0);
signal q3 : STD_LOGIC_VECTOR(4 downto 0);

begin

process(clk)
begin
    if clk'event and clk='1' then
         cnt <= cnt + 1;
    end if;
end process;

process(cnt)
begin
    if cnt=x"FFFF" then
        en <= '1';
    else
        en <= '0';
    end if;
end process;

process(clk)
begin
    if clk'event and clk='1' then
        if en = '1' then
            q1 <= btn;
        end if;
    end if;
end process;

process(clk)
begin
    if clk'event and clk='1' then
        q2 <= q1;
    end if;
end process;

process(clk)
begin
    if clk'event and clk='1' then
        q3 <= q2;
    end if;
end process;

enable <= q2 and (not q3);

end pulsegen;