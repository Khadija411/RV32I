`include "rtl/memory.sv"
`include "rtl/inst_mem.sv"
`include "rtl/reg_file.sv"
`include "rtl/Immediate.sv"
`include "rtl/ALU.sv"
`include "rtl/Branch.sv"
`include "rtl/control_unit.sv"
module top(
  input logic clk,
  input logic reset,
  output logic [31:0]data
);

// -----------------------local variables-----------------------
  
  logic [31:0]inst;
  logic [31:0]A;
  logic [31:0]B;
  logic [31:0]Result;
  logic [31:0] PC=32'b0;
  logic [31:0]I_type;
  logic [31:0]S_type;
  logic [31:0]Sb_type;
  logic [31:0]U_type;
  logic [31:0]Uj_type;
  logic [31:0]JALR;
  logic br;
  logic mem2reg;
  logic [3:0]ALU_C;
  logic [31:0]branch_PC;
  logic reg_write;
  logic branch_en;
  logic [1:0]PC_sel;
  logic [1:0]imm_sel;
  logic [1:0]A_sel;
  logic [31:0]a1;
  logic B_sel;
  logic [31:0]b1;
  logic [31:0]b2;
  logic [31:0]data_out;
  logic str;
// ----------------------calling the modules-------------------- 
  memory data_mem(
    .address(Result[13:2]),
    .clk(clk),
    .data_in(b1),
    .str(str),
    .byte_masking(Result[31:30]),
    .data_out(data_out)
  );
  inst_mem instructions(
    .data_out(inst),
    .clk(clk),
    .data_in(b1),
    .str(str),
    .byte_masking(Result[31:30]),
    .address(PC[13:2])
  );
  reg_file cache(
    .rs1(inst[19:15]),
    .rs2(inst[24:20]),
    .rd(inst[11:7]),
    .wen(reg_write),
    .wdata(data),
    .clk(clk),
    .rst(reset),
    .rdata1(a1),
    .rdata2(b1)
  );
  Immediate Imm_gen(
    .inst(inst[31:7]),
    .PC(PC),
    .I(I_type),
    .S(S_type),
    .Sb(Sb_type),
    .Uj(Uj_type),
    .U(U_type)
  );
  ALU alu(
    .A(A),
    .B(B),
    .Data_sel(ALU_C),
    .res(Result)
  );
  Branch branch(
    .A(a1),
    .B(b1),
    .fun3(inst[14:12]),
    .en(branch_en),
    .res(br)
  );
  control_unit CU(
    .opcode(inst[6:0]),
    .fun3(inst[14:12]),
    .func7(inst[30]),
    .ALU_C(ALU_C),
    .N_PC(PC_sel),
    .IMM_sel(imm_sel),
    .OP_A(A_sel),
    .OP_B(B_sel),
    .Mem2Reg(mem2reg),
    .store(str),
    .branch(branch_en),
    .reg_write(reg_write)
  );
// -----------------------datapath-------------------------------
    // fetch___________________________________________________
    
  always @(posedge clk ) begin
    if (reset==0) begin
      PC <= (PC_sel == 2'b00) ? PC+4 :
          ((PC_sel == 2'b01) ? Uj_type :
          ((PC_sel == 2'b10) ? branch_PC :
          ((PC_sel == 2'b11) ? JALR : PC+4)));
    end
  end
// decode__________________________________________________
  assign b2 = (imm_sel==2'b00) ? I_type:
              (imm_sel==2'b01) ? S_type:
              (imm_sel==2'b10) ? U_type:I_type;
  assign B = (B_sel==1'b0) ? b1 : b2;
  assign A = (A_sel==2'b00)? a1 :
             (A_sel==2'b01)? PC :
             (A_sel==2'b10)? PC+4 : 32'b0;
    // execute________________________________________________
// JALR 
  assign JALR=a1+I_type;
  assign branch_PC = (br==1'b0)?PC+4:Sb_type;
    // write back_______________________________________________
  assign data = (mem2reg==1'b0)?data_out:Result; 

endmodule