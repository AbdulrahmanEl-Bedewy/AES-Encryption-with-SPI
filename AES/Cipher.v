module Cipher #(parameter Nr=10,parameter Nk = 4)( //Nk = 4 for 128 bit key, 6 for 192 bit key, 8 for 256 bit key
    input [127:0]state,
    input [(128*(Nr+1))-1:0] w,
    output [127:0] Encrypted_Msg,
);


wire [127:0] state,Encrypted_Msg;

AddRoundKey k1(
    .state(state)
    .key(w[0+:128])
    .ostate(state)
);
genvar j;
generate
    for(j=0; j<Nr; j=j+1) begin
        SubBytes subBytes_inst1(
            .istate(state),
            .ostate(state)
        );
        ShiftRows shiftRows_inst1(
            .istate(state),
            .ostate(state)
        );
        MixColumns mixColumns_inst1(
            .state(state),
            .ostate(state)
        );
        AddRoundKey k2(
            .state(state)
            .key(w[j*128+:128])
            .ostate(state)
        );
    end
    SubBytes subBytes_inst2(
        .istate(state),
        .ostate(state)
    );
    ShiftRows shiftRows_inst2(
        .istate(state),
        .ostate(state)
    );
    AddRoundKey k3(
        .state(state)
        .key(w[Nr*128+:128])
        .ostate(state)
    );
    assign Encrypted_Msg = state;
endgenerate


endmodule