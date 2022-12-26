library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Data_memory_tb is
end Data_memory_tb;

architecture Behavioral of Data_memory_tb is

component Data_memory is
     Port (rst : in std_logic;
            clk,WE : in std_logic; 
            A : in std_logic_vector(31 downto 0);
            WD :in std_logic_vector(31 downto 0);
            RD : out std_logic_vector(31 downto 0));
end component;

    signal rst : std_logic := '1';
    signal clk, WE : std_logic := '0';
    signal A,WD : std_logic_vector(31 downto 0) := (others => '0');
    signal RD : std_logic_vector(31 downto 0);     

begin
uut: Data_memory port map(rst,clk,WE, A,WD,RD);

clock_process: process
begin
    clk <= not clk; wait for 5ns;
end process; 

stimulus_process: process
begin
    rst <= '1'; wait for 10ns; rst <= '0';
    WE <= '0'; A <= X"00000000"; wait for 10ns;
    A <= X"00000001"; wait for 10ns;
    WE <= '1'; A <= X"00000000"; WD <= X"00001111"; wait for 10ns;
    WE <= '0'; wait;
end process;
end Behavioral;
