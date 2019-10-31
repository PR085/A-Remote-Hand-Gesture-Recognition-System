`timescale 1ns / 1ps
module config_guass(
    input CMOS_oCLK,
    input iRST_N,
	input [7:0] DATA,
	input CMOS_VSYNC,
	//input pclk,
    output [7:0] reg1,
	output [7:0] reg2,
	output guass_clk
	//output pp_ram_write_clk
    );
	
	
//2bit counter
reg			byte_state;		
always@(posedge CMOS_oCLK or negedge iRST_N)
begin
	if(!iRST_N)
			begin
			byte_state <= 0;
			end
	else		
			begin
			byte_state <= byte_state + 1'b1;	
			end
end


//选择性的存到两个寄存器里面
reg [7:0] reg_1;
reg [7:0] reg_2;
assign reg1=reg_1;
assign reg2=reg_2;
always@(posedge CMOS_oCLK or negedge iRST_N)
begin
	if(!iRST_N)
			begin
			reg_1 <= 8'd0;
			reg_2 <= 8'd0;
			end
	else	
        if(!byte_state)	
		    begin
			  reg_2 <= DATA;	
			end
		else if(byte_state)
		    begin
			
			  reg_1 <= DATA;	
		    end
		else
		    begin
			reg_1 <= reg_1;
			reg_2 <= reg_2;
			end	    	  
end




//分频信号用来产生2分频（guass dsp工作信号）  会使结果再延后一个周期
reg clk_2;
assign  guass_clk=~clk_2;
// Attention: negedge CMOS_oCLK
always @ (negedge CMOS_oCLK or negedge iRST_N or posedge CMOS_VSYNC) 
begin
	if(!iRST_N)
			begin
			  clk_2<=0;
			end
	else if(CMOS_VSYNC)
	        begin
			  clk_2<=0;
			end
	else   
	        begin
           clk_2<=~clk_2;
			end
end

/*
reg guass_clk_rise;
always@(negedge guass_clk or negedge iRST_N)
begin
 if(!iRST_N)
   begin
	 guass_clk_rise <= 0;
	end
 else
	guass_clk_rise <= 1;
end
	
	
assign pp_ram_write_clk=pp_ram_write_clk_1;
reg pp_ram_write_clk_1;
always@(posedge pclk or negedge iRST_N)
begin
  if(!iRST_N)
   begin
	 pp_ram_write_clk_1 <= 0;
	end
  else if(guass_clk & guass_clk_rise)
   begin
     	pp_ram_write_clk_1 <= ~pp_ram_write_clk_1;

	end
  else
   pp_ram_write_clk_1 <= pp_ram_write_clk_1;
end
*/	

endmodule



