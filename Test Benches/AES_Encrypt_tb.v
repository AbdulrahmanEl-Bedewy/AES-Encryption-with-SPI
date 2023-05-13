module AES_Encrypt_tb(
    output [0:127] rxMain
);



reg [0:257] txMain;
//wire [0:127] rxMain;

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
    .sclk(sclk),
    .sdi(mosi),
    .sdo(miso)
);

initial begin
	clk = 1'b0;
	start = 1'b0;
//=============================TEST 1============================================
	txMain = 130'h000102030405060708090a0b0c0d0e0f;
//	txMain = 130'h2b7e151628aed2a6abf7158809cf4f3c;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1800
	$display("Key Used = %h", txMain);
	
    txMain = 130'h00112233445566778899aabbccddeeff;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1800
	$display("Msg Used = %h", txMain);
	
	txMain = 130'h0;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1800
	$display("Encrypted Msg = %h", rxMain);

//=============================TEST 2============================================
	txMain = 258'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
	txMain = {2'b10, txMain[2:257]};
//	txMain = 130'h2b7e151628aed2a6abf7158809cf4f3c;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#2800
	$display("Key Used = %h", txMain);
	
    txMain = 130'h00112233445566778899aabbccddeeff;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1800
	$display("Msg Used = %h", txMain);
	
	txMain = 130'h0;
	#20 start = 1'b1;
	#20 start = 1'b0;
	#1800
	$display("Encrypted Msg = %h", rxMain);
	
end



always begin
	#1 clk = ~clk;
end

endmodule