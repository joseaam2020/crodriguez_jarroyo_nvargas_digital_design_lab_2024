library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumador_tb is

end sumador_tb;

architecture Behavioral of sumador_tb is

    signal a, b, c, o, s : STD_LOGIC;

   
    component sumador_vhdl
        Port (
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            c : in STD_LOGIC;
            o : out STD_LOGIC;
            s : out STD_LOGIC
        );
    end component;

begin

    uut: sumador_vhdl
        Port map (
            a => a,
            b => b,
            c => c,
            o => o,
            s => s
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