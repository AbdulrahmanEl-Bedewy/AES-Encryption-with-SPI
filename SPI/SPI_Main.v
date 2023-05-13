module SPI_Main (
	input clk,
	input miso,
	input start,
	input [0:257] tx,
	output reg [0:127] rx,
	output reg cs_n,
	output reg sclk,
	output reg mosi,
	output reg done
);


reg [8:0] tbit;
reg [8:0] rbit;
reg state; // 00 send/receive 1 done
reg [8:0]size;
initial begin
	state = 1'b0;
	sclk = 1'b0;
	tbit = 9'd0;
	rbit = 9'd0;
	rx = 0;
	size = 258;
end

always @(posedge clk) begin
	if(state == 1'b0) begin//IDLE
		if(start == 1'b1) begin
			state = 1'b1;
			done = 0;
			cs_n = 1'b0;
			case(tx[0:1])
                2'b00: size = 130;
                2'b01: size = 194;
                2'b10: size = 258;
			endcase
		end
	end else begin// Send/receive
		if(rbit == size && tbit == size) begin
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
	if(state == 1'b1 && tbit < size)begin
		if(tbit < 2)
			mosi = tx[tbit];
		else
			mosi = tx[ 258 - size + tbit];
		tbit <= tbit + 1;
	end else if(state == 1'b0) begin //if(currbit == 4'd0) all 8 bits are sent
		mosi = 0;
		tbit = 9'd0;
	end
end

always @(negedge sclk) begin
	if(state == 1'b1) begin
		rbit <= rbit + 1;
		if(rbit < 9'd128)begin
			rx = {rx[1:127], miso};
		end
	end else if(state == 1'b0) begin
		rbit = 9'd0;
	end
end

endmodule