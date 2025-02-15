library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EU is
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
end EU;

architecture struct of EU is
component register_mode is 
PORT (
  clk, en: in std_logic;
  ld : in std_logic_vector(5 downto 0);
  a: out std_logic_vector(5 downto 0)
  );
END component;
component mpg is
  Port ( clk: in STD_LOGIC;
         btn : in STD_LOGIC_VECTOR(4 downto 0); 
         enable : out STD_LOGIC_VECTOR(4 downto 0));
end component;
component ONEsec IS
  PORT (
  clk : in std_logic;
  newclk : out std_logic
    );
END component;
component frequencyDEVIDER IS
  PORT (
    CLK, reset : in  std_logic;
    newClock, newclock2   : out std_logic
    );
END component;
component muxx_timer is
  Port (
  temp : in std_logic_vector (1 downto 0);
  mode : in std_logic_vector(5 downto 0);
  ER, PH: in std_logic;
  min, ore: out std_logic_vector (5 downto 0)
   );
end component;
component minute IS
  PORT (
  clk, en, ld:  in std_logic;
  a: in std_logic_vector(5 downto 0);
  m : out std_logic_vector (5 downto 0);
  t: out std_logic
    );
END component;
component ore IS
  PORT (
  clk, en, ld:  in std_logic;
  a: in std_logic_vector(5 downto 0);
  h : out std_logic_vector (5 downto 0)
    );
END component;
component bin_to_7seg is
  Port (
  bin_num : in std_logic_vector(5 downto 0);
  decimal, unit: out std_logic_vector(6 downto 0)
  );
end component;
component state_counter IS
  PORT (
           clk: in std_logic; -- clock input
           reset: in std_logic; -- reset input 
           up, down: in std_logic; -- up or down
           counter: out std_logic_vector(1 downto 0) -- output 4-bit counter
    );
END component;
component state_counter_RPM IS
  PORT (
           clk: in std_logic; -- clock input
           reset: in std_logic; -- reset input 
           up, down: in std_logic; -- up or down
           counter: out std_logic_vector(1 downto 0) -- output 4-bit counter
    );
END component;
component mux_mod_temp IS
  PORT (
  mode: in std_logic_vector(5 downto 0);
  temp_man: in std_logic_vector(1 downto 0);
  temp : out std_logic_vector (1 downto 0)
    );
END component;
component mux_iesire_temp IS
  PORT (
  temp : in std_logic_vector (1 downto 0);
  segment1, segment2 : out std_logic_vector(6 downto 0)
    );
END component;
component mux_mod_rpm IS
  PORT (
  mode: in std_logic_vector(5 downto 0);
  rpm_man: in std_logic_vector(1 downto 0);
  rpm : out std_logic_vector (1 downto 0)
    );
END component;
component mux_iesire_rpm IS
  PORT (
  rpm : in std_logic_vector (1 downto 0);
  segment1, segment2 : out std_logic_vector(6 downto 0)
    );
END component;
component outputsControl IS
  PORT (
    done, error, start: in std_logic;
    move1, move2, move3, move4, move5, move6, move7, move8 : in std_logic_vector (6 downto 0);
    minD, minU, secD, secU, rpm1, rpm2, temp1, temp2: in std_logic_vector (6 downto 0);
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: out std_logic_vector (6 downto 0)
    );
END component;
component move is
  Port (
  clk, start, err, done: in std_logic;
  s1, s2, s3, s4, s5, s6, s7, s8: out std_logic_vector(6 downto 0)
  );
end component;
component anodss IS
  PORT (
  
    CLK: in std_logic;
    s: out std_logic_vector (6 downto 0);
    AN: out std_logic_vector (7 downto 0);
    segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: in std_logic_vector(6 downto 0)
    );
END component;

component TIMER10 IS
  PORT (
    clk, reset, en: in std_logic;
    t10: out std_logic
    );
END component;
component TIMER3 IS
  PORT (
    clk, reset, en: in std_logic;
    t3: out std_logic
    );
END component;
component TIMER20 IS
  PORT (
    clk, reset, en: in std_logic;
    t20: out std_logic
    );
END component;

component colors is
  Port (clk, a, b, c: in std_logic;
  c1, c2, c3 : out std_logic
  );
