module comparator #(parameter N=8) (input logic [N-1:0] A, B,
												output logic equal);
												
assign equal = (A==B);

endmodule
