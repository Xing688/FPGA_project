//模块名：WaterLed_project
//功能：使用两个计数器控制Led灯的状态，实现流水灯效果
//说明：计数器1用来计时，当计数器1达到最大值时，计数器2自增，控制LED灯的状态切换；当计数器2达到最大值时，复位为初始状态

module WaterLed_project #(
    parameter CountTime_Max = 28'd24999999, // 计数器最大值，时钟频率为50MHz，要实现0.5秒的周期，计数器需要计数24999999个时钟周期
    parameter CountLed_Max = 4'd7  // LED状态切换的最大计数值
) (
    input wire Clk,  // 时钟信号
    input wire Rst_n,  // 复位信号，低电平有效
    output reg [3:0] Led_output  // LED输出信号，4位控制4个LED灯的状态
    //重置后1111 1110 1100 1000 0000 0001 0011 0111 0000循环
    //case实现
);

  reg [27:0] Count_1;  //计数器1,用来计时
  reg [ 3:0] Count_2;  //计数器2,用来控制led_output的状态

  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      Count_1 <= 28'd0;  // 计数器1复位
      Count_2 <= 4'd0;  // 计数器2复位
    end else if (Count_1 == CountTime_Max) begin
      Count_1 <= 28'd0;  // 计数器1达到最大值时复位
      if (Count_2 >= CountLed_Max) begin
        Count_2 <= 4'd0;  // 计数器2达到最大值时复位
      end else begin
        Count_2 <= Count_2 + 4'd1;  // 计数器2自增
      end

    end else begin
      Count_1 <= Count_1 + 28'd1;  // 计数器1自增
    end
  end

  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      Led_output <= 4'b1111;  // 复位时LED输出初始状态
    end else begin
      case (Count_2)
        4'd0: Led_output <= 4'b1111;  // 1111   
        4'd1: Led_output <= 4'b1110;  // 1110
        4'd2: Led_output <= 4'b1100;  // 1100
        4'd3: Led_output <= 4'b1000;  // 1000
        4'd4: Led_output <= 4'b0000;  // 0000
        4'd5: Led_output <= 4'b0001;  // 0001
        4'd6: Led_output <= 4'b0011;  // 0011
        4'd7: Led_output <= 4'b0111;  // 0111
        default: Led_output <= 4'b1111;  // 默认状态，1111
      endcase
    end
  end

endmodule