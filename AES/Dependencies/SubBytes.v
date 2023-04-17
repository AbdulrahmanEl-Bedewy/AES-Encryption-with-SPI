module SubBytes #(parameter DATA_SIZE=128)(
	input istate,
	output ostate
);

input [DATA_SIZE-1:0] istate;
output [DATA_SIZE-1:0] ostate;

genvar i;
generate
	for(i=0;i<DATA_SIZE;i=i+8) begin : SubBytes
		S_Box sbox_inst(
			.istate(istate[i+7:i]),
			.ostate(ostate[i+7:i])
		);
	end
endgenerate


endmodule 