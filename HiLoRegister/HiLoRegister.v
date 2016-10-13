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
module HiLoRegister(WriteEnable , WriteData, ReadData, Clk, Reset);
    input [63:0] WriteData;
    output [63:0] ReadData;
    
    input Reset, Clk, WriteEnable;
    
    reg [63:0] HiLo; 

    initial begin
        HiLo <= 64'd0;
    end
    
    always @(posedge Reset) begin
        HiLo <= 64'd0;
    end
    
    always @(negedge Clk) begin
        if(WriteEnable) begin
            HiLo <= WriteData;
        end
    end
    
    assign ReadData = HiLo;
endmodule
