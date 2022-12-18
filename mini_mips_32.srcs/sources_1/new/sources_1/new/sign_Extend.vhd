----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 08:03:12 PM
-- Design Name: 
-- Module Name: sign_Extend - Behavioral
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

entity sign_Extend is
  Port (in1:in std_logic_vector(4 downto 0);out1: out std_logic_vector(31 downto 0));
end sign_Extend;

architecture Behavioral of sign_Extend is

begin
out1<=(3 => in1(3), 2 => in1(2), 1 => in1(1), 0 => in1(0), others => in1(3));


end Behavioral;
