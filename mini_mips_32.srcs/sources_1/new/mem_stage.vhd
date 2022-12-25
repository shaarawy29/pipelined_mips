----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2022 10:11:45 PM
-- Design Name: 
-- Module Name: mem_stage - Behavioral
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

entity mem_stage is
    Port ( clk : in STD_LOGIC;
           RegWriteM : in STD_LOGIC;
           MemtoRegM : in STD_LOGIC;
           MemWriteM : in STD_LOGIC;
           ALUOutM : in STD_LOGIC_VECTOR (31 downto 0);
           WriteDataM : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegM : in STD_LOGIC_VECTOR (4 downto 0);
           RegWriteW : out STD_LOGIC;
           MemtoRegW : out STD_LOGIC;
           ReadDataW : out STD_LOGIC_VECTOR (31 downto 0);
           ALUOutW : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegW : out STD_LOGIC_VECTOR (4 downto 0));
end mem_stage;

architecture Behavioral of mem_stage is

    component Data_memory is 
        Port ( clk,WE : in std_logic; 
               A : in std_logic_vector(31 downto 0);
               WD :in std_logic_vector(31 downto 0);
               RD : out std_logic_vector(31 downto 0));
    end component;
    
    component pipe_reg_MW is 
        Port ( clk : in std_logic;
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
    end component;
    
    signal RD_internal : std_logic_vector(31 downto 0);
    signal nclk : std_logic;

begin

    nclk <= not clk;
    RAM: Data_memory port map (clk, MemWriteM, ALUOutM, WriteDataM, RD_internal);
    reg: pipe_reg_MW port map (clk, RegWriteM, MemtoRegM, RD_internal, ALUOutM,
                                WriteRegM, RegWriteW, MemtoRegW, ReadDataW, AlUOutW, WriteRegW);


end Behavioral;
