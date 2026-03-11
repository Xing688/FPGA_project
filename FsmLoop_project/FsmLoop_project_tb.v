`timescale 1ns / 1ps

module FsmLoop_project_tb ();

  reg  Clk;
  reg  Rst_n;
  reg  Din;
  wire Outsign;

  always #10 Clk = ~Clk;

  initial begin
    Clk   = 1'b0;
    Rst_n = 1'b0;
    Din   = 0;
    #15;
    Rst_n = ~Rst_n;
  end

  initial begin
    #10 Din = 0;
    #20 Din = 1;
    #20 Din = 0;
    #20 Din = 0;
    #20 Din = 1;
    #20 Din = 0;
    #100 $stop;
  end

  FsmLoop_project FsmLoop_project_inst (
      .Clk(Clk),
      .Din(Din),
      .Outsign(Outsign),
      .Rst_n(Rst_n)
  );

endmodule
