library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.all;

entity Adder_tb is
end Adder_tb;

architecture Behavioral of Adder_tb is
component Adder is
    port(A,B: in std_logic_vector(31 downto 0) ; out_address: out std_logic_vector(31 downto 0));
end component;
signal A,B : std_logic_vector(31 downto 0) := (others => '0');
signal out_address : std_logic_vector(31 downto 0);
begin
uut: Adder port map (A,B,out_address);
stimulus_process: process
begin
    A(2 downto 0) <= "111" ; B(2 downto 0 ) <= "001"; wait for 2ns;
    A(2 downto 0) <= "010" ; B(2 downto 0 ) <= "011"; wait for 2ns;
    A(2 downto 0) <= "100" ; B(2 downto 0 ) <= "010";wait for 2ns;
    A(2 downto 0) <= "110" ; B(2 downto 0 ) <= "101"; wait; 
end process;

end Behavioral;
