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
    Port ( RegWriteW : inout STD_LOGIC;
           MemtoRegW : in STD_LOGIC;
           ReadDataW : in STD_LOGIC_VECTOR (31 downto 0);
           ALUOutW : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegW : inout STD_LOGIC_VECTOR (4 downto 0);
           ResultW : out STD_LOGIC_VECTOR (31 downto 0));
end writeback_stage;

architecture Behavioral of writeback_stage is

begin

    ResultW <= ReadDataW when MemtoRegW = '1' else
               ALUOutW;

end Behavioral;
