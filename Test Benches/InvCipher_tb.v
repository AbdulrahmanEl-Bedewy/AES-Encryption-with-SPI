module InvCipher_tb(
    output [127:0] out
);


localparam Nr = 10;
localparam Nk = 4;

reg [127:0] in;
reg [32*Nk-1:0] key;
wire [(128*(Nr+1))-1:0] w;

//KeyExpansion #(Nk,Nr)KE1 (
//    .key(key),
//    .w(w)
//);

InvCipher #(Nk,Nr) C1 (
    .init(in),
    .w(w),
    .Decrypted_Msg(out)
);

initial begin
    in = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    key = 128'h000102030405060708090a0b0c0d0e0f;
    
    #100;
    $display("out = %h \n",out);
end


endmodule