----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2022 07:57:29 PM
-- Design Name: 
-- Module Name: pipe_reg_EM - Behavioral
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

entity pipe_reg_EM is
    Port ( rst : in std_logic;
           clk : in std_logic;
           CLR : in STD_LOGIC;
           RegWriteE : in STD_LOGIC;
           MemtoRegE : in STD_LOGIC;
           MemWriteE : in STD_LOGIC;
           ALUOutE : in STD_LOGIC_VECTOR (31 downto 0);
           WriteDataE : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegE : in STD_LOGIC_VECTOR (4 downto 0);
           RegWriteM : out STD_LOGIC;
           MemtoRegM : out STD_LOGIC;
           MemWriteM : out STD_LOGIC;
           ALUOutM : out STD_LOGIC_VECTOR (31 downto 0);
           WriteDataM : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegM : out STD_LOGIC_VECTOR (4 downto 0));
end pipe_reg_EM;

architecture Behavioral of pipe_reg_EM is

begin

    process(clk, rst)
    begin
        if(rst = '1') then
            RegWriteM <= '0';
            MemtoRegM <= '0';
            MemWriteM <= '0';
            ALUOutM <= (others => '0');
            WriteDataM <= (others => '0');
            WriteRegM <= (others => '0');
        else 
            if(clk'event and clk = '1') then 
                if(CLR = '1') then
                    RegWriteM <= '0';
                    MemtoRegM <= '0';
                    MemWriteM <= '0';
                    ALUOutM <= (others => '0');
                    WriteDataM <= (others => '0');
                    WriteRegM <= (others => '0');
                else 
                    RegWriteM <= RegWriteE;
                    MemtoRegM <= MemtoRegE;
                    MemWriteM <= MemWriteE;
                    ALUOutM <= ALUOutE;
                    WriteDataM <= WriteDataE;
                    WriteRegM <= WriteRegE;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
