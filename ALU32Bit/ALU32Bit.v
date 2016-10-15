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
// SRA  	| 10000
// SRAV 	| 10001
// SLTU 	| 10010
// MUL  	| 10011
// MADD 	| 10100
// MSUB 	| 10101
// SEH_SEB  | 10110
// 
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, Shamt, ALUResult, Zero, HiLoEn, HiLoWrite, HiLoRead);//, Move);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input[4:0] Shamt;       //21bit from instruction used for selecting ROTR or SRL
    
    input [63:0] HiLoRead;
    output reg HiLoEn = 0;
    output reg [63:0] HiLoWrite;
    
    //reg [31:0] Hi = 0, Lo = 0;
      
	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
    // output Move;		// Move = 1 For All Commands EXCEPT MOV*, MOV* Commands may be 0 or 1 (1 To Write Concur, 0 to Not Write)
       
    localparam [4:0] ADD  =  'b00000,
                     ADDU  = 'b00001,
                     SUB   = 'b00010,
                     MULT  = 'b00011,
                     MULTU = 'b00100,
                     AND   = 'b00101,
                     OR    = 'b00110,
                     NOR   = 'b00111,
                     XOR   = 'b01000,
                     SLL   = 'b01001,
                     SRL   = 'b01010,
                     SLLV  = 'b01011,
                     SLT   = 'b01100,
                     MOVN  = 'b01101,
                     MOVZ  = 'b01110,
                     ROTRV = 'b01111,
                     SRA   = 'b10000,
                     SRAV  = 'b10001,
                     SLTU  = 'b10010,
                     MUL   = 'b10011,
                     MADD  = 'b10100,
                     MSUB  = 'b10101,
                     SEH_SEB = 'b10110;
    
    reg [4:0] Operation;
    reg [31:0] temp_1 = 0, temp_2 = 0;
    reg [63:0] temp64 = 0;
    
    always @(A, B, ALUControl, Operation) begin
        HiLoEn = 0;
        case(Operation)
            ADD: begin
                //Move <= 1; // Write Concur
                ALUResult = $signed(A) + $signed(B);
            end
            ADDU: begin
                //Move <= 1; // Write Concur
                ALUResult = A + B;
            end
            SUB: begin
            	//Move <= 1; // Write Concur
                ALUResult = $signed(A) - $signed(B);
            end
            MULT: begin
            	//Move <= 1; // Write Concur
            	HiLoEn = 1;
                temp64 = $signed(A) * $signed(B);
                HiLoWrite <= temp64;
                ALUResult = 0; //No ALU Result defaults to zero;
            end
            MULTU: begin
                //Move <= 1; // Write Concur
                HiLoEn = 1;
                temp64 = A * B;
                HiLoWrite <= temp64;
                ALUResult <= 0; //No ALU Result defaults to zero;
            end
            AND: begin
            	//Move <= 1; // Write Concur
                ALUResult <= A & B;
            end
            OR: begin
            	//Move <= 1; // Write Concur
                ALUResult <= A | B;
            end
            NOR: begin
            	//Move <= 1; // Write Concur
                ALUResult <= ~(A | B);
            end
            XOR: begin
            	//Move <= 1; // Write Concur
                ALUResult <= A ^ B;
            end
            SLL: begin
            	//Move <= 1; // Write Concur
                ALUResult <= A << B;
            end
            SRL: begin
            	//Move <= 1; // Write Concur
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
            SLLV: begin
            	//Move <= 1; // Write Concur
                ALUResult <= A << B;
            end
            SLT: begin
            	//Move <= 1; // Write Concur
                ALUResult = ($signed(A) < $signed(B)) ? (1):(0); 
            end
            MOVN: begin
                if(B != 0) begin
                    //Move = 1; // Write Concur
                    ALUResult = A;
                //end else begin
                	//Move <= 0; // Write NOT Concur
            	end
            end
            MOVZ: begin
                if(B == 0) begin
                    //Move = 1; // Write Concur
                    ALUResult <= A;
                //end else begin
                	//Move <= 0; // Write NOT Concur
                end
            end
            ROTRV: begin
                //Move <= 1; // Write Concur
                temp_1 = A >> B;
                if(B > 0) begin
                    temp_2 = A << (32 - B);
                    temp_1 = temp_1 | temp_2;
                end
                ALUResult <= temp_1;
            end
            SRA: begin //Shift right arithmetic
                //Move <= 1; // Write Concur
                ALUResult = $signed(A) >>> B;
            end
            SRAV: begin
            	//Move <= 1; // Write Concur
                ALUResult = $signed(A) >>> B;
            end
            SLTU: begin
                //Move <= 1; // Write Concur
                ALUResult = (A < B) ? (1):(0);
            end
            MUL: begin
            	//Move <= 1; // Write Concur
                ALUResult <= ($signed(A) * $signed(B));
            end
            MADD: begin
            	//Move <= 1; // Write Concur
            	HiLoEn = 1;
                temp64 = $signed(A) * $signed(B);
                HiLoWrite <= temp64 + HiLoRead;
                ALUResult <= 0; //No ALU Result defaults to zero;
                //HiLoEn = 0;
            end
            MSUB: begin
            	//Move <= 1; // Write Concur
            	HiLoEn = 1;
                temp64 = $signed(A) * $signed(B);
                HiLoWrite <=  HiLoRead - temp64;
                ALUResult <= 0; //No ALU Result defaults to zero;
                //HiLoEn = 0;
            end
            SEH_SEB: begin
            	//Move <= 1; // Write Concur
                if(B[15] == 1)     //First check half word sign extend required
                    ALUResult = (B | 'hffff0000);
                else if(B[7] == 1) //Else check if byte sign extend required
                    ALUResult = (B | 'hffffff00);
                else               //Else no sign extend required
                    ALUResult <= B;
            end
            default:
            	//Move <= 0; // Write NOT Concur
                ALUResult <= 0;
        endcase
    end
    
    assign Zero = (ALUResult == 0) ? (1):(0);
    
    always @(ALUControl, A, B, Shamt)begin
        Operation <= ALUControl;
    end
endmodule

