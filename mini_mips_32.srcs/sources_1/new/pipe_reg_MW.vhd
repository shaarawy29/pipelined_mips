----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 08:06:06 PM
-- Design Name: 
-- Module Name: pipe_reg_MW - Behavioral
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

entity pipe_reg_MW is
    Port ( rst : in std_logic;
           clk : in std_logic;
           RegWriteM : in STD_LOGIC;
           MemtoRegM : in STD_LOGIC;
           ReadDataM : in STD_LOGIC_VECTOR (31 downto 0);
           ALUOutM : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegM : in STD_LOGIC_VECTOR (4 downto 0);
           RegWriteW : out STD_LOGIC;
           MemtoRegW : out STD_LOGIC;
           ReadDataW : out STD_LOGIC_VECTOR (31 downto 0);
           ALUOutW : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegW : out STD_LOGIC_VECTOR (4 downto 0));
end pipe_reg_MW;

architecture Behavioral of pipe_reg_MW is

begin

    process(clk, rst)    
    begin 
        if (rst = '1') then
            RegWriteW <= '0';
            MemtoRegW <= '0';
            ReadDataW <= (others => '0');
            ALUOutW <= (others => '0');
            WriteRegW <= (others => '0');
        else
            if(clk'event and clk = '1') then 
                RegWriteW <= RegWriteM;
                MemtoRegW <= MemtoRegM;
                ReadDataW <= ReadDataM;
                ALUOutW <= ALUOutM;
                WriteRegW <= WriteRegM;
            end if;
        end if;
    end process;


end Behavioral;
