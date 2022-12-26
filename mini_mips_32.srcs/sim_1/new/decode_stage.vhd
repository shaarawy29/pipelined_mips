----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 08:04:55 PM
-- Design Name: 
-- Module Name: decode_stage - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 

-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity decode_stage is
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
       RegDstE : out STD_LOGIC 
       ) ;
end decode_stage;

architecture Behavioral of decode_stage is
Component Adder is
  Port (A,B: in std_logic_vector(31 downto 0);
        out_address : out std_logic_vector(31 downto 0));
end component;

Component control_unit is
    Port ( opcode : in STD_LOGIC_VECTOR (5 downto 0);
           RegWrite : out STD_logic;
           MemtoReg : out std_logic;
           MemWrite : out std_logic;
           ALUControl : out std_logic_vector (2 downto 0);
           ALUSrc : out std_logic;
           RegDst : out std_logic;
           Branch : out std_logic);
end Component;

Component pipe_reg_DE is
    Port ( clk : in std_logic;
           CLR : in STD_LOGIC;
           nEN : in std_logic;
           Reg_WriteD : in STD_LOGIC;
           MemtoRegD : in STD_LOGIC;
           MemWriteD : in STD_LOGIC;
           ALUControlD : in STD_LOGIC_VECTOR(2 downto 0);
           ALUSrcD : in STD_LOGIC;
           RegDstD : in STD_LOGIC;
           RD1D : in STD_LOGIC_VECTOR (31 downto 0);
           RD2D : in STD_LOGIC_VECTOR (31 downto 0);
           RD3D : in STD_LOGIC_VECTOR (31 downto 0);
           RsD : in STD_LOGIC_VECTOR (4 downto 0);
           RtD : in STD_LOGIC_VECTOR (4 downto 0);
           RdD : in STD_LOGIC_VECTOR (4 downto 0);
           SignImmD : in STD_LOGIC_VECTOR (31 downto 0);
           Reg_WriteE : out STD_LOGIC;
           MemtoRegE : out STD_LOGIC;
           MemWriteE : out STD_LOGIC;
           ALUControlE : out STD_LOGIC_VECTOR( 2 downto 0);
           ALUSrcE : out STD_LOGIC;
           RegDstE : out STD_LOGIC;
           RD1E : out STD_LOGIC_VECTOR (31 downto 0);
           RD2E : out STD_LOGIC_VECTOR (31 downto 0);
           RD3E : out STD_LOGIC_VECTOR (31 downto 0);
           RsE : out STD_LOGIC_VECTOR (4 downto 0);
           RtE : out STD_LOGIC_VECTOR (4 downto 0);
           RdE : out STD_LOGIC_VECTOR (4 downto 0);
           SignImmE : out STD_LOGIC_VECTOR (31 downto 0));
end component;

Component reg_file is
    Port ( nclk : in STD_LOGIC; -- negative clk, it is triggered at the negative edge of the clk
           WE : in STD_LOGIC; -- write enable pin, to enable write in the WA register 
           RA1 : in STD_LOGIC_VECTOR (4 downto 0); -- address of the first operand, source register 
           RA2 : in STD_LOGIC_VECTOR (4 downto 0); -- address of the second operand, target register 
           RA3 : in STD_LOGIC_VECTOR (4 downto 0); -- address of the third register, destination register, it is only used in case of weight Inst, to make W3 = Rd 
           WA : in STD_LOGIC_VECTOR (4 downto 0); -- Write adress, the address of the target or the distination depends on the opcode
           WD : in STD_LOGIC_VECTOR (31 downto 0); -- Write date, the date to be writen in the WA address
           RD1 : out STD_LOGIC_VECTOR (31 downto 0); -- Read data 1, the date stored in RA1 source register 
           RD2 : out STD_LOGIC_VECTOR (31 downto 0); -- Read data 2, the data stored in the RA2 target register 
           RD3 : out STD_LOGIC_VECTOR (31 downto 0)); -- Read data 3, the data stored in the RA3, destination reg, it is only used in case of weight Inst
end Component;

component sign_Extend is
  Port (in1:in std_logic_vector(15 downto 0);
        out1: out std_logic_vector(31 downto 0));
end component;


Signal RegWriteD :  STD_logic;
Signal MemtoRegD : std_logic;
Signal MemWriteD :  std_logic;
Signal ALUControlD :  std_logic_vector (2 downto 0);
Signal ALUSrcD :  std_logic;
Signal RegDstD :  std_logic;
--Signal BranchD :  std_logic;
Signal RD12: std_logic_vector(31 downto 0);
Signal RD22: std_logic_vector(31 downto 0);
Signal RD32: std_logic_vector(31 downto 0);
Signal EqualID: std_logic;
Signal RSD :std_logic_vector (4 downto 0):= (others=>'0');
Signal opcode :std_logic_vector (5 downto 0):= (others=>'0');
Signal RTD :std_logic_vector (4 downto 0):= (others=>'0');
Signal RDD :std_logic_vector (4 downto 0):= (others=>'0');
Signal SignExt :std_logic_vector (15 downto 0):= (others=>'0');
Signal SignImmD: std_logic_vector(31 downto 0);
Signal zeros : std_logic_vector(31 downto 0) := X"00000000";


begin
RSD<=InstrD(25 downto 21);
opcode<=InstrD(31 downto 26);
RTD<=InstrD(20 downto 16);
RDD<=InstrD(15 downto 11);
SignExt<=InstrD(15 downto 0);
CU: control_unit port map (opcode,RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,BranchD);
RF: reg_file port map (clk,WE,RSD,RTD,RDD,WA,WD,RD12,RD22,RD32); --take care that it is clk instead of nclk to be handled in reg_file component
SE: sign_extend port map( SignExt,SignImmD);
AA: adder port map (SignImmD,PCPlus1D,PCBranchD);
--EqualID<=RD12;
PipeReg: pipe_reg_DE port map ( clk,CLR,nEN,RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,RD12,RD22,RD32,RSD,RTD,RDD,SignImmD,
                                RegWriteE,MemtoRegE,MemWriteE,ALUControlE,ALUSrcE,RegDstE,RD1E,RD2E,RD3E,RSE,RTE,RDE,SignImmE);


--PCSrcD <= ( BranchD and (RD12 = zeros));
PCSrcD <= '1' when (BranchD = '1' and (RD12 = zeros)) else '0'; 

-- RD12 is EqualID on the drawing
--PCSrcD<=BranchD and ;
--pipe: pipe_reg_DE port map (clk,CLR,nEN,RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,RD12,RD22,RD32,RS,RT,RD,signImmD,RegWriteE,MemtoRegE,MemWriteE,ALUControlE,ALUSrcE,RegDstE);
--RF: reg_file port map (not clk,WE,RS,RT,RD`,WA,WD,RD1,RD2,RD3);

end Behavioral;