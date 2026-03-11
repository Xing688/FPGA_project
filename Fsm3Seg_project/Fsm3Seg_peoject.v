//模块名：Fsm3Seg_project
//功能：三段式不循环检测状态机
//说明：三段式代码，不循环检测机制，检测到10010输出高电平

module Fsm3Seg_project (
    input wire Clk,  //时钟输入
    input wire Rst_n,  //复位信号，低电平有效
    input wire Din,  //输入信号
    output reg Outsign  //输出信号
);

  //状态寄存器
  reg [5:0] State_Start;
  reg [5:0] State_Next;

  //状态编码（独热码）
  parameter IDLE = 6'b000001;  //初始状态
  parameter S0 = 6'b000010;  //检测到第一位，S0状态：1
  parameter S1 = 6'b000100;  //检测到第二位，S1状态：10
  parameter S2 = 6'b001000;  //检测到第三位，S2状态：100
  parameter S3 = 6'b010000;  //检测到第四位，S3状态：1001
  parameter S4 = 6'b100000;  //检测到第五位，S4状态：10010

  //当前状态触发器
  always @(posedge Clk or negedge Rst_n) begin
    if (~Rst_n) begin
      State_Start <= IDLE;
    end else begin
      State_Start <= State_Next;
    end
  end

  //下一状态触发器
  always @(*) begin
    State_Next <= IDLE;
    if (~Rst_n) begin
      State_Next <= IDLE;
    end else begin
      case (State_Start)
        IDLE: begin
          State_Next <= (Din == 1) ? S0 : IDLE;//检测到1输入，进入S0状态，否则回归初始化
        end
        S0: begin
          State_Next <= (Din == 0) ? S1 : IDLE;//检测到0输入，进入S1状态，否则回归初始化
        end
        S1: begin
          State_Next <= (Din == 0) ? S2 : IDLE;//检测到0输入，进入S2状态，否则回归初始化
        end
        S2: begin
          State_Next <= (Din == 1) ? S3 : IDLE;//检测到1输入，进入S3状态，否则回归初始化
        end
        S3: begin
          State_Next <= (Din == 0) ? S4 : IDLE;//检测到0输入，进入S4状态，否则回归初始化
        end
        S4: begin
          State_Next <= (Din == 1) ? S0 : IDLE;//检测到1输入，进入S0状态，开始新序列，否则回归初始化
        end
        default: begin
          State_Next <= IDLE;  //默认初始化
        end
      endcase
    end
  end

  //输出触发器
  always @(posedge Clk or negedge Rst_n) begin
    if (~Rst_n) begin
      Outsign <= 1'b0;
    end else begin
      if (State_Start == S4) begin
        Outsign <= 1'b1;
      end else begin
        Outsign <= 1'b0;
      end
    end
  end

endmodule
