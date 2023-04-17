module InvS_Box (
    input [7:0] istate,
    output reg[7:0] ostate
);

//reg [7:0] ostate;

/*
   0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f 
0 52 09 6a d5 30 36 a5 38 bf 40 a3 9e 81 f3 d7 fb
1 7c e3 39 82 9b 2f ff 87 34 8e 43 44 c4 de e9 cb
2 54 7b 94 32 a6 c2 23 3d ee 4c 95 0b 42 fa c3 4e
3 08 2e a1 66 28 d9 24 b2 76 5b a2 49 6d 8b d1 25
4 72 f8 f6 64 86 68 98 16 d4 a4 5c cc 5d 65 b6 92
5 6c 70 48 50 fd ed b9 da 5e 15 46 57 a7 8d 9d 84
6 90 d8 ab 00 8c bc d3 0a f7 e4 58 05 b8 b3 45 06
7 d0 2c 1e 8f ca 3f 0f 02 c1 af bd 03 01 13 8a 6b
8 3a 91 11 41 4f 67 dc ea 97 f2 cf ce f0 b4 e6 73
9 96 ac 74 22 e7 ad 35 85 e2 f9 37 e8 1c 75 df 6e
a 47 f1 1a 71 1d 29 c5 89 6f b7 62 0e aa 18 be 1b
b fc 56 3e 4b c6 d2 79 20 9a db c0 fe 78 cd 5a f4
c 1f dd a8 33 88 07 c7 31 b1 12 10 59 27 80 ec 5f
d 60 51 7f a9 19 b5 4a 0d 2d e5 7a 9f 93 c9 9c ef
e a0 e0 3b 4d ae 2a f5 b0 c8 eb bb 3c 83 53 99 61
f 17 2b 04 7e ba 77 d6 26 e1 69 14 63 55 21 0c 7d
*/

