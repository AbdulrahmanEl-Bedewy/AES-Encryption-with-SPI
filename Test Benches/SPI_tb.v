module SPI_tb(

output reg [127:0] txMain,
output wire [127:0] rxMain,

output reg [127:0] txSub,
output wire [127:0] rxSub
);


wire miso;
reg start;
reg clk;
wire cs_n;
wire sclk;
wire mosi;
wire done;
wire doneSub;


SPI_Main spM(
	.clk(clk),
	.miso(miso),
	.start(start),
	.tx(txMain),
	.rx(rxMain),
	.cs_n(cs_n),
	.sclk(sclk),
	.mosi(mosi),
	.done(done)
);

SPI_Sub spS(
	.cs(cs_n),
	.sclk(sclk),
	.sdi(mosi),
	.tx(txSub), // sent from AES module
	.rx(rxSub), // sent to AES module
	.sdo(miso),
	.done(doneSub)
);

initial begin
	clk = 1'b0;
	start = 1'b0;
	txMain = 128'h00112233445566778899aabbccddeeff;
	txSub = 128'h0;
//	miso = 1'b1;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1700
	
	
	txMain = 128'h99999999999999999;
	txSub = 128'h555555555555555555;
	
	start = 1'b1;
	#20 start = 1'b0;
	#1700

	
	txMain = 128'habde1;
	txSub = 128'hfa4d;
	start = 1'b1;
	#20 start = 1'b0;
	#1700;

	
end



always begin
	#1 clk = ~clk;
end

endmodule 