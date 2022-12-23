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

    component inst_mem is 
        Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
               inst : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component generic_reg is 
        generic(w : integer);
        Port ( clk : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR(w-1 downto 0);
               q : out STD_LOGIC_VECTOR(w-1 downto 0));
    end component;
    
    component adder is 
        Port ( A,B: in std_logic_vector(31 downto 0);
               out_address : out std_logic_vector(31 downto 0));
    end component;
    
    component pipe_reg_FD is 
        Port ( instF : in STD_LOGIC_VECTOR (31 downto 0);
               PCplus1F : in STD_LOGIC_VECTOR (4 downto 0);
               clk : in STD_LOGIC;
               CLR : in STD_LOGIC;
               nEN : in STD_LOGIC;
               instD : out STD_LOGIC_VECTOR (31 downto 0);
               PCplus1D : out STD_LOGIC_VECTOR (4 downto 0));
   end component;
   
   component control_unit is 
       Port ( opcode : in STD_LOGIC_VECTOR (5 downto 0);
              RegWrite : out STD_logic;
              emtoReg : out std_logic;
              MemWrite : out std_logic;
              ALUControl : out std_logic_vector (2 downto 0);
              ALUSrc : out std_logic;
              RegDst : out std_logic;
              Branch : out std_logic);
      
   end component;
   
    component reg_file is
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
    end component;
    
    component sign_Extend is 
        Port (in1 : in std_logic_vector(15 downto 0);
              out1 : out std_logic_vector(31 downto 0));
    end component;
    
    component pipe_reg_DE is 
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
    
    component ALU_Unit is 
        Port (SrcA, SrcB,SrcC : in std_logic_vector(31 downto 0);
              ALU_out : out std_logic_vector(31 downto 0);
              ALU_sel : in std_logic_vector(2 downto 0));
    end component;
    
      
    
    -- signal in the fethc stage

begin


end Behavioral;
