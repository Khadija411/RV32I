 module inst_mem( 
     input logic [11:0]address,
     output logic [31:0]inst
 );
    logic [31:0]mem[0:4095];

    always_latch begin
    $readmemh("/home/khadija/Documents/RV32I/assembly/shift.mem",mem);
    end
    assign inst=mem[address];
endmodule
