`timescale 1ns / 1ps

module binary2bcd_tb;

	logic [3:0] binary_in;
	logic [7:0] bcd_out;
	integer i;
	
	binary2bcd DUT(.binary_in(binary_in), .bcd_out(bcd_out));
	
	initial begin 
		for (i = 0; i < 16; i = i + 1) begin 
			binary_in = i;
			#10; // Espera 10 unidades de tiempo
		end
		
	end
	
endmodule 