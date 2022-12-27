----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2022 01:45:39 PM
-- Design Name: 
-- Module Name: mips_top_tb - Behavioral
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

entity mips_top_tb is
--  Port ( );
end mips_top_tb;

architecture Behavioral of mips_top_tb is

    component mips_top is 
        port (rst : in std_logic;
              clk : in std_logic;
              InstrD_out : out std_logic_vector(31 downto 0);
              SignImmE_out : out std_logic_vector(31 downto 0);
              ALUOutM_out : out std_logic_vector(31 downto 0);
              ResultW_out : out std_logic_vector(31 downto 0);
              RegWriteW_out : out std_logic;
              WriteRegW_out : out std_logic_vector(4 downto 0);
              RegWriteM_out : out std_logic);
   end component;

    signal rst : std_logic := '1';
    signal clk: std_logic := '0';
    signal InstrD_out, SignImmE_out, ALUOutM_out, ResultW_out : std_logic_vector(31 downto 0);
    signal RegWriteW_out : std_logic := '0';
    signal WriteRegW_out : std_logic_vector(4 downto 0) := "00000";
    signal RegWriteM_out : std_logic := '0';
    
begin

    mips: mips_top port map(rst, clk, InstrD_out, SignImmE_out, ALUOutM_out, ResultW_out, RegWriteW_out, WriteRegW_out, RegWriteM_out);
    
    process 
    begin
        clk  <= not clk; wait for 5ns;
    end process;

    process
    begin
        rst <= '1'; wait for 23ns; rst <= '0'; wait;
    end process;


end Behavioral;
