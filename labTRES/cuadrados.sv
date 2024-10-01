module cuadrados(

    input logic [2:0][2:0][1:0] matriz,
    input logic [18:0] x,
    input logic [18:0] y,
    input logic clk,
    output logic print

);


parameter VIDEO_W	= 640;
parameter VIDEO_H	= 480;

logic cond_1; 
logic cond_2;
logic cond_3;
logic cond_4;
logic cond_5; 
logic cond_6;
logic cond_7;
logic cond_8;
logic icond1;
logic icond2;
logic icond3;
logic cond;

always @(posedge clk) begin
    print = 0;
    for(int i = 0; i < 3; i++) begin
        for(int j = 0; j < 3; j++) begin
            if (matriz[i][j] == 2'd2) begin
                cond_1 = x > ((VIDEO_W/3)*j)+20; 
                cond_2 = x < ((VIDEO_W/3)*j)+40;

                cond_3 = x < ((VIDEO_W/3)*(j+1))-10;
                cond_4 = x > ((VIDEO_W/3)*(j+1))-30;

                cond_5 = y > ((VIDEO_H/3)*i)+20;
                cond_6 = y < ((VIDEO_H/3)*i)+40;

                cond_7 = y < ((VIDEO_H/3)*(i+1))-10;
                cond_8 = y > ((VIDEO_H/3)*(i+1))-30;

                icond1 = (cond_1 && cond_2) && (cond_5 && cond_7);
                icond2 = (~cond_2 && ~cond_4) && ((cond_5 && cond_6)||(cond_7 && cond_8)); 
                icond3 = (cond_3 && cond_4) && (cond_5 && cond_7);

                cond = icond1 || icond2 || icond3;
                          
                //cond = cond_1 && cond_2 && cond_3 && cond_4;
                if(cond) begin
                    print = 1;
                end
            end
        end 
    end
end

endmodule