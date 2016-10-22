`timescale 1ns / 1ps

module DatapathController(OpCode, RegDst, RegWrite, AluSrc, AluOp, MemWrite, MemRead, Branch, MemToReg, SignExt, Jump, JumpMux);
    input[5:0] OpCode;
    
    output reg RegWrite, AluSrc, MemWrite, MemRead, Branch, SignExt, Jump, JumpMux;
    output reg [1:0] RegDst, MemToReg;
    output reg [4:0] AluOp;
    
    localparam [5:0] INITIAL = 'b111111,    // INITIAL
                    OP_000000 = 'b000000,   // Most R-type Instructions, JR
                    OP_000001 = 'b000001,   // BGEZ, BLTZ
                    OP_000010 = 'b000010,   // J
                    OP_000011 = 'b000011,   // JAL - NOT IMPLEMENTED
                    OP_000100 = 'b000100,   // BEQ
                    OP_000101 = 'b000101,   // BNE
                    OP_000110 = 'b000110,   // BLEZ 
                    OP_000111 = 'b000111,   // BGTZ 
                    OP_001000 = 'b001000,   // ADDI
                    OP_001001 = 'b001001,   // ADDIU
                    OP_001010 = 'b001010,   // SLTI
                    OP_001011 = 'b001011,   // SLTUI
                    OP_001100 = 'b001100,   // ANDI
                    OP_001101 = 'b001101,   // ORI
                    OP_001110 = 'b001110,   // XORI
                    OP_001111 = 'b001111,   // LUI - NOT IMPLEMENTED
                    OP_011100 = 'b011100,   // multiplies
                    OP_011111 = 'b011111,   // SEB, SEH
                    OP_100000 = 'b100000,   // LB - NOT IMPLEMENTED
                    OP_100001 = 'b100001,	// LH - NOT IMPLEMENTED
                    OP_100011 = 'b100011,	// LW
                    OP_101000 = 'b101000,	// SB - NOT IMPLEMENTED
                    OP_101001 = 'b101001,	// SH - NOT IMPLEMENTED
                    OP_101011 = 'b101011;   // SW

    reg [5:0] State = INITIAL;
     
    //always @(change of any input)begin
    always @ (*) begin
        case(State)
            INITIAL: begin 
                RegDst <= 2'b00; RegWrite <= 0; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 0; AluOp <= 'b00001;
                Jump <= 0; JumpMux <= 0;
            end
            OP_000000: begin // Most R-type Instructions and JR
                // TODO: JR Implementation, Can't set Jump <= 1 As PC+4 Does Not Get Written for all other commands
                RegDst <= 2'b00; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b00000;
                Jump <= 0; JumpMux <= 1;
            end
            OP_000001: begin // BGEZ, BLTZ
                RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 0;
                MemWrite <= 0; MemRead <= 0; Branch <= 1;
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b10000;
                Jump <= 0; JumpMux <= 0;
            end
            OP_000010: begin // J
                RegDst <= 2'b00; RegWrite <= 0; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b00000;
                Jump <= 1; JumpMux <= 0;
            end
            OP_000011: begin // JAL - NOT IMPLEMENTED
                RegDst <= 2'b10; RegWrite <= 0; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b10; SignExt <= 1; AluOp <= 'b????;
                Jump <= 1; JumpMux <= 0;
            end
            OP_000100: begin // BEQ
                RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 0;
                MemWrite <= 0; MemRead <= 0; Branch <= 1;
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b01110;
                Jump <= 0; JumpMux <= 0;
            end
            OP_000101: begin // BNE
                RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 0;
                MemWrite <= 0; MemRead <= 0; Branch <= 1;
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b01111;
                Jump <= 0; JumpMux <= 0;
            end
            OP_000110: begin // BLEZ
               RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 0;
                MemWrite <= 0; MemRead <= 0; Branch <= 1;
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b10010;
                Jump <= 0; JumpMux <= 0;
            end
            OP_000111: begin // BGTZ
                RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 0;
                MemWrite <= 0; MemRead <= 0; Branch <= 1;
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b10001;
                Jump <= 0; JumpMux <= 0;
            end
            OP_000010: begin // J
            	RegDst <= 2'b00; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b00000;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001000: begin // ADDI
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b00001;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001001: begin // ADDIU
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 0; AluOp <= 'b00111;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001010: begin // SLTI
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b01010;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001011: begin //SLTUI
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b01011;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001100: begin // ANDI
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b00100;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001101: begin // ORI
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b00011;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001110: begin // XORI
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b00101;
                Jump <= 0; JumpMux <= 0;
            end
            OP_001111: begin // LUI - NOT IMPLEMENTED
            end
            OP_011100: begin
                RegDst <= 2'b00; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 1; AluOp <= 'b01100;
                Jump <= 0; JumpMux <= 0;
            end
            OP_011111: begin // SEH & SEB
                RegDst <= 2'b00; RegWrite <= 1; AluSrc <= 0; 
                MemWrite <= 0; MemRead <= 0; Branch <= 0; 
                MemToReg <= 2'b00; SignExt <= 0; AluOp <= 'b01101;
                Jump <= 0; JumpMux <= 0;
            end
            // TODO: NEED TO FIND SOLUTION TO BE MEMORY READ/WRITE SAFE
            OP_100000: begin // LB
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1;
                MemWrite <= 0; MemRead <= 1; Branch <= 0;
                MemToReg <= 2'b01; SignExt <= 1; AluOp <= 'b00001; // Send ADDI to ALU Controller
                Jump <= 0; JumpMux <= 0;
            end
            // TODO: NEED TO FIND SOLUTION TO BE MEMORY READ/WRITE SAFE
            OP_100001: begin // LH
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1;
                MemWrite <= 0; MemRead <= 1; Branch <= 0;
                MemToReg <= 2'b01; SignExt <= 1; AluOp <= 'b00001; // Send ADDI to ALU Controller
                Jump <= 0; JumpMux <= 0;
            end
            OP_100011: begin // LW
                RegDst <= 2'b01; RegWrite <= 1; AluSrc <= 1;
                MemWrite <= 0; MemRead <= 1; Branch <= 0;
                MemToReg <= 2'b01; SignExt <= 1; AluOp <= 'b00001; // Send ADDI to ALU Controller
                Jump <= 0; JumpMux <= 0;
            end
            // TODO: NEED TO FIND SOLUTION TO BE MEMORY READ/WRITE SAFE
            OP_101000: begin // SB
                RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 1;
                MemWrite <= 1; MemRead <= 0; Branch <= 0;
                MemToReg <= 2'b01; SignExt <= 1; AluOp <= 'b00001; // Send ADDI to ALU Controller
                Jump <= 0; JumpMux <= 0;
            end
            // TODO: NEED TO FIND SOLUTION TO BE MEMORY READ/WRITE SAFE
            OP_101001: begin // SH
                RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 1;
                MemWrite <= 1; MemRead <= 0; Branch <= 0;
                MemToReg <= 2'b01; SignExt <= 1; AluOp <= 'b00001; // Send ADDI to ALU Controller
                Jump <= 0; JumpMux <= 0;
            end
            OP_101011: begin // SW
            	RegDst <= 2'b01; RegWrite <= 0; AluSrc <= 1;
            	MemWrite <= 1; MemRead <= 0; Branch <= 0;
            	MemToReg <= 2'b01; SignExt <= 1; AluOp <= 'b00001; // Send ADDI to ALU Controller
            	Jump <= 0; JumpMux <= 0;
            end
        endcase
     end
     
      //State Register
     always @(OpCode) begin
            State <= OpCode;
     end 
endmodule
