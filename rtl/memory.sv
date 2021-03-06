// memory
module memory#(parameter width=32, parameter addwidth=12)
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
  
//   data memory
  // assign byte_masking = address[addwidth-1 : addwidth- 2];
//   load
  assign data_out=mem[address];
  always @(posedge clk) begin 
//    store
    if (str) begin
      mem[address]<=data_in;
      case(byte_masking)
        2'b00:mem[address][7:0]<=data_in[7:0];
        2'b01:mem[address][15:8]<=data_in[15:8];
        2'b10:mem[address][23:16]<=data_in[23:16];
        2'b11:mem[address][31:24]<=data_in[31:24];
        default:mem[address]<=data_in;
      endcase
  	end
  end
endmodule