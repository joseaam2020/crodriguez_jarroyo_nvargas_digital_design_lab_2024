module extensor #(parameter M = 4, parameter N = 8) (
    input logic [M-1:0] in,
    input logic sign_extend,   
    output logic [N-1:0] out
);

    always_comb begin
        if (sign_extend) begin
    
            out = {{(N-M){in[M-1]}}, in};
        end else begin
            out = {{(N-M){1'b0}}, in};
        end
    end

endmodule
