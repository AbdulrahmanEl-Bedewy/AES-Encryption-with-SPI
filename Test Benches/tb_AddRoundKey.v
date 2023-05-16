module tb_AddRoundKey;

  // Inputs
  reg [127:0] istate;
  reg [127:0] key;

  // Outputs
  wire [127:0] ostate;

  // Instantiate the unit under test (UUT)
  AddRoundKey uut (
    .istate(istate),
    .key(key),
    .ostate(ostate)
  );

  initial begin
    // Initialize inputs
    istate = 128'h00112233445566778899aabbccddeeff;
    key = 128'h000102030405060708090a0b0c0d0e0f;

    // Wait a few time units for the output to settle
    #5;

    // Check the output
    if (ostate !== 128'h102030405060708090a0b0c0d0e0f0) begin
      $display("Test failed: expected ostate = 128'102030405060708090a0b0c0d0e0f0, got ostate = %h", ostate);
      $finish;
    end else begin
      $display("Test passed: ostate = 128'h102030405060708090a0b0c0d0e0f0");
      $finish;
    end
  end

endmodule
