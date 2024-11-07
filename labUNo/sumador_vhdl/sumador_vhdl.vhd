library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sumador_vhdl is
    port(
        a : in  STD_LOGIC;
        b : in  STD_LOGIC;
        c : in  STD_LOGIC;
        O : out STD_LOGIC; 
        s : out STD_LOGIC
    );
end entity;

architecture behavior of sumador_vhdl is
begin
    process(a, b, c)
    begin
       
        s <= (a xor b) xor c; 
        O <= (a and b) or (b and c) or (a and c); 
		  
    end process;
end architecture;