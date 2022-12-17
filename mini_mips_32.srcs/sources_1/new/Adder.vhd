library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use ieee.std_logic_unsigned.all;

entity Adder is
  Port (A,B: in std_logic_vector(31 downto 0); out_address : out std_logic_vector(31 downto 0));
end Adder;

architecture Behavioral of Adder is
begin
    out_address <= A + B;
end Behavioral;
