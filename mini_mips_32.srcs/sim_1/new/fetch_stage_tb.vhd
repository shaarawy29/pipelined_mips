library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fetch_stage_tb is
    --  Port ( );
end fetch_stage_tb;

architecture Behavioral of fetch_stage_tb is

    component fetch_stage is
         Port (clk: in std_logic;
               PCBranchD: in std_logic_vector(31 downto 0); --address to jump 
               StallF: in std_logic;
               StallD: in std_logic;
               PCSrcD: in std_logic;
               instD: out std_logic_vector(31 downto 0);
               PCPlus1D: out std_logic_vector(31 downto 0);
               instF_out: out std_logic_vector(31 downto 0);
               PC_out: out std_logic_vector(31 downto 0);
               PCF_out: out std_logic_vector(31 downto 0);
               PCPlus1F_out: out std_logic_vector(31 downto 0));
    end component;
    
    signal clk: std_logic := '0'; 
    signal PCBranchD: std_logic_vector(31 downto 0):= X"00000001"; --(others => '0');
    signal StallF: std_logic := '0';
    signal StallD: std_logic := '0';
    signal PCSrcD: std_logic := '0';
    signal instD: std_logic_vector(31 downto 0);
    signal PCPlus1D: std_logic_vector(31 downto 0) := (others => '0');
    signal instF_out: std_logic_vector(31 downto 0) := (others => '0');
    signal PC_out: std_logic_vector(31 downto 0) := (others => '0');
    signal PCF_out: std_logic_vector(31 downto 0) := (others => '0');
    signal PCPlus1F_out: std_logic_vector(31 downto 0) := (others => '0');
    
begin
    uut: fetch_stage port map (clk , PCBranchD , StallF , StallD, PCSrcD, instD, PCPlus1D, instF_out, PC_out, PCF_out, PCPlus1F_out);
    
    clk_process: process
    begin
        clk <= not clk; wait for 5ns;
    end process;
    
    stimulus_process: process
    begin
        PCSrcD <= '1';
        wait;    
    end process;
    
end Behavioral;
