`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 08:22:35 PM
// Design Name: 
// Module Name: DatapathController_TB
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
module DatapathController_TB();

    reg Clk, Rst;
    
    reg [5:0] OpCode;
    
    wire RegDist, RegWrite, AluSrc, MemWrite, MemRead, Branch, MemToReg, SignExt;
    
    wire [3:0] AluOp;
    
    DatapathController DP_TEST(Clk, Rst, OpCode, RegDist, RegWrite, AluSrc, AluOp, MemWrite, MemRead, Branch, MemToReg, SignExt);
    
    always begin
        Clk <= 0; #10;
        Clk <= 1; #10;
    end
    
    initial begin
        Rst <= 0; #10;
        Rst <= 1; #10;
        Rst <= 0; #10;
        OpCode <= 'b000000; //Don't care/ Non-immediate instruction
        #100;
        OpCode <= 'b011100;  //multiplies
        #100;
        OpCode <= 'b011111;  //seh & seb
        #100;
        OpCode <= 'b001001;  //addiu
        #100;
        OpCode <= 'b001000;  //addi
        #100;
        OpCode <= 'b001100;  //andi
        #100;
        OpCode <= 'b001101;  //ori
        #100;
        OpCode <= 'b001110;  //xori
        #100;
        OpCode <= 'b001010;  //slti
        #100;
        OpCode <= 'b001011;  //sltui
        #100;
        Rst <= 1; #10;
        Rst <= 0; #10;
    end


endmodule
