module FSM(input clk, rst, M, to, rst_manual, 
			  output error, en_count, rst_timer);

logic [1:0] state, next_state;

// Actual State
always_ff @(posedge clk or posedge rst)
	if (rst) state = 2'b00;
	else
		state = next_state;
		
// Next State
always_comb
	case(state)
	2'b00: if(M) next_state = 2'b01; else next_state = 2'b10; 
	2'b01: next_state = 2'b00;
	2'b10: if(to) next_state = 2'b11; else next_state = 2'b00;
	2'b11: if(rst_manual) next_state = 2'b00; else next_state = 2'b11;
	default next_state = 2'b00;
	endcase
	
	
// Outputs
assign error = (state == 2'b10);
assign en_count = (state == 2'b11);
assign rst_timer = (state == 2'b11);



endmodule