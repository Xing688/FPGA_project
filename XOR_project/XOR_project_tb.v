`timescale 1ns/1ps
module XOR_project_tb();

reg A;
reg B;
wire C;

initial begin
A = 0;
B = 0;
end

always #30 A={$random}%2;
always #50 B={$random}%2;

XOR_project XOR_project_inst(
.A(A),
.B(B),
.C(C)
);

endmodule