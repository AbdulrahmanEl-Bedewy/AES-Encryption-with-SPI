module AddRoundKey #(parameter DATA_SIZE = 128) (
    input [DATA_SIZE-1:0] state,
    input [DATA_SIZE-1:0] key,
    output [DATA_SIZE-1:0] ostate
);


assign out = key ^ state;

endmodule