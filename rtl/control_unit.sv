// CU
module control_unit (
  input logic [6:0]opcode,
  input logic [2:0]fun3,
  input logic func7,
  output logic [3:0]ALU_C,
  output logic [1:0]N_PC,
  output logic [1:0]IMM_sel,
  output logic [1:0]OP_A,
  output logic OP_B,
  output logic Mem2Reg,
  output logic store,
  output logic branch,
  output logic reg_write
); 
  always_comb begin
  	case (opcode)
    7'b0110011: begin
//       R-Type
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b00;
      assign OP_B=1'b0;
      assign IMM_sel=2'b11;
      assign N_PC=2'b00;
      case (fun3) 
        3'b000:begin 
          if (!func7)
            assign ALU_C=4'b0000;
          else 
            assign ALU_C=4'b0001;
        end
        3'b001: begin
          if (!func7)
            assign ALU_C=4'b0101;
          else 
            assign ALU_C=4'b1110;
        end
        3'b010:begin 
          if (!func7)
            assign ALU_C=4'b0111;
          else 
            assign ALU_C=4'b0111;
        end
        3'b011: begin
          if (!func7)
            assign ALU_C=4'b1000;
          else 
            assign ALU_C=4'b1000;
        end
        3'b100:begin 
          if (!func7)
            assign ALU_C=4'b0100;
          else 
            assign ALU_C=4'b1110;
        end
        3'b101: begin
          if (!func7)
            assign ALU_C=4'b0110;
          else 
            assign ALU_C=4'b1001;
        end
        3'b110:begin 
          if (!func7)
            assign ALU_C=4'b0011;
          else 
            assign ALU_C=4'b1110;
        end
        3'b111: begin
          if (!func7)
            assign ALU_C=4'b0010;
          else 
            assign ALU_C=4'b1110;
        end
      endcase
    end
    7'b1100111: begin
//       JALR
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b10;
      assign OP_B=1'b1;
      assign IMM_sel=2'b00;
      assign N_PC=2'b11;
      assign  ALU_C=4'b1111;
    end
    7'b0010011: begin
//       I-type
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b00;
      assign OP_B=1'b1;
      assign IMM_sel=2'b00;
      assign N_PC=2'b00;
      case (fun3) 
        3'b000: if (!func7) assign ALU_C=4'b0000;
        3'b001: assign ALU_C=4'b0101;
        3'b010: assign ALU_C=4'b0111;
        3'b011: assign ALU_C=4'b1000;
        3'b100: assign ALU_C=4'b0100;
        3'b101:  begin
          if (!func7)
            assign ALU_C=4'b0110;
          else 
            assign ALU_C=4'b1001;
        end
        3'b110: assign ALU_C=4'b0011;
        3'b111: assign ALU_C=4'b0010;
      endcase
    end
    7'b0000011: begin
//       load
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b0;
      assign OP_A=2'b00;
      assign OP_B=1'b1;
      assign IMM_sel=2'b00;
      assign N_PC=2'b00;
      assign  ALU_C=4'b0000;
    end
    7'b0100011: begin
//       S-type
      assign reg_write=1'b0;
      assign branch=1'b0;
      assign store=1'b1;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b00;
      assign OP_B=1'b1;
      assign IMM_sel=2'b01;
      assign N_PC=2'b00;
      assign  ALU_C=4'b0000;
    end
    7'b1100011: begin
//       Sb-type
      assign reg_write=1'b0;
      assign branch=1'b1;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b00;
      assign OP_B=1'b0;
      assign IMM_sel=2'b11;
      assign N_PC=2'b10;
    end
    7'b0110111: begin
//       LUI
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b00;
      assign OP_B=1'b1;
      assign IMM_sel=2'b10;
      assign N_PC=2'b00;
    end
    7'b0010111: begin 
//       AUIPC
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b01;
      assign OP_B=1'b1;
      assign IMM_sel=2'b10;
      assign N_PC=2'b00;
    end
    
    7'b1101111: begin
//       Uj-type
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b10;
      assign OP_B=1'b0;
      assign IMM_sel=2'b11;
      assign N_PC=2'b01;
      assign ALU_C=4'b1111;
    end
    default: begin
      assign reg_write=1'b1;
      assign branch=1'b0;
      assign store=1'b0;
      assign Mem2Reg=1'b1;
      assign OP_A=2'b00;
      assign OP_B=1'b0;
      assign IMM_sel=2'b11;
      assign N_PC=2'b00;
      assign ALU_C=4'b0000;
    end
    endcase
  end
endmodule

