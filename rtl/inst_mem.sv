 module inst_mem#(parameter width=32, parameter addwidth=12)
  (
    input logic [addwidth-1 : 0] address,
    input logic clk,
    input logic [31:0] data_in,
    input logic str,
    input logic [1:0] byte_masking,
    output logic [31:0] data_out
  );
  
  parameter depth=2**addwidth;
  logic [width-1:0]mem[0:depth-1];
  
  always @(posedge clk) begin 
    if (str) begin
      case(byte_masking)
        2'b00:mem[0][7:0]<=data_in[7:0];
        2'b01:mem[0][15:8]<=data_in[15:8];
        2'b10:mem[0][23:16]<=data_in[23:16];
        2'b11:mem[0][31:24]<=data_in[31:24];
      endcase
  	end
  end
  always_latch begin
    $readmemh("/home/khadija/Documents/RV32I/assembly/test.mem",mem);
  end
  assign data_out=mem[address];
endmodule
