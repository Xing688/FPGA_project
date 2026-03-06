`timescale 1ns / 1ps

module WaterLed_project_tb ();

  reg Clk;
  reg Rst_n;
  wire [3:0] Led_output;

  // 实例化被测试模块
  WaterLed_project #(
      .CountTime_Max(28'd24999999), // 计数器最大值，时钟频率为50MHz，要实现0.5秒的周期，计数器需要计数24999999个时钟周期
      .CountLed_Max(4'd8)  // LED状态切换的最大计数值
  ) WaterLed_project_inst (
      .Clk(Clk),
      .Rst_n(Rst_n),
      .Led_output(Led_output)
  );

  initial begin
    // 初始化信号
    Clk   = 0;
    Rst_n = 0;
    // 复位信号
    #15 Rst_n = 1;  // 15ns后释放复位
    #4000000040;  // 运行足够长的时间以观察LED状态变化
    $stop;  // 停止仿真
  end

  always #10 Clk = ~Clk;  // 生成时钟信号，周期为20ns

endmodule