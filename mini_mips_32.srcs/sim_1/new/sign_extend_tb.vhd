----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 08:12:51 PM
-- Design Name: 
-- Module Name: sign_extend_tb - Behavioral
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

entity sign_extend_tb is

end sign_extend_tb;

architecture Behavioral of sign_extend_tb is
component sign_Extend is
  Port (in1:in std_logic_vector(4 downto 0);out1: out std_logic_vector(31 downto 0));
end component;
signal in1: std_logic_vector(4 downto 0);
signal out1:  std_logic_vector(31 downto 0);
begin
uut : sign_extend port map (in1,out1);
process
begin
in1<="00011";wait for 10ps;
in1<="11001";wait for 10ps;
wait;
end process;

end Behavioral;
