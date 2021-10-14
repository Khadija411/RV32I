// TESTING THE REGISTER FILE 
`timescale 1ps/1ps

module test;
  logic [4:0]rs1;
  logic [4:0]rs2;
  logic [4:0]rd;
  logic wen;
  logic [31:0]wdata;
  logic clk;
  logic [31:0]rdata1;
  logic [31:0]rdata2;
  
  reg_file file1(
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .wen(wen),
    .wdata(wdata),
    .clk(clk),
    .rdata1(rdata1),
    .rdata2(rdata2)
  );

  
  initial begin //input 
    
    $dumpfile("dump.vcd");
    $dumpvars(0);
    clk=1;
    rs1=5'b00001;
    rs2=5'b00010;
    rd =5'b00101;
    #5;
    wen=1;
    wdata=32'b0000000000000000000000000000011;
    #10;
    rs1=5'b00101;
    rs2=5'b00010;
    rd =5'b01101;
    #5;
    wen=0;
    wdata=32'b00000000000000000000111000001111;
    #10;
    $stop;
    $finish;
  end
  
always 
  begin 
    forever #5 clk = ~clk;
  end
endmodule
