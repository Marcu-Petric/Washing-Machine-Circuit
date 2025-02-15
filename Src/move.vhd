library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity move is
  Port (
  clk, start, err, done: in std_logic;
  s1, s2, s3, s4, s5, s6, s7, s8: out std_logic_vector(6 downto 0)
  );
end move;

architecture Behavioral of move is
component output_move IS
  PORT (
    start, er, done: in std_logic;
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: out std_logic_vector(6 downto 0)
    );
END component;
component sevevled IS
  PORT (
  
    CLK: in std_logic;
    s1, s2, s3, s4, s5, s6, s7, s8: in std_logic_vector(6 downto 0);
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: out std_logic_vector(6 downto 0)
    );
END component;
signal a1, a2, a3, a4, a5, a6, a7, a8: std_logic_vector(6 downto 0);
begin
C1: output_move port map (start, err, done, a1, a2, a3, a4, a5, a6, a7, a8);
C2: sevevled port map (clk, a1, a2, a3, a4, a5, a6, a7, a8, s1, s2, s3, s4, s5, s6, s7, s8);
end Behavioral;
