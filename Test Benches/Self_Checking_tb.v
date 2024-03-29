module Self_Checking_tb (
    input FPGAclk,
    input startTest,
    input [0:1] testNum,
    output reg pass,
    output reg fail
);

localparam Idle = 0;
localparam SendKey = 1;
localparam SendMsg = 2;
localparam ReceiveEnc = 3;
localparam SendKey2 = 4;
localparam SendEnc = 5;
localparam ReceiveDec = 6;
localparam CheckAnswer = 7;

reg [0:257] txMain;
wire [0:127] rxMain;
wire [0:1]miso;
reg sel;
reg start;
wire [0:1]cs_n;
wire sclk;
wire mosi;
wire done;
reg clk;

SPI_Main spM(
	.clk(clk),
	.miso(miso),
    .sel(sel),
	.start(start),
	.tx(txMain),
	.rx(rxMain),
	.cs_n(cs_n),
	.sclk(sclk),
	.mosi(mosi),
	.done(done)
);

AES_Encrypt Encrypt(
    .cs(cs_n[0]),
    .sclk(clk),
    .sdi(mosi),
    .sdo(miso[0])
);

AES_Decrypt Decrypt(
    .cs(cs_n[1]),
    .sclk(clk),
    .sdi(mosi),
    .sdo(miso[1])
);
reg [0:2] state; //0 = idle, 1 = send key, 2 = send msg, 3 = receive enc, 4 = send key2, 5 = send enc, 6 = receive dec, 7 = check answer
reg sFlag;
integer CycleCount;
reg [0:127] encMSG, decMSG;
reg [0:257] testKeys[0:2];

reg [0:127] testMsg = 128'h00112233445566778899aabbccddeeff;
//reg clk;
reg clkDivisor1;
reg clkDivisor2;
//reg FPGAclk;
//always #1 FPGAclk = ~FPGAclk;
always @(posedge FPGAclk) clkDivisor1 = ~clkDivisor1;
always @(posedge clkDivisor1) clkDivisor2 = ~clkDivisor2;
always @(posedge clkDivisor2) clk = ~clk;