end component;
component mux_ctemp IS
  PORT (
  temp : in std_logic_vector (1 downto 0);
  o : out std_logic_vector(4 downto 0)
    );
END component;
component heat_count IS
  PORT (
  clk, en, ld:  in std_logic;
  a: in std_logic_vector(4 downto 0);
  m : out std_logic_vector (4 downto 0);
  t: out std_logic
    );
END component;
component reg_er_and_ph IS
  PORT (
  clk, en: in std_logic;
  ld : in std_logic_vector(1 downto 0);
  a: out std_logic_vector(1 downto 0)
  );
END component;
component dff_en is
   port(
      clk: in std_logic;
      reset: in std_logic;
      en: in std_logic;
      d: in std_logic;
      q: out std_logic
   );
end component;
component blink IS
  PORT (
  clk, en: in std_logic;
  in1, in2: in std_logic_vector(6 downto 0);
  seg1, seg2: out std_logic_vector(6 downto 0)
    );
END component;
signal temp_load ,mi: std_logic_vector(4 downto 0);
signal modd: std_logic_vector (5 downto 0);
signal f1, fmov, fan, t_min, en_timer_h, ER1, PH1: std_logic;
signal temp,rpm, tempMUX, rpmMUX, ER_PH, ER_PH_reg: std_logic_vector(1 downto 0);
signal h1, m1, m, h : std_logic_vector (5 downto 0);
signal oreD, oreU, minD, minU, temp1, temp2, rpm1, rpm2, temp1b, temp2b, rpm1b, rpm2b, move1, move2, move3, move4, move5, move6, move7, move8,segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8: std_logic_vector (6 downto 0);
begin
mod_out <= modd;
C00: blink port map (f1, ZTB, temp1, temp2, temp1b, temp2b);
C001: blink port map (f1, ZTRPM, rpm1, rpm2, rpm1b, rpm2b);
C01: register_mode port map(clk, en_reg, mode, modd);
C02: mpg port map (clk, buttons, b);
C03: onesec port map (clk, f1);
C4: frequencyDEVIDER port map (clk, '0', fan, fmov);
C5: muxx_timer port map (temp, modd, ER1, PH1, m1, h1);
C6: minute port map (f1, en_timer, ld_timer, m1, m, t_min);
en_timer_h <= t_min and en_timer;
C7: ore port map(f1, en_timer_h, ld_timer, h1, h);
C8: bin_to_7seg port map(h, oreD, oreU);
C9: bin_to_7seg port map(m, minD, minU);
C10: state_counter port map (clk, reset, uptemp, downtemp, temp);
C11: state_counter_RPM port map (clk, reset, upRPM, downRPM, rpm);
C12: mux_mod_temp port map (modd, temp, tempMUX);
C13: mux_iesire_temp port map (tempMUX, temp1, temp2);
C144: mux_ctemp port map (tempMUX, temp_load);
C145: heat_count port map (f1, HW,  Z_LoadHeat, temp_load, mi, CHeat);
C14: mux_mod_rpm port map (modd, rpm, rpmMUX);
C15: mux_iesire_rpm port map (rpmMUX, rpm1, rpm2);
C16: outputsControl port map (done, err, start, move1, move2, move3, move4, move5, move6, move7, move8, oreD, oreU, minD, minU,rpm1b, rpm2b, temp1b, temp2b, segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8);
C17: move port map (fmov, start, err, done, move1, move2, move3, move4, move5, move6, move7, move8);
C18: anodss port map (fan, segment, anods, segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8);
C19: TIMER10 port map (f1, reset, EN10, t10);
C20: TIMER3 port map (f1, reset, en3, t3);
C21: TIMER20 port map (f1, reset, en20, t20);
C22: colors port map (clk, DW, HW, IW, c1, c2, c3);
ER_PH <= ER&PH;
C23: reg_er_and_ph port map (clk, en_reg_set, ER_PH,  ER_PH_reg);
ER1 <= ER_PH_reg(0);
PH1 <= ER_PH_reg(1);
iPH <= PH1;
iER <= ER1;
C24: dff_en port map (clk, reset, EN_OK, OK, OK1);
C25: dff_en port map (clk, reset,EN_LOCK, Z_LOCK, lock);
end struct;
