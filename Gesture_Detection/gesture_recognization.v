`timescale 1ns / 1ps

module gesture_recognization(
			  clk, 
           CMOS_HREF, 
           CMOS_iDATA, 
           CMOS_PCLK, 
           CMOS_VSYNC, 
           RST, 
           I2C_SCLK, 
           //RS232_tx, 
//         vga_bclk, 
//         vga_blank, 
           vga_hs, 
           vga_vs, 
//           vga_rgb, 
           vga_r,
//           vga_g,
//           vga_b,
           
           XCLK, 
           I2C_SDAT,
           config_done
//           guass_clk
//           Ctrl,
//           judge_clk,
           
//           en_sw15,
//           rx_pin_jb1,
//           tx_pin_jb0,
           
		  
           //XLXN_41
          /* XLXN_45,
           XLXN_46*/);
 
    wire vga_blank;
    wire vga_bclk;
    input clk;
    input CMOS_HREF;
    input [7:0] CMOS_iDATA;
    input CMOS_PCLK;
    input CMOS_VSYNC;
    input RST;
//    input XLXN_48;
    
    //input en_sw15;
//    input rx_pin_jb1;
    
     output I2C_SCLK;
  // output RS232_tx;
     output vga_hs;
     output vga_vs;   
	  output [3:0]    vga_r;
	  wire [3:0]    vga_g;
	  wire [3:0]    vga_b;
  
  

   output XCLK;
   inout I2C_SDAT;
   output config_done;
//   output [1:0] Ctrl;
//   output judge_clk;
   
//   output tx_pin_jb0;
   
   wire guass_clk;
 
//   wire judge_clk;
   wire binary_data;
   wire [17:0] XLXN_20;
   wire XLXN_40;
   wire XLXN_41;
   wire [7:0] XLXN_42;
   wire [7:0] XLXN_45;
   wire [7:0] XLXN_46;
   wire XLXN_48;
   wire XLXN_60;
   wire XLXN_61;
   wire XLXN_78;
   wire XLXN_79;
   wire [8:0] XLXN_94;
   wire [9:0] XLXN_95;
   wire [8:0] XLXN_103;
   wire [8:0] XLXN_105;
   wire XLXN_107;
   wire [8:0] XLXN_118;
   wire [8:0] XLXN_120;
   wire [7:0] XLXN_124;
   wire XLXN_125;
   wire XLXN_126;
   wire XLXN_127;
   wire vga_bclk_DUMMY;
   wire [1:0] Ctrl;

    
   wire vga_rgb;
   assign vga_r={vga_rgb,vga_rgb,vga_rgb,vga_rgb};
   assign vga_g={4'b0};
   assign vga_b={4'b0};
   
	wire pp_ram_clk;
   
   assign XLXN_40=RST;
   assign vga_bclk = vga_bclk_DUMMY;
	
	
   config_top  XLXI_1 (.clk(clk), 
                      .CMOS_HREF(CMOS_HREF), 
                      .CMOS_iDATA(CMOS_iDATA[7:0]), 
                      .CMOS_PCLK(CMOS_PCLK), 
                      .CMOS_VSYNC(CMOS_VSYNC), 
                      .rst(XLXN_40), 
                      .CMOS_oCLK(XLXN_41), 
                      .data(XLXN_42[7:0]), 
                      .I2C_SCLK(I2C_SCLK), 
                      .xclk(XCLK), 
                      .I2C_SDAT(I2C_SDAT),
                      .con(config_done));
							 
							 
   config_guass  XLXI_2 (.CMOS_oCLK(XLXN_41), 
                        .CMOS_VSYNC(CMOS_VSYNC), 
                        .DATA(XLXN_42[7:0]), 
                        .iRST_N(XLXN_40), 
                        .guass_clk(guass_clk),
							   //.pp_ram_write_clk(pp_ram_clk),	
								//.pclk(CMOS_PCLK),
                        .reg1(XLXN_45[7:0]), 
                        .reg2(XLXN_46[7:0]));
								
								
   guass_dsp_cal XLXI_3(.rst(XLXN_40),
                                .clk(guass_clk),
                                .Cb(XLXN_45[7:0]),
                                .Cr(XLXN_46[7:0]),
                                .guass_odata(binary_data));   

	// Block Oct 31th Night 20:25 by XCLee									  
 //  median  XLXI_4 (.CMOS_VSYNC(CMOS_VSYNC), 
 //                 .data_in(binary_data), 
 //                 .guass_clk(guass_clk), 
 //                 .data_me(XLXN_48));
						
						
 //  pp_ram  XLXI_5 (.clk_in(vga_bclk), 
 //                 .CMOS_VSYNC(CMOS_VSYNC), 
 //                 .data_me(XLXN_48), 
 //                 .dout_addr(XLXN_20[17:0]), 
 //                 .frame_sw(XLXN_107), 
 //                 .guass_clk(guass_clk), 
//						//.pp_ram_clk(pp_ram_clk),
 //                 .RST_N(XLXN_40), 
 //                 .ena(XLXN_78), 
 //                 .ram_out(XLXN_79));
						
	// Added on Oct 31th Night 20:25 by XCLee							
   pp_ram  XLXI_5 (.clk_in(vga_bclk), 
                  .CMOS_VSYNC(CMOS_VSYNC), 
                  .data_me(binary_data), 
                  .dout_addr(XLXN_20[17:0]), 
                  .frame_sw(XLXN_107), 
                  .guass_clk(guass_clk), 
						//.pp_ram_clk(pp_ram_clk),
                  .RST_N(XLXN_40), 
                  .ena(XLXN_78), 
                  .ram_out(XLXN_79));
						
//                  
// Top_Detect  TOP_Det(
//                  .Rst(RST),
//                  .Pixel(XLXN_48),
//                  //field,  // Should be solved later !!!!!!!!!!!!!!!!!!!!!!
//                  .gauss_clk(guass_clk),
//                  .Ctrl(Ctrl),
//                  .x_max(XLXN_118[8:0]),
//                  .x_min(XLXN_94[8:0]),
//                  .judge_clk(judge_clk)
//                      );
   /*INV  XLXI_7 (.I(RST), 
               .O(XLXN_40));*/

  /* guass_dsp_ll  XLXI_10 (.ce(XLXN_40), 
                         .clk(XLXN_6), 
                         .gateway_in(XLXN_45[7:0]), 
                         .gateway_in1(XLXN_46[7:0]), 
                         .gateway_out1(XLXN_7));
  speed_select  XLXI_15 (.bps_start(XLXN_60), 
                         .clk(clk), 
                         .rst(RST), 
                         .clk_bps(XLXN_61));
   my_uart_tx  XLXI_16 (.clk(clk), 
                       .clk_bps(XLXN_61), 
                       .rst(RST), 
                       .rx_data(XLXN_124[7:0]), 
                       .rx_int(XLXN_125), 
                       .bps_start(XLXN_60), 
                       .rs232_tx(RS232_tx));*/
                      
   vga_top  XLXI_22 (.clk(clk), 
                    .ram_out(XLXN_79), 
                    .RST_N(XLXN_78), 
                    .x_max(XLXN_118[8:0]), 
                    .x_min(XLXN_94[8:0]), 
                    .y_max(XLXN_95[9:0]), 
                    .y_min(XLXN_120[8:0]), 
                    .addra(XLXN_20[17:0]), 
                    .clk_in(vga_bclk_DUMMY), 
                    .frame_sw(XLXN_107), 
                    .rec_clk(XLXN_126), 
                    .rec_clr(XLXN_127), 
                    .rgb_blank(vga_blank), 
                    .vga_hs(vga_hs), 
                    .vga_rgb(vga_rgb), 
                    .vga_vs(vga_vs));
   seg  XLXI_23 (.CMOS_VSYNC(CMOS_VSYNC), 
                .data_me(XLXN_48), 
                .guass_clk(guass_clk), 
                .RST_N(XLXN_40), 
                .x_max(XLXN_118[8:0]), 
                .x_min(XLXN_94[8:0]), 
                .x_zh(XLXN_105[8:0]), 
                .y_max(XLXN_95[9:0]), 
                .y_min(XLXN_120[8:0]), 
                .y_zh(XLXN_103[8:0]));
 /*  recognize  XLXI_27 (.clk_480(XLXN_125), 
                      .rec_clk(XLXN_126), 
                      .rec_clr(XLXN_127), 
                      .vga_rgb(XLXN_79), 
                      .x_max(XLXN_118[8:0]), 
                      .x_min(XLXN_94[8:0]), 
                      .x_zh(XLXN_105[8:0]), 
                      .y_max(XLXN_95[9:0]), 
                      .y_min(XLXN_120[8:0]), 
                      .y_zh(XLXN_103[8:0]), 
                      .fin_coun(XLXN_124[7:0]));
   clk_div_60000  XLXI_28 (.clk(clk), 
                          .rst(RST), 
                          .clk_480(XLXN_125));*/
                          
                          
//     wire rst_p;
//     assign rst_p = ~RST;
//     display_top display_top(
//         .clk(clk),
//         .rst(rst_p),
//         
//         .en_sw15(en_sw15),
//         
//         .rx_pin_jb1(rx_pin_jb1),
//         
//         .tx_data_in(Ctrl),
//         .tx_pin_jb0(tx_pin_jb0)
//     );
     
endmodule