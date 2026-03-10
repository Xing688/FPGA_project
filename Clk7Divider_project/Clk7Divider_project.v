module Clk7Divider_project#(
    parameter CountMax=3'd7 // 计数器最大值，范围0-7
)(
    input wire Clk,  // 输入时钟信号
    input wire Rst_n, // 复位信号，低有效
    output wire Clk_out // 输出分频后的时钟信号
);

reg [2:0] Count;
reg MidClk_1; // 中间时钟信号1
reg MidClk_2; // 中间时钟信号2

always @(posedge Clk or negedge Rst_n) begin
    if(!Rst_n) begin
        Count <= 0;
    end
    else if(Count == CountMax-1) begin
        Count <= 0; // 当计数器达到最大值时，重置为0
    end
    else begin
        Count <= Count + 1; // 每个时钟周期计数器加1
    end
end

always @(posedge Clk or negedge Rst_n) begin
    if(!Rst_n) begin
        MidClk_1 <= 0;
    end
    else if(Count < CountMax/2) begin
        MidClk_1 <= 1; // 当计数器达到一半时，翻转中间时钟信号1
    end
    else begin
        MidClk_1 <= 0;
    end
end

always @(negedge Clk or negedge Rst_n) begin
    if(!Rst_n) begin
        MidClk_2 <= 0;
    end
    else begin
    MidClk_2 <= MidClk_1;
    end
end

assign Clk_out = MidClk_1 || MidClk_2; // 输出时钟信号为两个中间时钟信号取或

endmodule