library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumador_tb is
end sumador_tb;

architecture Behavioral of sumador_tb is

    signal a, b, c : STD_LOGIC;
    signal c0, s0 : STD_LOGIC;
    signal c1, s1 : STD_LOGIC;
    signal c2, s2 : STD_LOGIC;
    signal c3, s3 : STD_LOGIC;
    signal s4 : STD_LOGIC;

    component sumador_vhdl
        port (
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            c : in STD_LOGIC;
            
            c0 : out STD_LOGIC;
            s0 : out STD_LOGIC;
            
            c1 : out STD_LOGIC;
            s1 : out STD_LOGIC;
            
            c2 : out STD_LOGIC;
            s2 : out STD_LOGIC;
            
            c3 : out STD_LOGIC;
            s3 : out STD_LOGIC;
            
            s4 : out STD_LOGIC
        );
    end component;

begin

    uut: sumador_vhdl
        port map (
            a => a,
            b => b,
            c => c,
            
            c0 => c0,
            s0 => s0,
            
            c1 => c1,
            s1 => s1,
            
            c2 => c2,
            s2 => s2,
            
            c3 => c3,
            s3 => s3,
            
            s4 => s4
        );

    stim_proc: process
    begin
        
        a <= '0';
        b <= '0';
        c <= '0';
        wait for 40 ns;

        a <= '0';
        b <= '0';
        c <= '1';
        wait for 40 ns;

        a <= '0';
        b <= '1';
        c <= '0';
        wait for 40 ns;

        a <= '0';
        b <= '1';
        c <= '1';
        wait for 40 ns;

        a <= '1';
        b <= '0';
        c <= '0';
        wait for 40 ns;

        a <= '1';
        b <= '0';
        c <= '1';
        wait for 40 ns;

        a <= '1';
        b <= '1';
        c <= '0';
        wait for 40 ns;

        a <= '1';
        b <= '1';
        c <= '1';
        wait for 40 ns;

        wait;
    end process;

end Behavioral;
