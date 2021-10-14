// Test bench for ALU

module test;
  logic [31:0]A;
  logic [31:0]B;
  logic [3:0]Data_sel;
  logic [31:0]res;
  
  ALU CaL1(
    .A(A), 
    .B(B),
    .Data_sel(Data_sel),
    .res(res)
  );
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
	#2;
    $monitor("At Data select=%0b res=%0b", Data_sel, res);
    A=32'b00000000000000000000000000000010;
    B=32'b11111111111111111111111111111111;
//     Data_sel=4'b0010;
//     #2;
//     Data_sel=4'b0011;
//     #2;
//     Data_sel=4'b0100;
//     #2;
//     Data_sel=4'b1111;
//     #2
    Data_sel=1001;
    #2;
    
    $finish();
  end
endmodule
