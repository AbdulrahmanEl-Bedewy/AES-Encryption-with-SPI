module InvCipher_tb(
    output [127:0] out
);


localparam Nr = 14;
localparam Nk = 8;

reg [127:0] in;
reg [32*Nk-1:0] key;
wire [(128*(Nr+1))-1:0] w;

KeyExpansion #(Nk,Nr)KE1 (
    .key(key),
    .w(w)
);

InvCipher #(Nk,Nr) C1 (
    .init(in),
    .w(w),
    .Decrypted_Msg(out)
);

initial begin
    in = 128'h8ea2b7ca516745bfeafc49904b496089;
    key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
    
    #10000;
    $display("out = %h \n",out);
end


endmodule