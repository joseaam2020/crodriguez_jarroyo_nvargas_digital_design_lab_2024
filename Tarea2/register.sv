module register #(parameter N=8) (input logic clk, rst,
											 input logic [N-1:0] D,
											 output logic [N-1:0] Q);


always_ff @(negedge clk or posedge rst) begin
	
	if (rst) begin 
		Q = 8'h00;
	end else begin
		Q = D;
	end
	
end

endmodule
