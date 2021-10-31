//Branch unit
module Branch(
  input logic [31:0]A, 
  input logic [31:0]B,
  input logic [2:0]fun3,
  input logic en,
  output logic res
);
  
	always_comb begin
    if (en) begin
      case (fun3)
  	    3'b000: begin//beq
  	      if(A==B)
            assign res=1;
  	    end
  	    3'b001: begin//bne
          if (A!=B)
            assign res=1;
  	    end
  	    3'b100:begin//blt
          if (A<B)
            assign res=1;
  	    end
  	    3'b101: begin//bge
          if (A>=B)
            assign res=1;
  	    end
  	    3'b110: begin//bltu
          if (($unsigned (A)) < ($unsigned (B)))
            assign res=1;
  	    end
  	    3'b111: begin //bgeu
          if (($unsigned (A)) >= ($unsigned (B)))
            assign res=1;
  	    end
  	    default: res=0;
  	  endcase
  	end
  end
endmodule  
