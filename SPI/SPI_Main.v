module SPI_Main (
	input clk,
	input miso,
	input start,
	input [0:127] tx,
	output reg [0:127] rx,
	output reg cs_n,
	output reg sclk,
	output reg mosi,
	output reg done
);


reg [7:0] tbit;
reg [7:0] rbit;
reg state; // 00 send/receive 1 done
initial begin
	state = 1'b0;
	sclk = 1'b0;
	tbit = 8'd0;
	rbit = 8'd0;
	rx = 0;
end

always @(posedge clk) begin
	if(state == 1'b0) begin//IDLE
		if(start == 1'b1) begin
			state = 1'b1;
			done = 0;
			cs_n = 1'b0;
		end
	end else begin// Send/receive
		if(rbit == 128 && tbit == 128) begin
			done = 1;
			state = 1'd0;
			cs_n = 1'b1;
		end
	end
		
end

always begin
	#5 sclk = ~sclk;
end

always @(posedge sclk) begin
	if(state == 1'b1 && tbit < 8'd128)begin
		mosi = tx[tbit];
		tbit <= tbit + 1;
	end else if(state == 1'b0) begin //if(currbit == 4'd0) all 8 bits are sent
		mosi = 0;
		tbit = 8'd0;
	end
end

always @(negedge sclk) begin
	if(state == 1'b1 && rbit < 8'd128)begin
		rx = {rx[1:127], miso};
		rbit <= rbit + 1;
	end else if(state == 1'b0) begin
		rbit = 8'd0;
	end
end

endmodule