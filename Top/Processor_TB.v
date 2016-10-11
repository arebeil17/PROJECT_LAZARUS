`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 03:17:57 PM
// Design Name: 
// Module Name: Processor_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Processor_TB();
    
    reg Clk, Rst = 0;
    
    top CPU_test(Clk, Rst);
    
    always begin
        Clk <= 0;
        #50; 
        Clk <= 1;
        #50;
    end
    
    initial begin
        Rst <= 1;
        #20 Rst <= 0;
    end
    
endmodule
