`timescale 1ns / 1ps

module config_top(clk,rst,CMOS_PCLK,CMOS_VSYNC,CMOS_HREF,CMOS_iDATA,I2C_SDAT,I2C_SCLK,xclk,data,CMOS_oCLK,con);
input clk;
input rst;

//cmos camera
input CMOS_PCLK;
input CMOS_VSYNC;
input CMOS_HREF;
input[7:0] CMOS_iDATA;
output I2C_SCLK;
output xclk;
inout I2C_SDAT;
//output CMOS_rst;
//synchronous clock
output CMOS_oCLK;
//generate pixel data
output[7:0] data;

wire clk_50M=clk;
output con;
wire[7:0] CMOS_oDATA;
wire[7:0] data;

wire pll_reset;
assign pll_reset=1'b0;

assign data[7:0]=CMOS_oDATA[7:0];
//assign CMOS_rst=rst;

 /*   ila_CMOS ila_cmos (
        .clk(clk_100M), // input wire clk
        .probe0(I2C_SCLK), // input wire [0:0]  probe0  
        .probe1(I2C_SDAT) // input wire [0:0]  probe1
    );*/
	 
	 
 // Blocked by XCLee @ Oct 31th, 21:06
//     clk_ip U1
  //   (
      // Clock out ports
   //   .outclk_0(xclk),     // output clk_out1
     // Clock in ports
  //    .refclk(clk_50M),
	//	.rst(pll_reset));      // input clk_in1
		
 // Added by XCLee @ Oct 31th, 21:06		
clk_wizard U1 (
		.refclk(clk_50M),   //  refclk.clk
		.rst(pll_reset),      //   reset.reset
		.outclk_0(xclk)); // outclk0.clk	
	
      
I2C_AV_Config  U2 (.iCLK(xclk), 
                   .iRST_N(rst), 
                   .Config_Done(con), 
                   .I2C_RDATA(), 
                   .I2C_SCLK(I2C_SCLK), 
                   .LUT_INDEX(), 
                   .I2C_SDAT(I2C_SDAT));
						 
CMOS_Capture U3 (
    .iRST_N(rst), 
    .Init_Done(con), 
    .CMOS_PCLK(CMOS_PCLK), 
    .CMOS_iDATA(CMOS_iDATA), 
    .CMOS_VSYNC(CMOS_VSYNC), 
    .CMOS_HREF(CMOS_HREF), 
    .CMOS_oCLK(CMOS_oCLK), 
    .CMOS_oDATA(CMOS_oDATA), 
    .CMOS_VALID()
    );
endmodule
