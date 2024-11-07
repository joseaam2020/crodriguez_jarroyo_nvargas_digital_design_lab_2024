
module restPara #(parameter N = 6)(clk,reset,q,wq,we);

	input logic clk;
	input logic reset;
	input logic we; //write enable
	input logic [N-1:0] wq; //write q 
	output logic [N-1:0] q;
	
	
	always_ff @(posedge clk, posedge reset, posedge we)
	
		if (reset) q <= 0;
		
		else if (we) begin
		
			for (int i = 0; i < N; i++) q[i] <= wq[i];
			
		end else q = q - 1;
		
endmodule

