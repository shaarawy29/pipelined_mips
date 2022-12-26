library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mem_stage_tb is
end mem_stage_tb;

architecture Behavioral of mem_stage_tb is
    component mem_stage is
        Port ( rst : in std_logic;
               clk : in STD_LOGIC;
               RegWriteM : in STD_LOGIC;
               MemtoRegM : in STD_LOGIC;
               MemWriteM : in STD_LOGIC;
               ALUOutM : in STD_LOGIC_VECTOR (31 downto 0);
               WriteDataM : in STD_LOGIC_VECTOR (31 downto 0);
               WriteRegM : in STD_LOGIC_VECTOR (4 downto 0);
               RegWriteW : out STD_LOGIC;
               MemtoRegW : out STD_LOGIC;
               ReadDataW : out STD_LOGIC_VECTOR (31 downto 0);
               ALUOutW : out STD_LOGIC_VECTOR (31 downto 0);
               WriteRegW : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    signal rst : STD_LOGIC := '0';
    signal clk : STD_LOGIC := '0';
    signal RegWriteM : STD_LOGIC := '0';
    signal MemtoRegM : STD_LOGIC := '0';
    signal MemWriteM : STD_LOGIC := '0';
    signal ALUOutM : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal WriteDataM : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal WriteRegM : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal RegWriteW : STD_LOGIC;
    signal MemtoRegW : STD_LOGIC;
    signal ReadDataW : STD_LOGIC_VECTOR (31 downto 0);
    signal ALUOutW : STD_LOGIC_VECTOR (31 downto 0);
    signal WriteRegW : STD_LOGIC_VECTOR (4 downto 0);

begin
    uut: mem_stage port map(rst,clk,RegWriteM,MemtoRegM,MemWriteM,ALUOutM,WriteDataM,WriteRegM,RegWriteW,MemtoRegW,ReadDataW,ALUOutW,WriteRegW);
    
    clk_process: process
    begin
        clk <= not clk; wait for 5ns;
    end process;
    
    stimulus_process: process
    begin
        rst <= '1'; wait for 10ns; rst <= '0';
        ALUOutM <= X"00000000"; WriteDataM <= X"00000000"; WriteRegM <= "00000";
        RegWriteM <= '1'; MemtoRegM <= '1'; MemWriteM <= '0'; wait for 10ns;
        WriteDataM <= X"ff11ff11"; MemWriteM <= '1'; wait for 10ns;
        RegWriteM <= '1'; MemtoRegM <= '1'; MemWriteM <= '0'; wait;
    end process;         

end Behavioral;
