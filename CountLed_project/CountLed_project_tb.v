`timescale 1ns / 1ps

module CountLed_project_tb ();

  reg Clk;
  reg Rst_n;
  wire [3:0] Out_sig;

  CountLed_project #(
      .Count_Max(28'd25000000) // 计数器最大值，时钟频率为50MHz，要实现0.5秒的周期，计数器需要计数25000000个时钟周期
  ) CountLed_project_inst (
      .Clk(Clk),
      .Rst_n(Rst_n),
      .Out_sig(Out_sig)
  );

  initial begin
    // 初始化信号
    Clk   = 0;
    Rst_n = 0;  // 初始状态为复位

    // 释放复位信号
    #15 Rst_n = 1;  // 15ns后释放复位

    // 运行仿真一段时间以观察输出
    #1000000100;  // 1s+100ns的仿真时间
    $stop;  // 停止仿真
  end

  // 生成时钟信号，周期为20ns（50MHz）
  always #10 Clk = ~Clk;  // 每10ns翻转一次时钟信号

endmodule
