module FSM1(input clk, rst, x, output a, b);

logic [1:0] state, next_state;

// Actual State
always_ff @(posedge clk or posedge rst)
	if (rst) state = 2'b00;
	else
		state = next_state;
		
// Next State
always_comb
	case(state)
	2'b00: if(x) next_state = 2'b01; else next_state = 2'b00; 
	2'b01: if(x) next_state = 2'b11; else next_state = 2'b10;
	2'b10: next_state = 2'b10;
	2'b11: next_state = 2'b00;
	default next_state = 2'b00;
	endcase
	
	
// Outputs
assign a = (state == 2'b10);
assign b = (state == 2'b11);



endmodule