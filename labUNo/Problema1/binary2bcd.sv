`timescale 1ns / 1ps

module binary2bcd (
	input logic [3:0] binary_in,
	output logic [7:0] bcd_out
);
	
	
	logic [3:0] tens, ones;
	
	always_comb begin // Se ejecuta cada que las entradas cambien
		tens = binary_in / 10; // Para las decenas
		ones = binary_in % 10; // Para las unidades
	end
	
	assign bcd_out = {tens, ones}; // Aquí se concatena o une todo el número 
	
endmodule 