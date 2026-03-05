module sum_project(
    input wire [9:0] A,
    input wire [9:0] B,
    output wire [10:0] C
);

assign C = A + B;

endmodule