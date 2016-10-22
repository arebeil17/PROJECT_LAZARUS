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
// EQ       | 11011 ***USED FOR BNE 
// BLTZ_BGEZ| 11100
// BGTZ     | 11101
// BLEZ     | 11110
// 
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, Shamt, ALUResult, Zero, HiLoEn, HiLoWrite, HiLoRead, RegWrite);

	input [5:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input [4:0] Shamt;       //21bit from instruction used for selecting ROTR or SRL
    input [63:0] HiLoRead;
    
    output reg HiLoEn = 0;
    output reg [63:0] HiLoWrite = 0;
    output reg RegWrite;
	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
       
    localparam [5:0] ADD        = 'b000000,
                     ADDU       = 'b000001,
                     SUB        = 'b000010,
                     MULT       = 'b000011,
                     MULTU      = 'b000100,
                     AND        = 'b000101,
                     OR         = 'b000110,
                     NOR        = 'b000111,
                     XOR        = 'b001000,
                     SLL        = 'b001001,
                     SRL        = 'b001010,
                     SLLV       = 'b001011,
                     SLT        = 'b001100,
                     MOVN       = 'b001101,
                     MOVZ       = 'b001110,
                     SRLV       = 'b001111,
                     SRA        = 'b010000,
                     SRAV       = 'b010001,       
                     SLTU       = 'b010010,
                     MUL        = 'b010011,
                     MADD       = 'b010100,
                     MSUB       = 'b010101,
                     SEH_SEB    = 'b010110,
                     MFHI       = 'b010111, // MFHI     | 10111
                     MFLO       = 'b011000, // MFLO     | 11000
                     MTHI       = 'b011001, // MTHI     | 11001
                     MTLO       = 'b011010, // MTLO     | 11010
                     EQ         = 'b011011, // BNE      | 11011
                     BLTZ_BGEZ  = 'b011100, // BGEZ     | 11100
                     BGTZ       = 'b011101, // BGTZ     | 11101
                     BLEZ       = 'b011110; // BLEZ     | 11110
    
    reg [5:0] Operation;
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
                ALUResult = ($unsigned(A) < $unsigned(B)) ? (1):(0);
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
                RegWrite <= 1; // Write Concur
                ALUResult = HiLoRead[63:32];
            end
            MFLO: begin
                RegWrite <= 1; // Write Concur
                ALUResult = HiLoRead[31:0];
            end
            MTHI: begin
                RegWrite <= 0; // Write NOT Concur
                HiLoEn = 1;
                HiLoWrite = {A,HiLoRead[31:0]};
                ALUResult = 0;
            end
            MTLO: begin
                RegWrite <= 0; // Write NOT Concur
                HiLoWrite = {HiLoRead[63:32],A};
                HiLoEn = 1;
            end
            MFHI: begin  
                ALUResult <= HiLoRead[63:32];
            end
            MFLO: begin  
                ALUResult <= HiLoRead[31:0];
            end
            MTHI: begin  
               HiLoEn = 1;
               HiLoWrite = {HiLoRead[63:32],A};
               ALUResult <= 0;
            end
            MTLO: begin
                HiLoEn = 1;
                HiLoWrite[31:0] = {HiLoRead[63:32],A}; 
                ALUResult <= 0;
            end 
            EQ: begin //Checks if A and B are equal
                RegWrite <= 0;
                if(A != B)
                    ALUResult <= 0;
                else
                    ALUResult <= 1;
            end
            BLTZ_BGEZ: begin
                if(B == 0) begin //Perform BLTZ if rt = 0
                    if( A < 0)
                        ALUResult <= 0;  //Branch triggered by Zero output
                    else
                        ALUResult <= 1;
                end
                else begin //else perform BGEZ if rt = 1
                      if( A >= 0)
                          ALUResult <= 0; //Branch triggered by Zero output
                      else
                          ALUResult <= 1;
                end
            end
            BGTZ: begin
                if( A > 0) //If rs is greater than zero branch
                    ALUResult <= 0;  //Branch triggered by Zero output
                else
                    ALUResult <= 1;  //Branch triggered by Zero output
            end
            BLEZ: begin
                if( A < 0) //If rs is less than zero branch
                    ALUResult <= 0;  //Branch triggered by Zero output
                else
                    ALUResult <= 1;  //Branch triggered by Zero output
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

