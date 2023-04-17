module AES_Encrypt #(parameter Nr=10,parameter Nk = 4)( //Nk = 4 for 128 bit key, 6 for 192 bit key, 8 for 256 bit key
    input cs, //chip select
    input sclk,
    input sdi,
    input [32*Nk-1:0] key,
    output sdo,
    output ready
);

SPI_sub #(.DATA_OUT(128)) SPI_sub_inst(
    .cs(cs),
    .sclk(sclk),
    .sdi(sdi),
    .tx(Encrypted_Msg), //to be sent
    .rx(Msg), //to be received
    .sdo(sdo),
    .done(done)
);

reg [127:0] Msg,Encrypted_Msg;

wire [(128*(Nr+1))-1:0] AllKeys;
wire [127:0] states [Nr+1:0];
wire [127:0] pSub,aSub;

//key expansion




endmodule