module comparator #(parameter N=8) (input [N-1] A, B,
												output equal)
												
assign equal = (A==B);

endmodule
