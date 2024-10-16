library ieee;
use ieee.std_logic_1164.all;

entity seven_segment is
    port(
		LED_in : in  STD_LOGIC_VECTOR (0 to 3);
		LED_out: out STD_LOGIC_VECTOR (0 to 6)
    );
end entity;


architecture Behavioral of seven_segment is
	
	begin
	process(LED_in)
	begin
		 case LED_in is
		 when "0000" => LED_out <= "0000001"; -- "0"     
		 when "0001" => LED_out <= "1001111"; -- "1" 
		 when "0010" => LED_out <= "0010010"; -- "2" 
		 when "0011" => LED_out <= "0000110"; -- "3" 
		 when "0100" => LED_out <= "1001100"; -- "4" 
		 when "0101" => LED_out <= "0100100"; -- "5" 
		 when "0110" => LED_out <= "0100000"; -- "6" 
		 when "0111" => LED_out <= "0001111"; -- "7" 
		 when "1000" => LED_out <= "0000000"; -- "8"     
		 when "1001" => LED_out <= "0000100"; -- "9" 
		 when "1010" => LED_out <= "0001000"; -- a
		 when "1011" => LED_out <= "1100000"; -- b
		 when "1100" => LED_out <= "0110001"; -- C
		 when "1101" => LED_out <= "1000010"; -- d
		 when "1110" => LED_out <= "0110000"; -- E
		 when "1111" => LED_out <= "0111000"; -- F
		 when others => LED_out <= "0000000";
		 end case;
	end process;
	
end architecture;
