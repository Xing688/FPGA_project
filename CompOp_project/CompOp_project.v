module CompOp_project(
    input wire [9:0]A,
    input wire [9:0]B,
    input wire [9:0]C,
    input wire [9:0]D,
    output wire [21:0]P
);

wire [10:0] medum_0;
wire [10:0] medum_1;

Sum_module Sum_module_inst(
    .Sum_in_0(A),
    .Sum_in_1(B),
    .Sum_out(medum_0)
);

Sub_module Sub_module_inst(
    .Sub_in_0(C),
    .Sub_in_1(D),
    .Sub_out(medum_1)
);

Mul_module Mul_module_inst(
    .Mul_in_0(medum_0),
    .Mul_in_1(medum_1),
    .Mul_out(P)
);

endmodule