module S_Box(
    input [7:0] istate,
    output reg [7:0] ostate
);

//reg [7:0] ostate;

/*
   0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0 63 7c 77 7b f2 6b 6f c5 30 01 67 2b fe d7 ab 76
1 ca 82 c9 7d fa 59 47 f0 ad d4 a2 af 9c a4 72 c0
2 b7 fd 93 26 36 3f f7 cc 34 a5 e5 f1 71 d8 31 15
3 04 c7 23 c3 18 96 05 9a 07 12 80 e2 eb 27 b2 75
4 09 83 2c 1a 1b 6e 5a a0 52 3b d6 b3 29 e3 2f 84
5 53 d1 00 ed 20 fc b1 5b 6a cb be 39 4a 4c 58 cf
6 d0 ef aa fb 43 4d 33 85 45 f9 02 7f 50 3c 9f a8
7 51 a3 40 8f 92 9d 38 f5 bc b6 da 21 10 ff f3 d2
8 cd 0c 13 ec 5f 97 44 17 c4 a7 7e 3d 64 5d 19 73
9 60 81 4f dc 22 2a 90 88 46 ee b8 14 de 5e 0b db
a e0 32 3a 0a 49 06 24 5c c2 d3 ac 62 91 95 e4 79
b e7 c8 37 6d 8d d5 4e a9 6c 56 f4 ea 65 7a ae 08
c ba 78 25 2e 1c a6 b4 c6 e8 dd 74 1f 4b bd 8b 8a
d 70 3e b5 66 48 03 f6 0e 61 35 57 b9 86 c1 1d 9e
e e1 f8 98 11 69 d9 8e 94 9b 1e 87 e9 ce 55 28 df
f 8c a1 89 0d bf e6 42 68 41 99 2d 0f b0 54 bb 16
*/

