library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Data_memory_tb is
end Data_memory_tb;

architecture Behavioral of Data_memory_tb is
component Data_memory is
     Port (clk,write_enable: in std_logic; address,WD:in std_logic_vector(31 downto 0); RD: out std_logic_vector(31 downto 0);arr_elem1:out std_logic_vector(31 downto 0);arr_elem2:out std_logic_vector(31 downto 0);arr_elem3:out std_logic_vector(31 downto 0));
end component;
signal clk,write_enable : std_logic := '0';
signal address,WD : std_logic_vector(31 downto 0) := (others => '0');
signal RD : std_logic_vector(31 downto 0);     
signal arr_elem1:std_logic_vector(31 downto 0);
signal arr_elem2:std_logic_vector(31 downto 0);
signal arr_elem3:std_logic_vector(31 downto 0);

begin
uut: Data_memory port map(clk,write_enable,address,WD,RD,arr_elem1,arr_elem2,arr_elem3);

clock_process: process
begin
    clk <= '0'; wait for 1ns;
    clk <= '1'; wait for 1ns;
end process; 

stimulus_process: process
begin
    write_enable <= '1' ; address(1 downto 0) <= "01"  ; WD(1 downto 0) <= "11"; wait for 2ns;
    write_enable <= '1' ; address(1 downto 0) <= "10"  ; WD(1 downto 0) <= "10"; wait for 2ns;
    write_enable <= '1' ; address(1 downto 0) <= "01"  ; WD(1 downto 0) <= "01"; wait for 2ns;  
    write_enable <= '0' ; address(1 downto 0) <= "01"  ; WD(1 downto 0) <= "01"; wait for 2ns;
    write_enable <= '0' ; address(1 downto 0) <= "10"  ; WD(1 downto 0) <= "01"; wait;
    --write_enable <= '1' ; address(1 downto 0) <= "01" ; WD(1 downto 0) <= "00"; wait; 
    --write_enable <= '1' ; address(1 downto 0) <= "01"  ; WD(1 downto 0) <= "11"; wait for 2ns;
    --write_enable <= '0' ; address(1 downto 0) <= "01" ; WD(1 downto 0) <= "00"; wait; 
end process;
end Behavioral;
