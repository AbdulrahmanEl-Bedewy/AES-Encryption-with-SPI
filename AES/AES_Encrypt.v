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
reg flag;
reg [0:3] Nk;
reg [0:3] Nr;

// Key expansion variables
// reg cs_Exp;
reg [0:(8*32)-1] key;
wire [0:(128*(14+1))-1] w;

// Cipher module msg and final output
reg cs_Cipher;
reg [0:127] init;
wire [0:127] Encrypted_Msg128;
wire [0:127] Encrypted_Msg196;
wire [0:127] Encrypted_Msg256;

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

Cipher #(4,10) C1 (
    // .cs(cs_Cipher),
    //.Nr(Nr),
    .init(init),
    .w(w[0:(128*(10+1))-1]),
    .Encrypted_Msg(Encrypted_Msg128)
);

Cipher #(6,12) C2 (
    // .cs(cs_Cipher),
    //.Nr(Nr),
    .init(init),
    .w(w[0:(128*(12+1))-1]),
    .Encrypted_Msg(Encrypted_Msg196)
);

Cipher #(8,14) C3 (
    // .cs(cs_Cipher),
    //.Nr(Nr),
    .init(init),
    .w(w[0:(128*(14+1))-1]),
    .Encrypted_Msg(Encrypted_Msg256)
);

localparam Key = 0;
localparam Message = 1;
localparam Encryption = 2;
reg [0:1] state;


initial begin
    flag = 0;
	 tx = 0;
	 state = 0;
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
			end
		end
		Encryption: begin
			state = Key;
		end
	endcase
	
end

always @(posedge sclk)begin 
	case(Nk)
		 4'd4: begin 
			  tx = Encrypted_Msg128;
		 end
		 4'd6: begin 
			  tx = Encrypted_Msg196;
		 end
		 4'd8: begin 
			  tx = Encrypted_Msg256;
		 end
	endcase
end 

endmodule
