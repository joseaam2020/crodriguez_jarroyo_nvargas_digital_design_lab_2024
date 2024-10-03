module cronometer(
	input  logic clock, //2Mhz clock
	input  logic reset,
	output logic [3:0] seconds
);

int micro_counter = 0;
logic clk2 = 0;

always_ff @(posedge clock,posedge reset) begin
	if(reset) begin
		micro_counter <= 0;
		seconds <= 0;
	end else begin
		if(clk2) begin
			if(micro_counter < (1000000)) begin
				micro_counter <= micro_counter + 1;
			end else begin
				seconds <= seconds + 1;
				micro_counter <= 0;
			end	
			clk2 <= 0;
		end else begin
			clk2 <= 1;
		end
	end
end

endmodule 