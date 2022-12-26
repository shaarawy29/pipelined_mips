library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fetch_stage_tb is
    --  Port ( );
end fetch_stage_tb;

architecture Behavioral of fetch_stage_tb is

    component fetch_stage is
         Port (rst : in std_logic;
               clk: in std_logic;
               PCBranchD: in std_logic_vector(31 downto 0); --address to jump 
               StallF: in std_logic;
               StallD: in std_logic;
               PCSrcD: in std_logic;
               instD: out std_logic_vector(31 downto 0);
               PCPlus1D: out std_logic_vector(31 downto 0));
    end component;
    
    signal rst : std_logic := '1';
    signal clk: std_logic := '0'; 
    signal PCBranchD: std_logic_vector(31 downto 0):= X"00000001"; --(others => '0');
    signal StallF: std_logic := '0';
    signal StallD: std_logic := '0';
    signal PCSrcD: std_logic := '0';
    signal instD: std_logic_vector(31 downto 0);
    signal PCPlus1D: std_logic_vector(31 downto 0);
    
begin
    uut: fetch_stage port map (rst, clk , PCBranchD , StallF , StallD, PCSrcD, instD, PCPlus1D);
    
    clk_process: process
    begin
        clk <= not clk; wait for 5ns;
    end process;
    
    stimulus_process: process
    begin
        rst <= '1'; wait for 15ns; rst <= '0';
        PCSrcD <= '0'; wait for 50ns;
        PCSrcD <= '1'; wait for 50ns;
        PCSrcD <= '0'; wait;
        wait;    
    end process;
    
end Behavioral;
