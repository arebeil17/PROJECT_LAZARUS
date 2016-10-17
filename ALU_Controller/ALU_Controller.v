`timescale 1ns / 1ps

module ALU_Controller(Rst, AluOp, Funct, ALUControl);

    input Rst;
    input [3:0] AluOp;           //4 bit AluOp code sent from controller 
    
    input [5:0] Funct;           //6 bit Instruction function field
    
    output reg [4:0] ALUControl; //4 bit output control signal sent to ALU
    
    //Controller AluOp 4 bit inputs (also are the state encodings)
    localparam [3:0] ALUOP_DC 		= 'b0000, // DONT CARE
                     ALUOP_ADDI 	= 'b0001, // ADD IMMEDIATE
                     ALUOP_SUBI 	= 'b0010, // SUB IMMEDIATE
                     ALUOP_ORI 		= 'b0011, // OR IMMEDIATE
                     ALUOP_ANDI 	= 'b0100, // AND IMMEDIATE (LW & SW TOO)
                     ALUOP_XORI 	= 'b0101, // XOR IMMEDIATE
                     ALUOP_NORI 	= 'b0110, // NOR IMMDEIATE
                     ALUOP_ADDUI 	= 'b0111, // ADDU IMMEDIATE
                     ALUOP_SUBUI 	= 'b1000, // SUBU IMMEDIATE
                     ALUOP_MULTUI 	= 'b1001, // MULTU IMMDEDIATE
                     ALUOP_SLTI 	= 'b1010, // SLT IMMEDIATE
                     ALUOP_SLTIU 	= 'b1011, // SLTU IMMEDIATE
                     ALUOP_MUL		= 'b1100, // ALL MULTIPLY OPERATIONS
                     ALUOP_SE 		= 'b1101; // SIGN EXTEND OPERATIONS
    				 
    //Instruction Function code 6 bit input definitions
    //---------------Dont Care FUNCTION FIELDS                
    localparam [5:0] FC_add  	=  'b100000,	// add
                     FC_addu 	=  'b100001,	// addu
                     FC_sub  	=  'b100010,	// sub
                     FC_mult 	=  'b011000,	// mult
                     FC_multu	=  'b011001,	// multu
                     FC_and  	=  'b100100,	// and
                     FC_or   	=  'b100101,	// or
                     FC_nor  	=  'b100111,	// nor
                     FC_xor  	=  'b100110,	// xor
                     FC_sll  	=  'b000000,	// sll
                     FC_srl  	=  'b000010,	// srl
                     FC_sllv 	=  'b000100,	// sllv
                     FC_slt  	=  'b101010,	// slt
                     FC_movn 	=  'b001011,  	// movn
                     FC_movz 	=  'b001010,  	// movz
                     FC_srlv 	=  'b000110,  	// rotrv
                     FC_sra  	=  'b000011,  	// sra
                     FC_srav 	=  'b000111,  	// srav
                     FC_sltu 	=  'b101011,  	// sltu
                     FC_mul  	=  'b000010,  	// mul
                     FC_madd 	=  'b000000,  	// madd
                     FC_msub 	=  'b000100,  	// msub
                     FC_mfhi 	= 	'b010000, 	// mfhi
                     FC_mflo 	= 	'b010010, 	// mflo
                     FC_mthi 	= 	'b010001, 	// mthi
                     FC_mtlo 	= 	'b010011; 	// mtlo                
     
     //ALU control 5 bit output definitions                
    localparam [4:0] ADD  = 'b00000, // ADD  	 | 00000
                     ADDU = 'b00001, // ADDU     | 00001
                     SUB  = 'b00010, // SUB      | 00010
                     MULT = 'b00011, // MULT     | 00011
                     MULTU= 'b00100, // MULTU    | 00100
                     AND  = 'b00101, // AND      | 00101
                     OR   = 'b00110, // OR       | 00110
                     NOR  = 'b00111, // NOR      | 00111
                     XOR  = 'b01000, // XOR      | 01000
                     SLL  = 'b01001, // SLL      | 01001
                     SRL  = 'b01010, // SRL      | 01010
                     SLLV = 'b01011, // SLLV     | 01011
                     SLT  = 'b01100, // SLT      | 01100
                     MOVN = 'b01101, // MOVN     | 01101
                     MOVZ = 'b01110, // MOVZ     | 01110
                     SRLV = 'b01111, // ROTRV    | 01111
                     SRA  = 'b10000, // SRA      | 10000
                     SRAV = 'b10001, // SRAV     | 10001
                     SLTU = 'b10010, // SLTU     | 10010
                     MUL  = 'b10011, // MUL      | 10011
                     MADD = 'b10100, // MADD     | 10100
                     MSUB = 'b10101, // MSUB     | 10101
                     SE = 'b10110,// SEH_SEB | 10110
                     MFHI = 'b10111, // MFHI     | 10111
                     MFLO = 'b11000, // MFLO     | 11000
                     MTHI = 'b11001, // MTHI     | 11001
                     MTLO = 'b11010; // MTLO     | 11010
                     
//    reg [3:0] State = DC;        //init dont care
//    reg [5:0] Function = FC_add; //init to add

    always @(*) begin
        if(AluOp == ALUOP_DC) begin //If its a dont care then function code is checked
            case(Funct)
                FC_add: begin  //add
                    ALUControl <= ADD;
                end
                FC_addu: begin  //addu
                    ALUControl <= ADDU;
                end
                FC_sub: begin  //sub
                    ALUControl <= SUB;
                end
                FC_mult: begin  //mult
                    ALUControl <= MULT;
                end
                FC_multu: begin  //multu
                    ALUControl <= MULTU;
                end
                FC_and: begin  //and
                    ALUControl <= AND;
                end
                FC_or: begin  //or
                    ALUControl <= OR;
                end
                FC_nor: begin  //nor
                    ALUControl <= NOR;
                end
                FC_xor: begin  //xor
                    ALUControl <= XOR;
                end
                FC_sll: begin  //sll
                    ALUControl <= SLL;
                end
                FC_srl: begin  //srl
                    ALUControl <= SRL;
                end
                FC_sllv: begin  //sllv
                    ALUControl <= SLLV;
                end
                FC_slt: begin  //slt
                    ALUControl <= SLT;
                end
                FC_movn: begin  //movn
                    ALUControl <= MOVN;
                end
                FC_movz: begin  //movz
                    ALUControl <= MOVZ;
                end
                FC_srlv: begin  //rotrv
                    ALUControl <= SRLV;
                end
                FC_sra: begin  //sra
                    ALUControl <= SRA;
                end
                FC_srav: begin  //srav
                    ALUControl <= SRAV;
                end
                FC_sltu: begin  //sltu
                    ALUControl <= SLTU;
                end
                FC_mfhi: begin  // mfhi
                    ALUControl <= MFHI;
                end
                FC_mflo: begin  // mflo
                    ALUControl <= MFLO;
                end
                FC_mthi: begin  // mthi
                    ALUControl <= MTHI;
                end
                FC_mtlo: begin  // mtlo
                    ALUControl <= MTLO;
                end 
                default: begin
                    ALUControl <= ADD;
                end
            endcase
        end else begin //All immediate and non-dc operations are below
            case(AluOp) //First Check AluOp Code
                ALUOP_ADDI: begin
                    ALUControl <= ADD;
                end
                ALUOP_SUBI: begin
                    ALUControl <= SUB;
                end
                ALUOP_ORI: begin
                    ALUControl <= OR;
                end
                ALUOP_ANDI: begin
                    ALUControl <= AND;
                end
                ALUOP_XORI: begin
                    ALUControl <= XOR;
                end
                ALUOP_NORI: begin
                    ALUControl <= NOR;
                end
                ALUOP_ADDUI: begin
                    ALUControl <= ADDU;
                end
                ALUOP_SUBUI: begin
                    ALUControl <= SUB;
                end
                ALUOP_MULTUI: begin
                    ALUControl <= MULT;
                end
                ALUOP_SLTI: begin
                    ALUControl <= SLT;
                end
                ALUOP_SLTIU: begin
                    ALUControl <= SLTU;
                end
                ALUOP_MUL: begin
                    if(Funct == FC_mul) begin
                    	ALUControl <= MUL;
                    end
                    else if(Funct == FC_madd) begin
                    	ALUControl <= MADD;
                    end
                    else if(Funct == FC_msub) begin
                        ALUControl <= MSUB;
                    end
                    else begin
                        ALUControl <= ADD;
                    end
                end
                ALUOP_SE: begin
                    ALUControl <= SE;
                end
                //default: begin
                //    ALUControl <= ADD;
                //end
            endcase
        end // End Else
    end
endmodule
