module SPI_sub (
    input cs,
    input sclk,
    input sdi,
    input [127:0] tx, // sent from AES module
    output [127:0] rx, // sent to AES module
    output sdo,
    output done
);

reg [127:0] tx_reg, rx_reg;

integer i,j;
initial begin
    i=0;
    j=0;
end

//receive on negedge
always @ (negedge sclk) begin
    if (~cs && i<128) begin
        rx_reg <= rx_reg<<1 | sdi;
        i<=i+1;
    end
    else if(cs) begin
        i<=0;
    end
end

assign rx = rx_reg;
assign done = i==128;

//send on posedge
always @ (posedge sclk) begin
    if (~cs && j<128) begin
//        sdo <= tx_reg[DATA_OUT-1-j];
        tx_reg <= tx_reg<<1;
        j<=j+1;
    end
    else if(cs) begin
        j<=0;
    end
end

//assign tx_reg = tx;


endmodule