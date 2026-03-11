//模块名：FsmLoop_project
//功能：FSM(状态机)循环项目顶层模块
//说明：对FSM循环项目的简单实现，持续检测10010输入，并在检测到后输出高电平
module FsmLoop_project (
    input  wire Clk,     // 时钟信号
    input  wire Rst_n,   // 复位信号，低有效
    input  wire Din,     // 输入信号
    output reg  Outsign  // 输出信号
);

  reg [5:0] state;  // 定义状态寄存器

  //状态编码（独热码）
  parameter IDLE = 6'b000001;  //初始状态
  parameter S0 = 6'b000010;  //检测到第一位：1
  parameter S1 = 6'b000100;  //检测到第二位：0
  parameter S2 = 6'b001000;  //检测到第三位：0
  parameter S3 = 6'b010000;  //检测到第四位：1
  parameter S4 = 6'b100000;  //检测到第五位：0

  //状态转移逻辑
  always @(posedge Clk or negedge Rst_n) begin
    if (~Rst_n) begin
      state   <= IDLE;  // 复位时回到初始状态
      Outsign <= 0;  // 复位时输出低电平
    end else begin
      case (state)
        IDLE: begin
          Outsign <= 0;  // 初始状态输出低电平
          if (Din == 1) state <= S0;  // 检测到第一位：1
        end
        S0: begin
          Outsign <= 0;
          if (Din == 0) state <= S1;  // 检测到第二位：0
          else state <= S0;  // 检测到第一位：1，继续保持在S0状态
        end
        S1: begin
          Outsign <= 0;
          if (Din == 0) state <= S2;  // 检测到第三位：0
          else
            state <= S0;  // 检测到第一位：1，回到S0状态继续检测下一轮10010序列
        end
        S2: begin
          Outsign <= 0;
          if (Din == 1) state <= S3;  // 检测到第四位：1
          else state <= IDLE;  // 输入不匹配，回到初始状态
        end
        S3: begin
          Outsign <= 0;
          if (Din == 0) state <= S4;  // 检测到第五位：0
          else
            state <= S0;  // 检测到第一位：1，回到S0状态继续检测下一轮10010序列
        end
        S4: begin
          Outsign <= 1;  // 检测到完整的10010序列，输出高电平
          if (Din == 1) state <= S0;  // 可以继续检测下一轮10010序列
          else
            state <= IDLE; // 检测到输入不匹配，回到初始状态继续检测下一轮10010序列
        end
        default: begin
          state   <= IDLE;
          Outsign <= 0;  // 默认状态回到初始状态
        end
      endcase
    end
  end

endmodule
