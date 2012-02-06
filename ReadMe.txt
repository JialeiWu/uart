verilog module for serial asynchronous communication, for example, the serial port of PC
8/N/1
8 bits data, no parity check, 1 bit stop
the parameter CLK_FREQ is the frequence of system clock
the parameter BAUD_RATE is the baud rate of current transmission

example:

UART uart_0(
	.iCLK(clk),
	.iRST_N(rst_n),
	.iRX(rx),  // connect with the fpga pin
	.oTX(tx),  // conncet with the fpga pin
	.oR(rt),
	.oT(tfinish),
	.iT(rt),
	.iTDATA(data),
	.oRDATA(data)
);



adream307@gmail.com