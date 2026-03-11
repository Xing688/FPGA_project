`timescale 1ns / 1ps

module Fsm3Seg_project_tb ();

  reg  Clk;
  reg  Rst_n;
  reg  Din;
  wire Outsign;

  always #10 Clk = ~Clk;  //20ns周期时钟

  initial begin
    Clk   = 1'b0;
    Rst_n = 1'b0;
    Din   = 1'b0;
    #15 Rst_n = ~Rst_n;
  end

  initial begin
    #100
    forever begin
      #20.5 Din = {$random} % 2;
    end
  end

  Fsm3Seg_project Fsm3Seg_project_inst (
      .Clk(Clk),
      .Rst_n(Rst_n),
      .Din(Din),
      .Outsign(Outsign)
  );

endmodule
