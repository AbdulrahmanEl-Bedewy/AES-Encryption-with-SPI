module AES_Encrypt(
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
reg [0:3] Nk;
reg [0:3] Nr;
wire flag;

// Key expansion variables
// reg cs_Exp;
reg [0:(8*32)-1] key;
wire [0:(128*(14+1))-1] w;

// Cipher module msg and final output
reg cs_Cipher;
reg [0:127] init;
wire [0:127] Encrypted_Msg;


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
    // .cs(cs_Exp)
    .Nk(Nk),
    .Nr(Nr),
    .key(key),
    .w(w)
);

Cipher C1 (
	 .cs(cs_Cipher),
	 .clk(sclk),
    .Nr(Nr),
    .init(init),
    .w(w),
    .Encrypted_Msg(Encrypted_Msg),
	 .flag(flag)
);

localparam Key = 0;
localparam Message = 1;
localparam Encryption = 2;
reg [0:1] state;


initial begin
//    flag = 0;
	tx = 0;
	state = 0;
	cs_Cipher = 0;
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
				state = Encryption;
				cs_Cipher = 1;
			end
		end
		Encryption: begin
				state = Key;			
		end
	endcase
	
end

always @(posedge sclk)begin 
 	if(state == Encryption && flag == 1)
		tx = Encrypted_Msg;
end 

endmodule
