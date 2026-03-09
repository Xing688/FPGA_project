//模块名：BreathLed_project
//功能：实现呼吸灯效果
//说明：该模块通过控制LED的亮度来实现呼吸灯效果，使用PWM信号来调节LED的占空比，从而实现亮度的变化，

module BreathLed_project #(
    parameter [6:0] CountMax_20ns = 7'd99,    // 20ns计数器的最大值
    parameter [9:0] CountMax_2us  = 10'd999,  // 2us计数器的最大值
    parameter [9:0] CountMax_2ms  = 10'd999   // 2ms计数器的最大值
) (
    input wire Clk,  // 时钟信号
    input wire Rst_n,  // 复位信号，低有效
    output wire [3:0] Led  // 4位LED输出
);

  reg [6:0] Count_20ns;  // 20ns计数器
  reg [9:0] Count_2us;  // 2us计数器
  reg [9:0] Count_2ms;  // 2ms计数器
  reg [3:0] Led_reg;  // LED寄存器

  always @(posedge Clk or negedge Rst_n) begin
    if (!Rst_n) begin
      //异步复位
      Count_20ns <= 0;
      Count_2us <= 0;
      Count_2ms <= 0;
      Led_reg <= 4'b0000;
    end
    else begin
      if (Count_20ns == CountMax_20ns) begin
        Count_20ns <= 0;
        //嵌套if语句实现多级计数器
        if (Count_2us == CountMax_2us) begin
          Count_2us <= 0;
          //嵌套第二层
          if (Count_2ms == CountMax_2ms) begin
            Count_2ms <= 0;
            Led_reg   <= ~Led_reg;//当Led灯达到最亮，寄存器取反
          end 
          else begin
            Count_2ms <= Count_2ms + 1;
          end
        end 
        else begin
          Count_2us <= Count_2us + 1;
        end
      end
      else begin
        Count_20ns <= Count_20ns + 1;
      end
    end
  end

  assign Led = (Count_2us < Count_2ms) ? Led_reg : ~Led_reg;

endmodule