module SPI_Sub (
    input cs,
    input sclk,
    input sdi,
    input [0:127] tx, // sent from AES module
    output reg [127:0] rx, // sent to AES module
    output reg sdo,
    output done
);

reg [127:0] tx_reg, rx_reg;

integer i,j;
initial begin
    i=0;
    j=0;
	 rx=0;
end

//receive on negedge
always @ (negedge sclk) begin
    if (cs == 1'b0 && i<128) begin
        rx = {rx[126:0], sdi};
        i<=i+1;
    end
    else begin
        i<=0;
    end
end

assign done = i==128;

//send on posedge
always @ (posedge sclk) begin
    if (cs == 1'b0 && j<128) begin
        sdo = tx[j];
        j<=j+1;
    end
    else begin
        j<=0;
    end
end


endmodule