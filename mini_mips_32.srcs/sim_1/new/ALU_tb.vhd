----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2022 12:50:20 AM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

    component ALU_Unit is 
        Port (SrcA, SrcB,SrcC : in std_logic_vector(31 downto 0);
         ALU_out : out std_logic_vector(31 downto 0);
         ALU_sel : in std_logic_vector(2 downto 0));
    end component;
    
    signal SrcA, SrcB, SrcC : std_logic_vector(31 downto 0) := (others => '0');
    signal ALU_Out : std_logic_vector(31 downto 0);
    signal ALU_sel : std_logic_vector (2 downto 0) := (others => '0');

begin
    
    uut: ALU_Unit port map (SrcA, SrcB, SrcC, ALU_out, ALU_sel);
    
    process 
    begin
        SrcA <= X"00000011"; SrcB <= X"00000001"; SrcC <= X"00000010"; ALU_sel <= "000"; wait for 5ns;
        SrcA <= X"00000011"; SrcB <= X"00000001"; SrcC <= X"00000010"; ALU_sel <= "001"; wait for 5ns;
        SrcA <= X"00000011"; SrcB <= X"00000001"; SrcC <= X"00000010"; ALU_sel <= "010"; wait for 5ns;
        SrcA <= X"00000011"; SrcB <= X"00000001"; SrcC <= X"00000010"; ALU_sel <= "011"; wait for 5ns;
        SrcA <= X"00000011"; SrcB <= X"00000001"; SrcC <= X"00000010"; ALU_sel <= "100"; wait for 5ns;
        SrcA <= X"00000011"; SrcB <= X"00000001"; SrcC <= X"00000010"; ALU_sel <= "101"; wait;
        
    end process;


end Behavioral;
