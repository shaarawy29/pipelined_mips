----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2022 01:45:39 PM
-- Design Name: 
-- Module Name: mips_top_tb - Behavioral
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

entity mips_top_tb is
--  Port ( );
end mips_top_tb;

architecture Behavioral of mips_top_tb is

    component mips_top is 
        port (clk : in std_logic;
              writeresult_out : out std_logic_vector(31 downto 0));
   end component;

    signal clk: std_logic := '0';
    signal writeresult_out: std_Logic_vector(31 downto 0) := (others => '0');
    
begin

process 
begin
    clk  <= not clk;
    wait for 10ns;
end process;

mips: mips_top port map(clk, writeresult_out);


end Behavioral;
