library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fetch_stage is
  Port (rst : in std_logic;
        clk: in std_logic;
        PCBranchD: in std_logic_vector(31 downto 0); --address to jump 
        StallF: in std_logic;
        StallD: in std_logic;
        PCSrcD : in std_logic;
        instD : out std_logic_vector(31 downto 0);
        PCPlus1D : out std_logic_vector(31 downto 0));
end fetch_stage;

architecture Behavioral of fetch_stage is
    component inst_mem is
        Port ( rst : in std_logic;
               A : in STD_LOGIC_VECTOR (31 downto 0);
               inst : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component generic_reg is
        generic(w : integer);
        Port ( rst : in std_logic;
               clk : in STD_LOGIC;
               nEN : in std_logic;
               d : in STD_LOGIC_VECTOR(w-1 downto 0);
               q : out STD_LOGIC_VECTOR(w-1 downto 0));
    end component;
    
    component Adder is
        Port (A,B: in std_logic_vector(31 downto 0);
              out_address : out std_logic_vector(31 downto 0));
    end component;
    
    component pipe_reg_FD is
        Port ( rst : in std_logic;
               instF : in STD_LOGIC_VECTOR (31 downto 0);
               PCPlus1F : in STD_LOGIC_VECTOR (31 downto 0);
               clk : in STD_LOGIC;
               CLR : in STD_LOGIC;
               nEN : in STD_LOGIC;
               instD : out STD_LOGIC_VECTOR (31 downto 0);
               PCPlus1D : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal PC : std_logic_vector(31 downto 0) := (others => '0');
    signal PCF: std_logic_vector(31 downto 0) := (others => '0');
    signal instF: std_logic_vector(31 downto 0) := (others => '0');
    signal PCPlus1F : std_logic_vector(31 downto 0) := (others => '0');
    signal intermediate: std_logic_vector(31 downto 0) := (others => '0');
    signal intermediate2: std_logic_vector(31 downto 0) := (others => '0');
        
begin
    PC <= PCPlus1F when PCSrcD = '0' else 
          PCBranchD;
    
    intermediate <= PC;
    intermediate2 <= PCPlus1F;
    
    PCREG: generic_reg generic map (32) port map (rst, clk , StallF , intermediate , PCF);
    PCAdder: Adder port map (PCF , X"00000001", PCPlus1F);
    ROM: inst_mem port map (rst, PCF, instF);
    FDReg: pipe_reg_FD port map (rst, instF, intermediate2, clk, PCSrcD, StallD , instD , PCPlus1D); 
    
end Behavioral;
