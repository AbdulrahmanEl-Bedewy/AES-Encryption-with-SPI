module SPI_sub #(parameter DATA_OUT = 128)(
    input cs,
    input sclk,
    input sdi,
    input [DATA_OUT-1:0] tx, // sent from AES module
    output [DATA_OUT-1:0] rx, // sent to AES module
    output sdo,
    output done,
)

reg [DATA_OUT-1:0] tx_reg, rx_reg;

integer i,j;
initial begin
    i=0;
    j=0;
end

//receive on negedge
always @ (negedge sclk) begin
    if (~cs && i<DATA_OUT) begin
        rx_reg <= rx_reg<<1 | sdi;
        i<=i+1;
    end
    else if(cs) begin
        i<=0;
    end
end

assign rx = rx_reg;
assign done = i==DATA_OUT;

//send on posedge
always @ (posedge sclk) begin
    if (~cs && j<DATA_OUT) begin
        sdo <= tx_reg[DATA_OUT-1-j];
        tx_reg <= tx_reg<<1;
        j<=j+1;
    end
    else if(cs) begin
        j<=0;
    end
end

assign tx_reg = tx;


endmodule

Message gaser, Thotimus Prime
