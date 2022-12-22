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
           ForwardAE : out STD_LOGIC_VECTOR (1 downto 0);
           ForwardBE : out STD_LOGIC_VECTOR (1 downto 0);
           ForwardCE : out STD_LOGIC_VECTOR (1 downto 0));
end hazard_unit;

architecture Behavioral of hazard_unit is

    signal Stall : std_logic := '0';    

begin

    Stall <= '1' when RegWriteM = '1' and MemtoRegM = '1' and WriteRegM = RsE else
             '1' when RegWriteM = '1' and MemtoRegm = '1' and WriteRegM = RtE and ALUSrcE = '0' else
             '1' when RegWriteM = '1' and MemtoRegM = '1' and WriteRegM = RdE and AlUControlE = "100" else
             '0';
             
    StallF <= Stall;
    StallD <= Stall;
    StallE <= Stall;
    
    
    ForwardAE <= "01" when RegWriteM = '1' and MemtoRegM = '0' and WriteRegM = RsE else
                 "10" when RegWriteW = '1' and WriteRegW = RsE else
                 "00";
                 
    ForwardBE <= "01" when RegWriteM = '1' and MemtoRegM = '0' and WriteRegM = RtE and ALUSrcE = '0' else
                 "10" when RegWriteW = '1' and WriteRegW = RtE and ALUSrcE = '0' else
                 "00";
    
    ForwardCE <= "01" when RegWriteM = '1' and MemtoRegM = '0' and WriteRegM = RdE and ALUControlE = "100" else
                 "10" when RegWriteW = '1' and WriteRegW = RdE and ALUControlE = "100" else
                 "00";
                 
    FlushE <= '1' when BranchD = '1' else '0';
    
end Behavioral;
