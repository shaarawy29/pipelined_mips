----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 12:08:39 AM
-- Design Name: 
-- Module Name: generic_reg - Behavioral
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

entity generic_reg is
    generic(w : integer);
    Port ( clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR(w-1 downto 0);
           q : out STD_LOGIC_VECTOR(w-1 downto 0));
end generic_reg;

architecture Behavioral of generic_reg is

begin

    process(clk)
    begin
        if(clk'event and clk = '1')then 
            q <= d;
        end if;
    end process;

end Behavioral;
