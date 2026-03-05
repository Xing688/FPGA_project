module Sum_module(

    input wire [9:0] Sum_in_0, Sum_in_1,
    output wire [10:0] Sum_out

    );

assign Sum_out = Sum_in_0 + Sum_in_1;

endmodule