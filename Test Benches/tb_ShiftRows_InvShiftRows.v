module tb_ShiftRows_InvShiftRows;

//for ShiftRows
reg [127:0] iiState;
wire [127:0] oMixedState;
//inistantiating ShiftRows device under test
ShiftRows dut1
(
.istate(iiState),
.ostate(oMixedState)
);

//for InvShiftRows
reg [127:0] iMixedState;
wire [127:0] invMixedState;
//inistantiating InvShiftRows device under test
InvShiftRows dut2
(
.istate(iMixedState),
.ostate(invMixedState)
);

initial begin

	$display("Starting ShiftRows & invShiftRows test bench\n");
	
  // Set input to some test values
  iiState = {8'h11, 8'h22, 8'h33, 8'h44, 8'h55, 8'h66, 8'h77, 8'h88,
              8'h99, 8'hAA, 8'hBB, 8'hCC, 8'hDD, 8'hEE, 8'hFF, 8'h00};
  //some delay
  #1
  //assign the input of invMix
	iMixedState = oMixedState;

//some delay
  #1
  // Verify that the output matches the input
  if (iiState === invMixedState) begin
    $display("Test succeeded!");
  end else begin
    $display("Test failed!");
  end
  
  #100
  // End simulation
  $finish;
end




endmodule