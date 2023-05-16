module SPI_tb(

output reg [257:0] txMain,
output wire [127:0] rxMain,

output reg [127:0] txSub,
output wire [257:0] rxSub
);


reg clk;
wire [0:1]miso;
reg sel;
reg start;
wire [0:1]cs_n;
wire sclk;
wire mosi;
wire done;
wire doneSub;


SPI_Main spM(
	.clk(clk),
	.miso(miso),
	.sel(sel),
	.start(start),
	.tx(txMain),
	.rx(rxMain),
	.cs_n(cs_n),
	.sclk(sclk),
	.mosi(mosi),
	.done(done)
);

SPI_Sub spS(
	.cs(cs_n[0]),
	.sclk(sclk),
	.sdi(mosi),
	.tx(txSub), // sent from AES module
	.rx(rxSub), // sent to AES module
	.sdo(miso[0]),
	.done(doneSub)
);

initial begin
    clk = 1'b0;
    start = 1'b0;
	sel = 0;
    txMain = 258'h8E73B0F7DA0E6452C810F32B809079E562F8EAD2522C6B7B;
//    txMain = 258'h8E73B0F7DA0E6452C810F32B809079E562F8EAD2522C6B7B;
    txMain = {2'b01, txMain[255:0]};
    txSub = 128'h0;
    start = 1'b1;
    #2 start = 1'b0;
    #2800
    $display("rxMain = %h", rxMain);
    $display("rxSub = %h", rxSub);
    if(rxSub == txMain)
        $display("3ayz anam");
        
    
    txMain = 258'h2603DEB1015CA71BE2B73AEF0857D77811F352C073B6108D72D9810A30914DFF4;
    txSub = 128'hfa4d;
    start = 1'b1;
    #4 start = 1'b0;
    #2800;
    
    $display("rxMain = %h", rxMain);
    $display("txMain = %h", txMain);
    $display("rxSub  = %h", rxSub);
    if(rxSub == txMain)
        $display("sha8al el7");
        
    txMain = 258'h99999999999999999;
    txMain = {2'b01, txMain[255:0]};
    txSub = 128'h555555555555555555;
    
    start = 1'b1;
    #2 start = 1'b0;
    #2800

    $display("rxMain = %h", rxMain);
    $display("rxSub = %h", rxSub);
    
end



always begin
	#1 clk = ~clk;
end

endmodule 