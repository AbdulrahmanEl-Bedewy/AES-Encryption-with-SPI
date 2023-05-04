module Cipher #(parameter Nk = 4,parameter Nr=10)( //Nk = 4 for 128 bit key, 6 for 192 bit key, 8 for 256 bit key
    // input cs,
    input [0:127]init,
    input [0:128*(Nr+1)-1] w,
    output [0:127] Encrypted_Msg
);

wire [0:127] state [0:Nr],aSub[0:Nr],aShift[0:Nr],aMix[0:Nr];


AddRoundKey k1(
    .istate(init),
    .key(w[0:127]),
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