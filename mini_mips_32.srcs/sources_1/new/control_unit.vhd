----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2022 09:51:39 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    Port ( rst : in std_logic;
           opcode : in STD_LOGIC_VECTOR (5 downto 0);
           RegWrite : out STD_logic;
           MemtoReg : out std_logic;
           MemWrite : out std_logic;
           ALUControl : out std_logic_vector (2 downto 0);
           ALUSrc : out std_logic;
           RegDst : out std_logic;
           Branch : out std_logic);
    end control_unit;

architecture Behavioral of control_unit is

    signal Control_vector: std_logic_vector(8 downto 0);

    begin

    process(opcode, rst)
    begin
        if(rst = '1') then
            Control_vector <= "000000000";
        else 
            case opcode is
                when "000000" => Control_vector <= "100000010"; -- ADD
                when "000001" => Control_vector <= "100001010"; -- SUB
                when "000010" => Control_vector <= "100000100"; -- ADDI
                when "000011" => Control_vector <= "100001100"; -- SUBI
                when "000100" => Control_vector <= "100010010"; -- AND
                when "000101" => Control_vector <= "100011010"; -- OR
                when "000110" => Control_vector <= "110000100"; -- LW
                when "000111" => Control_vector <= "001000100"; -- SW
                when "001000" => Control_vector <= "000100000"; -- WEIGHT
                when "001001" => Control_vector <= "100101010"; -- ANN
                when "001010" => Control_vector <= "000000001"; -- BEQZ
                when others   => Control_vector <= "000000000"; -----------
            end case;
        end if;
    end process;
    
    RegWrite <= Control_vector(8);
    MemtoReg <= Control_vector(7);
    MemWrite <= Control_vector(6);
    ALUControl <= Control_vector(5 downto 3);
    ALUSrc <= Control_vector(2);
    RegDst <= Control_vector(1);
    Branch <= Control_vector(0);
    

end Behavioral;
