----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2022 10:13:09 PM
-- Design Name: 
-- Module Name: control_unit_tb - Behavioral
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

entity control_unit_tb is
--  Port ( );
end control_unit_tb;

architecture Behavioral of control_unit_tb is

    component control_unit is
    Port ( opcode : in STD_LOGIC_VECTOR (5 downto 0);
           RegWrite : out STD_logic;
           MemtoReg : out std_logic;
           MemWrite : out std_logic;
           ALUControl : out std_logic_vector (2 downto 0);
           ALUSrc : out std_logic;
           RegDst : out std_logic;
           Branch : out std_logic);
    end component;
    
    signal opcode : std_logic_vector (5 downto 0);
    signal ALUControl : std_logic_vector(2 downto 0);
    signal RegWrite, MemtoReg, MemWrite, ALUSrc, RegDst, Branch : std_logic;

begin

    uut: control_unit port map (opcode, Regwrite, MemtoReg, MemWrite, ALUControl, ALUSrc, RegDst, Branch);

    process begin
        opcode <= "000000"; wait for 4ns;
        opcode <= "000001"; wait for 4ns;
        opcode <= "000010"; wait for 4ns;
        opcode <= "000011"; wait for 4ns;
        opcode <= "000100"; wait for 4ns;
        opcode <= "000101"; wait for 4ns;
        opcode <= "000110"; wait for 4ns;
        opcode <= "000111"; wait for 4ns;
        opcode <= "001000"; wait for 4ns;
        opcode <= "001001"; wait for 4ns;
        opcode <= "001010"; wait;
        
    end process;    

end Behavioral;
