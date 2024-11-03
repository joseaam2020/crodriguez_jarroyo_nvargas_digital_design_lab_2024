module mux16to1_tb (); 
    logic [3:0] s;
    logic [15:0][2:0] in;
    logic [2:0] out;

    mux16to1 #(3) mux2bit(
        .s(s),
        .in(in),
        .out(out)
    );
    
    initial begin
        for(int i = 0; i < 16;i++) begin
            if(i < 8) begin
                in[i] = i;
            end else begin
                in[i] = 0;
            end
        end
        
        for(int i = 0; i < 16; i++) begin
            s = i;
            #3;
            if(i < 8) begin 
                mux_num : assert (out == i)
                    else $error("Assertion mux_num failed! i=%d, out=%d",i,out);
            end else begin
                mux_zero: assert (out == 0)
                    else $error("Assertion mux_zero failed! i=%d, out=%d",i,out);
            end
        end    
    end



endmodule