----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 03:37:11 PM
-- Design Name: 
-- Module Name: ALU_test - Behavioral
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

entity ALU_test is
end ALU_test;

architecture Behavioral of ALU_test is
component ALU_Unit is
port(in1,in2,in3: in std_logic_vector(31 downto 0);out1:out std_logic_vector(31 downto 0);cout:out std_logic;sel:in std_logic_vector(2 downto 0));
end component;
signal in1,in2,in3:std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal out1: std_logic_vector(31 downto 0);
signal cout:std_logic;
signal sel: std_logic_vector(2 downto 0) := "000";
begin
uut: ALU_Unit port map (in1,in2,in3,out1,cout,sel);

stimulus_process: process
begin
    in1<="00000000000000000000000000000010";in2<="00000000000000000000000000000001";sel<="000"; wait for 10ns;
    in1<="00000000000000000000000000000010";in2<="00000000000000000000000000000001";sel<="001"; wait for 10ns;
    in1<="00000000000000000000000000000111";in2<="00000000000000000000000000000101";sel<="010"; wait for 10ns;
    in1<="00000000000000000000000000000111";in2<="00000000000000000000000000000101";sel<="011"; wait ;
    --in1<="0";in2<="1";sel<="000"; wait for 10ns;
    --in1<="0";in2<="1";sel<="000"; wait for 10ns;
end process;    
end;