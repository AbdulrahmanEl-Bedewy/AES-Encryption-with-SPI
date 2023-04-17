module Cipher_tb(
    output [127:0] out
);

reg [127:0] in;
reg [127:0] key;
wire [(128*(10+1))-1:0] w;

localparam Nr = 10;
localparam Nk = 4;

KeyExpansion KE1 #(Nk,Nr)(
    .key(key),
    .w(w)
);

Cipher C1 #(Nr,Nk)(
    .init(in),
    .w(w),
    .Encrypted_Msg(out)
);

initial begin
    in = 128'h00112233445566778899aabbccddeeff;
    key = 128'h000102030405060708090a0b0c0d0e0f;
    
    #100  $finish;      // Terminate simulation
end


endmodule