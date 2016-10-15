`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 06:46:30 PM
// Design Name: 
// Module Name: DatapathController
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
module DatapathController(OpCode, RegDst, RegWrite, AluSrc, AluOp, MemWrite, MemRead, Branch, MemToReg, SignExt);
    
    //input Rst;
    
    input[5:0] OpCode;
    
    output reg RegDst, RegWrite, AluSrc, MemWrite, MemRead, Branch, MemToReg, SignExt;
    
    output reg [3:0] AluOp;
    
    localparam [5:0] INITIAL = 'b111111,    //INITIAL
                     OP_000000 = 'b000000,  //dont care/Non-immediate
                     OP_011100 = 'b011100,  //multiplies
                     OP_011111 = 'b011111,  //seh & seb
                     OP_001001 = 'b001001,  //addiu
                     OP_001000 = 'b001000,  //addi
                     OP_001100 = 'b001100,  //andi
                     OP_001101 = 'b001101,  //ori
                     OP_001110 = 'b001110,  //xori
                     OP_001010 = 'b001010,  //slti
                     OP_001011 = 'b001011;  //sltui
     
     reg [5:0] State = INITIAL;
     
     //always @(change of any input)begin
     always @ (*) begin
        case(State)
                 INITIAL: begin
                    RegDst <= 0; RegWrite <= 0; AluSrc <= 0; 
                    MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                    MemToReg <= 0; SignExt <= 0; AluOp <= 'b0001;
                 end
                 OP_000000: begin
                     RegDst <= 0; RegWrite <= 1; AluSrc <= 0; 
                     MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                     MemToReg <= 0; SignExt <= 1; AluOp <= 'b0000;
                 end
                 OP_011100: begin
                      RegDst <= 0; RegWrite <= 1; AluSrc <= 0; 
                      MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                      MemToReg <= 0; SignExt <= 1; AluOp <= 'b1100;
                 end
                 OP_011111: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 0; AluOp <= 'b0000;
                 end
                 OP_001001: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 0; AluOp <= 'b0111;
                end
                OP_001000: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 1; AluOp <= 'b0001;
                end
                OP_001100: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 1; AluOp <= 'b0100;
                end
                OP_001101: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 1; AluOp <= 'b0011;
                end
                OP_001110: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 1; AluOp <= 'b0101;
                end
                OP_001110: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 1; AluOp <= 'b0101;
                end
                OP_001010: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 0; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 1; AluOp <= 'b1010;
                end
                OP_001011: begin
                       RegDst <= 1; RegWrite <= 1; AluSrc <= 0; 
                       MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                       MemToReg <= 0; SignExt <= 1; AluOp <= 'b1011;
                end
                default: begin
                    State <= INITIAL;
                end
        endcase
     end
      //State Register
     always @(OpCode) begin
//        if(Rst == 1) begin
//            State <= INITIAL;
//        end    
//        else begin
            State <= OpCode;
//        end
     end
                 
endmodule
