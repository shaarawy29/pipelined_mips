library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;   
--use std.textio.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity Data_memory is
  Port (rst : in std_logic;
        clk,WE : in std_logic; 
        A : in std_logic_vector(31 downto 0);
        WD :in std_logic_vector(31 downto 0);
        RD : out std_logic_vector(31 downto 0));
end Data_memory;

architecture Behavioral of Data_memory is

    type mem is array (0 to 31) of std_logic_vector(31 downto 0);
    signal ram_block : mem := (others=>(others=>'0'));

begin
    
    process(clk, rst)
        file f : TEXT;
        constant filename: string := "D:\vivado_proj\mini_mips_32\data.txt";
        variable l : line;
        variable i : integer := 0;
        variable b : std_logic_vector(31 downto 0);
    begin
        if(rst = '1')then
            file_open(f,filename,read_mode);
            while((i <= 31) and (not endfile(f)))loop
                readline(f,l);
                next when l(1) = '#';
                read(l,b);
                ram_block(i) <= b;
                i := i+1;
            end loop;
            file_close(f);
            RD <= X"00000000";
        else
            if(falling_edge(clk)) then
                if(WE = '1') then
                    ram_block(to_integer(unsigned(A))) <= WD;     
                else    
                    RD <= ram_block(to_integer(unsigned(A)));
                end if;
            end if;
        end if;
    end process;
end Behavioral;
