----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2022 01:25:42 AM
-- Design Name: 
-- Module Name: pipe_reg_DE - Behavioral
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

entity pipe_reg_DE is
    Port ( clk : in std_logic;
           CLR : in STD_LOGIC;
           nEN : in std_logic;
           RegWriteD : in STD_LOGIC;
           MemtoRegD : in STD_LOGIC;
           MemWriteD : in STD_LOGIC;
           ALUControlD : in STD_LOGIC_VECTOR(2 downto 0);
           ALUSrcD : in STD_LOGIC;
           RegDstD : in STD_LOGIC;
           RD1D : in STD_LOGIC_VECTOR (31 downto 0);
           RD2D : in STD_LOGIC_VECTOR (31 downto 0);
           RD3D : in STD_LOGIC_VECTOR (31 downto 0);
           RsD : in STD_LOGIC_VECTOR (4 downto 0);
           RtD : in STD_LOGIC_VECTOR (4 downto 0);
           RdD : in STD_LOGIC_VECTOR (4 downto 0);
           SignImmD : in STD_LOGIC_VECTOR (31 downto 0);
           RegWriteE : out STD_LOGIC;
           MemtoRegE : out STD_LOGIC;
           MemWriteE : out STD_LOGIC;
           ALUControlE : out STD_LOGIC_VECTOR( 2 downto 0);
           ALUSrcE : out STD_LOGIC;
           RegDstE : out STD_LOGIC;
           RD1E : out STD_LOGIC_VECTOR (31 downto 0);
           RD2E : out STD_LOGIC_VECTOR (31 downto 0);
           RD3E : out STD_LOGIC_VECTOR (31 downto 0);
           RsE : out STD_LOGIC_VECTOR (4 downto 0);
           RtE : out STD_LOGIC_VECTOR (4 downto 0);
           RdE : out STD_LOGIC_VECTOR (4 downto 0);
           SignImmE : out STD_LOGIC_VECTOR (31 downto 0));
end pipe_reg_DE;

architecture Behavioral of pipe_reg_DE is

    signal EN : std_logic;
    signal startup : std_logic := '1';
    signal rst : std_logic := '0';
    
begin

    EN <= not nEN;
    
    process 
    begin
        rst <= '1'; wait for 10ps; rst <= '0'; wait;
    end process;

    process(clk, rst)
    begin
    
        if (startup = '1')then
            RegWriteE <= '0';
            MemtoRegE <= '0';
            MemWriteE <= '0';
            ALUControlE <= "000";
            ALUSrcE <= '0';
            RegDstE <= '0';
            RD1E <= (others => '0');
            RD2E <= (others => '0');
            RD3E <= (others => '0');
            RsE <= "00000";
            RtE <= "00000";
            RdE <= "00000";
            SignImmE <= (others => '0');
            startup <= '0';
        end if;
        
        if( EN = '1') then 
            if(clk'event and clk = '1') then
                if(CLR = '1') then 
                    RegWriteE <= '0';
                    MemtoRegE <= '0';
                    MemWriteE <= '0';
                    ALUControlE <= "000";
                    ALUSrcE <= '0';
                    RegDstE <= '0';
                    RD1E <= (others => '0');
                    RD2E <= (others => '0');
                    RD3E <= (others => '0');
                    RsE <= "00000";
                    RtE <= "00000";
                    RdE <= "00000";
                    SignImmE <= (others => '0');
                else 
                    RegWriteE <= RegWriteD;
                    MemtoRegE <= MemtoRegD;
                    MemWriteE <= MemWriteD;
                    ALUControlE <= ALUControlD;
                    ALUSrcE <= ALUSrcD;
                    RegDstE <= RegDstD;
                    RD1E <= RD1D;
                    RD2E <= RD2D;
                    RD3E <= RD3D;
                    RsE <= RsD;
                    RtE <= RtD;
                    RdE <= RdD;
                    SignImmE <= SignImmD;
                end if;
            end if;
        end if;
        
    end process;


end Behavioral;
