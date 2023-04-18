module SPI_Main (
	input clk,
	input miso,
	input start,
	input [127:0] tx,
	output reg [127:0] rx,
	output reg cs_n,
	output reg sclk,
	output reg mosi,
	output reg done
);


reg [6:0] tbit;
reg [6:0] rbit;
reg state; // 00 send/receive 1 done
initial begin
	state = 1'b0;
	sclk = 1'b0;
	tbit = 7'd127;
	rbit = 7'd127;
	rx = 0;
end

always @(posedge clk) begin
	if(state == 1'b0) begin
								//IDLE
//			sclk = 1'b0;
//			mosi = 0;
			
			if(start == 1'b1) begin
//				rbit = 7'd127;
//				tbit = 7'd127;
				state = 1'b1;
				done = 0;
				cs_n = 1'b0;
			end
	end else begin
									// Send/receive
//			sclk = ~sclk;
		if(rbit == 127 && tbit == 127) begin
//				#5 sclk = ~sclk;
//			end else begin
			done = 1;
			state = 1'd0;
			cs_n = 1'b1;
		end
	end
		
end
//
always begin
//	if(state == 1'b1) begin
		#5 sclk = ~sclk;
//	end else begin
//		sclk = 1'b0;
//	end
end

always @(posedge sclk) begin
	if(tbit >= 7'd0)begin
		mosi = tx[tbit];
		tbit <= tbit - 1;
	end else begin //if(currbit == 4'd0) all 8 bits are sent
		mosi = 0;
		tbit = 7'd127;
	end
end

always @(negedge sclk) begin
	if(rbit >= 7'd0)begin
		rx = {rx[126:0], miso};
		rbit <= rbit - 1;
	end else begin
		rbit = 7'd127;
	end
end

endmodule