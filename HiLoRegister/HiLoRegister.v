`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 12:17:44 PM
// Design Name: 
// Module Name: HiLORegisters
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

module HiLoRegisters(HiWriteEnable, LoWriteEnable, 
    HiWriteData, LoWriteData, HiReadData, LoReadData, Clk, Reset);
    input [31:0] HiWriteData, LoWriteData;
    output [31:0] HiReadData, LoReadData;
    
    input Reset, Clk, HiWriteEnable, LoWriteEnable;
    
    reg [31:0] Hi, Lo;

    initial begin
        Hi <= 32'd0;
        Lo <= 32'd0;
    end
    
    always @(Reset) begin
        Hi <= 32'd0;
        Lo <= 32'd0;
    end
    
    always @(negedge Clk) begin
        if(HiWriteEnable) begin
            Hi <= HiWriteData;
        end
        if(LoWriteEnable) begin
            Lo <= LoWriteData;
        end
    end
    
    assign HiReadData = Hi;
    assign LoReadData = Lo;
endmodule
