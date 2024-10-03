`timescale 1 ns / 1 ns

module cronometer_tb ();

logic clk_50Mhz;
logic clk_2Mhz;
logic newClk_reset;
logic cronometer_rst;
logic [3:0] seconds;


second_clk newClk (
    .refclk(clk_50Mhz),
    .rst(newClk_reset),
    .outclk_0(clk_2Mhz),
    .locked()
);

cronometer crono (
    .clock(clk_2Mhz),
    .reset(cronometer_rst),
    .seconds(seconds)
);

initial begin

    newClk_reset = 1;
    cronometer_rst = 1;
    #1;
    newClk_reset = 0;
    cronometer_rst = 0;
    #1;

    for(int i = 0; i < (2000000000); i++) begin
        clk_50Mhz = 1;
        #10;
        clk_50Mhz = 0;
        #10;
    end

end

endmodule