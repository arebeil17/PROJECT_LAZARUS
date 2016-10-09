`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2016 12:11:58 PM
// Design Name: 
// Module Name: ALU_Controller_And_ALU32bit_TOP
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


module ALU_Controller_And_ALU32bit_TOP(Rst, AluOp, Funct, A, B, SRL_Select, ALUResult, Zero);
    
    input Rst, SRL_Select;
    input [3:0] AluOp;
    input [5:0] Funct;
    
    input [31:0] A, B;
    
    output [31:0] ALUResult;
    output Zero;
    
    wire [4:0] ALUControl;
    
    ALU_Controller  ALU_Control(Rst, AluOp, Funct, ALUControl);
    
    ALU32Bit    ALU(ALUControl, A, B, SRL_Select, ALUResult, Zero);

endmodule
