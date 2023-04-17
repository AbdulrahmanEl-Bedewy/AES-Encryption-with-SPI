module ShiftRows #(parameter DATA_SIZE = 128, parameter Nb = 4) (
    input [7:0] istate[0:3][0:Nb-1],
    output [7:0] ostatestate[0:3][0:Nb-1]
);

reg [7:0] istate[0:3][0:Nb-1];
wire [7:0] ostatestate[0:3][0:Nb-1];

assign ostate[0] = {istate[0]};
assign ostate[1] = {istate[1][1:Nb], istate[1][0]};
assign ostate[2] = {istate[2][2:Nb], istate[1][0:1]};
assign ostate[3] = {istate[3][3:Nb], istate[1][0:2]};

endmodule