module SPI_Sub (
    input cs,
    input sclk,
    input sdi,
    input [0:127] tx, // sent from AES module
    output reg [0:257] rx, // sent to AES module
    output reg sdo,
    output reg done
);

//reg [127:0] tx_reg, rx_reg;
reg [0:8] size;

integer i,j;
initial begin
    i=0;
    j=0;
    rx=0;
    size = 130;
	 done = 0;
end

//receive on negedge
always @ (negedge sclk) begin
    if (cs == 1'b0 && i < size) begin
        done = 0;

        rx = {rx[1:257], sdi};
        i=i+1;

        // check the size of message from the first 2 bits sent
        if(i == 2)begin
            case(rx[256:257])
                2'b00: begin 
						size = 130;
						rx = {128'b0 , rx[256:257], 128'b0};
					end
                2'b01: begin
						size = 194;
						rx = {192'b0 , rx[256:257], 64'b0};
					end
                2'b10: begin 
						size = 258;
					end
            endcase
				
        end

    end
    else begin
        i<=0;
		  if(i == size)
				done = 1;
    end
end



//send on posedge
always @ (posedge sclk) begin
    if (cs == 1'b0) begin
		if(j<128) begin
        sdo = tx[j];
        j<=j+1;
		end
	 end
    else begin
        j<=0;
    end
end


endmodule