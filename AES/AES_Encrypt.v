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
wire [7:0] state[0:3][0:3];
wire [127:0] pSub,aSub;

//key expansion
KeyExpansion KeyEx(
    .key(key) //[(Nk*32)-1:0] key,
    .w(AllKeys) //reg [(128*(Nr+1))-1:0] w
);


always @(*) begin
    
    if(done ==1)begin

        AddRoundKey k1(
            .state(Msg)
            .key(AllKeys[0+:128])
            .ostate(Msg)
        );
        genvar j;
        generate
            for(j=1; j<Nr; j=j+1) begin
                SubBytes subBytes_inst1(
                    .istate(Msg),
                    .ostate(Msg)
                );
                ShiftRows shiftRows_inst1(
                    .istate(Msg),
                    .ostate(Msg)
                );
                MixColumns mixColumns_inst1(
                    .state(Msg),
                    .ostate(Msg)
                );
                AddRoundKey k2(
                    .state(Msg)
                    .key(AllKeys[j*128+:128])
                    .ostate(Msg)
                );
            end
        endgenerate
        SubBytes subBytes_inst2(
            .istate(Msg),
            .ostate(Msg)
        );
        ShiftRows shiftRows_inst2(
            .istate(Msg),
            .ostate(Msg)
        );
        AddRoundKey k3(
            .state(Msg)
            .key(AllKeys[Nr*128+:128])
            .ostate(Msg)
        );
        Encrypted_Msg = Msg;
    end
end



endmodule