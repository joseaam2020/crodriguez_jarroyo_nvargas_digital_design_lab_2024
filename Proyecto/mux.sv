module mux #(parameter S = 4,parameter N = 4)(
    input logic [S-1:0] s,
    input logic [(2**S)-1:0][N-1:0] in,
    output logic [N-1:0] out
);

    always_comb begin
        out = 0;
        for (int i=0; i<(2**S); i++) begin
            if(s == i) begin
                out = in[i];
            end 
        end
    end

endmodule
