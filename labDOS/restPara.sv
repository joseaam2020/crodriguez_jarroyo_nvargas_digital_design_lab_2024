
module restPara #(parameter N = 6)(clk,reset,q,wq,we,display1,display2);

	input logic clk;
	input logic reset;
	input logic we; //write enable
	input logic [N-1:0] wq; //write q 
	output logic [N-1:0] q;
	output logic [6:0] display1;
	output logic [6:0] display2;
	
	logic [3:0] bin_in1;
	logic [3:0] bin_in2;
	
	always_ff @(posedge clk, posedge reset, posedge we) begin
	
		if (reset) q <= 0;
		
		else if (we) begin
		
			for (int i = 0; i < N; i++) q[i] <= wq[i];
			
		end else q <= q - 1;
		
	
	end
		
	assign bin_in1 = q % 10;
	assign bin_in2 = q / 10;
		
	SevenSegmentDisplay seven1 (.binary_input(bin_in1), .display_output(display1));
	SevenSegmentDisplay seven2 (.binary_input(bin_in2), .display_output(display2));

endmodule

