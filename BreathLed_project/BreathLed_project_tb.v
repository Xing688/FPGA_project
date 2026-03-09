`timescale 1ns/1ps

module BreathLed_project_tb;

  reg Clk;
  reg Rst_n;
  wire [3:0] Led;

  // 实例化被测试模块
  BreathLed_project#(
    .CountMax_20ns(7'd99),
    .CountMax_2us(10'd999),
    .CountMax_2ms(10'd999)
  ) BreathLed_project_inst(
    .Clk(Clk),
    .Rst_n(Rst_n),
    .Led(Led)
  );

  // 初始化
  initial begin
    //初始化信号
    Clk = 0;
    Rst_n = 0; // 初始复位状态
    #15; // 等待15ns

    Rst_n = 1; // 解除复位，开始测试
  end

always #10 Clk = ~Clk; // 20ns周期的时钟信号

endmodule