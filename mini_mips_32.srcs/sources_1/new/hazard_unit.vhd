----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 09:28:59 PM
-- Design Name: 
-- Module Name: hazard_unit - Behavioral
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

entity hazard_unit is
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
end hazard_unit;

architecture Behavioral of hazard_unit is

    signal Stall : std_logic := '0';    

begin
    
    -- stall when there is lw inst followed by an inst using this data 
    -- first check if the mem stage are going to write in reg, and if the address is the same as the ALU srcA wants
    Stall <= '1' when RegWriteM = '1' and MemtoRegM = '1' and WriteRegM = RsE else
             '1' when RegWriteM = '1' and MemtoRegm = '1' and WriteRegM = RtE and ALUSrcE = '0' else -- check for the target register, same as rs except that we also check that it is going to be read not write in
             '1' when RegWriteM = '1' and MemtoRegM = '1' and WriteRegM = RdE and AlUControlE = "100" else -- check for the third operad, which is only used in case of weight inst
             '0';
     -- to stall the first three stages thus no new instruction enter the pipeline        
    StallF <= Stall;
    StallD <= Stall;
    StallE <= Stall;
    FlushM <= Stall;
    
    
    -- forward unit for SRCA, if the mem stage write A take it from Mem, if not then if the wb stage write it then take it from there, if not then no hazard
    -- as the write occurs in the fist half of the cycle and read occurs in the second half 
    ForwardAE <= "10" when RegWriteM = '1' and MemtoRegM = '0' and WriteRegM = RsE else
                 "01" when RegWriteW = '1' and WriteRegW = RsE else
                 "00";
    
    -- same logic here as SRCA except that we make extra check that this reg is going to be read              
    ForwardBE <= "10" when RegWriteM = '1' and MemtoRegM = '0' and WriteRegM = RtE and ALUSrcE = '0' else
                 "01" when RegWriteW = '1' and WriteRegW = RtE and ALUSrcE = '0' else
                 "00";
    
    -- same logic as SRCA, but here we only use RDC in case weight inst, thus to check if we are going to use it
    ForwardCE <= "10" when RegWriteM = '1' and MemtoRegM = '0' and WriteRegM = RdE and ALUControlE = "100" else
                 "01" when RegWriteW = '1' and WriteRegW = RdE and ALUControlE = "100" else
                 "00";
     
     -- if there is branch then no way to solve it except flush the false inst entered the pipeline            
    FlushE <= '1' when BranchD = '1' else '0';
    
end Behavioral;
