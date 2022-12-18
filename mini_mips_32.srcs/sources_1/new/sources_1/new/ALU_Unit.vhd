----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 01:43:34 PM
-- Design Name: 
-- Module Name: ALU_Unit - Behavioral
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
    use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;



entity ALU_Unit is
   Port (in1,in2,in3: in std_logic_vector(31 downto 0);out1:out std_logic_vector(31 downto 0);cout:out std_logic ;sel:in std_logic_vector(2 downto 0));
end ALU_Unit;

architecture Behavioral of ALU_Unit is
signal w1,w2,w3:std_logic_vector(31 downto 0);
signal tmp: std_logic_vector(8 downto 0);
begin
process (in1,in2,in3,sel)
variable OANN: std_logic_vector(63 downto 0);

begin 
if(sel="000") then
    out1 <=in1 + in2;
    tmp <= '0'&in1+'0'&in2;
    cout<= tmp(8);
  --out1 <= "00000000000000000000000000000000000000000000000000000000000000001";
  --out1 <= (others => '0');
elsif(sel="001") then
    out1<=in1 - in2;
    --out1 <= (others => '1');
elsif (sel="010") then 
    out1<= in1 and in2;
elsif (sel="011") then
    out1<= in1 or in2;
elsif (sel="100") then  --weight
    w1<=in1; 
    w2<=in2; 
    w3<=in3; 
end if;
--elsif (sel="101") then   --ANN
--    OANN:=w1*in1+w2*in2;
--    out1<=OANN+OANN*w3;
--end if;
end process;
end Behavioral;