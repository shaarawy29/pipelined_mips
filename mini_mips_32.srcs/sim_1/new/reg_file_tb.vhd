----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 02:50:48 PM
-- Design Name: 
-- Module Name: reg_file_tb - Behavioral
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

entity reg_file_tb is
--  Port ( );
end reg_file_tb;

architecture Behavioral of reg_file_tb is

component reg_file is 
    Port ( rst : in std_logic;
           clk : in STD_LOGIC;
           WE : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           RA3 : in STD_LOGIC_VECTOR (4 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0);
           RD3 : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal clk, WE, rst : std_logic;
signal RD1, RD2, RD3, WD : std_logic_vector(31 downto 0) := X"00000000";
signal RA1, RA2, RA3, WA : std_logic_vector(4 downto 0) := "00000";

begin

    uut: reg_file port map(rst, clk, WE, RA1, RA2, RA3, WA, WD, RD1, RD2, RD3);

process

    begin
        clk <= '0'; wait for 2ns;
        clk <= '1'; wait for 2ns;
    end process;

    process
        begin 
            rst <= '1'; wait for 3ns; rst <= '0'; 
            WE <= '1'; WA <= "00001"; WD <= X"00000001"; RA1 <= "00001"; wait for 4ns;
            WE <= '1'; WA <= "00010"; WD <= X"0000000A"; RA1 <= "00001"; RA2 <= "00010"; wait for 4ns;
            WE <= '1'; WA <= "00011"; WD <= X"0000000F"; RA1 <= "00001"; RA2 <= "00010"; RA3 <= "00011"; wait for 4ns;
            WE <= '0'; RA1 <= "00000"; RA2 <= "00001"; RA3 <= "00010"; wait for 4ns;
            RA1 <= "00011"; wait;
        
    end process;

end Behavioral;
