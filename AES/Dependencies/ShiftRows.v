module ShiftRows (
    input [0:127] istate,
    output [0:127] ostate
);

//reg [127:0] istate;
//wire [127:0] ostate;

//top most row r = 1 (1 indexed)
assign ostate[0+:8] = istate[0+:8];
assign ostate[32+:8] = istate[32+:8];
assign ostate[64+:8] = istate[64+:8];
assign ostate[96+:8] = istate[96+:8];


//row r = 2 (1 indexed)
assign ostate[8+:8] = istate[40+:8];
assign ostate[40+:8] = istate[72+:8];
assign ostate[72+:8] = istate[104+:8];
assign ostate[104+:8] = istate[8+:8];


//row r = 3 (1 indexed)
assign ostate[16+:8] = istate[80+:8];
assign ostate[48+:8] = istate[112+:8];
assign ostate[80+:8] = istate[16+:8];
assign ostate[112+:8] = istate[48+:8];

//bottom most row r = 4 (1 indexed)
assign ostate[24+:8] = istate[120+:8];
assign ostate[56+:8] = istate[24+:8];
assign ostate[88+:8] = istate[56+:8];
assign ostate[120+:8] = istate[88+:8];


endmodule