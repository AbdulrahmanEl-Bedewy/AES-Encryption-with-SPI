module SubBytes (
	input [127:0] istate,
	output [127:0] ostate
);

genvar i;
generate
	for(i=0;i<16;i=i+1) begin : SubBytes
		S_Box sub_inst(
			.istate(istate[8*i+7:8*i]),
			.ostate(ostate[8*i+7:8*i])
		);
	end
endgenerate

endmodule 