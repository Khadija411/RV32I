// unit testing of immediate

module test;
  logic [31:0]inst;
  logic [31:0]PC;
  logic [31:0]I;
  logic [31:0]S;
  logic [31:0]Sb;
  logic [31:0]Uj;
  logic [31:0]U;
  
  Immediate Imm(
    .inst(inst),
    .PC(PC),
    .I(I),
    .S(S),
    .Sb(Sb),
    .Uj(Uj),
    .U(U)
  );
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
	#2;
    inst=32'b00000000000100101000001010010011;
    PC=32'b00000000000000000000000000001100;

    #2;
    
    $finish();
  end
endmodule
