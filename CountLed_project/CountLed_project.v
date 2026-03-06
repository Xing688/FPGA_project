//模块名：CountLed_project
//功能：使用计数器控制Led灯的状态，实现亮0.5秒，灭0.5秒的效果
//说明：在计数器达到最大值时，输出信号为高电平，点亮LED灯；在其他时间为低电平，熄灭LED灯

module CountLed_project #(
    parameter Count_Max = 28'd25000000 // 计数器最大值，时钟频率为50MHz，要实现0.5秒的周期，计数器需要计数25000000个时钟周期
) (
    input wire Clk,
    input wire Rst_n,
    output reg [3:0] Out_sig
);

  reg [27:0] Count;

  //计数器复位与自增逻辑
  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      Count <= 28'd0;  // 复位时计数器清零
    end else if (Count == Count_Max) begin
      Count <= 28'd0;  // 计数器达到最大值时清零
    end else begin
      Count <= Count + 28'd1;  // 时钟上升沿计数器加1
    end
  end

  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      Out_sig <= 4'b0000;  // 复位时输出信号为低电平，LED灯点亮
    end else if (Count == Count_Max) begin
      Out_sig <= ~Out_sig;  // 计数器达到最大值时，翻转输出信号，点亮或熄灭LED灯
    end else begin
      Out_sig <= Out_sig;  // 其他时间保持当前状态
    end
  end

endmodule