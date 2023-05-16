module tb_MixColumns_InvMixColumns;

//for MixColumns
reg [127:0] iState;
wire [127:0] oMixedState;
//inistantiating MixColumns device under test
MixColumns dut1
(
.state(iState),
.ostate(oMixedState)
);

//for InvMixColumns
reg [127:0] iMixedState;
wire [127:0] invMixedState;
//inistantiating InvMixColumns device under test
InvMixColumns dut2
(
.istate(iMixedState),
.ostate(invMixedState)
);

initial begin
  // Set input to some test values
  iState = 128'h0123456789abcdef0123456789abcdef;

  //some delay
  #1
  //assign the input of invMix
	iMixedState = oMixedState;

//some delay
  #1
  // Verify that the output matches the input
  if (iState === invMixedState) begin
    $display("Test succeeded!");
  end else begin
    $display("Test failed!");
  end
  
  #100
  // End simulation
  $finish;
end




endmodule