module Mul_module(

    input wire [10:0] Mul_in_0, Mul_in_1,
    output wire [21:0] Mul_out
    
    );

assign Mul_out = Mul_in_0 * Mul_in_1;

endmodule