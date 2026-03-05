`timescale 1ns/1ps

module CompOp_project_tb();

reg [9:0] A;
reg [9:0] B;
reg [9:0] C;
reg [9:0] D;
wire [21:0] P;

CompOp_project CompOp_project_inst(
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .P(P)
);

initial begin
    A=10'd0;
    B=10'd0;
    C=10'd0;
    D=10'd0;
end

always #30 A=$random % 1000;
always #30 B=$random % 1000;
always #30 C=$random % 1000;
always #30 D=$random % 1000;

endmodule