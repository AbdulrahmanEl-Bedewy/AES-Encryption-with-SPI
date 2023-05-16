module tb_Subbytes_Invsubbytes;

//for subBytes
reg [127:0] iState_subBytes;
wire [127:0] oState_subBytes;
//inistantiating subBytes device under test
SubBytes DUT1(
.istate(iState_subBytes),
.ostate(oState_subBytes)
);

//for InvSubBytes
reg [127:0] iState_InvSubBytes;
wire [127:0] oState_InvSubBytes;
//inistantiating InvsubBytes device under test
InvSubBytes DUT2(
.istate(iState_InvSubBytes),
.ostate(oState_InvSubBytes)
);

initial begin
  // Set input to some test values
  iState_subBytes = 128'h1323456789abcdef0123456789abcdef;

  //some delay
  #1
  //assign the input of invSubBytes
	iState_InvSubBytes = oState_subBytes;

//some delay
  #1
  // Verify that the output matches the input
  if (iState_subBytes === oState_InvSubBytes) begin
    $display("Test succeeded!");
  end else begin
    $display("Test failed!");
  end
  
  #100
  // End simulation
  $finish;
end




endmodule