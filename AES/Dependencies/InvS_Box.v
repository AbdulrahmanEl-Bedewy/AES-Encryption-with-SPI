module InvS_Box (
    input [7:0] istate,
    output [7:0] ostate
);

reg [7:0] ostate;

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
        8'h00:sbout =8'h52;
        8'h01:sbout =8'h09;
        8'h02:sbout =8'h6a;
        8'h03:sbout =8'hd5;
        8'h04:sbout =8'h30;
        8'h05:sbout =8'h36;
        8'h06:sbout =8'ha5;
        8'h07:sbout =8'h38;
        8'h08:sbout =8'hbf;
        8'h09:sbout =8'h40;
        8'h0a:sbout =8'ha3;
        8'h0b:sbout =8'h9e;
        8'h0c:sbout =8'h81;
        8'h0d:sbout =8'hf3;
        8'h0e:sbout =8'hd7;
        8'h0f:sbout =8'hfb;
        8'h10:sbout =8'h7c;
        8'h11:sbout =8'he3;
        8'h12:sbout =8'h39;
        8'h13:sbout =8'h82;
        8'h14:sbout =8'h9b;
        8'h15:sbout =8'h2f;
        8'h16:sbout =8'hff;
        8'h17:sbout =8'h87;
        8'h18:sbout =8'h34;
        8'h19:sbout =8'h8e;
        8'h1a:sbout =8'h43;
        8'h1b:sbout =8'h44;
        8'h1c:sbout =8'hc4;
        8'h1d:sbout =8'hde;
        8'h1e:sbout =8'he9;
        8'h1f:sbout =8'hcb;
        8'h20:sbout =8'h54;
        8'h21:sbout =8'h7b;
        8'h22:sbout =8'h94;
        8'h23:sbout =8'h32;
        8'h24:sbout =8'ha6;
        8'h25:sbout =8'hc2;
        8'h26:sbout =8'h23;
        8'h27:sbout =8'h3d;
        8'h28:sbout =8'hee;
        8'h29:sbout =8'h4c;
        8'h2a:sbout =8'h95;
        8'h2b:sbout =8'h0b;
        8'h2c:sbout =8'h42;
        8'h2d:sbout =8'hfa;
        8'h2e:sbout =8'hc3;
        8'h2f:sbout =8'h4e;
        8'h30:sbout =8'h08;
        8'h31:sbout =8'h2e;
        8'h32:sbout =8'ha1;
        8'h33:sbout =8'h66;
        8'h34:sbout =8'h28;
        8'h35:sbout =8'hd9;
        8'h36:sbout =8'h24;
        8'h37:sbout =8'hb2;
        8'h38:sbout =8'h76;
        8'h39:sbout =8'h5b;
        8'h3a:sbout =8'ha2;
        8'h3b:sbout =8'h49;
        8'h3c:sbout =8'h6d;
        8'h3d:sbout =8'h8b;
        8'h3e:sbout =8'hd1;
        8'h3f:sbout =8'h25;
        8'h40:sbout =8'h72;
        8'h41:sbout =8'hf8;
        8'h42:sbout =8'hf6;
        8'h43:sbout =8'h64;
        8'h44:sbout =8'h86;
        8'h45:sbout =8'h68;
        8'h46:sbout =8'h98;
        8'h47:sbout =8'h16;
        8'h48:sbout =8'hd4;
        8'h49:sbout =8'ha4;
        8'h4a:sbout =8'h5c;
        8'h4b:sbout =8'hcc;
        8'h4c:sbout =8'h5d;
        8'h4d:sbout =8'h65;
        8'h4e:sbout =8'hb6;
        8'h4f:sbout =8'h92;
        8'h50:sbout =8'h6c;
        8'h51:sbout =8'h70;
        8'h52:sbout =8'h48;
        8'h53:sbout =8'h50;
        8'h54:sbout =8'hfd;
        8'h55:sbout =8'hed;
        8'h56:sbout =8'hb9;
        8'h57:sbout =8'hda;
        8'h58:sbout =8'h5e;
        8'h59:sbout =8'h15;
        8'h5a:sbout =8'h46;
        8'h5b:sbout =8'h57;
        8'h5c:sbout =8'ha7;
        8'h5d:sbout =8'h8d;
        8'h5e:sbout =8'h9d;
        8'h5f:sbout =8'h84;
        8'h60:sbout =8'h90;
        8'h61:sbout =8'hd8;
        8'h62:sbout =8'hab;
        8'h63:sbout =8'h00;
        8'h64:sbout =8'h8c;
        8'h65:sbout =8'hbc;
        8'h66:sbout =8'hd3;
        8'h67:sbout =8'h0a;
        8'h68:sbout =8'hf7;
        8'h69:sbout =8'he4;
        8'h6a:sbout =8'h58;
        8'h6b:sbout =8'h05;
        8'h6c:sbout =8'hb8;
        8'h6d:sbout =8'hb3;
        8'h6e:sbout =8'h45;
        8'h6f:sbout =8'h06;
        8'h70:sbout =8'hd0;
        8'h71:sbout =8'h2c;
        8'h72:sbout =8'h1e;
        8'h73:sbout =8'h8f;
        8'h74:sbout =8'hca;
        8'h75:sbout =8'h3f;
        8'h76:sbout =8'h0f;
        8'h77:sbout =8'h02;
        8'h78:sbout =8'hc1;
        8'h79:sbout =8'haf;
        8'h7a:sbout =8'hbd;
        8'h7b:sbout =8'h03;
        8'h7c:sbout =8'h01;
        8'h7d:sbout =8'h13;
        8'h7e:sbout =8'h8a;
        8'h7f:sbout =8'h6b;
        8'h80:sbout =8'h3a;
        8'h81:sbout =8'h91;
        8'h82:sbout =8'h11;
        8'h83:sbout =8'h41;
        8'h84:sbout =8'h4f;
        8'h85:sbout =8'h67;
        8'h86:sbout =8'hdc;
        8'h87:sbout =8'hea;
        8'h88:sbout =8'h97;
        8'h89:sbout =8'hf2;
        8'h8a:sbout =8'hcf;
        8'h8b:sbout =8'hce;
        8'h8c:sbout =8'hf0;
        8'h8d:sbout =8'hb4;
        8'h8e:sbout =8'he6;
        8'h8f:sbout =8'h73;
        8'h90:sbout =8'h96;
        8'h91:sbout =8'hac;
        8'h92:sbout =8'h74;
        8'h93:sbout =8'h22;
        8'h94:sbout =8'he7;
        8'h95:sbout =8'had;
        8'h96:sbout =8'h35;
        8'h97:sbout =8'h85;
        8'h98:sbout =8'he2;
        8'h99:sbout =8'hf9;
        8'h9a:sbout =8'h37;
        8'h9b:sbout =8'he8;
        8'h9c:sbout =8'h1c;
        8'h9d:sbout =8'h75;
        8'h9e:sbout =8'hdf;
        8'h9f:sbout =8'h6e;
        8'ha0:sbout =8'h47;
        8'ha1:sbout =8'hf1;
        8'ha2:sbout =8'h1a;
        8'ha3:sbout =8'h71;
        8'ha4:sbout =8'h1d;
        8'ha5:sbout =8'h29;
        8'ha6:sbout =8'hc5;
        8'ha7:sbout =8'h89;
        8'ha8:sbout =8'h6f;
        8'ha9:sbout =8'hb7;
        8'haa:sbout =8'h62;
        8'hab:sbout =8'h0e;
        8'hac:sbout =8'haa;
        8'had:sbout =8'h18;
        8'hae:sbout =8'hbe;
        8'haf:sbout =8'h1b;
        8'hb0:sbout =8'hfc;
        8'hb1:sbout =8'h56;
        8'hb2:sbout =8'h3e;
        8'hb3:sbout =8'h4b;
        8'hb4:sbout =8'hc6;
        8'hb5:sbout =8'hd2;
        8'hb6:sbout =8'h79;
        8'hb7:sbout =8'h20;
        8'hb8:sbout =8'h9a;
        8'hb9:sbout =8'hdb;
        8'hba:sbout =8'hc0;
        8'hbb:sbout =8'hfe;
        8'hbc:sbout =8'h78;
        8'hbd:sbout =8'hcd;
        8'hbe:sbout =8'h5a;
        8'hbf:sbout =8'hf4;
        8'hc0:sbout =8'h1f;
        8'hc1:sbout =8'hdd;
        8'hc2:sbout =8'ha8;
        8'hc3:sbout =8'h33;
        8'hc4:sbout =8'h88;
        8'hc5:sbout =8'h07;
        8'hc6:sbout =8'hc7;
        8'hc7:sbout =8'h31;
        8'hc8:sbout =8'hb1;
        8'hc9:sbout =8'h12;
        8'hca:sbout =8'h10;
        8'hcb:sbout =8'h59;
        8'hcc:sbout =8'h27;
        8'hcd:sbout =8'h80;
        8'hce:sbout =8'hec;
        8'hcf:sbout =8'h5f;
        8'hd0:sbout =8'h60;
        8'hd1:sbout =8'h51;
        8'hd2:sbout =8'h7f;
        8'hd3:sbout =8'ha9;
        8'hd4:sbout =8'h19;
        8'hd5:sbout =8'hb5;
        8'hd6:sbout =8'h4a;
        8'hd7:sbout =8'h0d;
        8'hd8:sbout =8'h2d;
        8'hd9:sbout =8'he5;
        8'hda:sbout =8'h7a;
        8'hdb:sbout =8'h9f;
        8'hdc:sbout =8'h93;
        8'hdd:sbout =8'hc9;
        8'hde:sbout =8'h9c;
        8'hdf:sbout =8'hef;
        8'he0:sbout =8'ha0;
        8'he1:sbout =8'he0;
        8'he2:sbout =8'h3b;
        8'he3:sbout =8'h4d;
        8'he4:sbout =8'hae;
        8'he5:sbout =8'h2a;
        8'he6:sbout =8'hf5;
        8'he7:sbout =8'hb0;
        8'he8:sbout =8'hc8;
        8'he9:sbout =8'heb;
        8'hea:sbout =8'hbb;
        8'heb:sbout =8'h3c;
        8'hec:sbout =8'h83;
        8'hed:sbout =8'h53;
        8'hee:sbout =8'h99;
        8'hef:sbout =8'h61;
        8'hf0:sbout =8'h17;
        8'hf1:sbout =8'h2b;
        8'hf2:sbout =8'h04;
        8'hf3:sbout =8'h7e;
        8'hf4:sbout =8'hba;
        8'hf5:sbout =8'h77;
        8'hf6:sbout =8'hd6;
        8'hf7:sbout =8'h26;
        8'hf8:sbout =8'he1;
        8'hf9:sbout =8'h69;
        8'hfa:sbout =8'h14;
        8'hfb:sbout =8'h63;
        8'hfc:sbout =8'h55;
        8'hfd:sbout =8'h21;
        8'hfe:sbout =8'h0c;
        8'hff:sbout =8'h7d;
    endcase
end
endmodule