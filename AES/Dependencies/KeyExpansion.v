module KeyExpansion #(parameter Nk=4,parameter Nr=10)(
    input [(Nk*32)-1:0] key,
    output reg [(128*(Nr+1))-1:0] w
);

// Rotate [a0,a1,a2,a3] to [a1,a2,a3,a0]
function [31:0] Rotword
    (input [31:0] word);
    begin
        Rotword = {word[23:0],word[31:24]};
    end
endfunction

/*
        Values of rci in hexadecimal  //from https://en.wikipedia.org/wiki/AES_key_schedule#Rcon
i	1	2	3	4	5	6	7	8	9	10
rci	01	02	04	08	10	20	40	80	1B	36
*/
function [7:0] Rcon
    (input [3:0] i);
    begin
        case(i)
            4'h1: Rcon = 8'h01;
            4'h2: Rcon = 8'h02;
            4'h3: Rcon = 8'h04;
            4'h4: Rcon = 8'h08;
            4'h5: Rcon = 8'h10;
            4'h6: Rcon = 8'h20;
            4'h7: Rcon = 8'h40;
            4'h8: Rcon = 8'h80;
            4'h9: Rcon = 8'h1b;
            4'ha: Rcon = 8'h36;
            default: Rcon = 8'h00;
        endcase
    end
endfunction

reg [31:0] temp;
wire [31:0] temp2;
reg [31:0] rotated;
wire [31:0] subbed;


S_Box sbox_inst1(
    .istate(rotated[0+:8]),
    .ostate(subbed[0+:8])
);
S_Box sbox_inst2(
    .istate(rotated[1*8+:8]),
    .ostate(subbed[1*8+:8])
);
S_Box sbox_inst3(
    .istate(rotated[2*8+:8]),
    .ostate(subbed[2*8+:8])
);
S_Box sbox_inst4(
    .istate(rotated[3*8+:8]),
    .ostate(subbed[3*8+:8])
);

S_Box sbox_inst5(
    .istate(temp[0*8+:8]),
    .ostate(temp2[0*8+:8])
);
S_Box sbox_inst6(
    .istate(temp[1*8+:8]),
    .ostate(temp2[1*8+:8])
);
S_Box sbox_inst7(
    .istate(temp[2*8+:8]),
    .ostate(temp2[2*8+:8])
);
S_Box sbox_inst8(
    .istate(temp[3*8+:8]),
    .ostate(temp2[3*8+:8])
);


initial begin
	w[0+:32*Nk] = key[0+:32*Nk];
end

integer i,j;
always @(*) begin 
    // i = Nk ; i<Nb*(Nr+1) ;i++
    for(i=Nk;i<4*(Nr+1); i=i+1) begin :KeyExp
        temp = w[(i-1)*32+:32];
        if(i%Nk==0) begin
            // temp = SubWord(RotWord(temp)) ^ Rcon(i/Nk);
            rotated = Rotword(temp);
            // assign temp = SubWord(rotated) ^ Rcon(i/Nk);           
            temp = subbed ^ {Rcon(i/Nk),8'h00,8'h00,8'h00};
        end
        else if(Nk>6 && i%Nk==4) begin
            temp = temp2;
        end
        w[i*32+:32] = w[(i-Nk)*32+:32] ^ temp;
    end
end

endmodule

