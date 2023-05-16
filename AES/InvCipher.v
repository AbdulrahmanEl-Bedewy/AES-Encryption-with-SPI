module InvCipher ( //Nk = 4 for 128 bit key, 6 for 192 bit key, 8 for 256 bit key
    input cs,
    input clk,
    input [0:3] Nr,
    input [0:127]init,
    input [0:(128*(14+1))-1] w,
    output [0:127] Decrypted_Msg,
    output reg flag
);

localparam InitialKey = 1;
localparam SubByte = 2;
localparam Shift = 3;
localparam AddKey = 4;
localparam Mix = 5;

reg [0:127] iW, iKey , iSub, iShift, iMix, temp;
wire [0:127] oKey , oSub, oShift, oMix;
reg [0:3] state;
reg [0:3] round;


AddRoundKey k1(
    .istate(iKey),
    .key(iW),
    .ostate(oKey)
);
InvSubBytes subBytes_inst1(
    .istate(iSub),
    .ostate(oSub)
);
InvShiftRows shiftRows_inst1(
    .istate(iShift),
    .ostate(oShift)
);
InvMixColumns mixColumns_inst1(
    .istate(iMix),
    .ostate(oMix)
);


initial begin
    round = 1;
    state = InitialKey;
    flag = 0;
end

always @(negedge clk) begin
	if(cs == 0)begin
			round = Nr-1;
			state = InitialKey;
    end
    else if(round != 15)begin       
        case(state)
            InitialKey: begin
                iW = w[Nr*128+:128];
                iKey = init;
                state = Shift;
                flag = 0;
            end
            Shift: begin
                state = SubByte;
                if(round == Nr - 1)
                    iShift = oKey;
                else
                    iShift = oMix;
            end
            SubByte: begin
                iSub = oShift;
                state = AddKey;
            end
            AddKey: begin
                iW = w[128*round+:128];  
                iKey = oSub;
                round = round - 1;
                state = Mix;
            end
            Mix: begin
                iMix = oKey;
                state = Shift;
            end
        endcase
    end
    else begin
        flag = 1;
    end
end

assign Decrypted_Msg = oKey;

endmodule