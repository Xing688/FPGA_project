//仿真文件testbench    tb
//作用 模拟产生输入变量

//tb文件不被实际综合，仿真时使用，综合时会被忽略
//每个测试文件前需要先声明时间单位和时间精度
`timescale 1ns/1ps//时间单位为1ns，时间精度为1ps
module new_project_tb();

//输入用reg类型，输出用wire类型   
reg A,B;//输入变量
wire C;//输出变量

//给变量A和B赋初始值
initial begin
  A=0;
  B=0;
end

//模拟输入变量值，让A和B变量等于0或1的随机值
always #30 A={$random}%2;//每隔30ns，A变量随机变为0或1
always #20 B={$random}%2;//每隔20ns，B变量随机变为0或1

/*调用被测试模块，调用格式：
被测试模块模块名 实例化名*/
new_project new_project_inst(

//.输入变量（端口变量）
  .A(A),//输入变量A连接到被测试模块的输入端口A
  .B(B),//输入变量B连接到被测试模块的输入端口B
  .C(C) //输出变量C连接到被测试模块的输出端口C

);

endmodule