----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2022 11:39:39 PM
-- Design Name: 
-- Module Name: writeback_stage - Behavioral
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

entity writeback_stage is
    Port ( rst : in std_logic;
           RegWriteW_in : in STD_LOGIC;
           RegWriteW_out : out STD_LOGIC;
           MemtoRegW_in : in STD_LOGIC;
           MemtoRegW_out : out std_logic;
           ReadDataW : in STD_LOGIC_VECTOR (31 downto 0);
           ALUOutW : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegW_in : in STD_LOGIC_VECTOR (4 downto 0);
           WriteRegW_out : out std_logic_vector(4 downto 0);
           ResultW : out STD_LOGIC_VECTOR (31 downto 0));
end writeback_stage;

architecture Behavioral of writeback_stage is

begin
    
    RegWriteW_out <= '0' when rst = '1' else
                     RegWriteW_in;
                     
    MemtoRegW_out <= '0' when rst = '1' else
                     MemtoRegW_in;
                     
    WriteRegW_out <= "00000" when rst = '1' else
                     WriteRegW_in;

    ResultW <= X"00000000" when rst = '1' else
               ReadDataW when MemtoRegW_in = '1' else
               ALUOutW;

end Behavioral;