always @(*) begin
    case(istate)
        8'h00: ostate=8'h52;
        8'h01: ostate=8'h09;
        8'h02: ostate=8'h6a;
        8'h03: ostate=8'hd5;
        8'h04: ostate=8'h30;
        8'h05: ostate=8'h36;
        8'h06: ostate=8'ha5;
        8'h07: ostate=8'h38;
        8'h08: ostate=8'hbf;
        8'h09: ostate=8'h40;
        8'h0a: ostate=8'ha3;
        8'h0b: ostate=8'h9e;
        8'h0c: ostate=8'h81;
        8'h0d: ostate=8'hf3;
        8'h0e: ostate=8'hd7;
        8'h0f: ostate=8'hfb;
        8'h10: ostate=8'h7c;
        8'h11: ostate=8'he3;
        8'h12: ostate=8'h39;
        8'h13: ostate=8'h82;
        8'h14: ostate=8'h9b;
        8'h15: ostate=8'h2f;
        8'h16: ostate=8'hff;
        8'h17: ostate=8'h87;
        8'h18: ostate=8'h34;
        8'h19: ostate=8'h8e;
        8'h1a: ostate=8'h43;
        8'h1b: ostate=8'h44;
        8'h1c: ostate=8'hc4;
        8'h1d: ostate=8'hde;
        8'h1e: ostate=8'he9;
        8'h1f: ostate=8'hcb;
        8'h20: ostate=8'h54;
        8'h21: ostate=8'h7b;
        8'h22: ostate=8'h94;
        8'h23: ostate=8'h32;
        8'h24: ostate=8'ha6;
        8'h25: ostate=8'hc2;
        8'h26: ostate=8'h23;
        8'h27: ostate=8'h3d;
        8'h28: ostate=8'hee;
        8'h29: ostate=8'h4c;
        8'h2a: ostate=8'h95;
        8'h2b: ostate=8'h0b;
        8'h2c: ostate=8'h42;
        8'h2d: ostate=8'hfa;
        8'h2e: ostate=8'hc3;
        8'h2f: ostate=8'h4e;
        8'h30: ostate=8'h08;
        8'h31: ostate=8'h2e;
        8'h32: ostate=8'ha1;
        8'h33: ostate=8'h66;
        8'h34: ostate=8'h28;
        8'h35: ostate=8'hd9;
        8'h36: ostate=8'h24;
        8'h37: ostate=8'hb2;
        8'h38: ostate=8'h76;
        8'h39: ostate=8'h5b;
        8'h3a: ostate=8'ha2;
        8'h3b: ostate=8'h49;
        8'h3c: ostate=8'h6d;
        8'h3d: ostate=8'h8b;
        8'h3e: ostate=8'hd1;
        8'h3f: ostate=8'h25;
        8'h40: ostate=8'h72;
        8'h41: ostate=8'hf8;
        8'h42: ostate=8'hf6;
        8'h43: ostate=8'h64;
        8'h44: ostate=8'h86;
        8'h45: ostate=8'h68;
        8'h46: ostate=8'h98;
        8'h47: ostate=8'h16;
        8'h48: ostate=8'hd4;
        8'h49: ostate=8'ha4;
        8'h4a: ostate=8'h5c;
        8'h4b: ostate=8'hcc;
        8'h4c: ostate=8'h5d;
        8'h4d: ostate=8'h65;
        8'h4e: ostate=8'hb6;
        8'h4f: ostate=8'h92;
        8'h50: ostate=8'h6c;
        8'h51: ostate=8'h70;
        8'h52: ostate=8'h48;
        8'h53: ostate=8'h50;
        8'h54: ostate=8'hfd;
        8'h55: ostate=8'hed;
        8'h56: ostate=8'hb9;
        8'h57: ostate=8'hda;
        8'h58: ostate=8'h5e;
        8'h59: ostate=8'h15;
        8'h5a: ostate=8'h46;
        8'h5b: ostate=8'h57;
        8'h5c: ostate=8'ha7;
        8'h5d: ostate=8'h8d;
        8'h5e: ostate=8'h9d;
        8'h5f: ostate=8'h84;
        8'h60: ostate=8'h90;
        8'h61: ostate=8'hd8;
        8'h62: ostate=8'hab;
        8'h63: ostate=8'h00;
        8'h64: ostate=8'h8c;
        8'h65: ostate=8'hbc;
        8'h66: ostate=8'hd3;
        8'h67: ostate=8'h0a;
        8'h68: ostate=8'hf7;
        8'h69: ostate=8'he4;
        8'h6a: ostate=8'h58;
        8'h6b: ostate=8'h05;
        8'h6c: ostate=8'hb8;
        8'h6d: ostate=8'hb3;
        8'h6e: ostate=8'h45;
        8'h6f: ostate=8'h06;
        8'h70: ostate=8'hd0;
        8'h71: ostate=8'h2c;
        8'h72: ostate=8'h1e;
        8'h73: ostate=8'h8f;
        8'h74: ostate=8'hca;
        8'h75: ostate=8'h3f;
        8'h76: ostate=8'h0f;
        8'h77: ostate=8'h02;
        8'h78: ostate=8'hc1;
        8'h79: ostate=8'haf;
        8'h7a: ostate=8'hbd;
        8'h7b: ostate=8'h03;
        8'h7c: ostate=8'h01;
        8'h7d: ostate=8'h13;
        8'h7e: ostate=8'h8a;
        8'h7f: ostate=8'h6b;
        8'h80: ostate=8'h3a;
        8'h81: ostate=8'h91;
        8'h82: ostate=8'h11;
        8'h83: ostate=8'h41;
        8'h84: ostate=8'h4f;
        8'h85: ostate=8'h67;
        8'h86: ostate=8'hdc;
        8'h87: ostate=8'hea;
        8'h88: ostate=8'h97;
        8'h89: ostate=8'hf2;
        8'h8a: ostate=8'hcf;
        8'h8b: ostate=8'hce;
        8'h8c: ostate=8'hf0;
        8'h8d: ostate=8'hb4;
        8'h8e: ostate=8'he6;
        8'h8f: ostate=8'h73;
        8'h90: ostate=8'h96;
        8'h91: ostate=8'hac;
        8'h92: ostate=8'h74;
        8'h93: ostate=8'h22;
        8'h94: ostate=8'he7;
        8'h95: ostate=8'had;
        8'h96: ostate=8'h35;
        8'h97: ostate=8'h85;
        8'h98: ostate=8'he2;
        8'h99: ostate=8'hf9;
        8'h9a: ostate=8'h37;
        8'h9b: ostate=8'he8;
        8'h9c: ostate=8'h1c;
        8'h9d: ostate=8'h75;
        8'h9e: ostate=8'hdf;
        8'h9f: ostate=8'h6e;
        8'ha0: ostate=8'h47;
        8'ha1: ostate=8'hf1;
        8'ha2: ostate=8'h1a;
        8'ha3: ostate=8'h71;
        8'ha4: ostate=8'h1d;
        8'ha5: ostate=8'h29;
        8'ha6: ostate=8'hc5;
        8'ha7: ostate=8'h89;
        8'ha8: ostate=8'h6f;
        8'ha9: ostate=8'hb7;
        8'haa: ostate=8'h62;
        8'hab: ostate=8'h0e;
        8'hac: ostate=8'haa;
        8'had: ostate=8'h18;
        8'hae: ostate=8'hbe;
        8'haf: ostate=8'h1b;
        8'hb0: ostate=8'hfc;
        8'hb1: ostate=8'h56;
        8'hb2: ostate=8'h3e;
        8'hb3: ostate=8'h4b;
        8'hb4: ostate=8'hc6;
        8'hb5: ostate=8'hd2;
        8'hb6: ostate=8'h79;
        8'hb7: ostate=8'h20;
        8'hb8: ostate=8'h9a;
        8'hb9: ostate=8'hdb;
        8'hba: ostate=8'hc0;
        8'hbb: ostate=8'hfe;
        8'hbc: ostate=8'h78;
        8'hbd: ostate=8'hcd;
        8'hbe: ostate=8'h5a;
        8'hbf: ostate=8'hf4;
        8'hc0: ostate=8'h1f;
        8'hc1: ostate=8'hdd;
        8'hc2: ostate=8'ha8;
        8'hc3: ostate=8'h33;
        8'hc4: ostate=8'h88;
        8'hc5: ostate=8'h07;
        8'hc6: ostate=8'hc7;
        8'hc7: ostate=8'h31;
        8'hc8: ostate=8'hb1;
        8'hc9: ostate=8'h12;
        8'hca: ostate=8'h10;
        8'hcb: ostate=8'h59;
        8'hcc: ostate=8'h27;
        8'hcd: ostate=8'h80;
        8'hce: ostate=8'hec;
        8'hcf: ostate=8'h5f;
        8'hd0: ostate=8'h60;
        8'hd1: ostate=8'h51;
        8'hd2: ostate=8'h7f;
        8'hd3: ostate=8'ha9;
        8'hd4: ostate=8'h19;
        8'hd5: ostate=8'hb5;
        8'hd6: ostate=8'h4a;
        8'hd7: ostate=8'h0d;
        8'hd8: ostate=8'h2d;
        8'hd9: ostate=8'he5;
        8'hda: ostate=8'h7a;
        8'hdb: ostate=8'h9f;
        8'hdc: ostate=8'h93;
        8'hdd: ostate=8'hc9;
        8'hde: ostate=8'h9c;
        8'hdf: ostate=8'hef;
        8'he0: ostate=8'ha0;
        8'he1: ostate=8'he0;
        8'he2: ostate=8'h3b;
        8'he3: ostate=8'h4d;
        8'he4: ostate=8'hae;
        8'he5: ostate=8'h2a;
        8'he6: ostate=8'hf5;
        8'he7: ostate=8'hb0;
        8'he8: ostate=8'hc8;
        8'he9: ostate=8'heb;
        8'hea: ostate=8'hbb;
        8'heb: ostate=8'h3c;
        8'hec: ostate=8'h83;
        8'hed: ostate=8'h53;
        8'hee: ostate=8'h99;
        8'hef: ostate=8'h61;
        8'hf0: ostate=8'h17;
        8'hf1: ostate=8'h2b;
        8'hf2: ostate=8'h04;
        8'hf3: ostate=8'h7e;
        8'hf4: ostate=8'hba;
        8'hf5: ostate=8'h77;
        8'hf6: ostate=8'hd6;
        8'hf7: ostate=8'h26;
        8'hf8: ostate=8'he1;
        8'hf9: ostate=8'h69;
        8'hfa: ostate=8'h14;
        8'hfb: ostate=8'h63;
        8'hfc: ostate=8'h55;
        8'hfd: ostate=8'h21;
        8'hfe: ostate=8'h0c;
        8'hff: ostate=8'h7d;
    endcase
end
endmodule