----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2022 07:59:47 PM
-- Design Name: 
-- Module Name: generic_reg_tb - Behavioral
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

entity generic_reg_tb is
--  Port ( );
end generic_reg_tb;

architecture Behavioral of generic_reg_tb is

    component generic_reg is
        generic(w : integer);
        Port ( clk : in STD_LOGIC;
               nEN : in std_logic;
               d : in STD_LOGIC_VECTOR(w-1 downto 0);
               q : out STD_LOGIC_VECTOR(w-1 downto 0));
    end component;
    
    signal clk : std_logic := '1';
    signal nEN : std_logic := '0';
    signal d, q : std_logic_vector(31 downto 0) := (others => '0');

begin

    uut: generic_reg generic map (32) port map(clk, nEN, d, q);
    
    clk_process: process
    begin
        clk <= not clk; wait for 5ns;
    end process;
    
    stimulus_proc: process
    begin 
        d <= X"00000011"; wait for 6ns;
        d <= X"01010101"; wait for 10ns;
        d <= X"11111111"; wait for 10ns;
    end process;

end Behavioral;
