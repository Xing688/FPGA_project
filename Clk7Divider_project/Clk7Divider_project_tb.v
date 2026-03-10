`timescale 1ns / 1ps
module Clk7Divider_project_tb();

  reg Clk;  // 时钟信号
  reg Rst_n;  // 复位信号，低有效
  wire Clk_out;  // 分频后的时钟输出

  // 实例化被测试的模块
  Clk7Divider_project Clk7Divider_project_inst (
    .Clk(Clk),
    .Rst_n(Rst_n),
    .Clk_out(Clk_out)
  );

  // 时钟生成
  initial begin
    Clk = 0; // 初始时钟信号为0
  end

  always #10 Clk = ~Clk; // 每10ns翻转一次时钟信号，产生50MHz的时钟频率

  // 测试序列
  initial begin
    // 初始化信号
    Rst_n = 0; // 初始状态为复位
    #15; // 等待15ns

    Rst_n = 1; // 解除复位，开始测试
    #200; // 等待200ns，观察输出

    Rst_n = 0; // 再次复位，测试复位功能
    #15; // 等待15ns

    Rst_n = 1; // 再次解除复位，继续观察输出
    #200; // 等待200ns

    $stop; // 停止仿真
  end
endmodule