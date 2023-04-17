module MixColumns (
    input [127:0] state,
    output [127:0] ostate
);
/*
[S'0c]    02 03 01 01 [S0c]
[S'1c]    01 02 03 01 [S1c]
[S'2c]    01 01 02 03 [S2c]
[S'3c]    03 01 01 02 [S3c]
*/
genvar i;
generate
    for(i=0; i<4; i=i+1) begin: mixColumns
        assign ostate[(i*32 + 24)+:8]= mult2(state[(i*32 + 24)+:8]) ^ mult3(state[(i*32 + 16)+:8]) ^ state[(i*32 + 8)+:8] ^ state[i*32+:8];
        assign ostate[(i*32 + 16)+:8]= state[(i*32 + 24)+:8] ^ mult2(state[(i*32 + 16)+:8]) ^ mult3(state[(i*32 + 8)+:8]) ^ state[i*32+:8];
        assign ostate[(i*32 + 8)+:8]= state[(i*32 + 24)+:8] ^ state[(i*32 + 16)+:8] ^ mult2(state[(i*32 + 8)+:8]) ^ mult3(state[i*32+:8]);
        assign ostate[i*32+:8]= mult3(state[(i*32 + 24)+:8]) ^ state[(i*32 + 16)+:8] ^ state[(i*32 + 8)+:8] ^ mult2(state[i*32+:8]);
    end
endgenerate

function [7:0] mult2
    (input [7:0] x);
    begin
        if (x[7]==1'b0) mult2 = x<<1;
        else mult2 = (x<<1) ^ 8'h1b;
    end
endfunction

function [7:0] mult3
    (input [7:0] x);
    begin
        mult3 = mult2(x) ^ x;
    end
endfunction



endmodule


