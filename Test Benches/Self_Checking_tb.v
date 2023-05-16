module Self_Checking_tb (
    // input clk,
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


// reg [0:1] testNum;
// reg startTest;
reg prevDone;
initial begin
    // startTest = 1'b1;
    // testNum = 2'b00;
    encMSG = 0;
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

always #1 clk = ~clk;

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
            if(sFlag==0) begin
                start = 1'b1;
                sFlag = 1'b1;
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
                start = 1'b1;
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