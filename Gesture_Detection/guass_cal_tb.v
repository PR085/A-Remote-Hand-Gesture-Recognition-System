module guass_cal_tb();
    reg [7:0]Cr;
    reg [7:0]Cb;
    wire result;
    reg clk;
    reg rst;
    
    always #5 clk=~clk;
    
    initial
     begin
      clk=0;
      rst=0;
     #2 rst=1;
     Cb=121;
     Cr=132;
     #10
     Cb=125;
     Cr=132;
     #10
     Cb=125;
     Cr=145;
     #10
     Cb=124;
     Cr=142;
     end
    
    guass_dsp_cal tb1(.clk(clk), .rst(rst),.Cb(Cb),.Cr(Cr),.guass_odata(result));
    
endmodule