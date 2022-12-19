----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 01:43:34 PM
-- Design Name: 
-- Module Name: ALU_Unit - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;



entity ALU_Unit is
   Port (SrcA, SrcB,SrcC : in std_logic_vector(31 downto 0);
         ALU_out : out std_logic_vector(31 downto 0);
         ALU_sel : in std_logic_vector(2 downto 0));
end ALU_Unit;

architecture Behavioral of ALU_Unit is

    signal W1, W2, W3:std_logic_vector(31 downto 0);
    signal tmp: std_logic_vector(31 downto 0);

begin
    process (SrcA, SrcB, SrcC, ALU_sel)
    begin 
        case ALU_sel is 
            when "000" => 
                ALU_out <= SrcA + SrcB; -- addition used in ADD, ADDI, LW, SW
            when "001" =>
                ALU_out <= SrcA - SrcB; -- subtraction used in SUB, SUBI
            when "010" =>
                ALU_out <= SrcA and SrcB; -- AND operation 
            when "011" =>
                ALU_out <= SrcA or SrcB; -- OR operation
            when "100" => -- weight instruction to update W1, W2, W3
                W1 <= SrcA;
                W2 <= SrcB;
                W3 <= SrcC;
            when "101" => -- ANN instruction to use the feedback tmp 
                ALU_out <= W1*SrcA + W2*SrcB + W3*tmp;
                tmp <= W1*SrcA + W2*SrcB + W3*tmp;
            when others => -- in case of undefiend signal is in 
                ALU_out <= (others => 'X');
        end case;
        
    end process;
end Behavioral;