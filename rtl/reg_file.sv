// REGISTER FILE
module reg_file(
  input logic [4:0]rs1,
  input logic [4:0]rs2,
  input logic [4:0]rd,
  input logic wen,
  input logic [31:0]wdata,
  input logic clk,
  output logic [31:0]rdata1,
  output logic [31:0]rdata2
);
  logic [31:0]r[0:31];
  always_ff @(posedge clk)begin
    
    if (wen)begin
      r[rd]<=wdata;
    end
    
  end
  assign rdata1=r[rs1];
  assign rdata2=r[rs2];

endmodule
