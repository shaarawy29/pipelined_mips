library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Data_memory is
  Port (clk,write_enable: in std_logic; address,WD:in std_logic_vector(31 downto 0); RD: out std_logic_vector(31 downto 0); arr_elem1:out std_logic_vector(31 downto 0);arr_elem2:out std_logic_vector(31 downto 0);arr_elem3:out std_logic_vector(31 downto 0));
end Data_memory;

architecture Behavioral of Data_memory is
type array_mem is array (0 to 255) of std_logic_vector(31 downto 0);
signal array_memory  : array_mem := (others=>(others=>'0'));
--signal cut_address : integer := conv_integer(address(7 downto 0));
begin
process(clk)
    begin
        if(rising_edge(clk)) then
            if(write_enable = '1') then
                array_memory(conv_integer(address(7 downto 0))) <= WD ;     
            else    
                --RD <= array_memory(cut_address);
                RD <= array_memory(conv_integer(address(7 downto 0)));
            end if;
        arr_elem1 <= array_memory(0);
        arr_elem2 <= array_memory(1);
        arr_elem3 <= array_memory(2); 
        end if;
end process;
end Behavioral;
