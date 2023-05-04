module AES_Encrypt_tb(
    output [127:0] out
);



reg [0:257] txMain;
wire [0:127] rxMain;



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


AES_Encrypt Encrypt(
    .cs(cs_n),
    .sclk(clk),
    .sdi(mosi),
    .sdo(miso)
);

initial begin
	clk = 1'b0;
	start = 1'b0;
	txMain = 130'h000102030405060708090a0b0c0d0e0f;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1800
	$display("rxMain = %h", rxMain);
	
    txMain = 130'h00112233445566778899aabbccddeeff;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1800
	$display("rxMain = %h", rxMain);
	
	// start = 1'b1;
	// #20 start = 1'b0;
	// #1800

	// $display("rxMain = %h", rxMain);
	// $display("rxSub = %h", rxSub);
	
	// txMain = 128'habde1;
	// txSub = 128'hfa4d;
	// start = 1'b1;
	// #20 start = 1'b0;
	// #1800;
	
	// $display("rxMain = %h", rxMain);
	// $display("rxSub = %h", rxSub);
	
end



always begin
	#1 clk = ~clk;
end

endmodule