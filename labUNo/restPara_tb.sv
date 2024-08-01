
module restPara_tb();

	logic clk;
	logic reset; 
	logic we;
	logic wq;
	logic [1:0] q;
	
	restPara #(2) rest  (
		.clk (clk),
		.reset (reset),
		.q (q),
		.we (we),
		.wq (wq)
	);
	
	
	always #3 clk = ~clk;
	
	initial begin 
		we <= 0;
		wq <= 1;
	
		clk <= 0;
		reset <= 3;
		
		#1 reset <= 0;
		
		#5 we <= 1; 
		#1 we <= 0;
		
	end 

endmodule	
	