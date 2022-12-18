----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 02:10:19 PM
-- Design Name: 
-- Module Name: reg_file - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;   
--use std.textio.all;
use IEEE.std_logic_textio.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
    Port ( nclk : in STD_LOGIC; -- negative clk, it is triggered at the negative edge of the clk
           WE : in STD_LOGIC; -- write enable pin, to enable write in the WA register 
           RA1 : in STD_LOGIC_VECTOR (4 downto 0); -- address of the first operand, source register 
           RA2 : in STD_LOGIC_VECTOR (4 downto 0); -- address of the second operand, target register 
           RA3 : in STD_LOGIC_VECTOR (4 downto 0); -- address of the third register, destination register, it is only used in case of weight Inst, to make W3 = Rd 
           WA : in STD_LOGIC_VECTOR (4 downto 0); -- Write adress, the address of the target or the distination depends on the opcode
           WD : in STD_LOGIC_VECTOR (31 downto 0); -- Write date, the date to be writen in the WA address
           RD1 : out STD_LOGIC_VECTOR (31 downto 0); -- Read data 1, the date stored in RA1 source register 
           RD2 : out STD_LOGIC_VECTOR (31 downto 0); -- Read data 2, the data stored in the RA2 target register 
           RD3 : out STD_LOGIC_VECTOR (31 downto 0)); -- Read data 3, the data stored in the RA3, destination reg, it is only used in case of weight Inst
end reg_file;

architecture Behavioral of reg_file is

    type reg_file is array (0 to 31) of std_logic_vector(31 downto 0);
    signal reg_file1 : reg_file  := (others => X"00000000");
    signal clk : std_logic;

begin

    clk <= not nclk;
    
    process(nclk) 
        begin 
            if (nclk'event and nclk = '1') then
                RD1 <= reg_file1(to_integer(unsigned(RA1)));
                RD2 <= reg_file1(to_integer(unsigned(RA2)));
                RD3 <= reg_file1(to_integer(unsigned(RA3)));
                if (RA1 = "00000") then 
                    RD1 <= X"00000000";
                end if;
                if (RA2 = "00000") then 
                    RD2 <= X"00000000";
                end if;
                if (RA3 = "00000") then 
                    RD3 <= X"00000000";
                end if;
            end if; 
    end process;
    
    process(clk)
    
        begin 
            if (clk'event and clk = '1') then 
                if(WE = '1') then
                    reg_file1(to_integer(unsigned(WA))) <= WD; 
                end if;
            end if;
    end process;
    
end Behavioral;
