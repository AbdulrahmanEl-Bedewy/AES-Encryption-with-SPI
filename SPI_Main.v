module SPI_Main(
	input clk,
	input miso,
	input start
	input [7:0] tx,
	output [7:0] rx,
	output cs_n,
	output sclk,
	output mosi,
	output done
)

reg [2:0] tbit;
reg [2:0] rbit;
reg state; // 00 send 01 receive 10 done

always @(posedge clk) begin
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
			sclk = ~sclk;
			if(rbit == 0 && tbit == 0) begin
				done = 1;
				state = 1'd0;
			end
		end
	endcase	
end

always @(posedge sclk) begin
	if(tbit >= 3'd0)begin
		mosi = tx[currbit];
		tbit <= tbit - 1;
	end else begin //if(currbit == 4'd0) all 8 bits are sent
		miso = 0;
	end
end

always @(negedge sclk) begin
	if(rbit >= 3'd0)begin
		rx = {rx[6:0], miso};
		rbit <= rbit - 1;
	end else begin //if(currbit == 4'd0) all 8 bits are sent
		miso = 0;
	end
end
