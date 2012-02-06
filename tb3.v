`timescale 1ps/1ps
`define CLK_FREQ 100
`define BAUD_RATE 10

// test bench for uart
// adream307@gmail.com

module tb3();
reg clk;
reg rst_n;

initial begin
	clk=0;
	forever begin
		#10;
		clk=~clk;
	end
end

initial begin
	rst_n=0;
	repeat(4)@(negedge clk);
	rst_n=1;
end

reg rx;
wire tx;
wire [7:0] data;
wire rt;
wire tfinish;
reg sclk;
reg [15:0] cnt;
initial begin
	cnt=0;
	sclk=0;
	forever begin
		@(posedge clk);
		cnt=cnt+1;
		if(cnt==`CLK_FREQ/`BAUD_RATE/2) sclk=1;
		if(cnt==`CLK_FREQ/`BAUD_RATE)begin
			cnt=0;
			sclk=0;
		end
	end
end

reg [7:0] rdata;
reg [7:0] rdata_bak;
initial begin
	rx=1;
	rdata=0;
	rdata_bak=0;
	repeat(5)@(posedge sclk);
	repeat(256)begin
		rx=0;
		rdata=rdata_bak;
		@(posedge sclk);	//sending start bit
		repeat(8)begin
			rx=rdata[0];
			rdata={1'b0,rdata[7:1]};
			@(posedge sclk);
		end
		rx=1;
		@(posedge sclk);
		rdata_bak=rdata_bak+1;
		//$stop;
	end
	$stop;
end

initial begin
	forever begin
		@(negedge rt);
		@(posedge rt);
		$display("%d",data);
	end
end

UART uart_0(
	.iCLK(clk),
	.iRST_N(rst_n),
	.iRX(rx),
	.oTX(tx),
	.oR(rt),
	.oT(tfinish),
	.iT(rt),
	.iTDATA(data),
	.oRDATA(data)
);
defparam uart_0.CLK_FREQ=`CLK_FREQ;
defparam uart_0.BAUD_RATE=`BAUD_RATE;

endmodule
