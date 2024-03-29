library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity decode_stage_tb is
end;

architecture bench of decode_stage_tb is

  component decode_stage
   Port (rst : in std_logic;
         clk: in std_logic;
         CLR: in std_logic;
         nEN : in std_logic;
         InstrD:in std_logic_vector(31 downto 0);
         WA:in std_logic_vector(4 downto 0);
         WD:in std_logic_vector(31 downto 0); 
         PCPlus1D: in std_logic_vector(31 downto 0);
         WE: in std_logic;
         --ResultW:in std_logic_vector(31 downto 0);
         PCSrcD: out std_logic;
         RD1E: out std_logic_vector(31 downto 0);
         RD2E: out std_logic_vector(31 downto 0);
         RD3E: out std_logic_vector(31 downto 0);
         RSE: out std_logic_vector(4 downto 0);
         RTE: out std_logic_vector(4 downto 0);
         RDE: out std_logic_vector(4 downto 0);
         SignImmE: out std_logic_vector(31 downto 0);
         PCBranchD: out std_logic_vector( 31 downto 0);
         BranchD : inout std_logic;
         RegWriteE : out STD_LOGIC;
         MemtoRegE : out STD_LOGIC;
         MemWriteE : out STD_LOGIC;
         ALUControlE : out STD_LOGIC_VECTOR( 2 downto 0);
         ALUSrcE : out STD_LOGIC;
         RegDstE : out STD_LOGIC 
         ) ;
  end component;

  signal rst: std_logic := '1';
  signal clk: std_logic:='1';
  signal CLR: std_logic:='0';
  signal nEN: std_logic:='0';
  signal InstrD: std_logic_vector(31 downto 0):=(others=>'0');
  signal WA: std_logic_vector(4 downto 0):=(others=>'0');
  signal WD: std_logic_vector(31 downto 0):=(others=>'0');
  signal PCPlus1D: std_logic_vector(31 downto 0):=(others=>'0');
  signal WE: std_logic:='0';
  signal ResultW: std_logic_vector(31 downto 0):=(others=>'0');
  signal PCSrcD: std_logic;
  signal RD1E: std_logic_vector(31 downto 0);
  signal RD2E: std_logic_vector(31 downto 0);
  signal RD3E: std_logic_vector(31 downto 0);
  signal RSE: std_logic_vector(4 downto 0);
  signal RTE: std_logic_vector(4 downto 0);
  signal RDE: std_logic_vector(4 downto 0);
  signal SignImmE: std_logic_vector(31 downto 0);
  signal PCBranchD: std_logic_vector( 31 downto 0);
  signal BranchD: std_logic;
  signal RegWriteE: STD_LOGIC;
  signal MemtoRegE: STD_LOGIC;
  signal MemWriteE: STD_LOGIC;
  signal ALUControlE: STD_LOGIC_VECTOR( 2 downto 0);
  signal ALUSrcE: STD_LOGIC;
  signal RegDstE: STD_LOGIC;

begin

  uut: decode_stage port map ( rst         => rst,
                               clk         => clk,
                               CLR         => CLR,
                               nEN         => nEN,
                               InstrD      => InstrD,
                               WA          => WA,
                               WD          => WD,
                               PCPlus1D    => PCPlus1D,
                               WE          => WE,
                               --ResultW     => ResultW,
                               PCSrcD      => PCSrcD,
                               RD1E        => RD1E,
                               RD2E        => RD2E,
                               RD3E        => RD3E,
                               RSE         => RSE,
                               RTE         => RTE,
                               RDE         => RDE,
                               SignImmE    => SignImmE,
                               PCBranchD   => PCBranchD,
                               BranchD     => BranchD,
                               RegWriteE   => RegWriteE,
                               MemtoRegE   => MemtoRegE,
                               MemWriteE   => MemWriteE,
                               ALUControlE => ALUControlE,
                               ALUSrcE     => ALUSrcE,
                               RegDstE     => RegDstE );
  clocking: process
  begin
    clk <= not clk; wait for 5ns;
  end process;
  
  stimulus: process
  begin
    rst <= '1'; wait for 5ns; rst <= '0';
    nEN <= '0'; InstrD <= "00000000001000100001100000000000";wait for 10ns;-- add 1(rs) 2(rt) 3(rd) (tested correct)
    InstrD <= "00000100001000101001100000000000";wait for 10ns;--sub
    InstrD <= "00001000001000100001100000000000";wait for 10ns;--addi
    InstrD <= "00001100001000100001100000000000";wait for 10ns;--subi
    InstrD <= "00010000001000100001100000000000";wait for 10ns;--and
    InstrD <= "00010100001000100001100000000000";wait for 10ns;--or
    InstrD <= "00011000001000100001100000000000";wait for 10ns;--lw
    InstrD <= "00011100001000100001100000000000";wait for 10ns;--sw
    InstrD <= "00100000001000100001100000000000";wait for 10ns;--weight
    InstrD <= "00100100001000100001100000000000";wait for 10ns;--ann
    InstrD <= "00101000001000100001100000000000";wait for 10ns;--beqz
    WA<="00011";WD<="00101000001000100001100000000000";WE<='1';InstrD <= "00000000001000100001100000000000";wait for 10ns;--testing writing and reading at same clock cycle 
    --all tested
    
    
    --WA <= "00000"; WE <= '0'; PCPlus1D <= X"00000001"; WD <= X"0000ffff"; wait for 10ns;
    --InstrD <= "00001000011001010000000000000110"; WA <= "00011"; WE <= '1'; PCPlus1D <= X"00000002"; wait for 10ns;
    wait;
    
  end process;


end;