module LightLed_project (
    output wire [3:0] led_out
);
//从左到右依次为LED0、LED1、LED2、LED3
assign led_out = 4'b0000; //四路均输出低电平，LED灯全亮
endmodule