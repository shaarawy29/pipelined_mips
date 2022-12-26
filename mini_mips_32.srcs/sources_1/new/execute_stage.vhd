----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 07:54:34 PM
-- Design Name: 
-- Module Name: execute_stage - Behavioral
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

entity execute_stage is
    Port ( rst : in std_logic;
           clk : in STD_LOGIC;
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
end execute_stage;

architecture Behavioral of execute_stage is
    
    component ALU_Unit is 
        Port ( rst : in std_logic;
               SrcA, SrcB,SrcC : in std_logic_vector(31 downto 0);
               ALU_out : out std_logic_vector(31 downto 0);
               ALU_sel : in std_logic_vector(2 downto 0));
    end component;
    
    component pipe_reg_EM is 
        Port ( rst : in std_logic;
               clk : in std_logic;
               CLR : in STD_LOGIC;
               RegWriteE : in STD_LOGIC;
               MemtoRegE : in STD_LOGIC;
               MemWriteE : in STD_LOGIC;
               ALUOutE : in STD_LOGIC_VECTOR (31 downto 0);
               WriteDataE : in STD_LOGIC_VECTOR (31 downto 0);
               WriteRegE : in STD_LOGIC_VECTOR (4 downto 0);
               RegWriteM : out STD_LOGIC;
               MemtoRegM : out STD_LOGIC;
               MemWriteM : out STD_LOGIC;
               ALUOutM : out STD_LOGIC_VECTOR (31 downto 0);
               WriteDataM : out STD_LOGIC_VECTOR (31 downto 0);
               WriteRegM : out STD_LOGIC_VECTOR (4 downto 0));
    end component;   
    
    signal WriteRegE : std_logic_vector(4 downto 0) := (others => '0');
    signal operandB : std_logic_vector (31 downto 0) := (others => '0');  
    signal SrcAE : std_logic_vector(31 downto 0) := (others => '0');
    signal SrcBE : std_logic_vector(31 downto 0) := (others => '0');
    signal SrcCE : std_logic_vector(31 downto 0) := (others => '0');
    signal WriteDataE : std_logic_vector(31 downto 0) := (others => '0');
    signal ALUOutE : std_logic_vector(31 downto 0) := (others => '0');

begin

    ALU: ALU_Unit port map ( rst, SrcAE, SrcBE, SrcCE, ALUOutE, ALUControlE);
    reg: pipe_reg_EM port map ( rst, clk, CLR, RegWriteE, MemtoRegE, MemWriteE, ALUOutE, WriteDataE, WriteRegE,
                                RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM); 
    
    WriteRegE <= RtE when RegDstE = '0' else
                 RdE;
                 
   SrcAE <= ALUOutM when forwardAE = "10" else
            ResultW when forwardAE = "01" else
            RD1E;
            
   operandB <= ALUOutM when forwardBE = "10" else
               ResultW when forwardBE = "01" else
               RD2E;
            
   SrcBE <= operandB when ALUSrcE = '0' else
            SignImmE;
            
   SrcCE <= ALUOutM when forwardCE = "10" else
            ResultW when forwardCE = "01" else
            RD3E;
            
   WriteDataE <= operandB;

end Behavioral;
