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
    
    wire [6:0] out7;
    wire [7:0] en_out;
    wire ClkOut;

    top CPU_test(Clk, Rst, out7, en_out, ClkOut);
    
    always begin
        Clk <= 0;
        #5; 
        Clk <= 1;
        #5;
    end
    
    initial begin
        //Rst <= 1;
        #20 Rst <= 1;
        #20 Rst <= 0;
    end
    
endmodule
