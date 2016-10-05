`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 03:17:58 PM
// Design Name: 
// Module Name: ShiftLeft
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


module ShiftLeft(INPUT,OUTPUT,SHIFT);
    input [31:0] INPUT;
    input [4:0] SHIFT;
    output [31:0] OUTPUT;
    
    assign OUTPUT = INPUT << SHIFT;
endmodule
