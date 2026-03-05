//每个代码（模块）以module开头以endmodule结尾
//每个模块由两部分组成：端口列表+逻辑功能
module new_project(
    input wire A,//输入变量A
    input wire B,//输入变量B
    output wire C//输出变量C C=A||B
);
//时序逻辑变量赋值，变量类型reg寄存器类型，使用always赋值
//组合逻辑赋值用assign
assign C = A || B;//或运算

endmodule