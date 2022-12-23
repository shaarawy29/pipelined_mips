----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2022 01:14:19 PM
-- Design Name: 
-- Module Name: inst_mem - Behavioral
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
use ieee.numeric_std.all;       -- for the signed, unsigned types and arithmetic ops
use ieee.std_logic_textio.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inst_mem is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           inst : out STD_LOGIC_VECTOR (31 downto 0));
end inst_mem;

architecture Behavioral of inst_mem is

    type mem is array (0 to 31) of std_logic_vector(31 downto 0);
    signal rom_block : mem  := (others => X"00000000");

begin
    
    inst <= rom_block(to_integer(unsigned(A)));
    
    process
        file f : TEXT;
        constant filename: string := "D:\vivado_proj\mini_mips_32\program.txt";
        variable l : line;
        variable i : integer := 0;
        variable b : std_logic_vector(31 downto 0);
        variable startup : boolean := true;
    begin
        if(startup = true)then
            file_open(f,filename,read_mode);
            while((i <= 31) and (not endfile(f)))loop
                readline(f,l);
                next when l(1) = '#';
                read(l,b);
                rom_block(i) <= b;
                i := i+1;
            end loop;
            file_close(f);
            startup := false;
        end if;
        wait;
    end process;
    
    
end Behavioral;
