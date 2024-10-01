module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      oVGA_B,
                      oVGA_G,
                      oVGA_R,
                      matriz);
parameter VIDEO_W	= 640;
parameter VIDEO_H	= 480;

input logic iRST_n;
input logic iVGA_CLK;
input logic [2:0][2:0][1:0] matriz;
output logic oBLANK_n;
output logic oHS;
output logic oVS;
output logic [7:0] oVGA_B;
output logic [7:0] oVGA_G;  
output logic [7:0] oVGA_R;                       
///////// ////                     
logic [18:0] ADDR_x = 0;
logic [18:0] ADDR_y = 0;
//logic VGA_CLK_n;
//logic [7:0] index;
//logic [23:0] bgr_data_raw;
logic cBLANK_n,cHS,cVS,rst;
////
assign rst = iRST_n;



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
int horizontal_left;
int horizontal_right;
int vertical_top;
int vertical_bottom;
logic h_cond1;
logic h_cond2;
logic h_cond3;
logic h_cond4;
logic v_cond1;
logic v_cond2;
logic v_cond3;
logic v_cond4;
logic print1;
logic print2;
logic print3;
logic printe;
logic printc;

equis equi (
  .matriz(matriz),
  .clk(iVGA_CLK),
  .x(ADDR_x),
  .y(ADDR_y),
  .print(printe)
);

cuadrados cuadrado (
  .matriz(matriz),
  .clk(iVGA_CLK),
  .x(ADDR_x),
  .y(ADDR_y),
  .print(printc)
);

//Parameters 
parameter line_W = 10;
parameter vertical_margin = 20;
parameter horizontal_margin = 20;

always@(posedge iVGA_CLK)
begin
  if (iRST_n)
  begin
    bgr_data[2] <= 8'hcc; 
    bgr_data[1] <= 8'hff;
    bgr_data[0] <= 8'hff;//red
  end
    else
    begin

      //Tablero vertical
      horizontal_left <= VIDEO_W / 3;
      horizontal_right <= 2*(VIDEO_W/3);
      h_cond1 <= (horizontal_left-line_W < ADDR_x) && (ADDR_x <= horizontal_left+line_W);
      h_cond2 <= (horizontal_right-line_W < ADDR_x) && (ADDR_x <= horizontal_right+line_W); 
      v_cond1 <= (ADDR_y > vertical_margin);
      v_cond2 <= (ADDR_y < VIDEO_H -vertical_margin);
       
      print1 <= (h_cond1 || h_cond2) && (v_cond1 && v_cond2);

      //tablero horizontal
      vertical_top <= VIDEO_H / 3; 
      vertical_bottom <= 2 * (VIDEO_H/3);
      v_cond3 <= (vertical_top-line_W < ADDR_y)  && (ADDR_y <= vertical_top+line_W);
      v_cond4 <= (vertical_bottom-line_W < ADDR_y)  && (ADDR_y <= vertical_bottom+line_W);
      h_cond3 <= (ADDR_x > horizontal_margin);
      h_cond4 <= (ADDR_x < VIDEO_W - horizontal_margin);

      print2 <= (v_cond3 || v_cond4) && (h_cond3 && h_cond4);

      //Print
      if(print1 || print2) begin 
        bgr_data[2] <= 8'h88; 
        bgr_data[1] <= 8'h67;
        bgr_data[0] <= 8'h08;//red
      end else if(printe) begin
				bgr_data[2] <= 8'hd5;  
        bgr_data[1] <= 8'hae;//green
        bgr_data[0] <= 8'h06;
      end else if(printc)begin 
        bgr_data[2] <= 8'h08; 
        bgr_data[1] <= 8'hc8;
        bgr_data[0] <= 8'hf0;//red
      end else begin 
        bgr_data[2] <= 8'hd0; 
        bgr_data[1] <= 8'hf1;
        bgr_data[0] <= 8'hff;//red
      end


     /* 
      if (0<ADDR_x && ADDR_x <= VIDEO_W/3) begin
					bgr_data[2] <= 8'hcc; // blue
          bgr_data[1] <= 8'hff;
          bgr_data[0] <= 8'hff;
      end else if (ADDR_x > VIDEO_W/3 && ADDR_x <= VIDEO_W*2/3) begin
					bgr_data[2] <= 8'h66;  
          bgr_data[1] <= 8'h33;//green
          bgr_data[0] <= 8'h00;
      end else if(ADDR_x > VIDEO_W*2/3 && ADDR_x <=VIDEO_W) begin
					bgr_data[2] <= 8'h33; 
          bgr_data[1] <= 8'h33;
          bgr_data[0] <= 8'hff;//red
      end else begin
					bgr_data[2] <= 8'h00; 
          bgr_data[1] <= 8'h00;
          bgr_data[0] <= 8'h00;
      end
      */
 
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