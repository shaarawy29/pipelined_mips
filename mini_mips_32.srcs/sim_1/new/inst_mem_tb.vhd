----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2022 01:46:17 PM
-- Design Name: 
-- Module Name: inst_mem_tb - Behavioral
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

entity inst_mem_tb is
--  Port ( );
end inst_mem_tb;

architecture Behavioral of inst_mem_tb is

    component inst_mem is 
        Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
               inst : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    signal A : std_logic_vector (4 downto 0) := "00000";
    signal inst : std_logic_vector (31 downto 0);
    
begin

    uut: inst_mem port map(A, inst);

    process
        begin
            wait for 4ns;
            A <= "00001"; wait for 4ns;
            A <= "00010"; wait for 4ns;
            A <= "00011"; wait for 4ns;
            A <= "00100"; wait for 4ns;
            A <= "00101"; wait;
            
    end process;
    
end Behavioral;
