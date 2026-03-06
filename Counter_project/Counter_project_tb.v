`timescale 1ns / 1ps

module Counter_project_tb ();

  reg  Clk;
  reg  Rst_n;
  wire Out_sig;

  initial begin
    Clk = 0;
    Rst_n = 0;  // 初始复位
    #15 Rst_n = 1;  // 15ns后释放复位
  end

  always #10 Clk = ~Clk;  // 每10ns翻转一次时钟,周期为20ns
  Counter_project Counter_project_inst (
    .Clk(Clk),
    .Rst_n(Rst_n),
    .Out_sig(Out_sig)
  );

endmodule