//模块名：Counter_project
//功能：使用计数器控制输出
//说明：在计数器1、3、5时，输出信号为高电平，在其他时间为低电平
module Counter_project (
    input  wire Clk,
    input  wire Rst_n,
    output reg  Out_sig
);
  reg [2:0] Counter;  // 3位计数器，范围0-7

  // 计数器复位与自增逻辑
  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      Counter <= 3'b000;  // 复位时计数器清零
    end else begin
      Counter <= Counter + 3'b001;  // 时钟上升沿计数器加1
    end
  end

  always @(*) begin
    // 根据计数器的值控制输出信号
    case (Counter)
      3'b001, 3'b011, 3'b101: Out_sig = 1;  // 当计数器为1、3、5时，输出高电平
      default: Out_sig = 0;  // 其他时间输出低电平
    endcase
  end

endmodule