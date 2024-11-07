library ieee;
use ieee.std_logic_1164.all;

entity sumador_vhdl is
    port(
        a : in  std_logic_vector (0 to 3);
        b : in  std_logic_vector (0 to 3);
        c : in  std_logic;
		  
		  
		  
        
        c0 : buffer std_logic;
        s0 : out std_logic;
        
        c1 : buffer std_logic;
        s1 : out std_logic;
        
        c2 : buffer std_logic;
        s2 : out std_logic;
        
        c3 : buffer std_logic;
        s3 : out std_logic;
        
        s4 : out std_logic
    );
end entity;

architecture Behavioral of sumador_vhdl is
    signal a_and0, b_and0, c_and0 : std_logic;
    signal a_xor0 : std_logic;
    
    signal a_and1, b_and1, c_and1 : std_logic;
    signal a_xor1 : std_logic;
    
    signal a_and2, b_and2, c_and2 : std_logic;
    signal a_xor2 : std_logic;
    
    signal a_and3, b_and3, c_and3 : std_logic;
    signal a_xor3 : std_logic;
begin
    
    a_and0 <= a(0) and b(0);
    b_and0 <= c and b(0);
    c_and0 <= a(0) and c;
    
    c0 <= a_and0 or b_and0 or c_and0;
    a_xor0 <= a(0) xor b(0);
    s0 <= a_xor0 xor c;
    
-----------------------------------------------------------------------   
    a_and1 <= a(1) and b(1);
    b_and1 <= c0 and b(1);
    c_and1 <= a(1) and c0;
    
    c1 <= a_and1 or b_and1 or c_and1;
    a_xor1 <= a(1) xor b(1);
    s1 <= a_xor1 xor c0;
    
-----------------------------------------------------------------------   
    a_and2 <= a(2) and b(2);
    b_and2 <= c1 and b(2);
    c_and2 <= a(2) and c1;
    
    c2 <= a_and2 or b_and2 or c_and2;
    a_xor2 <= a(2) xor b(2);
    s2 <= a_xor2 xor c1;
    
----------------------------------------------------------------------- 
    a_and3 <= a(3) and b(3);
    b_and3 <= c2 and b(3);
    c_and3 <= a(3) and c2;
    
    c3 <= a_and3 or b_and3 or c_and3;
    a_xor3 <= a(3) xor b(3);
    s3 <= a_xor3 xor c2;
-----------------------------------------------------------------------    
    
    s4 <= c3;
end architecture;

