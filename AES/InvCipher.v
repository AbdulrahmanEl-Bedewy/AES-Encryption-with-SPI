module InvCipher #(parameter Nk=4,parameter Nr=10)(
    input [0:127]init, 
    input [0:128*(Nr+1)-1] w,
    output [0:127] Decrypted_Msg
);

wire [0:127] state [0:Nr],aSub[0:Nr],aShift[0:Nr],aAdd[0:Nr];


AddRoundKey k1(
    .istate(init),
    .key(w[Nr*128+:128]),
    .ostate(state[Nr])
);

genvar round;
generate
    for(round=Nr-1; round>=1; round=round-1) begin :invcipher
        InvShiftRows shiftRows_inst1(
            .istate(state[round+1]),
            .ostate(aShift[round])
        );
        InvSubBytes subBytes_inst1(
            .istate(aShift[round]),
            .ostate(aSub[round])
        );
        AddRoundKey k2(
            .istate(aSub[round]),
            .key(w[round*128+:128]),
            .ostate(aAdd[round])
        );
        InvMixColumns mixColumns_inst1(
            .istate(aAdd[round]),
            .ostate(state[round])
        );
    end
    InvShiftRows shiftRows_inst2(
        .istate(state[1]),
        .ostate(aShift[0])
    );
    InvSubBytes subBytes_inst2(
        .istate(aShift[0]),
        .ostate(aSub[0])
    );
    AddRoundKey k3(
        .istate(aSub[0]),
        .key(w[0+:128]),
        .ostate(state[0])
    );
endgenerate
assign Decrypted_Msg = state[0];



endmodule