// reg [0:1] testNum;
// reg startTest;
reg prevDone;
initial begin
//	 startTest = 1'b1;
//    testNum = 2'b01;
    encMSG = 0;
	 clkDivisor1=0;
	 clkDivisor2=0;
    clk = 0;
    decMSG = 0;
    state = Idle;
    sFlag = 0;
    CycleCount = 0;
    start = 0;
	testKeys[0][0:257] = 258'h000102030405060708090a0b0c0d0e0f;
	testKeys[1][0:257] = {2'b01,256'h000102030405060708090a0b0c0d0e0f1011121314151617};
	testKeys[2][0:257] = {2'b10,256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f};
    prevDone = 0;
end

//always #1 clk = ~clk;

always @(posedge clk) begin
    case(state)
        Idle: begin
            if(startTest==1) begin
                state = SendKey;
                pass = 1'b0;
                fail = 1'b0;
            end
        end
        SendKey: begin
            //send key
            txMain = testKeys[testNum][0:257];
            sel = 1'b0;
            if(sFlag==0) begin
                start = 1'b1;
                sFlag = 1'b1;
            end
            else begin
                start = 1'b0;
            end
            if(done==1 && prevDone == 0) begin
                state = SendMsg;
                sFlag = 0;
            end
        end
        SendMsg: begin
            //send msg
            txMain = testMsg;
            sel = 1'b0;
				if(sFlag==0)  begin
					CycleCount = CycleCount + 1;
				end
            if(CycleCount == 80) begin
                start = 1'b1;
                sFlag = 1'b1;
					 CycleCount = 0;
            end
            else begin
                start = 1'b0;
            end
            if(done==1 && prevDone == 0) begin
                state = ReceiveEnc;
                sFlag = 0;
            end
        end
        ReceiveEnc: begin
            //receive enc
            sel = 1'b0;
            if(sFlag==0) begin
                CycleCount = CycleCount + 1;
            end
            if(CycleCount == 70) begin
                start = 1'b1;
                CycleCount = 0;
                sFlag = 1'b1;
            end
            else begin
                start = 1'b0;
            end
            if(done==1 && prevDone == 0) begin
                encMSG = rxMain;
                state = SendKey2;
                sFlag = 0;
            end
        end
        SendKey2: begin
            //send key
            txMain = testKeys[testNum][0:257];
            sel = 1'b1;
            if(sFlag==0) begin
                start = 1'b1;
                sFlag = 1'b1;
            end
            else begin
                start = 1'b0;
            end
            if(done==1 && prevDone == 0) begin
                state = SendEnc;
                sFlag = 0;
            end
        end
        SendEnc: begin
            //send enc
            txMain = encMSG;
            sel = 1'b1;
				if(sFlag==0) begin
					CycleCount = CycleCount + 1;
				end
            if(CycleCount==80) begin
                start = 1'b1;
					 CycleCount = 0;
                sFlag = 1'b1;
            end
            else begin
                start = 1'b0;
            end
            if(done==1 && prevDone == 0) begin
                state = ReceiveDec;
                sFlag = 0;
            end
        end
        ReceiveDec: begin
            //receive dec
            sel = 1'b1;
            if(sFlag==0) begin
                CycleCount = CycleCount + 1;
            end
            if(CycleCount == 70) begin
                start = 1'b1;
                CycleCount = 0;
                sFlag = 1'b1;
            end
            else begin
                start = 1'b0;
            end
            if(done==1 && prevDone == 0) begin
                decMSG = rxMain;
                state = CheckAnswer;
                sFlag = 0;
            end
        end
        CheckAnswer: begin
            //check answer
            if(decMSG == testMsg) begin
                $display("Test Passed");
                pass = 1'b1;
            end
            else begin
                $display("Test Failed");
                fail = 1'b1;
            end
            state = Idle;
        end
    endcase
    if(done != prevDone) begin
        prevDone = done;
    end
end




endmodule

//module Self_Checking_tb (
////    input FPGAclk,
////    input startTest,
////    input [0:1] testNum,
//    output reg pass,
//    output reg fail,
//	 output reg Encrypted_Pass,
//	 output reg Encrypted_Fail
//);
//
//localparam Idle = 0;
//localparam SendKey = 1;
//localparam SendMsg = 2;
//localparam ReceiveEnc = 3;
//localparam SendKey2 = 4;
//localparam SendEnc = 5;
//localparam ReceiveDec = 6;
//localparam CheckAnswer = 7;
//
//reg [0:257] txMain;
//wire [0:127] rxMain;
//wire [0:1]miso;
//reg sel;
//reg start;
//wire [0:1]cs_n;
//wire sclk;
//wire mosi;
//wire done;
//reg clk;
//reg clkDivisor1;
//reg clkDivisor2;
//reg FPGAclk;
//always #1 FPGAclk = ~FPGAclk;
//always @(posedge FPGAclk) clkDivisor1 = ~clkDivisor1;
//always @(posedge clkDivisor1) clkDivisor2 = ~clkDivisor2;
//always @(posedge clkDivisor2) clk = ~clk;
//
//SPI_Main spM(
//	.clk(clk),
//	.miso(miso),
//    .sel(sel),
//	.start(start),
//	.tx(txMain),
//	.rx(rxMain),
//	.cs_n(cs_n),
//	.sclk(sclk),
//	.mosi(mosi),
//	.done(done)
//);
//
//AES_Encrypt Encrypt(
//    .cs(cs_n[0]),
//    .sclk(sclk),
//    .sdi(mosi),
//    .sdo(miso[0])
//);
//
//AES_Decrypt Decrypt(
//    .cs(cs_n[1]),
//    .sclk(sclk),
//    .sdi(mosi),
//    .sdo(miso[1])
//);
//reg [0:2] state; //0 = idle, 1 = send key, 2 = send msg, 3 = receive enc, 4 = send key2, 5 = send enc, 6 = receive dec, 7 = check answer
//reg sFlag;
//integer CycleCount;
//reg [0:127] encMSG, decMSG;
//reg [0:257] testKeys[0:2];
//
//reg [0:127] testMsg;
//
//
// reg startTest;
// reg [0:1] testNum;
//reg prevDone;
//initial begin
//	 startTest = 1'b1;
//    testNum = 2'b00;
//    encMSG = 0;
//    clk = 0;
//	 FPGAclk = 0;
//	 clkDivisor1 = 0;
//	 clkDivisor2 = 0;
//    decMSG = 0;
//    state = Idle;
//    sFlag = 0;
//    CycleCount = 0;
//    start = 0;
//	 testMsg = 128'h00112233445566778899aabbccddeeff;
//	 Encrypted_Pass = 0;
//	 Encrypted_Fail = 0;
////	testKeys[0][0:257] = 258'h000102030405060708090a0b0c0d0e0f;
////	testKeys[1][0:257] = {2'b01,256'h000102030405060708090a0b0c0d0e0f1011121314151617};
////	testKeys[2][0:257] = {2'b10,256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f};
//    prevDone = 0;
//end
//
////always #1 clk = ~clk;
//
//always @(posedge clk) begin
//    case(state)
//        Idle: begin
//            if(startTest==1) begin
//                state = SendKey;
//                pass = 1'b0;
//                fail = 1'b0;
//            end
//        end
//        SendKey: begin
//            //send key
//				if(testNum == 0)
//					txMain = 258'h000102030405060708090a0b0c0d0e0f;
//				else if(testNum == 1)
//					txMain = {2'b01,256'h000102030405060708090a0b0c0d0e0f1011121314151617};
//				else if(testNum == 2)
//					txMain = {2'b10,256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f};
//				else 
//					txMain = 0;
//            sel = 1'b0;
//            if(sFlag==0) begin
//                start = 1'b1;
//                sFlag = 1'b1;
//            end
//            else begin
//                start = 1'b0;
//            end
//            if(done==1 && prevDone == 0) begin
//                state = SendMsg;
//                sFlag = 0;
//            end
//        end
//        SendMsg: begin
//            //send msg
//            txMain = testMsg;
//            sel = 1'b0;
//				if(sFlag==0)  begin
//					CycleCount = CycleCount + 1;
//				end
//            if(CycleCount == 150) begin
//                start = 1'b1;
//                sFlag = 1'b1;
//					 CycleCount = 0;
//            end
//            else begin
//                start = 1'b0;
//            end
//            if(done==1 && prevDone == 0) begin
//                state = ReceiveEnc;
//                sFlag = 0;
//            end
//        end
//        ReceiveEnc: begin
//            //receive enc
//            sel = 1'b0;
//            if(sFlag==0) begin
//                CycleCount = CycleCount + 1;
//            end
//            if(CycleCount == 150) begin
//                start = 1'b1;
//                CycleCount = 0;
//                sFlag = 1'b1;
//            end
//            else begin
//                start = 1'b0;
//            end
//            if(done==1 && prevDone == 0) begin
//                encMSG = rxMain;
//                state = SendKey2;
//                sFlag = 0;
//					 
//					 Encrypted_Pass = 0;
//					 Encrypted_Fail = 0;
//					 if(testNum == 0 && rxMain == 130'h69c4e0d86a7b0430d8cdb78070b4c55a) begin
//						 Encrypted_Pass = 1;
//					 end
//					 else if(testNum == 1 && rxMain == 130'hdda97ca4864cdfe06eaf70a0ec0d7191)
//						Encrypted_Pass = 1;
//					 else if(testNum == 2 && rxMain == 130'h8ea2b7ca516745bfeafc49904b496089)
//						Encrypted_Pass = 1;
//					 else 
//						Encrypted_Fail = 1;
//						
//            end
//        end
//        SendKey2: begin
//            //send key
//            txMain = testKeys[testNum][0:257];
//            sel = 1'b1;
//            if(sFlag==0) begin
//                start = 1'b1;
//                sFlag = 1'b1;
//            end
//            else begin
//                start = 1'b0;
//            end
//            if(done==1 && prevDone == 0) begin
//                state = SendEnc;
//                sFlag = 0;
//            end
//        end
//        SendEnc: begin
//            //send enc
//            txMain = encMSG;
//            sel = 1'b1;
//				if(sFlag==0) begin
//					CycleCount = CycleCount + 1;
//				end
//            if(CycleCount==150) begin
//                start = 1'b1;
//					 CycleCount = 0;
//                sFlag = 1'b1;
//            end
//            else begin
//                start = 1'b0;
//            end
//            if(done==1 && prevDone == 0) begin
//                state = ReceiveDec;
//                sFlag = 0;
//            end
//        end
//        ReceiveDec: begin
//            //receive dec
//            sel = 1'b1;
//            if(sFlag==0) begin
//                CycleCount = CycleCount + 1;
//            end
//            if(CycleCount == 150) begin
//                start = 1'b1;
//                CycleCount = 0;
//                sFlag = 1'b1;
//            end
//            else begin
//                start = 1'b0;
//            end
//            if(done==1 && prevDone == 0) begin
//                decMSG = rxMain;
//                state = CheckAnswer;
//                sFlag = 0;
//            end
//        end
//        CheckAnswer: begin
//            //check answer
//            if(decMSG == testMsg) begin
//                $display("Test Passed");
//                pass = 1'b1;
//            end
//            else begin
//                $display("Test Failed");
//                fail = 1'b1;
//            end
//            state = Idle;
//        end
//    endcase
//    if(done != prevDone) begin
//        prevDone = done;
//    end
//end
//
//
//
//
//endmodule