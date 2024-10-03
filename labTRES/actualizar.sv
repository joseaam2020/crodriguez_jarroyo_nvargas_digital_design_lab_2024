module actualizar(
	input logic [2:0][2:0][1:0] matriz_juego,
	input logic [3:0] posicion,
	input logic Jug,
	input logic actualizar,
	input logic reset,
	input logic clk,
	
	output logic [2:0][2:0][1:0] new_juego
);

// Intermediate temporary signal for calculations
logic [2:0][2:0][1:0] juego_temporal;

always_ff @(posedge clk or posedge reset) begin
	if(reset) begin
		// Initialize new_juego to zero on reset
		new_juego <= '{default: 2'b00};
	end else begin
		// Sequentially update new_juego with calculated juego_temporal
		new_juego <= juego_temporal;
	end
end

always_comb begin
	// Default assignment to maintain the same value if actualizar is not triggered
	juego_temporal = matriz_juego;
	
	// Update juego_temporal if 'actualizar' is high
	if (actualizar) begin
		// Case statement to fill the matrix based on the position
		case(posicion)
			4'd1: juego_temporal[0][0] = Jug + 1; 
			4'd2: juego_temporal[0][1] = Jug + 1;
			4'd3: juego_temporal[0][2] = Jug + 1;
			4'd4: juego_temporal[1][0] = Jug + 1;
			4'd5: juego_temporal[1][1] = Jug + 1;
			4'd6: juego_temporal[1][2] = Jug + 1;
			4'd7: juego_temporal[2][0] = Jug + 1;
			4'd8: juego_temporal[2][1] = Jug + 1;
			4'd9: juego_temporal[2][2] = Jug + 1;
			default: juego_temporal = matriz_juego; 
		endcase
	end
end 

endmodule
