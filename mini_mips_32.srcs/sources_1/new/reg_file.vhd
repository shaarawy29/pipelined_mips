----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 02:10:19 PM
-- Design Name: 
-- Module Name: reg_file - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;   
--use std.textio.all;
use IEEE.std_logic_textio.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
    Port ( clk : in STD_LOGIC;
           WE : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           RA3 : in STD_LOGIC_VECTOR (4 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0);
           RD3 : out STD_LOGIC_VECTOR (31 downto 0));
end reg_file;

architecture Behavioral of reg_file is

type reg_file is array (0 to 31) of std_logic_vector(31 downto 0);
shared variable reg_file1 : reg_file  := (others => X"00000000");

begin

process(clk) 
    begin 
       if ( clk'event and clk = '1') then
            RD1 <= reg_file1(to_integer(unsigned(RA1)));
            RD2 <= reg_file1(to_integer(unsigned(RA2)));
            RD3 <= reg_file1(to_integer(unsigned(RA3)));
            if(WE = '1') then
               reg_file1(to_integer(unsigned(WA))) := WD; 
            end if;
       end if; 
    end process;

end Behavioral;
