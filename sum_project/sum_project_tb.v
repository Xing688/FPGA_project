`timescale 1ns/1ps
module sum_project_tb;
    reg [9:0] A;
    reg [9:0] B;
    wire [10:0] C;
    
    sum_project sum_project_inst(
        .A(A),
        .B(B),
        .C(C)
    );
    
    initial begin
        A=10'd0;
        B=10'd0;
    end
    always #30 A=$random % 1000;
    always #10 B=$random % 1000;

endmodule