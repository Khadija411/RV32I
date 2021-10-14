// memory

module memory#(parameter width=32, parameter addwidth=12)
  (
    input logic [addwidth-1 : 0] address_read,
    input logic clk,
    input logic [31:0] data_in,
    input logic [addwidth-1 : 0] address,
    input logic str,
    input logic ld,
    input logic [3:0]byte_masking,
    output logic [31:0] instruction,
    output logic [31:0] data_out
  );
  
  parameter depth=2**addwidth;
  logic [width-1:0]mem[0:depth-1];
//   instruction memory
  assign instruction=mem[address_read];
//   data memory
  always @(posedge clk) begin
//   load
    if (ld)
      data_out<=mem[address];
//    store
    if (str) begin
      case(byte_masking)
        0:mem[address][7:0]<=data_in[7:0];
        1:mem[address][15:8]<=data_in[15:8];
        2:mem[address][23:16]<=data_in[23:16];
        3:mem[address][31:24]<=data_in[31:24];
        default:mem[address]<=data_in;
      endcase
  	end
  end
endmodule
