module AddRoundKey (
    input [127:0] istate,
    input [127:0] key,
    output [127:0] ostate
);


assign ostate = key ^ istate;

endmodule