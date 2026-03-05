`timescale 1ns / 1ps
module DFF_project_tb ();

  reg  CLK;  //时钟输入信号
  reg  RST_N;  //复位输入信号
  reg  DATA_IN;  //数据输入信号
  wire DATA_OUT_0;  //数据输出0
  wire DATA_OUT_1;  //数据输出1

  //实例化DFF_project模块
  DFF_project DFF_project_inst (
      .CLK(CLK),
      .RST_N(RST_N),
      .DATA_IN(DATA_IN),
      .DATA_OUT_0(DATA_OUT_0),
      .DATA_OUT_1(DATA_OUT_1)
  );

  //时钟信号生成，每10ns一个周期
  initial begin
    CLK = 1'b0;
    //初始化输入信号
    RST_N = 1'b0;  //复位信号置低，触发复位
    DATA_IN = 1'b0;  //数据输入置低
    #25;  //等待25ns，确保复位完成
    RST_N = 1'b1;  //复位信号置高，结束复位
  end

  initial begin
    forever #10 CLK = ~CLK;  //每10ns翻转一次，形成20ns周期的时钟信号
  end

  always #({$random} % 50 + 1) DATA_IN = ~DATA_IN;//随机改变数据输入信号，周期在1ns到50ns之间

endmodule
