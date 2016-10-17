`timescale 1ns / 1ps

module DatapathController(OpCode, RegDst, RegWrite, AluSrc, AluOp, MemWrite, MemRead, Branch, MemToReg, SignExt);
    input[5:0] OpCode;
    
    output reg RegDst, RegWrite, AluSrc, MemWrite, MemRead, Branch, MemToReg, SignExt;
    output reg [3:0] AluOp;
    
    localparam [5:0] INITIAL = 'b111111,    // INITIAL
                     OP_000000 = 'b000000,  // Most R-type Instructions
                     OP_011100 = 'b011100,  // multiplies
                     OP_011111 = 'b011111,  // seh & seb
                     OP_001001 = 'b001001,  // addiu
                     OP_001000 = 'b001000,  // addi
                     OP_001100 = 'b001100,  // andi
                     OP_001101 = 'b001101,  // ori
                     OP_001110 = 'b001110,  // xori
                     OP_001010 = 'b001010,  // slti
                     OP_001011 = 'b001011,  // sltui
                     OP_101011 = 'b101011,  // SW
                     OP_100011 = 'b100011,	// LW
                     // NOT IMPLEMENTED YET...
                     OP_101001 = 'b101001,	// SH
                     OP_101000 = 'b101000,	// SB
                     OP_100001 = 'b100001,	// LH
                     OP_100000 = 'b100000,  // LB
                     OP_000010 = 'b000010;  // J
     
    reg [5:0] State = INITIAL;
     
    //always @(change of any input)begin
    always @ (*) begin
        case(State)
            INITIAL: begin 
                RegDst <= 0; RegWrite <= 0; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 0; AluOp <= 'b0001;
            end
            OP_000000: begin // Most R-type Instructions
                RegDst <= 0; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b0000;
            end
            OP_000010: begin // J
            	RegDst <= 0; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b0000;
            end
            OP_011100: begin
                RegDst <= 0; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b1100;
            end
            OP_011111: begin // SEH & SEB
                RegDst <= 0; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 0; AluOp <= 'b1101;
            end
            OP_001001: begin // ADDIU
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 0; AluOp <= 'b0111;
            end
            OP_001000: begin // ADDI
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b0001;
            end
            OP_001100: begin // ANDI
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b0100;
            end
            OP_001101: begin // ORI
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b0011;
            end
            OP_001110: begin // XORI
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b0101;
            end
            /*OP_001110: begin // DUPLICATE
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b0101;
            end*/
            OP_001010: begin // SLTI
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b1010;
            end
            OP_001011: begin //SLTUI
                RegDst <= 1; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 0; SignExt <= 1; AluOp <= 'b1011;
            end
            OP_101011: begin // SW
            	RegDst <= 1; RegWrite <= 0; AluSrc <= 1;
            	MemWrite <= 1; MemRead <= 0; Branch <= 0;
            	MemToReg <= 1; SignExt <= 1; AluOp <= 'b0001; // Send ADDI to ALU Controller
            end
            OP_100011: begin // LW
            	RegDst <= 1; RegWrite <= 1; AluSrc <= 1;
            	MemWrite <= 0; MemRead <= 1; Branch <= 0;
            	MemToReg <= 1; SignExt <= 1; AluOp <= 'b0001; // Send ADDI to ALU Controller
            end
            // NEED TO FIND SOLUTION TO BE MEMORY READ/WRITE SAFE
            OP_101001: begin // SH
            	RegDst <= 1; RegWrite <= 0; AluSrc <= 1;
            	MemWrite <= 1; MemRead <= 0; Branch <= 0;
            	MemToReg <= 1; SignExt <= 1; AluOp <= 'b0001; // Send ADDI to ALU Controller
            end
        	OP_101000: begin // SB
        		RegDst <= 1; RegWrite <= 0; AluSrc <= 1;
            	MemWrite <= 1; MemRead <= 0; Branch <= 0;
            	MemToReg <= 1; SignExt <= 1; AluOp <= 'b0001; // Send ADDI to ALU Controller
        	end
            OP_100001: begin // LH
            	RegDst <= 1; RegWrite <= 1; AluSrc <= 1;
            	MemWrite <= 0; MemRead <= 1; Branch <= 0;
            	MemToReg <= 1; SignExt <= 1; AluOp <= 'b0001; // Send ADDI to ALU Controller
            end
            OP_100000: begin // LB
            	RegDst <= 1; RegWrite <= 1; AluSrc <= 1;
            	MemWrite <= 0; MemRead <= 1; Branch <= 0;
            	MemToReg <= 1; SignExt <= 1; AluOp <= 'b0001; // Send ADDI to ALU Controller
            end
            //default: begin
            //    RegDst <= 0; RegWrite <= 0; AluSrc <= 0; 
            //    MemWrite <= 0; MemRead <= 0; Branch <= 0; 
            //    MemToReg <= 0; SignExt <= 0; AluOp <= 'b0001;
            //end
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
