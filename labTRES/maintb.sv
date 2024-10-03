`timescale 1 ns / 1 ns
module maintb;
  logic [1:0] PC;
  logic Reset;
  logic clk;
  logic [8:0] switches;
  logic MISO;

  // Outputs
  logic VGA_CLK;
  logic [7:0] VGA_B;
  logic [7:0] VGA_G;
  logic [7:0] VGA_R;
  logic VGA_HS;
  logic VGA_VS;
  logic VGA_BLANK;
  logic VGA_SYNC;

  logic MOSI;
  logic SCLK;
  logic CS; 

  logic [6:0] display1;
  logic [6:0] display2;

  // Instantiate the Unit Under Test (UUT)
  main uut (
    .PC(PC),
    .Reset(Reset),
    .clk(clk),
    .switches(switches),
    .MISO(MISO),
    .VGA_CLK(VGA_CLK),
    .VGA_B(VGA_B),
    .VGA_G(VGA_G),
    .VGA_R(VGA_R),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_BLANK(VGA_BLANK),
    .VGA_SYNC(VGA_SYNC),
    .MOSI(MOSI),
    .SCLK(SCLK),
    .CS(CS),
    .display1(display1),
    .display2(display2)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk; // 50MHz clock
  end

  // Test stimulus
  initial begin
    // Initialize Inputs
    PC = 0;
    Reset = 0;
    switches = 9'b000000000;
    MISO = 0;

    #20 Reset = 1;
    #500 Reset = 0;

    #100 PC = 1; //FPGA
    #100 switches = 9'b000000001; 


  end

endmodule
