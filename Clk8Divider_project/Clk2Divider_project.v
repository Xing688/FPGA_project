module Clk2Divider_project (
    input wire Clk,  // 时钟信号
    input wire Rst_n,  // 复位信号，低有效
    output reg Clk_out  // 分频后的时钟输出
);

  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      //异步复位
      Clk_out <= 0;
    end
    else begin
      Clk_out <= ~Clk_out;
    end
  end

endmodule