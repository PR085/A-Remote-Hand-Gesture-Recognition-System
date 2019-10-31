`timescale 1ns/1ns
module CMOS_Capture
(
	
	
	input				iRST_N,

	//I2C鍒濆鍖栧畬鎴愭爣蹇	
	input				Init_Done,		
	
	//cmos浼犳劅鍣ㄦ帴鍙    
	input				CMOS_PCLK,			//25MHz	
	input	[7:0]		CMOS_iDATA,		
	input				CMOS_VSYNC,		//鍦烘暟鎹	
	input				CMOS_HREF,		//琛屾暟鎹	
	//cmos浼犳劅鍣ㄨ緭鍑	
	output	reg			CMOS_oCLK,	 //涓婂崌娌挎暟鎹湁鏁
	output	reg	[7:0]	CMOS_oDATA, //YUV	
	output	reg			CMOS_VALID);		//鏁版嵁鏈夋晥鎬
		

reg		mCMOS_VSYNC;
always@(posedge CMOS_PCLK or negedge iRST_N)
begin
	if(!iRST_N)
		mCMOS_VSYNC <= 1;
	else
		mCMOS_VSYNC <= CMOS_VSYNC;		//鍦哄悓姝ワ細浣庣數骞虫湁鏁
	end
wire	CMOS_VSYNC_over = ({mCMOS_VSYNC,CMOS_VSYNC} == 2'b01) ? 1'b1 : 1'b0;	//VSYNC negtive edge



reg byte_state;		
reg [7:0]  	Pre_CMOS_iDATA;
always@(posedge CMOS_PCLK or negedge iRST_N)
begin
	if(!iRST_N)
		begin
		byte_state <= 0;
		Pre_CMOS_iDATA <= 8'd0;
		CMOS_oDATA <= 8'd0;
		end
	else
		begin
		if(~CMOS_VSYNC & CMOS_HREF)			//琛屽満鏈夋晥 
			begin
			byte_state <= byte_state + 1'b1;	
			case(byte_state)
			1'b0 :	CMOS_oDATA[7:0] <= CMOS_iDATA;
			1'b1 : 	Pre_CMOS_iDATA[7:0]<= CMOS_iDATA; //只输出了CrCb信号而将Y信号过滤掉
			endcase
			end
		else
			begin
			byte_state <= 0;
			Pre_CMOS_iDATA <= 8'd0;
			CMOS_oDATA <= CMOS_oDATA;
			end
		end
end



//绛夊緟浼犳劅鍣ㄨ緭鍑烘暟鎹湁鏁   鍗佸抚鍚庢湁鏁
reg	[3:0] 	Frame_Cont;
reg 		Frame_valid;
always@(posedge CMOS_PCLK or negedge iRST_N)
begin
	if(!iRST_N)
		begin
		Frame_Cont <= 0;
		Frame_valid <= 0;
		end
	else if(Init_Done)					//CMOS I2C鍒濆鍖栧畬姣		
	begin
		if(CMOS_VSYNC_over == 1'b1)		//一帧采样结束信号（此信号保持一个上升沿）			
		begin
			if(Frame_Cont < 10)
				begin
				Frame_Cont	<=	Frame_Cont + 1'b1;
				Frame_valid <= 1'b0;
				end
			else
				begin
				Frame_Cont	<=	Frame_Cont;
				Frame_valid <= 1'b1;		//Frame valid一直都是1，应为表示帧可以读出了
				end
			end
		end
end



//frame valid=1 nearly for all. When read Y data(byte_state=1),CMOS_oclk flips
//When in flip phase, the frequency of CMOS_oclk is half the CMOS_PCLK(see picture in blog)
//此处代码及其容易误解，在byte_state=1器件的clk置低是通过最后一个else实现的；因此oclk的频率还是PCLK一半12.5MHz
always@(posedge CMOS_PCLK or negedge iRST_N)
begin
	if(!iRST_N)
		CMOS_oCLK <= 0;
	else if(Frame_valid == 1'b1 && byte_state)//(X_Cont >= 12'd1 && X_Cont <= H_DISP))
		CMOS_oCLK <= ~CMOS_oCLK;
	else
		CMOS_oCLK <= 0;
end



//When CMOS_VSYNC=0, the data is valid
//Note also that Frame_valid is 1 for all time but the first 10 frames
always@(posedge CMOS_PCLK or negedge iRST_N)
begin
	if(!iRST_N)
		CMOS_VALID <= 0;
	else if(Frame_valid == 1'b1)
		CMOS_VALID <= ~CMOS_VSYNC;
	else
		CMOS_VALID <= 0;
end


endmodule



