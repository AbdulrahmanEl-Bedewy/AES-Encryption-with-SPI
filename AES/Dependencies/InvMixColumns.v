module InvMixColumns (
    input [127:0] istate, // 128-bit input state
    output [127:0] ostate // 128-bit output state
);

/*
    This module performs the inverse MixColumns transformation 
    in the AES encryption algorithm.
    
    The MixColumns transformation is a matrix multiplication 
    operation that is applied to each column of the input state 
    matrix. The inverse MixColumns transformation is the 
    multiplication by the inverse matrix.
    
    The matrix used for the inverse MixColumns transformation is:
    
    0e 0b 0d 09
    09 0e 0b 0d
    0d 09 0e 0b
    0b 0d 09 0e 
    
    Each element of the matrix is a multiplication coefficient 
    used to calculate the result of the transformation.
*/

// Define functions for multiplication by each matrix element

function [7:0] mult2
    (input [7:0] x);
    begin
        // Shift left by 1, equivalent to multiplying by 2
        if(x[7]==1'b0) mult2 = x<<1;
        // If MSB is 1, the multiplication by 2 needs to be 
        // done in the Galois Field defined by polynomial 0x11b
        else mult2 = (x<<1) ^ 8'h1b;
    end
endfunction

function [7:0] mult9 // 9
    (input [7:0] x);
    begin
        // Multiplication by 9 is defined as:
        // mult9(x) = mult2(mult2(mult2(x))) ^ x
        mult9 = mult2(mult2(mult2(x))) ^ x;
    end
endfunction

function [7:0] mult11// b
    (input [7:0] x);
    begin
        // Multiplication by 11 is defined as:
        // mult11(x) = mult9(x) ^ mult2(x)
        mult11 = mult9(x) ^ mult2(x);
    end
endfunction

function [7:0] mult13 // d
    (input [7:0] x);
    begin
        // Multiplication by 13 is defined as:
        // mult13(x) = mult9(x) ^ mult2(mult2(x))
        mult13 = mult9(x) ^ mult2(mult2(x));
    end
endfunction

function [7:0] mult14 // e
    (input [7:0] x);
    begin
        // Multiplication by 14 is defined as:
        // mult14(x) = mult2(mult2(mult2(x))) ^ mult2(mult2(x)) ^ mult2(x)
        mult14 = mult2(mult2(mult2(x))) ^ mult2(mult2(x)) ^ mult2(x);
    end
endfunction

// Use a generate block to apply the matrix multiplication to each column

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