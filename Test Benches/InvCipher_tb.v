module InvCipher_tb(
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

InvCipher C1 (
	.cs(cs),
	.clk(clk),
	.Nr(Nr),
	.init(in),
	.w(w),
	.Decrypted_Msg(out),
	.flag(flag)
);

initial begin
	 Nr = 10;
	 Nk = 4;
	 clk = 0;
	 cs = 0;
	 in = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    key = 128'h000102030405060708090a0b0c0d0e0f;
	 
	 #10 cs = 1;
	 
    
    #1000;
    $display("out = %h \n",out);
end

always begin
	#5 clk = ~clk;
end


endmodule