`timescale 1ns/10ps
module LEDDC( DCK, DAI, DEN, GCK, Vsync, mode, rst, OUT);
input           DCK;
input           DAI;
input           DEN;
input           GCK;
input           Vsync;
input           mode;
input           rst;
output reg [15:0]   OUT;

reg [4:0] bit_count;
reg [16:0] out_count;
reg [9:0] pix_count;
reg [6:0] scanline_count;
reg round_count;
reg [15:0] memory [511:0];
reg [15:0] out0_count;reg [15:0] out1_count;reg [15:0] out2_count;reg [15:0] out3_count;
reg [15:0] out4_count;reg [15:0] out5_count;reg [15:0] out6_count;reg [15:0] out7_count;
reg [15:0] out8_count;reg [15:0] out9_count;reg [15:0] out10_count;reg [15:0] out11_count;
reg [15:0] out12_count;reg [15:0] out13_count;reg [15:0] out14_count;reg [15:0] out15_count;
reg [15:0] out0_count_1;reg [15:0] out1_count_1;reg [15:0] out2_count_1;reg [15:0] out3_count_1;
reg [15:0] out4_count_1;reg [15:0] out5_count_1;reg [15:0] out6_count_1;reg [15:0] out7_count_1;
reg [15:0] out8_count_1;reg [15:0] out9_count_1;reg [15:0] out10_count_1;reg [15:0] out11_count_1;
reg [15:0] out12_count_1;reg [15:0] out13_count_1;reg [15:0] out14_count_1;reg [15:0] out15_count_1;
reg [15:0] buffer;

always@(posedge DCK or posedge rst)begin
	if(rst)
		bit_count<=0;
	else if( bit_count==17)
		bit_count<=0;
	else if(pix_count==512)
		bit_count<=0;
	else
		bit_count<=bit_count+1;
end

always@(posedge DCK or posedge rst)begin
	if(rst)
		buffer<=0;
	else if(DEN)
		buffer[bit_count]<=DAI;
	else buffer<=0;
end

always@(posedge DCK)begin
	if(bit_count==16)
		memory[pix_count]<=buffer;
end

always@(posedge DCK or posedge rst)begin
	if(rst)
		pix_count<=0;
	else if(bit_count==17)
		pix_count<=pix_count+1;
	else if (pix_count==512 && !DEN)
		pix_count<=0;
end

always@(posedge GCK or posedge rst)begin
	if(rst)
		out_count<=0;
	else if (!Vsync)
		out_count<=0;
	else 
		out_count<=out_count+1;
end

always@(posedge GCK or posedge rst)begin
	if(rst)
		round_count<=0;
	else if(scanline_count==32)
		round_count<=round_count+1;
end

always@(posedge GCK)begin
	
	 if(Vsync)begin
		if(out0_count!=0) out0_count<=out0_count-1;
		if(out1_count!=0) out1_count<=out1_count-1;
		if(out2_count!=0) out2_count<=out2_count-1;
		if(out3_count!=0) out3_count<=out3_count-1;
		if(out4_count!=0) out4_count<=out4_count-1;
		if(out5_count!=0) out5_count<=out5_count-1;
		if(out6_count!=0) out6_count<=out6_count-1;
		if(out7_count!=0) out7_count<=out7_count-1;
		if(out8_count!=0) out8_count<=out8_count-1;
		if(out9_count!=0) out9_count<=out9_count-1;
		if(out10_count!=0) out10_count<=out10_count-1;
		if(out11_count!=0) out11_count<=out11_count-1;
		if(out12_count!=0) out12_count<=out12_count-1;
		if(out13_count!=0) out13_count<=out13_count-1;
		if(out14_count!=0) out14_count<=out14_count-1;
		if(out15_count!=0) out15_count<=out15_count-1;
	end
		
	else if(out_count==0 && mode==0)begin
		out0_count<=memory[0+(scanline_count<<4)];
		out1_count<=memory[1+(scanline_count<<4)];
		out2_count<=memory[2+(scanline_count<<4)];
		out3_count<=memory[3+(scanline_count<<4)];
		out4_count<=memory[4+(scanline_count<<4)];
		out5_count<=memory[5+(scanline_count<<4)];
		out6_count<=memory[6+(scanline_count<<4)];
		out7_count<=memory[7+(scanline_count<<4)];
		out8_count<=memory[8+(scanline_count<<4)];
		out9_count<=memory[9+(scanline_count<<4)];
		out10_count<=memory[10+(scanline_count<<4)];
		out11_count<=memory[11+(scanline_count<<4)];
		out12_count<=memory[12+(scanline_count<<4)];
		out13_count<=memory[13+(scanline_count<<4)];
		out14_count<=memory[14+(scanline_count<<4)];
		out15_count<=memory[15+(scanline_count<<4)];
	end
	
	else if (out_count==0 && mode==1 && round_count==0)begin
		out0_count<=((memory[0+(scanline_count<<4)]+1)>>1);
		out1_count<=((memory[1+(scanline_count<<4)]+1)>>1);
		out2_count<=((memory[2+(scanline_count<<4)]+1)>>1);
		out3_count<=((memory[3+(scanline_count<<4)]+1)>>1);
		out4_count<=((memory[4+(scanline_count<<4)]+1)>>1);
		out5_count<=((memory[5+(scanline_count<<4)]+1)>>1);
		out6_count<=((memory[6+(scanline_count<<4)]+1)>>1);
		out7_count<=((memory[7+(scanline_count<<4)]+1)>>1);
		out8_count<=((memory[8+(scanline_count<<4)]+1)>>1);
		out9_count<=((memory[9+(scanline_count<<4)]+1)>>1);
		out10_count<=((memory[10+(scanline_count<<4)]+1)>>1);
		out11_count<=((memory[11+(scanline_count<<4)]+1)>>1);
		out12_count<=((memory[12+(scanline_count<<4)]+1)>>1);
		out13_count<=((memory[13+(scanline_count<<4)]+1)>>1);
		out14_count<=((memory[14+(scanline_count<<4)]+1)>>1);
		out15_count<=((memory[15+(scanline_count<<4)]+1)>>1);
	end
end
always@(posedge GCK)begin
	if(Vsync && round_count==1)begin
		if(out0_count_1!=0) out0_count_1<=out0_count_1-1;
		if(out1_count_1!=0) out1_count_1<=out1_count_1-1;
		if(out2_count_1!=0) out2_count_1<=out2_count_1-1;
		if(out3_count_1!=0) out3_count_1<=out3_count_1-1;
		if(out4_count_1!=0) out4_count_1<=out4_count_1-1;
		if(out5_count_1!=0) out5_count_1<=out5_count_1-1;
		if(out6_count_1!=0) out6_count_1<=out6_count_1-1;
		if(out7_count_1!=0) out7_count_1<=out7_count_1-1;
		if(out8_count_1!=0) out8_count_1<=out8_count_1-1;
		if(out9_count_1!=0) out9_count_1<=out9_count_1-1;
		if(out10_count_1!=0) out10_count_1<=out10_count_1-1;
		if(out11_count_1!=0) out11_count_1<=out11_count_1-1;
		if(out12_count_1!=0) out12_count_1<=out12_count_1-1;
		if(out13_count_1!=0) out13_count_1<=out13_count_1-1;
		if(out14_count_1!=0) out14_count_1<=out14_count_1-1;
		if(out15_count_1!=0) out15_count_1<=out15_count_1-1;
	end

	else if (!Vsync && pix_count==0)begin
		if(out0_count_1[0]!=0) out0_count_1<= out0_count-1;
			else out0_count_1<= out0_count;
		if(out1_count_1[0]!=0) out1_count_1<= out1_count-1;
			else out1_count_1<= out1_count;
		if(out2_count_1[0]!=0) out2_count_1<= out2_count-1;
			else out2_count_1<= out2_count;
		if(out3_count_1[0]!=0) out3_count_1<= out3_count-1;
			else out3_count_1<= out3_count;
		if(out4_count_1[0]!=0) out4_count_1<= out4_count-1;
			else out4_count_1<= out4_count;
		if(out5_count_1[0]!=0) out5_count_1<= out5_count-1;
			else out5_count_1<= out5_count;
		if(out6_count_1[0]!=0) out6_count_1<= out6_count-1;
			else out6_count_1<= out6_count;
		if(out7_count_1[0]!=0) out7_count_1<= out7_count-1;
			else out7_count_1<= out7_count;
		if(out8_count_1[0]!=0) out8_count_1<= out8_count-1;
			else out8_count_1<= out8_count;
		if(out9_count_1[0]!=0) out9_count_1<= out9_count-1;
			else out9_count_1<= out9_count;
		if(out10_count_1[0]!=0) out10_count_1<= out10_count-1;
			else out10_count_1<= out10_count;
		if(out11_count_1[0]!=0) out11_count_1<= out11_count-1;
			else out11_count_1<= out11_count;
		if(out12_count_1[0]!=0) out12_count_1<= out12_count-1;
			else out12_count_1<= out12_count;
		if(out13_count_1[0]!=0) out13_count_1<= out13_count-1;
			else out13_count_1<= out13_count;
		if(out14_count_1[0]!=0) out14_count_1<= out14_count-1;
			else out14_count_1<= out14_count;
		if(out15_count_1[0]!=0) out15_count_1<= out15_count-1;
			else out15_count_1<= out15_count
		
	end
end

always@(posedge GCK or posedge rst)begin
	if(rst)
		scanline_count<=0;
	if(mode==0)begin
		if(out_count==65536)
			scanline_count<=scanline_count+1;
		else if(scanline_count==32)
			scanline_count<=0;
		end
	else if(mode==1)begin
		if(out_count==32768)
			scanline_count<=scanline_count+1;
		else if(scanline_count==32)
			scanline_count<=0;
		end
			
end


always@(*)begin
	if(Vsync && out0_count!=0 && round_count==0 )
		OUT[0]=1;
	else if(Vsync && out0_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[0]=0;
	if(Vsync && out1_count!=0 && round_count==0 )
		OUT[1]=1;
	else if(Vsync && out1_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[1]=0;
	if(Vsync && out2_count!=0 && round_count==0 )
		OUT[2]=1;
	else if(Vsync && out2_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[2]=0;
	if(Vsync && out3_count!=0 && round_count==0 )
		OUT[3]=1;
	else if(Vsync && out3_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[3]=0;
	if(Vsync && out4_count!=0 && round_count==0 )
		OUT[4]=1;
	else if(Vsync && out4_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[4]=0;
	if(Vsync && out5_count!=0 && round_count==0 )
		OUT[5]=1;
	else if(Vsync && out5_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[5]=0;
	if(Vsync && out6_count!=0 && round_count==0 )
		OUT[6]=1;
	else if(Vsync && out6_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[6]=0;
	if(Vsync && out7_count!=0 && round_count==0)
		OUT[7]=1;
	else if(Vsync && out7_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[7]=0;
	if(Vsync && out8_count!=0 && round_count==0)
		OUT[8]=1;
	else if(Vsync && out8_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[8]=0;
	if(Vsync && out9_count!=0 && round_count==0)
		OUT[9]=1;
	else if(Vsync && out9_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[9]=0;
	if(Vsync && out10_count!=0 && round_count==0)
		OUT[10]=1;
	else if(Vsync && out10_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[10]=0;
	if(Vsync && out11_count!=0 && round_count==0)
		OUT[11]=1;
	else if(Vsync && out11_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[11]=0;
	if(Vsync && out12_count!=0 && round_count==0)
		OUT[12]=1;
	else if(Vsync && out12_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[12]=0;
	if(Vsync && out13_count!=0 && round_count==0)
		OUT[13]=1;
	else if(Vsync && out13_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[13]=0;
	if(Vsync && out14_count!=0 && round_count==0)
		OUT[14]=1;
	else if(Vsync && out14_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[14]=0;
	if(Vsync && out15_count!=0 && round_count==0)
		OUT[15]=1;
	else if(Vsync && out15_count_1!=0 && round_count==1 )
		OUT[0]=1;
	else
		OUT[15]=0;
end



		

	
		
	
		
		
		
		
endmodule