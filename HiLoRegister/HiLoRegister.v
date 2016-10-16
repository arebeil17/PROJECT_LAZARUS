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
module HiLoRegister(WriteEnable , WriteData, HiLoReg, Clk, Reset);
    input [63:0] WriteData;
    //output [63:0] ReadData;
    
    input Reset, Clk, WriteEnable;
    
    output reg [63:0] HiLoReg = 0; 

//    initial begin
//        HiLo <= 64'd0;
//    end
    
//    always @(posedge Reset) begin
//        HiLo <= 64'd0;
//    end
    
    always @(negedge Clk) begin
        if(WriteEnable) begin
            HiLoReg <= WriteData;
        end
        else if(Reset) begin
            HiLoReg <= 0;
        end
    end
    
    //assign ReadData = HiLo;
endmodule
