module AES_Decrypt(
    input cs,
    input sclk,
    input sdi,
    output sdo
);

// SPI variable
reg [0:127] tx;
wire [0:257] rx;
wire done;

// Sizes and stage variable
wire flag;
reg [0:3] Nk;
reg [0:3] Nr;

// Key expansion variables
// reg cs_Exp;
reg [0:(8*32)-1] key;
wire [0:(128*(14+1))-1] w;

// InvCipher module msg and final output
reg [0:127] init;
wire [0:127] Decrypted_Msg;
reg cs_decipher;


SPI_Sub SPI1(
    .cs(cs),
    .sclk(sclk),
    .sdi(sdi),
    .tx(tx), // sent from AES module
    .rx(rx), // sent to AES module
    .sdo(sdo),
    .done(done)
);

KeyExpansion KE1 (
    .Nk(Nk),
    .Nr(Nr),
    .key(key),
    .w(w)
);

InvCipher C1 (
	.cs(cs_decipher),
	.clk(sclk),
	.Nr(Nr),
	.init(init),
	.w(w),
	.Decrypted_Msg(Decrypted_Msg),
	.flag(flag)
);

localparam Key = 0;
localparam Message = 1;
localparam Decryption = 2;
reg [0:1] state;

initial begin
//    flag = 0;
	tx = 0;
	state = 0;
	cs_decipher = 0;
end


always @(posedge done) begin
	case(state) 
		Key: begin
			if(done==1)begin
				case(rx[0:1])
					 2'b00: begin 
						  Nk = 4;
						  Nr = 10;
					 end
					 2'b01: begin 
						  Nk = 6;
						  Nr = 12;
					 end
					 2'b10: begin 
						  Nk = 8;
						  Nr = 14;
					 end
				endcase
				state = Message;
				key = rx[2:257];
			end
		end
		Message: begin
			if(done == 1) begin
				init = rx[257-:128];
				state = Decryption;
				cs_decipher = 1;
			end
		end
		Decryption: begin
				state = Key;	
				cs_decipher = 0;
		end
	endcase
	
end

always @(posedge sclk)begin 
 	if(state == Decryption && flag == 1)
		tx = Decrypted_Msg;
end 

endmodule
