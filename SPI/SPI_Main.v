module SPI_Main (
	input clk,
	input miso,
	input start,
	input [7:0] tx,
	output reg [7:0] rx,
	output reg cs_n,
	output reg sclk,
	output reg mosi,
	output reg done
);


reg [2:0] tbit;
reg [2:0] rbit;
reg state; // 00 send/receive 1 done
initial begin
	state = 0;
end

always @(*) begin
	case(state)
		0: begin //IDLE
			sclk = 1'b0;
			mosi = 0;
			cs_n = 1'b1;
			if(start == 1) begin
				rbit = 3'd7;
				tbit = 3'd7;
				state = 1'd1;
				done = 0;
				cs_n = 1'b0;
			end
		end
		1: begin // Send/receive
//			sclk = ~sclk;
			if(rbit == 0 && tbit == 0) begin
				done = 1;
				state = 1'd0;
			end
		end
	endcase	
end

always @(state) begin
	#5 sclk = ~sclk;
end

always @(posedge sclk) begin
	if(tbit >= 3'd0)begin
		mosi = tx[tbit];
		tbit <= tbit - 1;
	end else begin //if(currbit == 4'd0) all 8 bits are sent
		mosi = 0;
	end
end

always @(negedge sclk) begin
	if(rbit >= 3'd0)begin
		rx = {rx[6:0], miso};
		rbit <= rbit - 1;
	end 
end

endmodule