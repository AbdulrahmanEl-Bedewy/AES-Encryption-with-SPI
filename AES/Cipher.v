module Cipher ( //Nk = 4 for 128 bit key, 6 for 192 bit key, 8 for 256 bit key
    input cs,
    input clk,
    input [0:3] Nr,
    input [0:127]init,
    input [0:(128*(14+1))-1] w,
    output [0:127] Encrypted_Msg,
    output reg flag
);

localparam InitialKey = 1;
localparam SubByte = 2;
localparam Shift = 3;
localparam Mix = 4;
localparam AddKey = 5;

reg [0:127] iW, iKey , iSub, iShift, iMix, temp;
wire [0:127] aKey , aSub, aShift, aMix;
reg [0:3] state;
reg [0:3] round;


AddRoundKey k1(
    .istate(iKey),
    .key(iW),
    .ostate(aKey)
);
SubBytes subBytes_inst1(
    .istate(iSub),
    .ostate(aSub)
);
ShiftRows shiftRows_inst1(
    .istate(iShift),
    .ostate(aShift)
);
MixColumns mixColumns_inst1(
    .state(iMix),
    .ostate(aMix)
);


initial begin
    round = 1;
    state = InitialKey;
    flag = 0;
end

always @(negedge clk) begin
	if(cs == 0)begin
			round = 1;
			state = InitialKey;
    end
    if(round <= Nr)begin       
        case(state)
            InitialKey: begin
                iW = w[0+:128];
                iKey = init;
                state = SubByte;
					 flag = 0;
            end
            SubByte: begin
                iSub = aKey;
                state = Shift;
            end
            Shift: begin
                iShift = aSub;
                if(round == Nr)
                    state = AddKey;
                else
                    state = Mix;
            end
            Mix: begin
                iMix = aShift;
                state = AddKey;
            end
            AddKey: begin
                iW = w[128*round+:128];
                iKey = aMix;
                round = round + 1;
                state = SubByte;
            end
        endcase
    end
    else begin
        flag = 1;
    end
end


assign Encrypted_Msg = aKey;



endmodule