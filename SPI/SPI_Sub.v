module SPI_Sub (
    input cs,
    input sclk,
    input sdi,
    input [0:127] tx, // sent from AES module
    output reg [0:257] rx, // sent to AES module
    output reg sdo,
    output done
);

reg [127:0] tx_reg, rx_reg;
reg [0:7] size;

integer i,j;
initial begin
    i=0;
    j=0;
    rx=0;
    size = 130;
end

//receive on negedge
always @ (negedge sclk) begin
    if (cs == 1'b0 && i < size) begin
        done = 0;

        rx = {rx[0:254], sdi};
        i<=i+1;

        // check the size of message from the first 2 bits sent
        if(i == 2)begin
            case(rx[0:1])
                00: size = 130;
                01: size = 198;
                10: size = 258;
            endcase
        end

    end
    else begin
        i<=0;
        done = 1;
    end
end



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