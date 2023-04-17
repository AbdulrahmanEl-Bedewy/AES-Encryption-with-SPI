module Cipher #(parameter Nr=10,parameter Nk = 4)( //Nk = 4 for 128 bit key, 6 for 192 bit key, 8 for 256 bit key
    input [127:0]init,
    input [(128*(Nr+1))-1:0] w,
    output [127:0] Encrypted_Msg
);

wire [127:0] state [Nr+1:0],aSub[Nr+1:0],aShift[Nr+1:0],aMix[Nr+1:0],aAdd[Nr+1:0];


AddRoundKey k1(
    .istate(init),
    .key(w[0+:128]),
    .ostate(state[0])
);

genvar round;
generate
    for(round=1; round<Nr; round=round+1) begin :cipher
        SubBytes subBytes_inst1(
            .istate(state[round-1]),
            .ostate(aSub[round])
        );
        ShiftRows shiftRows_inst1(
            .istate(aSub[round]),
            .ostate(aShift[round])
        );
        MixColumns mixColumns_inst1(
            .state(aShift[round]),
            .ostate(aMix[round])
        );
        AddRoundKey k2(
            .istate(aMix[round]),
            .key(w[round*128+:128]),
            .ostate(state[round])
        );
    end
    SubBytes subBytes_inst2(
        .istate(state[Nr-1]),
        .ostate(aSub[Nr])
    );
    ShiftRows shiftRows_inst2(
        .istate(aSub[Nr]),
        .ostate(aShift[Nr])
    );
    AddRoundKey k3(
        .istate(aShift[Nr]),
        .key(w[Nr*128+:128]),
        .ostate(state[Nr])
    );
endgenerate
assign Encrypted_Msg = state[Nr];


endmodule