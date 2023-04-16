module SPI_Sub(
	input cs,
	input sclk,
	input sdi,
	input [7:0] data,
	output sdo
)

always @(posedge sclk) begin
	if(cs == 0) begin
		sdo <= 
	end
	
end
	
	