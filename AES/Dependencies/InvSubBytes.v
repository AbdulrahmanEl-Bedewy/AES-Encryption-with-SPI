module InvSubBytes (
    input [0:127] istate,
    output [0:127] ostate
);

genvar i;
generate
    for(i=0;i<16;i=i+1) begin : InvSubBytes
        InvS_Box sbox_inst(
            .istate(istate[i*8+:8]),
            .ostate(ostate[i*8+:8])
        );
    end
endgenerate

endmodule