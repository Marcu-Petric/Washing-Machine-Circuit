library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity bin_to_7seg is
  Port (
  bin_num : in std_logic_vector(5 downto 0);
  decimal, unit: out std_logic_vector(6 downto 0)
  );
end bin_to_7seg;

architecture Behavioral of bin_to_7seg is
component Binary_to_decimal_converter IS
  PORT (
 Bin_num: in std_logic_vector(5 downto 0);
  		Unit: out std_logic_vector(3 downto 0);
  		Decimal: out std_logic_vector(3 downto 0)  
    );
END component;
component bcd IS
  PORT (
  number: in std_logic_vector(3 downto 0);
  segment: out std_logic_vector(6 downto 0)
    );
END component;
signal dec, un: std_logic_vector(3 downto 0);
begin
C1: binary_to_decimal_converter port map (bin_num, un, dec);
C2: bcd port map (un, unit);
C3: bcd port map (dec, decimal);
end Behavioral;
