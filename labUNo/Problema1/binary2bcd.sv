`timescale 1ns / 1ps

module binary2bcd (
	input logic [3:0] binary_in,
	output logic [7:0] bcd_out,
	output logic [6:0] display_output
	output logic [6:0] display_output2
);
	
	
	logic [3:0] tens, ones;
	//logic [3:0] binary_input;
   
	
	always_comb begin // Se ejecuta cada que las entradas cambien
		tens = binary_in / 10; // Para las decenas
		ones = binary_in % 10; // Para las unidades, revisar si son de 4 bits*
	end
	
	assign bcd_out = {tens, ones}; // Aquí se concatena o une todo el número 
	
	SevenSegmentDisplay display1 (.binary_input(bcd_out[3:0]), .display_output(display_output));
	SevenSegmentDisplay display2 (.binary_input(bcd_out[7:4]), .display_output(display_output2));
	
endmodule 