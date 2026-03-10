module Clk8Divider_project(
    input wire Clk,  // 时钟信号
    input wire Rst_n,  // 复位信号，低有效
    output wire Clk_out  // 分频后的时钟输出
);

wire conect_1; 
wire conect_2;

Clk2Divider_project Clk2Divider_project_inst (
    .Clk(Clk),
    .Rst_n(Rst_n),
    .Clk_out(conect_1)
);

Clk2Divider_project Clk2Divider_project_inst2 (
    .Clk(conect_1),
    .Rst_n(Rst_n),
    .Clk_out(conect_2)
);

Clk2Divider_project Clk2Divider_project_inst3 (
    .Clk(conect_2),
    .Rst_n(Rst_n),
    .Clk_out(Clk_out)
);

endmodule