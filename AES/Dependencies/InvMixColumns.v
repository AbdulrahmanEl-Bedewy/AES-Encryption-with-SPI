module InvMixColumns (
    input [127:0] istate,
    output [127:0] ostate
);

/*
    0e 0b 0d 09
    09 0e 0b 0d
    0d 09 0e 0b
    0b 0d 09 0e 
*/

// b d e

function [7:0] mult2
    (input [7:0] x);
    begin
        if(x[7]==1'b0) mult2 = x<<1;
        else mult2 = (x<<1) ^ 8'h1b;
    end
endfunction

function [7:0] mult9 // 9
    (input [7:0] x);
    begin
        mult9 = mult2(mult2(mult2(x))) ^ x;
    end
endfunction

function [7:0] mult11// b
    (input [7:0] x);
    begin
        mult11 = mult9(x) ^ mult2(x);
    end
endfunction

function [7:0] mult13 // d
    (input [7:0] x);
    begin
        mult13 = mult11(x) ^ mult2(x);
    end
endfunction

function [7:0] mult14 // e
    (input [7:0] x);
    begin
        mult14 = mult13(x) ^ x;
    end
endfunction


genvar i;
generate
    for(i=0; i<4; i=i+1) begin: mixColumns
        assign ostate[(i*32 + 24)+:8]= mult14(istate[(i*32 + 24)+:8]) ^ mult11(istate[(i*32 + 16)+:8]) ^ mult13(istate[(i*32 + 8)+:8]) ^ mult9(istate[i*32+:8]);
        assign ostate[(i*32 + 16)+:8]= mult9(istate[(i*32 + 24)+:8]) ^ mult14(istate[(i*32 + 16)+:8]) ^ mult11(istate[(i*32 + 8)+:8]) ^ mult13(istate[i*32+:8]);
        assign ostate[(i*32 + 8)+:8]= mult13(istate[(i*32 + 24)+:8]) ^ mult9(istate[(i*32 + 16)+:8]) ^ mult14(istate[(i*32 + 8)+:8]) ^ mult11(istate[i*32+:8]);
        assign ostate[i*32+:8]= mult11(istate[(i*32 + 24)+:8]) ^ mult13(istate[(i*32 + 16)+:8]) ^ mult9(istate[(i*32 + 8)+:8]) ^ mult14(istate[i*32+:8]);
    end
endgenerate

endmodule