module AES_Encrypt #(parameter Nk = 4)( //Nk = 4 for 128 bit key, 6 for 192 bit key, 8 for 256 bit key
    input cs, //chip select
    input sclk,
    input sdi,
    output sdo,
    output ready,
);

SPI_sub #(.DATA_OUT(32*Nk)) SPI_sub_inst(
    .cs(cs),
    .sclk(sclk),
    .sdi(sdi),
    .tx(Encrypted_Msg), //to be sent
    .rx(Msg), //to be received
    .sdo(sdo),
    .done(done)
);

reg [32*Nk-1:0] Msg,Encrypted_Msg;
reg done;
reg isEncrypted;

initial begin
    Encrypted_Msg = 0;
    isEncrypted = 0;
end

always @ (*) begin
    if(done) begin
        //encrypt Msg to Encrypted_Msg
    end
end


endmodule