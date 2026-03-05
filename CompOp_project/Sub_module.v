module Sub_module(

    input wire [9:0] Sub_in_0, Sub_in_1,
    output wire [10:0] Sub_out

    );

assign Sub_out = Sub_in_0 - Sub_in_1;

endmodule