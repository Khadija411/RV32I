// ALU

module ALU(
  input logic [31:0]A, 
  input logic [31:0]B,
  input logic [3:0]Data_sel,
  output logic [31:0]res
);
  always_comb begin
    case (Data_sel)
      4'b0000: assign res=A+B;//add
      4'b0001: assign res=A-B;//sub
      4'b0010: assign res=A&B;//and
      4'b0011: assign res=A|B;//or
      4'b0100: assign res=A^B;//xor
      4'b0101: assign res=A<<B;//sll
      4'b0110: assign res=A>>B;//srl
      4'b0111: assign res=(A<B)?1:0;//slt
      4'b1000: assign res=$unsigned(A<B)?1:0;//sltu
      4'b1001: assign res=(B<=11111)?A>>B:0;//sra
      4'b1111: assign res=A;//JAL/JALR
      default: assign res=A+B;
    endcase
  end
endmodule
