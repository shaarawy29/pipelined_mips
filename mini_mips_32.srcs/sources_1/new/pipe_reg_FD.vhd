----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2022 01:01:58 AM
-- Design Name: 
-- Module Name: pipe_reg_FD - Behavioral
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

entity pipe_reg_FD is
    Port ( instF : in STD_LOGIC_VECTOR (31 downto 0);
           PCPlus1F : in STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           CLR : in STD_LOGIC;
           nEN : in STD_LOGIC;
           instD : out STD_LOGIC_VECTOR (31 downto 0);
           PCPlus1D : out STD_LOGIC_VECTOR (31 downto 0));
end pipe_reg_FD;

architecture Behavioral of pipe_reg_FD is
    
    signal EN : std_logic;
   
begin
    
    EN <= not nEN;

    process(clk)
            variable startup : boolean := true;
        begin
        
            if (startup = true)then
                instD <= (others => '0');
                PCPlus1D <= (others => '0');
                startup := false;
            end if;
            
            if(EN = '1') then
                if( clk'event and clk = '1') then
                    instD <= instF;
                    PCPlus1D <= PCPlus1F;
                    if(CLR = '1') then
                        instD <= (others => '0');
                        PCPlus1D <= (others => '0');
                    end if;
                end if;
            end if;
            
    end process;

end Behavioral;
