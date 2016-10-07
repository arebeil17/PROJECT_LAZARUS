`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   	| 'ALUControl' value
// ==========================
// ADD  	| 00000
// ADDU 	| 00001
// SUB  	| 00010
// MULT 	| 00011
// MULTU	| 00100
// AND  	| 00101
// OR   	| 00110
// NOR  	| 00111
// XOR  	| 01000
// SLL  	| 01001
// SRL  	| 01010
// SLLV 	| 01011
// SLT  	| 01100
// MOVN 	| 01101
// MOVZ 	| 01110
// ROTRV	| 01111
// ROTR 	| 10000  *SAME AS SRL
// SRA  	| 10001
// SRAV 	| 10010
// SLTU 	| 10011
// MUL  	| 10100
// MADD 	| 10101
// MSUB 	| 10110
// SEH_SEB  | 10111
// 
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0

    always @(A, B, ALUControl) begin
        if(ALUControl == 4'b0010)           //ADD
            ALUResult =  A + B;
        else if(ALUControl == 4'b0110)      //SUB
            ALUResult =  A - B;
        else if(ALUControl == 4'b0000)      //AND
            ALUResult =  A & B;
        else if(ALUControl == 4'b0001)      //OR
            ALUResult =  A | B;
        else if(ALUControl == 4'b0111)      //SLT
            ALUResult =  (A < B) ? (1):(0);
    end
    
    assign Zero = (ALUResult == 0) ? (1):(0);

endmodule

