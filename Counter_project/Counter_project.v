//模块名：Counter_project
//功能：使用计数器控制输出
//说明：在计数器2、4、6时，输出信号为高电平，在其他时间为低电平
module Counter_project #(
    //定义全局参数用prameter
    //用全局参数定义计数器最大值
    parameter MAX_COUNT = 3'b111  // 计数器最大值为7
) (
    input  wire Clk,
    input  wire Rst_n,
    output reg  Out_sig
);
  reg [2:0] Counter;  // 3位计数器，范围0-7

  // 计数器复位与自增逻辑
  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      Counter <= 3'b000;  // 复位时计数器清零
    end else if (Counter == 3'b111) begin
      Counter <= 3'b000;  // 计数器达到最大值时清零
    end else begin
      Counter <= Counter + 3'b001;  // 时钟上升沿计数器加1
    end
  end

  //使用组合逻辑输出控制信号
  //优点：输出信号随计数器值的变化立即更新，无需等待时钟边沿
  //缺点：可能会产生毛刺（glitch），因为输出信号直接依赖于计数器的值，计数器在某些时刻可能会出现短暂的过渡状态
  //如从3(011)到4(100)
  //011 -> 001 (中间态) -> 000 (中间态) -> 100 (最终态)
  //使用说明：当输出信号不直接接到芯片引脚作为输入时，可以使用组合逻辑，
  //即输出信号作为内部信号连接到寄存器，在时钟边沿更新寄存器的值，这样可以避免毛刺问题
  always @(*) begin
    // 根据计数器的值控制输出信号
    case (Counter)
      3'b010, 3'b100, 3'b110: Out_sig = 1;  // 当计数器为2、4、6时，输出高电平
      default: Out_sig = 0;  // 其他时间输出低电平
    endcase
  end

  //使用时序逻辑输出控制信号
  //优点：输出信号在时钟边沿更新，避免了毛刺
  //缺点：输出信号的更新需要等待时钟边沿，可能会有一定的延迟
  // always @(posedge Clk or negedge Rst_n) begin
  //   if (!Rst_n) begin
  //     Out_sig <= 0;  // 复位时输出信号为低电平
  //   end else begin
  //     case (Counter)
  //时序逻辑会延后一拍，所以要想在2、4、6时输出高电平，需要在计数器值为1、3、5时更新输出信号
  //       3'b001, 3'b011, 3'b101: Out_sig <= 1;  // 当计数器为2、4、6时，输出高电平
  //       default: Out_sig <= 0;  // 其他时间输出低电平
  //     endcase
  //   end
  // end

endmodule