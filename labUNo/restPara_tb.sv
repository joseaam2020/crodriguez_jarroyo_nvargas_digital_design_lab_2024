
module restPara_tb();

	logic clk;
	logic reset; 
	logic we;
	
	logic [1:0] wq0;
	logic [3:0] wq1;
	logic [5:0] wq2;
	
	logic [1:0] q0;
	logic [3:0] q1;
	logic [5:0] q2;
	
	restPara #(2) rest0  (
		.clk (clk),
		.reset (reset),
		.q (q0),
		.we (we),
		.wq (wq0)
	);
	
	restPara #(4) rest1  (
		.clk (clk),
		.reset (reset),
		.q (q1),
		.we (we),
		.wq (wq1)
	);
	
	restPara #(6) rest2  (
		.clk (clk),
		.reset (reset),
		.q (q2),
		.we (we),
		.wq (wq2)
	);
	
	always #3 clk = ~clk;
	
	
	initial begin 
	
		reset = 1; we = 0; clk = 0;
		wq0 = 1; wq1 = 1; wq2 = 1;
		
		#1;
		
		assert(q0 === 0) else $error("q0 = 0 fail");
		assert(q1 === 0) else $error("q1 = 0 fail");
		assert(q2 === 0) else $error("q2 = 0 fail");
		
		#1;
		
		reset = 0;
		
		#2
		
		for(int i = 63; i > -1; i--) begin 
		
			assert(q2 === i) else $error("q2 = %d fail",i);
			$display("q2 = %d, i = %d",q2,i);
			#6;
			
		end 
		
		for(int i = 15; i > -1; i--) begin 
		
			assert(q1 === i) else $error("q1 = %d fail",i);
			$display("q1 = %d, i = %d",q1,i);
			#6;
			
		end 
		
		
		for(int i = 3; i > -1; i--) begin 
		
			assert(q0 === i) else $error("q0 = %d fail",i);
			$display("q0 = %d, i = %d",q0,i);
			#6;
			
		end	
		
		
		$display("q0 = %d",q0);
		$display("q1 = %d",q1);
		$display("q2 = %d",q2);
		
		$display("Enabling write, all counters set to one");
		
		we = 1;
		
		#1
		
		we = 0;
		
		#1; 
		
		assert(q0 === 2'b01) else $error("q0 = 01 fail");
		assert(q1 === 4'b0001) else $error("q1 = 0001 fail");
		assert(q2 === 6'b000001) else $error("q2 = 000001 fail");
		
		$display("q0 = %d",q0);
		$display("q1 = %d",q1);
		$display("q2 = %d",q2);
		
		$stop;
		
		
	end 

endmodule	
	