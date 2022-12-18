library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;   
--use std.textio.all;
use IEEE.std_logic_textio.all;

entity Data_memory is
  Port (clk,WE : in std_logic; 
        A : std_logic_vector(4 downto 0);
        WD :in std_logic_vector(31 downto 0);
        RD : out std_logic_vector(31 downto 0));
end Data_memory;

architecture Behavioral of Data_memory is

    type mem is array (0 to 31) of std_logic_vector(31 downto 0);
    signal ram_block : mem := (others=>(others=>'0'));

begin
    process(clk)
    begin
            if(rising_edge(clk)) then
                if(WE = '1') then
                    ram_block(to_integer(unsigned(A))) <= WD;     
                else    
                    --RD <= array_memory(cut_address);
                    RD <= ram_block(to_integer(unsigned(A)));
                end if;
            end if;
    end process;
end Behavioral;
