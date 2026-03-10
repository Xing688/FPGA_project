`timescale 1ns/1ps

module Clk8Divider_project_tb;

    reg Clk;  // 时钟信号
    reg Rst_n;  // 复位信号，低有效
    wire Clk_out;  // 分频后的时钟输出

    // 实例化被测试模块
    Clk8Divider_project Clk8Divider_project_inst (
        .Clk(Clk),
        .Rst_n(Rst_n),
        .Clk_out(Clk_out)
    );

    // 时钟生成
    initial begin
        Clk = 0;
    end

    always #10 Clk = ~Clk;  // 每10ns翻转一次，产生50MHz的时钟信号

    // 测试序列
    initial begin
        // 初始化信号
        Rst_n = 0;  // 复位
        #15;  // 等待15ns
        
        Rst_n = 1;  // 解除复位
        #200;  // 等待200ns观察输出
        
        $stop;  // 停止仿真
    end
endmodule