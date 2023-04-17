module KeyExpansion_tb (
	output [(128*(10+1))-1:0]w
);
localparam Nk = 4;
localparam Nr = 10;
reg [127:0] key;

KeyExpansion #(.Nk(Nk),.Nr(Nr))ke_inst1(
    .key(key),
    .w(w)
);
initial begin
    key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    #100;
    $display("w = %h \n",w);
end
endmodule