always @(*)begin
    case (istate) 
        8'h00: ostate=8'h63;
        8'h01: ostate=8'h7c;
        8'h02: ostate=8'h77;
        8'h03: ostate=8'h7b;
        8'h04: ostate=8'hf2;
        8'h05: ostate=8'h6b;
        8'h06: ostate=8'h6f;
        8'h07: ostate=8'hc5;
        8'h08: ostate=8'h30;
        8'h09: ostate=8'h01;
        8'h0a: ostate=8'h67;
        8'h0b: ostate=8'h2b;
        8'h0c: ostate=8'hfe;
        8'h0d: ostate=8'hd7;
        8'h0e: ostate=8'hab;
        8'h0f: ostate=8'h76;
        8'h10: ostate=8'hca;
        8'h11: ostate=8'h82;
        8'h12: ostate=8'hc9;
        8'h13: ostate=8'h7d;
        8'h14: ostate=8'hfa;
        8'h15: ostate=8'h59;
        8'h16: ostate=8'h47;
        8'h17: ostate=8'hf0;
        8'h18: ostate=8'had;
        8'h19: ostate=8'hd4;
        8'h1a: ostate=8'ha2;
        8'h1b: ostate=8'haf;
        8'h1c: ostate=8'h9c;
        8'h1d: ostate=8'ha4;
        8'h1e: ostate=8'h72;
        8'h1f: ostate=8'hc0;
        8'h20: ostate=8'hb7;
        8'h21: ostate=8'hfd;
        8'h22: ostate=8'h93;
        8'h23: ostate=8'h26;
        8'h24: ostate=8'h36;
        8'h25: ostate=8'h3f;
        8'h26: ostate=8'hf7;
        8'h27: ostate=8'hcc;
        8'h28: ostate=8'h34;
        8'h29: ostate=8'ha5;
        8'h2a: ostate=8'he5;
        8'h2b: ostate=8'hf1;
        8'h2c: ostate=8'h71;
        8'h2d: ostate=8'hd8;
        8'h2e: ostate=8'h31;
        8'h2f: ostate=8'h15;
        8'h30: ostate=8'h04;
        8'h31: ostate=8'hc7;
        8'h32: ostate=8'h23;
        8'h33: ostate=8'hc3;
        8'h34: ostate=8'h18;
        8'h35: ostate=8'h96;
        8'h36: ostate=8'h05;
        8'h37: ostate=8'h9a;
        8'h38: ostate=8'h07;
        8'h39: ostate=8'h12;
        8'h3a: ostate=8'h80;
        8'h3b: ostate=8'he2;
        8'h3c: ostate=8'heb;
        8'h3d: ostate=8'h27;
        8'h3e: ostate=8'hb2;
        8'h3f: ostate=8'h75;
        8'h40: ostate=8'h09;
        8'h41: ostate=8'h83;
        8'h42: ostate=8'h2c;
        8'h43: ostate=8'h1a;
        8'h44: ostate=8'h1b;
        8'h45: ostate=8'h6e;
        8'h46: ostate=8'h5a;
        8'h47: ostate=8'ha0;
        8'h48: ostate=8'h52;
        8'h49: ostate=8'h3b;
        8'h4a: ostate=8'hd6;
        8'h4b: ostate=8'hb3;
        8'h4c: ostate=8'h29;
        8'h4d: ostate=8'he3;
        8'h4e: ostate=8'h2f;
        8'h4f: ostate=8'h84;
        8'h50: ostate=8'h53;
        8'h51: ostate=8'hd1;
        8'h52: ostate=8'h00;
        8'h53: ostate=8'hed;
        8'h54: ostate=8'h20;
        8'h55: ostate=8'hfc;
        8'h56: ostate=8'hb1;
        8'h57: ostate=8'h5b;
        8'h58: ostate=8'h6a;
        8'h59: ostate=8'hcb;
        8'h5a: ostate=8'hbe;
        8'h5b: ostate=8'h39;
        8'h5c: ostate=8'h4a;
        8'h5d: ostate=8'h4c;
        8'h5e: ostate=8'h58;
        8'h5f: ostate=8'hcf;
        8'h60: ostate=8'hd0;
        8'h61: ostate=8'hef;
        8'h62: ostate=8'haa;
        8'h63: ostate=8'hfb;
        8'h64: ostate=8'h43;
        8'h65: ostate=8'h4d;
        8'h66: ostate=8'h33;
        8'h67: ostate=8'h85;
        8'h68: ostate=8'h45;
        8'h69: ostate=8'hf9;
        8'h6a: ostate=8'h02;
        8'h6b: ostate=8'h7f;
        8'h6c: ostate=8'h50;
        8'h6d: ostate=8'h3c;
        8'h6e: ostate=8'h9f;
        8'h6f: ostate=8'ha8;
        8'h70: ostate=8'h51;
        8'h71: ostate=8'ha3;
        8'h72: ostate=8'h40;
        8'h73: ostate=8'h8f;
        8'h74: ostate=8'h92;
        8'h75: ostate=8'h9d;
        8'h76: ostate=8'h38;
        8'h77: ostate=8'hf5;
        8'h78: ostate=8'hbc;
        8'h79: ostate=8'hb6;
        8'h7a: ostate=8'hda;
        8'h7b: ostate=8'h21;
        8'h7c: ostate=8'h10;
        8'h7d: ostate=8'hff;
        8'h7e: ostate=8'hf3;
        8'h7f: ostate=8'hd2;
        8'h80: ostate=8'hcd;
        8'h81: ostate=8'h0c;
        8'h82: ostate=8'h13;
        8'h83: ostate=8'hec;
        8'h84: ostate=8'h5f;
        8'h85: ostate=8'h97;
        8'h86: ostate=8'h44;
        8'h87: ostate=8'h17;
        8'h88: ostate=8'hc4;
        8'h89: ostate=8'ha7;
        8'h8a: ostate=8'h7e;
        8'h8b: ostate=8'h3d;
        8'h8c: ostate=8'h64;
        8'h8d: ostate=8'h5d;
        8'h8e: ostate=8'h19;
        8'h8f: ostate=8'h73;
        8'h90: ostate=8'h60;
        8'h91: ostate=8'h81;
        8'h92: ostate=8'h4f;
        8'h93: ostate=8'hdc;
        8'h94: ostate=8'h22;
        8'h95: ostate=8'h2a;
        8'h96: ostate=8'h90;
        8'h97: ostate=8'h88;
        8'h98: ostate=8'h46;
        8'h99: ostate=8'hee;
        8'h9a: ostate=8'hb8;
        8'h9b: ostate=8'h14;
        8'h9c: ostate=8'hde;
        8'h9d: ostate=8'h5e;
        8'h9e: ostate=8'h0b;
        8'h9f: ostate=8'hdb;
        8'ha0: ostate=8'he0;
        8'ha1: ostate=8'h32;
        8'ha2: ostate=8'h3a;
        8'ha3: ostate=8'h0a;
        8'ha4: ostate=8'h49;
        8'ha5: ostate=8'h06;
        8'ha6: ostate=8'h24;
        8'ha7: ostate=8'h5c;
        8'ha8: ostate=8'hc2;
        8'ha9: ostate=8'hd3;
        8'haa: ostate=8'hac;
        8'hab: ostate=8'h62;
        8'hac: ostate=8'h91;
        8'had: ostate=8'h95;
        8'hae: ostate=8'he4;
        8'haf: ostate=8'h79;
        8'hb0: ostate=8'he7;
        8'hb1: ostate=8'hc8;
        8'hb2: ostate=8'h37;
        8'hb3: ostate=8'h6d;
        8'hb4: ostate=8'h8d;
        8'hb5: ostate=8'hd5;
        8'hb6: ostate=8'h4e;
        8'hb7: ostate=8'ha9;
        8'hb8: ostate=8'h6c;
        8'hb9: ostate=8'h56;
        8'hba: ostate=8'hf4;
        8'hbb: ostate=8'hea;
        8'hbc: ostate=8'h65;
        8'hbd: ostate=8'h7a;
        8'hbe: ostate=8'hae;
        8'hbf: ostate=8'h08;
        8'hc0: ostate=8'hba;
        8'hc1: ostate=8'h78;
        8'hc2: ostate=8'h25;
        8'hc3: ostate=8'h2e;
        8'hc4: ostate=8'h1c;
        8'hc5: ostate=8'ha6;
        8'hc6: ostate=8'hb4;
        8'hc7: ostate=8'hc6;
        8'hc8: ostate=8'he8;
        8'hc9: ostate=8'hdd;
        8'hca: ostate=8'h74;
        8'hcb: ostate=8'h1f;
        8'hcc: ostate=8'h4b;
        8'hcd: ostate=8'hbd;
        8'hce: ostate=8'h8b;
        8'hcf: ostate=8'h8a;
        8'hd0: ostate=8'h70;
        8'hd1: ostate=8'h3e;
        8'hd2: ostate=8'hb5;
        8'hd3: ostate=8'h66;
        8'hd4: ostate=8'h48;
        8'hd5: ostate=8'h03;
        8'hd6: ostate=8'hf6;
        8'hd7: ostate=8'h0e;
        8'hd8: ostate=8'h61;
        8'hd9: ostate=8'h35;
        8'hda: ostate=8'h57;
        8'hdb: ostate=8'hb9;
        8'hdc: ostate=8'h86;
        8'hdd: ostate=8'hc1;
        8'hde: ostate=8'h1d;
        8'hdf: ostate=8'h9e;
        8'he0: ostate=8'he1;
        8'he1: ostate=8'hf8;
        8'he2: ostate=8'h98;
        8'he3: ostate=8'h11;
        8'he4: ostate=8'h69;
        8'he5: ostate=8'hd9;
        8'he6: ostate=8'h8e;
        8'he7: ostate=8'h94;
        8'he8: ostate=8'h9b;
        8'he9: ostate=8'h1e;
        8'hea: ostate=8'h87;
        8'heb: ostate=8'he9;
        8'hec: ostate=8'hce;
        8'hed: ostate=8'h55;
        8'hee: ostate=8'h28;
        8'hef: ostate=8'hdf;
        8'hf0: ostate=8'h8c;
        8'hf1: ostate=8'ha1;
        8'hf2: ostate=8'h89;
        8'hf3: ostate=8'h0d;
        8'hf4: ostate=8'hbf;
        8'hf5: ostate=8'he6;
        8'hf6: ostate=8'h42;
        8'hf7: ostate=8'h68;
        8'hf8: ostate=8'h41;
        8'hf9: ostate=8'h99;
        8'hfa: ostate=8'h2d;
        8'hfb: ostate=8'h0f;
        8'hfc: ostate=8'hb0;
        8'hfd: ostate=8'h54;
        8'hfe: ostate=8'hbb;
        8'hff: ostate=8'h16;
    endcase
end

endmodule

