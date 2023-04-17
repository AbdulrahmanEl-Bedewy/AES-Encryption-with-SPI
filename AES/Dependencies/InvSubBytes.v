module InvSubBytes (
    input [127:0] istate,
    output [127:0] ostate
);

genvar i;
generate
    for(i=0;i<16;i=i+1) begin : InvSubBytes
        InvS_Box sbox_inst(
            .istate(istate[i*8+7:i*8]),
            .ostate(ostate[i*8+7:i*8])
        );
    end
endgenerate

endmodule