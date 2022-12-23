library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hazard_unit_tb is
end hazard_unit_tb;

architecture Behavioral of hazard_unit_tb is
    component hazard_unit is 
        port(BranchD : in STD_LOGIC;
             RsE : in STD_LOGIC_VECTOR (4 downto 0);
             RtE : in STD_LOGIC_VECTOR (4 downto 0);
             RdE : in STD_LOGIC_VECTOR (4 downto 0);
             ALUControlE : in STD_LOGIC_VECTOR (2 downto 0);
             ALUSrcE : in STD_LOGIC;
             WriteRegM : in STD_LOGIC_VECTOR (4 downto 0);
             MemtoRegM : in STD_LOGIC;
             RegWriteM : in STD_LOGIC;
             WriteRegW : in STD_LOGIC_VECTOR (4 downto 0);
             RegWriteW : in STD_LOGIC;
             StallF : out STD_LOGIC;
             StallD : out STD_LOGIC;
             StallE : out STD_LOGIC;
             FlushE : out STD_LOGIC;
             FlushM : out STD_LOGIC;
             ForwardAE : out STD_LOGIC_VECTOR (1 downto 0);
             ForwardBE : out STD_LOGIC_VECTOR (1 downto 0);
             ForwardCE : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    signal BranchD : STD_LOGIC := '0';
    signal RsE : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    signal RtE : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    signal RdE : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    signal ALUControlE : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal ALUSrcE : STD_LOGIC := '0';
    signal WriteRegM : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    signal MemtoRegM : STD_LOGIC := '0';
    signal RegWriteM : STD_LOGIC := '0';
    signal WriteRegW : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    signal RegWriteW : STD_LOGIC := '0';
    signal StallF : STD_LOGIC;
    signal StallD : STD_LOGIC;
    signal StallE : STD_LOGIC;
    signal FlushE : STD_LOGIC;
    signal FlushM : STD_LOGIC;
    signal ForwardAE : STD_LOGIC_VECTOR (1 downto 0);
    signal ForwardBE : STD_LOGIC_VECTOR (1 downto 0);
    signal ForwardCE : STD_LOGIC_VECTOR (1 downto 0);

begin
    uut: hazard_unit port map(BranchD,RsE,RtE,RdE,ALUControlE,ALUSrcE,WriteRegM,MemtoRegM,RegWriteM,WriteRegW,RegWriteW,StallF,StallD,StallE,FlushE,FlushM,ForwardAE,ForwardBE,ForwardCE);
    stimulus_process: process
        begin
            --BranchD <= '0'; RsE <= "00011"; WriteRegM <= "00011"; RegWriteM <= '1'; wait for 1ns;
            --BranchD <= '0'; RtE <= "00010"; WriteRegM <= "00000"; ALUSrcE <= '0'; RegWriteW <= '1'; WriteRegW <= "00010"; wait for 1ns;
            BranchD <= '0'; MemtoRegM <= '1';RegWriteM <= '1';RsE <= "00001";WriteRegM <= "00001"; wait;
            --BranchD <= '0'; RsE <= "00011"; WriteRegM <= "00011"; RegWriteM <= '1'; wait for 1ns;
            --BranchD <= '0'; RsE <= "00011"; WriteRegM <= "00011"; RegWriteM <= '1'; wait for 1ns;
            --BranchD <= '0'; RsE <= "00011"; WriteRegM <= "00011"; RegWriteM <= '1'; wait for 1ns;                           
    end process;

end Behavioral;
