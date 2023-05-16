module Cipher_tb(
    output [127:0] out
);


reg [0:3] Nr;
reg [0:3] Nk;

reg [127:0] in;
reg [255:0] key;
wire [1919:0] w;

KeyExpansion KE1 (
    .Nk(Nk),
    .Nr(Nr), 
    .key(key),
    .w(w)
);

reg cs;
reg clk;
wire [0:127] Msg;
wire flag;

Cipher C1 (
	.cs(cs),
	.clk(clk),
	.Nr(Nr),
	.init(in),
	.w(w),
	.Encrypted_Msg(out),
	.flag(flag)
);

initial begin
	 Nr = 14;
	 Nk = 8;
	 clk = 0;
	 cs = 0;
	 in = 128'h00112233445566778899aabbccddeeff;
    key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
	 
	 #10 cs = 1;
	 
    
    #1000;
    $display("out = %h \n",out);
end

always begin
	#5 clk = ~clk;
end

endmodule