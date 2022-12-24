----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 12:20:05 AM
-- Design Name: 
-- Module Name: mips_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mips_top is
    Port ( clk : in STD_LOGIC);
end mips_top;

architecture Behavioral of mips_top is

    component fetch_stage is 
        Port (clk: in std_logic;
              PCBranchD: in std_logic_vector(31 downto 0); --address to jump 
              StallF: in std_logic;
              StallD: in std_logic;
              PCSrcD : in std_logic;
              instD : out std_logic_vector(31 downto 0);
              PCPlus1D : out std_logic_vector(31 downto 0));
    end component;
    
    component decode_stage is 
        Port (clk:in std_logic;
              CLR: in std_logic;
              nEN : in std_logic;
              InstrD:in std_logic_vector(31 downto 0);
              WA:in std_logic_vector(4 downto 0);
              WD:in std_logic_vector(31 downto 0); 
              PCPlus1D: in std_logic_vector(31 downto 0);
              WE: in std_logic;
              ResultW:in std_logic_vector;
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
              RegDstE : out STD_LOGIC);
   end component;
   
   component execute_stage is 
       Port ( clk : in STD_LOGIC;
              RegWriteE : in STD_LOGIC;
              MemtoRegE : in STD_LOGIC;
              MemWriteE : in STD_LOGIC;
              ALUControlE : in STD_LOGIC_VECTOR (2 downto 0);
              ALUSrcE : in STD_LOGIC;
              RegDstE : in STD_LOGIC;
              RD1E : in STD_LOGIC_VECTOR (31 downto 0);
              RD2E : in STD_LOGIC_VECTOR (31 downto 0);
              RD3E : in STD_LOGIC_VECTOR (31 downto 0);
              RsE : in STD_LOGIC_VECTOR (4 downto 0);
              RtE : in STD_LOGIC_VECTOR (4 downto 0);
              RdE : in STD_LOGIC_VECTOR (4 downto 0);
              SignImmE : in STD_LOGIC_VECTOR (31 downto 0);
              CLR : in STD_LOGIC;
              --nEN : in STD_LOGIC;
              forwardAE : in std_logic_vector(1 downto 0);
              forwardBE : in std_logic_vector(1 downto 0);
              forwardCE : in std_logic_vector(1 downto 0);
              ResultW : in std_logic_vector(31 downto 0);
              --WriteRegE : inout std_logic_vector(4 downto 0);
              RegWriteM : out STD_LOGIC;
              MemtoRegM : out STD_LOGIC;
              MemWriteM : out STD_LOGIC;
              ALUOutM : inout STD_LOGIC_VECTOR (31 downto 0);
              WriteDataM : out STD_LOGIC_VECTOR (31 downto 0);
              WriteRegM : out STD_LOGIC_VECTOR (4 downto 0));
   end component;
   
    component mem_stage is 
        Port ( clk : in STD_LOGIC;
               RegWriteM : in STD_LOGIC;
               MemtoRegM : in STD_LOGIC;
               MemWriteM : in STD_LOGIC;
               ALUOutM : in STD_LOGIC_VECTOR (31 downto 0);
               WriteDataM : in STD_LOGIC_VECTOR (31 downto 0);
               WriteRegM : in STD_LOGIC_VECTOR (4 downto 0);
               RegWriteW : out STD_LOGIC;
               MemtoRegW : out STD_LOGIC;
               ReadDataW : out STD_LOGIC_VECTOR (31 downto 0);
               ALUOutW : out STD_LOGIC_VECTOR (31 downto 0);
               WriteRegW : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    component writeback_stage is 
        Port ( RegWriteW : inout STD_LOGIC;
               MemtoRegW : inout STD_LOGIC;
               ReadDataW : in STD_LOGIC_VECTOR (31 downto 0);
               ALUOutW : in STD_LOGIC_VECTOR (31 downto 0);
               WriteRegW : inout STD_LOGIC_VECTOR (4 downto 0);
               ResultW : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component hazard_unit is 
        Port ( BranchD : in STD_LOGIC;
               RsE : in STD_LOGIC_VECTOR (4 downto 0);
               RtE : in STD_LOGIC_VECTOR (4 downto 0);
               RdE : in STD_LOGIC_VECTOR (4 downto 0);
               ALUControlE : in STD_LOGIC_VECTOR (2 downto 0);
               ALUSrcE : in STD_LOGIC;
               WriteRegM : in STD_LOGIC_VECTOR (4 downto 0);
               MemtoRegM : in STD_LOGIC;
               RegWriteM : in STD_LOGIC;
               WriteRegW : in STD_LOGIC_VECTOR (4 downto 0);
               RegWriteW : in STD_LOGIC;
               StallF : out STD_LOGIC;
               StallD : out STD_LOGIC;
               StallE : out STD_LOGIC;
               FlushE : out STD_LOGIC;
               FlushM : out STD_LOGIC;
               ForwardAE : out STD_LOGIC_VECTOR (1 downto 0);
               ForwardBE : out STD_LOGIC_VECTOR (1 downto 0);
               ForwardCE : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    -- fetch stage signals
    signal PCBranchD : std_logic_vector(31 downto 0);
    signal StallF: std_logic;
    signal StallD:  std_logic;
    signal PCSrcD : std_logic;
    signal instD : std_logic_vector(31 downto 0);
    signal PCPlus1D : std_logic_vector(31 downto 0);
    
    -- decode stage signals
    signal CLR: std_logic;
    signal nEN : std_logic;
    signal InstrD : std_logic_vector(31 downto 0);
    signal WA : std_logic_vector(4 downto 0);
    signal WD : std_logic_vector(31 downto 0); 
    --signal PCPlus1D : std_logic_vector(31 downto 0);
    signal WE : std_logic;
    signal ResultW: std_logic_vector;
    --signal PCSrcD : std_logic;
    signal RD1E : std_logic_vector(31 downto 0);
    signal RD2E : std_logic_vector(31 downto 0);
    signal RD3E : std_logic_vector(31 downto 0);
    signal RSE : std_logic_vector(4 downto 0);
    signal RTE : std_logic_vector(4 downto 0);
    signal RDE : std_logic_vector(4 downto 0);
    signal SignImmE : std_logic_vector(31 downto 0);
    --signal PCBranchD : std_logic_vector( 31 downto 0);
    signal BranchD: std_logic;
    signal RegWriteE : STD_LOGIC;
    signal MemtoRegE : STD_LOGIC;
    signal MemWriteE : STD_LOGIC;
    signal ALUControlE : STD_LOGIC_VECTOR( 2 downto 0);
    signal ALUSrcE : STD_LOGIC;
    signal RegDstE : STD_LOGIC;
    
    -- signal for the execute stage
    --signal RegWriteE : STD_LOGIC;
    --signal MemtoRegE : STD_LOGIC;
    --signal MemWriteE : STD_LOGIC;
    --signal ALUControlE : STD_LOGIC_VECTOR (2 downto 0);
    --signal ALUSrcE : STD_LOGIC;
    --signal RegDstE : STD_LOGIC;
    --signal RD1E : STD_LOGIC_VECTOR (31 downto 0);
    --signal RD2E : STD_LOGIC_VECTOR (31 downto 0);
    --signal RD3E : STD_LOGIC_VECTOR (31 downto 0);
    --signal RsE : STD_LOGIC_VECTOR (4 downto 0);
    --signal RtE : STD_LOGIC_VECTOR (4 downto 0);
    --signal RdE : STD_LOGIC_VECTOR (4 downto 0);
    --signal SignImmE : STD_LOGIC_VECTOR (31 downto 0);
    --signal CLR : STD_LOGIC;
    --signal nEN : in STD_LOGIC;
    signal forwardAE : std_logic_vector(1 downto 0);
    signal forwardBE : std_logic_vector(1 downto 0);
    signal forwardCE : std_logic_vector(1 downto 0);
    --signal ResultW : std_logic_vector(31 downto 0);
    --WriteRegE : inout std_logic_vector(4 downto 0);
    signal RegWriteM : STD_LOGIC;
    signal MemtoRegM : STD_LOGIC;
    signal MemWriteM : STD_LOGIC;
    signal ALUOutM : STD_LOGIC_VECTOR (31 downto 0);
    signal WriteDataM : STD_LOGIC_VECTOR (31 downto 0);
    signal WriteRegM : STD_LOGIC_VECTOR (4 downto 0);
    
    -- signals for mem stage
    --signal RegWriteM : STD_LOGIC;
    --signal MemtoRegM : STD_LOGIC;
    --signal MemWriteM : STD_LOGIC;
    --signal ALUOutM : STD_LOGIC_VECTOR (31 downto 0);
    --signal WriteDataM : STD_LOGIC_VECTOR (31 downto 0);
    --signal WriteRegM : STD_LOGIC_VECTOR (4 downto 0);
    signal RegWriteW : STD_LOGIC;
    signal MemtoRegW : STD_LOGIC;
    signal ReadDataW : STD_LOGIC_VECTOR (31 downto 0);
    signal ALUOutW : STD_LOGIC_VECTOR (31 downto 0);
    signal WriteRegW : STD_LOGIC_VECTOR (4 downto 0);
    
    -- signals for the write back stage
    --signal RegWriteW : STD_LOGIC;
    --signal MemtoRegW : STD_LOGIC;
    --signal ReadDataW : STD_LOGIC_VECTOR (31 downto 0);
    --signal ALUOutW : STD_LOGIC_VECTOR (31 downto 0);
    --signal WriteRegW : STD_LOGIC_VECTOR (4 downto 0);
    --signal ResultW : STD_LOGIC_VECTOR (31 downto 0)
    
    -- signals for the hazard unit 
    --signal BranchD : STD_LOGIC;
    --signal RsE : STD_LOGIC_VECTOR (4 downto 0);
    --signal RtE : STD_LOGIC_VECTOR (4 downto 0);
    --signal RdE : STD_LOGIC_VECTOR (4 downto 0);
    --signal ALUControlE : STD_LOGIC_VECTOR (2 downto 0);
    --signal ALUSrcE : STD_LOGIC;
    --signal WriteRegM : STD_LOGIC_VECTOR (4 downto 0);
    --signal MemtoRegM : STD_LOGIC;
    --signal RegWriteM : STD_LOGIC;
    --signal WriteRegW : STD_LOGIC_VECTOR (4 downto 0);
    --signal RegWriteW : STD_LOGIC;
    --signal StallF : STD_LOGIC;
    --signal StallD : STD_LOGIC;
    signal StallE : STD_LOGIC;
    signal FlushE : STD_LOGIC;
    signal FlushM : STD_LOGIC;
    --signal ForwardAE : STD_LOGIC_VECTOR (1 downto 0);
    --signal ForwardBE : STD_LOGIC_VECTOR (1 downto 0);
    --signal ForwardCE : STD_LOGIC_VECTOR (1 downto 0);

begin

    fs: fetch_stage port map(clk, PCBranchD, StallF, StallD, PCSrcD, instD, PCPlus1D);
    ds: decode_stage port map(clk, FlushE, StallE, InstrD, WA, WD, PCPlus1D, WE, ResultW, PCSrcD, RD1E, RD2E, RD3E, RSE, RTE, 
                              RDE, SignImmE, PCBranchD, BranchD, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE);
    es: execute_stage port map(clk, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, RD1E, RD2E, RD3E, RsE, RtE, RdE, SignImmE,
                               FlushM, forwardAE, forwardBE, forwardCE, ResultW, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM);
    me: mem_stage port  map (clk, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM, RegWriteW, MemtoRegW, 
                             ReadDataW, ALUOutW, WriteRegW);
    wbs: writeback_stage port map (RegWriteW, MemtoRegW, ReadDataW, ALUOutw, WriteRegW, ResultW);
    hazard: hazard_unit port map (BranchD, RsE, RtE, RdE, ALUControlE, ALUSrcE, WriteRegM, MemtoRegM, RegWriteM,
                                  WriteRegW, RegWriteW, StallF, StallD, StallE, FlushE, FlushM, forwardAE, forwardBE, forwardCE);                 

end Behavioral;
