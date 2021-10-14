// unit testing
`timescale 1ps/1ps
module mem;

  parameter addwidth=12;
  parameter width=32;
  // local parameter
  parameter depth=2**addwidth;
  logic [width-1:0]mem[0:depth-1];
	  
  logic [addwidth-1 : 0] address_read;
  logic 				 clk;
  logic [31:0] 			 data_in;
  logic [addwidth-1 : 0] address;
  logic					 str;
  logic 				 ld;
  logic [3:0]			 byte_masking;
  logic [31:0]  		 instruction;
  logic [31:0] 			 data_out;


memory M1(
  
  .address_read(address_read),
  .data_in(data_in),
  .address(address),
  .ld(ld),
  .str(str),
  .clk(clk),
  .byte_masking(byte_masking),
  .instruction(instruction),
  .data_out(data_out)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
	clk=0;
  	str=1;
  	ld=0;
  	address=12'b000000000001;
  	data_in=32'b01000000000100010000001010110011;
  	byte_masking=2;
  	#5;
  	address_read=12'b000000000001;
  	#5;
  	ld=1;
    #10 $finish();
end

always 
  begin 
    forever #2 clk = ~clk;
  end

endmodule
