`timescale 1ns / 1ps


module guass_dsp_cal(
        clk,
        rst,
        Cb,
        Cr,
        guass_odata
    );
    input clk;
    input rst;
    input [7:0]Cb;
    input [7:0]Cr;
    output guass_odata;
    wire [8:0]diff1;
    wire [8:0]diff2;
    wire [17:0]mul1,mul2,mul3;
    wire [32:0]res1,res2,res3;
    wire [32:0]result;
    wire [32:0]threshold;
    assign threshold=(14<<14);
    assign diff1=Cb-123;
    assign diff2=Cr-139;
    
    assign result=res1-res2+res3;
    assign guass_odata=result<threshold?1:0;
    mul_16 multipier1 (
      .dataa(diff1),      // input wire [8 : 0] A
      .datab(diff1),      // input wire [8 : 0] B
      .result(mul1)      // output wire [17 : 0] P
    );
    mul_16 multipier2 (
      .dataa(diff1),      // input wire [8 : 0] A
      .datab(diff2),      // input wire [8 : 0] B
      .result(mul2)      // output wire [17 : 0] P
    );
    mul_16 multipier3 (
      .dataa(diff2),      // input wire [8 : 0] A
      .datab(diff2),      // input wire [8 : 0] B
      .result(mul3)      // output wire [17 : 0] P
    );
    multiply_const1 constant1 (
      .dataa(mul1),  // input wire [17 : 0] A
      .result(res1)  // output wire [31 : 0] P
    );
    multiply_const2 constant2(
      .dataa(mul2),  // input wire [17 : 0] A
      .result(res2)  // output wire [31 : 0] P
    );
    multiply_const3 constant3 (
      .dataa(mul3),  // input wire [17 : 0] A
      .result(res3)  // output wire [31 : 0] P
    );    
endmodule
