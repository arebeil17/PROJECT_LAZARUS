`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 09:55:03 PM
// Design Name: 
// Module Name: Mux5bit_2to1
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


module Mux5bit_2to1(In0, In1, sel, Out);
    
    input sel;
    input [4:0] In0, In1;
    
    output [4:0] Out;
    
    assign Out = (sel) ? (In1):(In0);
    
endmodule
