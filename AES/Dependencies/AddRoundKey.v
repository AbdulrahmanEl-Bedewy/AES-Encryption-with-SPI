module AddRoundKey (
    input [127:0] istate, // 128-bit input state
    input [127:0] key, // 128-bit key
    output [127:0] ostate // 128-bit output state
);

assign ostate = key ^ istate; // XOR the input state with the key and assign the result to the output state

endmodule
