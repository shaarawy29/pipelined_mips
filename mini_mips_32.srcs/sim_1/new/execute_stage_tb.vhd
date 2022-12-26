----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2022 01:25:04 AM
-- Design Name: 
-- Module Name: execute_stage_tb - Behavioral
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

entity execute_stage_tb is
--  Port ( );
end execute_stage_tb;

architecture Behavioral of execute_stage_tb is
    
    component execute_stage is 
        Port ( rst : in std_logic;
               clk : in STD_LOGIC;
               RegWriteE : in STD_LOGIC;
               MemtoRegE : in STD_LOGIC;
               MemWriteE : in STD_LOGIC;
               ALUControlE : in STD_LOGIC_VECTOR (2 downto 0);
               ALUSrcE : in STD_LOGIC;
               RegDstE : in STD_LOGIC;
               RD1E : in STD_LOGIC_VECTOR (31 downto 0);
               RD2E : in STD_LOGIC_VECTOR (31 downto 0);
               RD3E : in STD_LOGIC_VECTOR (31 downto 0);
               RsE : in STD_LOGIC_VECTOR (4 downto 0);
               RtE : in STD_LOGIC_VECTOR (4 downto 0);
               RdE : in STD_LOGIC_VECTOR (4 downto 0);
               SignImmE : in STD_LOGIC_VECTOR (31 downto 0);
               CLR : in STD_LOGIC;
               --nEN : in STD_LOGIC;
               forwardAE : in std_logic_vector(1 downto 0);
               forwardBE : in std_logic_vector(1 downto 0);
               forwardCE : in std_logic_vector(1 downto 0);
               ResultW : in std_logic_vector(31 downto 0);
               --WriteRegE : inout std_logic_vector(4 downto 0);
               RegWriteM : out STD_LOGIC;
               MemtoRegM : out STD_LOGIC;
               MemWriteM : out STD_LOGIC;
               ALUOutM : inout STD_LOGIC_VECTOR (31 downto 0);
               WriteDataM : out STD_LOGIC_VECTOR (31 downto 0);
               WriteRegM : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    -- execute state signals 
    signal rst : std_logic := '1';
    signal clk : STD_LOGIC := '0';
    signal RegWriteE : STD_LOGIC := '0';
    signal MemtoRegE : STD_LOGIC := '0';
    signal MemWriteE : STD_LOGIC := '0';
    signal ALUControlE : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal ALUSrcE : STD_LOGIC := '0';
    signal RegDstE : STD_LOGIC := '0';
    signal RD1E : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal RD2E : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal RD3E : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal RsE : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal RtE : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal RdE : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal SignImmE : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal CLR : STD_LOGIC := '0';
     --nEN : in STD_LOGIC;
    signal forwardAE : std_logic_vector(1 downto 0) := (others => '0');
    signal forwardBE : std_logic_vector(1 downto 0) := (others => '0');
    signal forwardCE : std_logic_vector(1 downto 0) := (others => '0');
    signal ResultW : std_logic_vector(31 downto 0) := (others => '0');
     --WriteRegE : inout std_logic_vector(4 downto 0);
    signal RegWriteM : STD_LOGIC;
    signal MemtoRegM : STD_LOGIC;
    signal MemWriteM : STD_LOGIC;
    signal ALUOutM : STD_LOGIC_VECTOR (31 downto 0);
    signal WriteDataM : STD_LOGIC_VECTOR (31 downto 0);
    signal WriteRegM : STD_LOGIC_VECTOR (4 downto 0);
    
begin

    uut: execute_stage port map (rst, clk, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, RD1E, RD2E, RD3E, RsE, RtE, RdE, SignImmE,
                                 CLR, forwardAE, forwardBE, forwardCE, ResultW, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM);

    clk_process: process
    begin 
        clk <= not clk; wait for 5ns;
    end process;
    
    stimulus_process: process 
    begin
        rst <= '1'; wait for 13ns; rst <= '0';
        RegWriteE <= '1'; MemtoRegE <= '0'; MemWriteE <= '0'; ALUControlE <= "000"; ALUSrcE <= '0'; RegDstE <= '1';
        RD1E <= X"10000001"; RD2E <= X"11000000"; RD3E <= X"00110011";
        RsE <= "00011"; RtE <= "00001"; RdE <= "00010"; SignImmE <= X"00000111"; CLR <= '0';
        forwardAE <= "00"; forwardBE <= "00"; forwardCE <= "00";
        ResultW <= X"11111111"; wait for 10ns;
        forwardAE <= "10"; wait for 10ns;
        forwardBE <= "01"; wait for 10ns;
        forwardAE <= "00"; forwardBE <= "00"; wait for 10ns;
        ALUSrcE <= '1'; RegDstE <= '0'; wait;
        
    end process;  

end Behavioral;
