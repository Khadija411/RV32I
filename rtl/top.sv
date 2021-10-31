`include "rtl/memory.sv"
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
  parameter depth=2**addwidth;
  parameter width=32;
  parameter addwidth=12;
  logic [width-1:0]mem[0:depth-1];
  logic [31:0]inst;
  logic [31:0]A;
  logic [31:0]B;
  logic [31:0]Result;
  logic [31:0] PC;
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
  logic ld;
// ----------------------calling the modules-------------------- 
  memory data_mem(
    .address(Result[13:2]),
    .clk(clk),
    .data_in(b1),
    .str(str),
    .ld(ld),
    .data_out(data_out)
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
    .load(ld),
    .store(str),
    .branch(branch_en),
    .reg_write(reg_write)
  );
// -----------------------datapath-------------------------------
  always @(posedge clk ) begin
    // fetch___________________________________________________

    //   instruction memory
    $readmemh("/home/khadija/Documents/RV32I/inst.mem",mem);
    inst<=mem[PC[13:2]];
    
    case(PC_sel)
      2'b00: PC<=PC+4;
      2'b01: PC<=Uj_type;
      2'b10: PC<=branch_PC;
      2'b11: PC<=JALR;
      default: PC<=PC+4;
    endcase
    // decode__________________________________________________
    case (imm_sel)
      2'b00: b2<=I_type;
      2'b01: b2<=S_type;
      2'b10: b2<=U_type;
      default: b2<=I_type;
    endcase
    case (B_sel)
      1'b0: B<=b1;
      1'b1: B<=b2;
      default: B<=b1;
    endcase
    case (A_sel)
      2'b00: A<=a1;
      2'b01: A<=PC;
      2'b10: A<=PC+4;
      2'b11: A<=32'b0;
      default: A<=a1;
    endcase
    // execute________________________________________________
// JALR 

    JALR<=a1+I_type;
    case (br)
      1'b0: branch_PC<=PC+4;
      1'b1: branch_PC<=Sb_type;
      default: branch_PC<=PC+4;
    endcase

    // write back_______________________________________________
     case (mem2reg)
       1'b0: data<=data_out;
       1'b1: data<=Result;
       default: data<=data_out;
     endcase
  end
endmodule