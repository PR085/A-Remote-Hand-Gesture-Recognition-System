module median(guass_clk,CMOS_VSYNC,data_in,data_me);


input CMOS_VSYNC;
input guass_clk;
input data_in;
output data_me;




// //////////////////////////////ram input address counter/////////////////////////////
reg[17:0]frame_reg;
wire[17:0]addra;
assign addra=frame_reg;




always@(posedge guass_clk or posedge CMOS_VSYNC)
begin
   if(CMOS_VSYNC)
	    begin
        frame_reg<=18'd0;
		end
		  
		  
	else if(frame_reg==18'd153599)
		begin
		frame_reg<=18'd0;
	    end
	
   else if( frame_reg<18'd153599)
        begin
		frame_reg<=frame_reg+1'd1;
		end      
	else
	    begin
		frame_reg<=frame_reg;
		end
end
///////////////////////////////////////////////////////////////////






////////////////////////////九个ram的输出地址////////////////////////
reg[17:0]meout_reg;
wire[17:0]addrb;
assign addrb=meout_reg;



always@(posedge guass_clk or posedge CMOS_VSYNC)
begin
   if(CMOS_VSYNC)
	    begin
        meout_reg<=18'd0;
		end
		  
		  
	else if(meout_reg==18'd153599)
		begin
		meout_reg<=0;
	    end
	
   else if( meout_reg<18'd153599)
        begin
		meout_reg<=meout_reg+1'd1;
		end      
	else
	    begin
		meout_reg<=meout_reg;
		end
end

     
///////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////中值滤波结果的比较///////////////////////////////
wire[17:0] dout_addr1;
wire[17:0] dout_addr2;
wire[17:0] dout_addr3;
wire[17:0] dout_addr4;
wire[17:0] dout_addr5;
wire[17:0] dout_addr6;
wire[17:0] dout_addr7;
wire[17:0] dout_addr8;
wire[17:0] dout_addr9;

assign dout_addr1=addrb;
assign dout_addr2=(addrb<=18'd152957)?addrb+1'd1:addrb;
assign dout_addr3=(addrb<=18'd152957)?addrb+2'd2:addrb;
assign dout_addr4=(addrb<=18'd152957)?addrb+9'd320:addrb;
assign dout_addr5=(addrb<=18'd152957)?addrb+9'd321:addrb;
assign dout_addr6=(addrb<=18'd152957)?addrb+9'd322:addrb;
assign dout_addr7=(addrb<=18'd152957)?addrb+10'd640:addrb;
assign dout_addr8=(addrb<=18'd152957)?addrb+10'd641:addrb;
assign dout_addr9=(addrb<=18'd152957)?addrb+10'd642:addrb;


wire[3:0] sum;
wire data_me;
wire dout1,dout2,dout3,dout4,dout5,dout6,dout7,dout8,dout9;
//assign dout9=0;
//assign dout5=0;
//assign dout6=0;
//assign dout7=0;
//assign dout8=0;

assign sum=dout1+dout2+dout3+dout4+dout5+dout6+dout7+dout8+dout9;
assign data_me=(sum>3'd4)?1:0;
//////////////////////////////////////////////////////////////////////////////////////////////////////



ram1 U_ram1	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr1[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout1) // output [0 : 0] doutb
);

ram1 U_ram2	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr2[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout2) // output [0 : 0] doutb
);

ram1 U_ram3	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr3[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout3) // output [0 : 0] doutb
);

ram1 U_ram4	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr4[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout4) // output [0 : 0] doutb
);

ram1 U_ram5	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr5[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout5) // output [0 : 0] doutb
);

ram1 U_ram6	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr6[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout6) // output [0 : 0] doutb
);

ram1 U_ram7	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr7[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout7) // output [0 : 0] doutb
);

ram1 U_ram8	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr8[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout8) // output [0 : 0] doutb
);

ram1 U_ram9	 (
  .clock(guass_clk), // input clka
  .wren(1'b1), // input [0 : 0] wea  first write ram
  .rdaddress(dout_addr9[17:0]), // input [17 : 0] addra
  .data(data_in), // input [0 : 0] dina
//  .clkb(guass_clk), // input clkb
  .wraddress(addra[17:0]), // input [17 : 0] addrb
  .q(dout9) // output [0 : 0] doutb
);
	
endmodule
		
		
		
		
		

   
        
