//时序逻辑验证D触发器
//输入：CLK（时钟信号），RST_N（复位信号），DATA_IN（数据输入）
//输出：DATA_OUT_0（数据输出0），DATA_OUT_1（数据输出1）

//定义模块以及声明输入输出端口
module DFF_project (
    input wire CLK,  //时钟输入信号 50MHz                                                                      
    input wire RST_N,  //复位输入信号 低电平有效
    input wire DATA_IN,  //数据输入信号
    output reg DATA_OUT_0,  //数据输出0 =DATA_IN
    output reg DATA_OUT_1  //数据输出1 ~DATA_IN
);

/*
   等号的用法
   ==用来表示判断左右变量是否相等
   =用来在组合逻辑下给变量赋值
   <=用来在时序逻辑下给变量赋值
*/

  //用always在时序逻辑下给输出赋值
  always @(posedge CLK or negedge RST_N) begin//posedge CLK：在时钟上升沿触发；negedge RST_N：在复位信号下降沿触发
    if (!RST_N) begin  //复位信号为低电平时执行
      DATA_OUT_0 <= 1'b0;  //数据输出0置为0
      DATA_OUT_1 <= 1'b0;  //数据输出1置为0
    end else begin  //复位信号为高电平时执行
      DATA_OUT_0 <= DATA_IN;  //数据输出0赋值为数据输入
      DATA_OUT_1 <= ~DATA_IN;  //数据输出1赋值为数据输入的反码
    end
  end

endmodule
