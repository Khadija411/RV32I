// unit testing of branch

module test;
  logic [31:0]A;
  logic [31:0]B;
  logic [2:0]fun3;
  logic en;
  logic res;
  
  Branch branch(
    .A(A),
    .B(B),
    .func3(func3),
    .en(en),
    .res(res),
  );
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
	#2;
   A=32'b00000000000100101000001010010011;
    B=32'b00000000000000000000000000001100;
func3=3'b000;
    en=1;
    #2;
    fun3=101;
    #2
    fuc3=111;
    $finish();
  end
endmodule
