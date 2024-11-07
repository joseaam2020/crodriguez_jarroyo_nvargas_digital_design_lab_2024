module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      oVGA_B,
                      oVGA_G,
                      oVGA_R,
                      rgb,
                      x,
                      y);
parameter VIDEO_W	= 640;
parameter VIDEO_H	= 480;

input logic iRST_n;
input logic iVGA_CLK;
input logic [2:0][7:0] rgb;
output logic oBLANK_n;
output logic oHS;
output logic oVS;
output logic [7:0] oVGA_B;
output logic [7:0] oVGA_G;  
output logic [7:0] oVGA_R;       
output logic [18:0] x;
output logic [18:0] y;                
///////// ////                     
logic [18:0] ADDR_x = 0;
logic [18:0] ADDR_y = 0;
logic cBLANK_n,cHS,cVS,rst;

assign rst = iRST_n;
assign x = ADDR_x;
assign y = ADDR_y;


video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS)
										);

////Addresss generator
always@(posedge iVGA_CLK,posedge iRST_n)
begin
  if (iRST_n) begin
     ADDR_x<=19'd0;
  end else if (cBLANK_n==1'b1) begin
     ADDR_x<=ADDR_x+19'd1;
  end else begin
	    ADDR_x<=19'd0;
  end 
end

always @(negedge cBLANK_n, posedge iRST_n,negedge cVS) begin
  if(iRST_n) begin
    ADDR_y <= 19'd0;
  end else if (~cVS) begin
    ADDR_y <= 19'd0;
  end else begin
      ADDR_y <= ADDR_y + 1;
  end
  
end
										
logic [2:0][7:0] bgr_data;

//Parameters 
parameter line_W = 10;
parameter vertical_margin = 20;
parameter horizontal_margin = 20;

always@(posedge iVGA_CLK)
begin
  if (iRST_n) begin
    bgr_data[2] <= 8'hcc; 
    bgr_data[1] <= 8'hff;
    bgr_data[0] <= 8'hff;//red
  end else begin
    bgr_data <= rgb;
  end
end

assign oVGA_B=bgr_data[2];
assign oVGA_G=bgr_data[1]; 
assign oVGA_R=bgr_data[0];
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
logic mHS, mVS, mBLANK_n;
always@(posedge iVGA_CLK)
begin
  mHS<=cHS;
  mVS<=cVS;
  mBLANK_n<=cBLANK_n;
  oHS<=mHS;
  oVS<=mVS;
  oBLANK_n<=mBLANK_n;
end


////for signaltap ii/////////////
logic [18:0] H_Cont/*synthesis noprune*/;
always@(posedge iVGA_CLK,posedge iRST_n)
begin
  if (iRST_n)
     H_Cont<=19'd0;
  else if (mHS==1'b1)
     H_Cont<=H_Cont+1;
	  else
	    H_Cont<=19'd0;
end
endmodule