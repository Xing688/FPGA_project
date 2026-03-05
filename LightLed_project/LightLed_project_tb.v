`timescale 1ns / 1ps
module LightLed_project_tb ();
  wire [3:0] led_out;
  LightLed_project LightLed_project_tb (.led_out(led_out));
  initial begin
    #100;  //等待100ns稳定输出
    $stop;  //停止仿真
  end
endmodule
