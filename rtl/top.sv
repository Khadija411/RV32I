'timescale 1ns/1ps
// -----------------------Top Module---------------------------
module top(
  input logic clk,
  output logic [31:0]data
);
// -----------------parameters / local variables--------------
  parameter addwidth=12;
  parameter width=32;
  parameter depth=2**addwidth;
  logic [addwidth-1:0]inst_address;
  logic [31:0]inst;
  logic [31:0]A;
  logic [31:0]B;
  logic [31:0]Result;
  logic [31:0] PC;
  logic [width-1:0] memory [0:depth-1];
  logic [31:0]I_type;
  logic [31:0]S_type;
  logic [31:0]Sb_type;
  logic [31:0]U_type;
  logic [31:0]Uj_type;
  logic [31:0]JALR;
  logic br;
  logic mem2reg;
  logic ALU_C;
  logic branch_PC;
  logic reg_write;
  logic branch_en;
  logic [1:0]PC_sel;
  logic [1:0]imm_sel;
  logic [1:0]A_sel;
  logic [31:0]a1;
  logic B_sel;
  logic [31:0]b1;
  logic [31:0]b2;
  logic [3:0]byte_masking;
  logic [31:0]data_out;
  logic str;
  logic ld;
// ----------------------calling the modules-------------------- 
  memory inst_mem(
    .address_read(inst_address),
    .instruction(inst)
  );
  memory data_mem(
    .address(Result[13:2]),
    .clk(clk),
    .data_in(b1),
    .str(str),
    .ld(ld),
    .byte_masking(byte_masking),
    .data_out(data_out)
  );
  reg_file cache(
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .wen(reg_write),
    .wdata(data),
    .clk(clk),
    .rdata1(a1),
    .rdata2(b1)
  );
  Immediate Imm_gen(
    .inst(inst),
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
    .func3(inst[14:12]),
    .func7(inst[30]),
    .ALU_C(ALU_C),
    .N_PC(PC_sel),
    .IMM_sel(Imm_sel),
    .OP_A(A_sel),
    .OP_B(B_sel),
    .Mem2Reg(mem2reg),
    .load(ld),
    .store(str),
    .branch(branch_en),
    .reg_write(reg_write)
  );
// -----------------------datapath-------------------------------
  always @(posedge clk ) begin
    // fetch___________________________________________________
    inst_address<=PC[13:2];
    case(PC_sel)
      2'b00: PC=PC+4;
      2'b01: PC=Uj_type;
      2'b10: PC=branch_PC;
      2'b11: PC=JALR;
    endcase
    // decode__________________________________________________
    case (Imm_sel)
      2'b00: b2=I_type;
      2'b01: b2=S_type;
      2'b10: b2=U_type;   
    endcase
    case (B_sel)
      1'b0: B=b1;
      1'b1: B=b2;
    endcase
    case (A_sel)
      2'b00: A=a1;
      2'b01: A=PC;
      2'b10: A=PC+4;
      2'b11: A=32'b0;
    endcase
    // execute________________________________________________
// JALR 
    JALR=a1+I_type;
    case (br)
      1'b0: branch_PC=PC+4;
      1'b1: branch=Sb_type;
    endcase

    // write back_______________________________________________
     case (mem2reg)
       1'b0: data=data_out;
       1'b1: data=Result;
     endcase
  end
endmodule