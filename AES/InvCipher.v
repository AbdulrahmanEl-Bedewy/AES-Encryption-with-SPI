module InvCipher #(parameter Nr=10,parameter Nk=4)(
    input [127:0]state, 
    input [(128*(Nr+1))-1:0] w,
    output [127:0] Decrypted_Msg,
);

wire [127:0] state,Decrypted_Msg;

AddRoundKey k1(
    .state(state)
    .key(w[Nr*128+:128])
    .ostate(state)
);

genvar round;
generate
    for(round=Nr-1; round>=1; round=round-1) begin
        InvShiftRows shiftRows_inst1(
            .istate(state),
            .ostate(state)
        );
        InvSubBytes subBytes_inst1(
            .istate(state),
            .ostate(state)
        );
        AddRoundKey k2(
            .state(state)
            .key(w[round*128+:128])
            .ostate(state)
        );
        InvMixColumns mixColumns_inst1(
            .state(state),
            .ostate(state)
        );
    end

    InvShiftRows shiftRows_inst2(
        .istate(state),
        .ostate(state)
    );
    InvSubBytes subBytes_inst2(
        .istate(state),
        .ostate(state)
    );
    AddRoundKey k3(
        .state(state)
        .key(w[0+:128])
        .ostate(state)
    );
    assign Decrypted_Msg = state;
endgenerate


endmodule