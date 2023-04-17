module SubBytes (
	input [0:127] istate,
	output [0:127] ostate
);

genvar i;
generate
	for(i=0;i<16;i=i+1) begin : SubBytes
		S_Box sub_inst(
			.istate(istate[8*i+:8]),
			.ostate(ostate[8*i+:8])
		);
	end
endgenerate

endmodule 