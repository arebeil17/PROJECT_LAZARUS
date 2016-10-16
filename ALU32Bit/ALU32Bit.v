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
// ALL PHASE 1 OPERATIONS ARE LISTED BELOW
// Op   	| 'ALUControl value
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
// SRA  	| 10000
// SRAV 	| 10001
// SLTU 	| 10010
// MUL  	| 10011
// MADD 	| 10100
// MSUB 	| 10101
// SEH_SEB  | 10110
// MFHI     | 10111
// MFLO     | 11000
// MTHI     | 11001
// MTLO     | 11010
// 
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, Shamt, ALUResult, Zero, HiLoEn, HiLoWrite, HiLoRead, RegWrite);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input [4:0] Shamt;       //21bit from instruction used for selecting ROTR or SRL
    input [63:0] HiLoRead;
    
    output reg HiLoEn = 0;
    output reg [63:0] HiLoWrite = 0;
    output reg RegWrite;
	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
       
    localparam [4:0] ADD        = 'b00000,
                     ADDU       = 'b00001,
                     SUB        = 'b00010,
                     MULT       = 'b00011,
                     MULTU      = 'b00100,
                     AND        = 'b00101,
                     OR         = 'b00110,
                     NOR        = 'b00111,
                     XOR        = 'b01000,
                     SLL        = 'b01001,
                     SRL        = 'b01010,
                     SLLV       = 'b01011,
                     SLT        = 'b01100,
                     MOVN       = 'b01101,
                     MOVZ       = 'b01110,
                     SRLV       = 'b01111,
                     SRA        = 'b10000,
                     SRAV       = 'b10001,
                     SLTU       = 'b10010,
                     MUL        = 'b10011,
                     MADD       = 'b10100,
                     MSUB       = 'b10101,
                     SEH_SEB    = 'b10110,
                     MFHI       = 'b10111, // MFHI     | 10111
                     MFLO       = 'b11000, // MFLO     | 11000
                     MTHI       = 'b11001, // MTHI     | 11001
                     MTLO       = 'b11010; // MTLO     | 11010
    
    reg [4:0] Operation;
    reg [31:0] temp_1 = 0, temp_2 = 0;
    reg [63:0] temp64 = 0;
    
    always @(*) begin
        HiLoEn = 0;
        case(Operation)
            ADD: begin
                RegWrite <= 1; // Write Concur
                ALUResult = $signed(A) + $signed(B);
            end
            ADDU: begin
                RegWrite <= 1; // Write Concur
                ALUResult = A + B;
            end
            SUB: begin
            	RegWrite <= 1; // Write Concur
                ALUResult = $signed(A) - $signed(B);
            end
            MULT: begin
            	RegWrite <= 0; // Write NOT Concur
            	HiLoEn = 1;
                temp64 = $signed(A) * $signed(B);
                HiLoWrite <= temp64;
                ALUResult = 0; //No ALU Result defaults to zero;
            end
            MULTU: begin
                RegWrite <= 0; // Write NOT Concur
                HiLoEn = 1;
                temp64 = A * B;
                HiLoWrite <= temp64;
                ALUResult <= 0; //No ALU Result defaults to zero;
            end
            AND: begin
            	RegWrite <= 1; // Write Concur
                ALUResult <= A & B;
            end
            OR: begin
            	RegWrite <= 1; // Write Concur
                ALUResult <= A | B;
            end
            NOR: begin
            	RegWrite <= 1; // Write Concur
                ALUResult <= ~(A | B);
            end
            XOR: begin
            	RegWrite <= 1; // Write Concur
                ALUResult <= A ^ B;
            end
            SLL: begin
            	RegWrite <= 1; // Write Concur
                ALUResult <= B << Shamt;
            end
            SLLV: begin
                RegWrite <= 1; // Write Concur
                ALUResult <= B << A;
            end
            SRL: begin
            	RegWrite <= 1; // Write Concur
                if(A == 0) begin
                    ALUResult <= B >> Shamt;
                end else begin
                    temp_1 = B >> Shamt;
                    if(Shamt > 0) begin
                        temp_2 = B << (32 - Shamt);
                        temp_1 = temp_1 | temp_2;
                    end
                    ALUResult <= temp_1;
                end
            end
            SRLV: begin
                RegWrite <= 1; // Write Concur
                if(Shamt == 0) begin
                    ALUResult = B >> A;
                end else begin
                    temp_1 = B >> A;
                    if(B > 0) begin
                        temp_2 = B << (32 - A);
                        temp_1 = temp_1 | temp_2;
                    end
                ALUResult <= temp_1;
                end
            end
            SLT: begin
            	RegWrite <= 1; // Write Concur
                ALUResult = ($signed(A) < $signed(B)) ? (1):(0); 
            end
            SLTU: begin
                RegWrite <= 1; // Write Concur
                ALUResult = (A < B) ? (1):(0);
            end
            MOVN: begin
                if(B != 0) begin
                    RegWrite <= 1; // Write Concur
                    ALUResult = A;
                end else begin
                	RegWrite <= 0; // Write NOT Concur
            	end
            end
            MOVZ: begin
                if(B == 0) begin
                    RegWrite <= 1; // Write Concur
                    ALUResult <= A;
                end else begin
                    RegWrite <= 0; // Write NOT Concur
                end
            end
/*            ROTRV: begin
                
            end*/
            SRA: begin //Shift right arithmetic
                RegWrite <= 1; // Write Concur
                ALUResult = (B[30:0] >> Shamt) | (B[31] << 31);
            end
            SRAV: begin
            	RegWrite <= 1; // Write Concur
                ALUResult = (B[30:0] >> A) | (B[31] << 31);
            end
            MUL: begin
            	RegWrite <= 1; // Write Concur
                ALUResult <= ($signed(A) * $signed(B));
            end
            MADD: begin
            	RegWrite <= 0; // Write NOT Concur
            	HiLoEn = 1;
                temp64 = $signed(A) * $signed(B);
                HiLoWrite <= temp64 + HiLoRead;
                ALUResult <= 0; //No ALU Result defaults to zero;
            end
            MSUB: begin
            	RegWrite <= 0; // Write NOT Concur
            	HiLoEn = 1;
                temp64 = $signed(A) * $signed(B);
                HiLoWrite <=  HiLoRead - temp64;
                ALUResult <= 0; //No ALU Result defaults to zero;
            end
            SEH_SEB: begin
            	RegWrite <= 1; // Write Concur
                if(Shamt == 'b11000) begin
                    ALUResult = {{16{B[15]}},B[15:0]};
                end else if(Shamt == 'b10000) begin
                    ALUResult = {{24{B[7]}},B[7:0]};
                end
            end
            MFHI: begin  
                ALUResult <= HiLoRead[63:32];
            end
            MFLO: begin  
                ALUResult <= HiLoRead[31:0];
            end
            MTHI: begin  
               HiLoEn = 1;
               HiLoWrite[63:32] <= A;
               //HiLoWrite[31:0] = HiLoRead[31:0];
               ALUResult <= 0;
            end
            MTLO: begin
                HiLoEn = 1;
               // HiLoWrite[63:32] = HiLoRead[63:32];
                HiLoWrite[31:0] <= A; 
                ALUResult <= 0;
            end 
            default: begin
            	RegWrite <= 0; // Write NOT Concur
                ALUResult <= 0;
                HiLoEn <= 0;
            end
        endcase
    end
    
    assign Zero = (ALUResult == 0) ? (1):(0);
    
    always @(ALUControl, A, B, Shamt)begin
        Operation <= ALUControl;
    end
endmodule

