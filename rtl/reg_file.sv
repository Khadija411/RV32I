// REGISTER FILE   
module reg_file#(
parameter DataWidth=32,
parameter Registers=32,
parameter AddrRegWidth=5
)
(
  input logic [AddrRegWidth-1:0]rs1,
  input logic [AddrRegWidth-1:0]rs2,
  input logic [AddrRegWidth-1:0]rd,
  input logic wen,
  input logic [DataWidth-1:0]wdata,
  input logic clk,
  input logic rst,
  output logic [DataWidth-1:0]rdata1,
  output logic [DataWidth-1:0]rdata2
);
  logic [DataWidth-1:0]r[0:Registers-1];

  integer i;
initial begin
  for (i=0;i<(Registers);i=i+1)begin
    r[i]<=0;
  end
  r[2]<=32'h00000200;
end

  always_ff @(posedge clk)begin
    if (rst) begin
        for (i=0;i<(Registers);i=i+1)
            r[i]<=0;
        end
    else if (!rst && wen)begin
            if (rd==5'd0)
                r[0]<=32'h00000000;
            else
                r[rd]<=wdata;       
        end
    
  end
  assign rdata1=r[rs1];
  assign rdata2=r[rs2];

endmodule
