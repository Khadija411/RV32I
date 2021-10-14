// CU Test
module test;
  logic [6:0]op;
  logic [2:0]fun3;
  logic func7;
  logic [3:0]ALU_C;
  logic [1:0]N_PC;
  logic [1:0]IMM_sel;
  logic [1:0]OP_A;
  logic OP_B;
  logic Mem2Reg;
  logic load;
  logic store;
  logic branch;
  logic reg_write;

  control_unit CU(
    .opcode(op),
    .fun3(fun3),
    .func7(func7),
    .ALU_C(ALU_C),
    .N_PC(N_PC),
    .IMM_sel(IMM_sel),
    .OP_A(OP_A),
    .OP_B(OP_B),
    .Mem2Reg(Mem2Reg),
    .load(load),
    .store(store),
    .branch(branch),
    .reg_write(reg_write)
  );
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    #2;
    op=7'b0110011;
    fun3=3'b000;
    func7=1'b1;
    #2;
    op=7'b1101111;
    #2;
    $finish();
  end
endmodule
