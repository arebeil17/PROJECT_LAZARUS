`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [4:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs
	reg [4:0] Shamt;

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0
	//wire Move;
	
    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B),
        .Shamt(Shamt), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
        //.Move(Move)
    );
    
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

	initial begin
	   //Test ADD
	       ALUControl <= ADD; A <= 0; B <= 0; Shamt <= 0;
	   #50                    A <= 1; B <= 1;
	   #50                    A <= 2; B <= -2; 
	   #50                    A <= 10; B <= -15; 
	   #50                    A <= 64; B <= 64;
	   //Test ADDU
       #50 ALUControl <= ADDU; A <= 0; B <= 0;
       #50                     A <= 1; B <= 1;
       #50                     A <= 2; B <= -2; 
       #50                     A <= 10; B <= 'hfffffff0; 
       #50                     A <= 64; B <= 64; 
	   //Test SUB
	   #50 ALUControl <= SUB; A <= 0; B <= 4; 
       #50                    A <= 1; B <= 1; 
       #50                    A <= 2; B <= -2; 
       #50                    A <= 10; B <= -15; 
       #50                    A <= 10; B <= 11;
       //Test MULT
       #50 ALUControl <= MULT; A <= 0; B <= 4; 
       #50                     A <= 1; B <= 1;
       #50                     A <= 2; B <= -2;
       #50                     A <= 10; B <= -15; 
       #50                     A <= 10; B <= 11; 
       //Test MULTU
       #50 ALUControl <= MULTU; A <= 0; B <= 4;
       #50                      A <= 1; B <= 1; 
       #50                      A <= 2; B <= -2; 
       #50                      A <= 10; B <= -15; 
       #50                      A <= 10; B <= 11;
       //Test AND
       #50 ALUControl <= AND; A <= 0; B <= 0;
       #50                    A <= 1; B <= 1;
       #50                    A <= 0; B <= 6;
       #50                    A <= 14; B <= 6;
       #50                    A <= 2021; B <= 1;
       //Test OR
       #50 ALUControl <= OR; A <= 0; B <= 0;
       #50                    A <= 1; B <= 0;
       #50                    A <= 4; B <= 4; 
       #50                    A <= -4; B <= -4; 
       #50                    A <= 2021; B <= 0;
       //Test NOR
       #50 ALUControl <= NOR; A <= 0; B <= 0; 
       #50                    A <= 1; B <= 0; 
       #50                    A <= 4; B <= 4; 
       #50                    A <= 'hfffffff0; B <= 0; 
       #50                    A <= 2021; B <= 0; 
       //Test XOR
       #50 ALUControl <= XOR; A <= 0; B <= 0; 
       #50                    A <= 1; B <= 0; 
       #50                    A <= 0; B <= 4; 
       #50                    A <= 2; B <= 4; 
       #50                    A <= 2; B <= 2; 
       //Test SLL
       #50 ALUControl <= SLL; A <= 4; B <= 1; 
       #50                    A <= 4; B <= 2; 
       #50                    A <= 4; B <= 3; 
       #50                    A <= 8; B <= 31;
       #50                    A <= 1024; B <= 1;
       //Test SRL
       #50 ALUControl <= SRL; A <= 0; B <= 1; Shamt <= 0;
       #50                    A <= 0; B <= 2;
       #50                    A <= 0; B <= 3;
       #50                    A <= 0; B <= 1;
       #50                    A <= 0; B <= 10;
       //Test ROTR
       #50 ALUControl <= SRL; A <= 1; B <= 15; Shamt <= 2; 
       #50                    A <= 0; B <= 15; Shamt <= 2;
       #50                    A <= 1; B <= 7; Shamt <= 2;
       #50                    A <= 1; B <= 8; Shamt <= 2; 
       #50                    A <= 1; B <= 31; Shamt <= 2;
       //Test SLLV
       #50 ALUControl <= SLLV; A <= 4; B <= 1;
       #50                     A <= 4; B <= 2;
       #50                     A <= 4; B <= 3;
       #50                     A <= 8; B <= 31;
       #50                     A <= 1024; B <= 1;
       //Test SLT
       #50 ALUControl <= SLT;   A <= 1; B <= 1; Shamt <= 0;
       #50                      A <= -1; B <= 1; 
       #50                      A <= 64; B <= 4; 
       #50                      A <= -64; B <= 2;
       #50                      A <= 0; B <= -4;
       //Test MOVN
       #50 ALUControl <= MOVN; A <= 1; B <= 0; 
       #50                     A <= 15; B <= 0; 
       #50                     A <= 1; B <= 1;
       #50                     A <= 4; B <= 1; 
       #50                     A <= -16; B <= 1; 
       //Test MOVZ
       #50 ALUControl <= MOVZ; A <= 1; B <= 0; 
       #50                     A <= 15; B <= 0; 
       #50                     A <= 1; B <= 1; 
       #50                     A <= 4; B <= 1; 
       #50                     A <= -16; B <= 1; 
       //Test ROTRV
       #50 ALUControl <= ROTRV; A <= 1; B <= 1; 
       #50                      A <= 15; B <= 4; 
       #50                      A <= 1; B <= 32; 
       #50                      A <= 4; B <= 2;
       #50                      A <= 16; B <= 5;
       //Test SRA
       #50 ALUControl <= SRA;   A <= 1; B <= 1;
       #50                      A <= -1; B <= 1;
       #50                      A <= 64; B <= 4;
       #50                      A <= -64; B <= 2;
       #50                      A <= 'hf0000000; B <= 28;
       //Test SRAV
       #50 ALUControl <= SRAV;  A <= 1; B <= 1; 
       #50                      A <= -1; B <= 1; 
       #50                      A <= 64; B <= 4; 
       #50                      A <= -64; B <= 2; 
       #50                      A <= 'hf0000000; B <= 28;
       //Test SLTU
       #50 ALUControl <= SLTU;  A <= 1; B <= 1; 
       #50                      A <= 0; B <= 1; 
       #50                      A <= 64; B <= 4; 
       #50                      A <= 10; B <= 2048; 
       #50                      A <= 1024; B <= 1000; 
       //Test MUL
       #50 ALUControl <= MUL;   A <= 1; B <= 1; 
       #50                      A <= 0; B <= 1; 
       #50                      A <= 64; B <= 4; 
       #50                      A <= 10; B <= 2048; 
       #50                      A <= 1024; B <= 1000;
       //Test MADD
       #50 ALUControl <= MADD;  A <= 1; B <= 1; 
       #50                      A <= 0; B <= 1; 
       #50                      A <= 64; B <= 4;
       #50                      A <= 10; B <= 2048; 
       #50                      A <= 1024; B <= 1000;
       //Test MSUB
       #50 ALUControl <= MSUB;  A <= 1; B <= 1; 
       #50                      A <= 0; B <= 1; 
       #50                      A <= 64; B <= 4; 
       #50                      A <= 10; B <= 2048; 
       #50                      A <= 1024; B <= 1000; 
       //Test SEH_SEB
       #50 ALUControl <= SEH_SEB;  A <= 0; B <= 1; 
       #50                         A <= 0; B <= 16;
       #50                         A <= 0; B <= 'h0000fff0; 
       #50                         A <= 0; B <= 'h000000f0;
       #50                         A <= 0; B <= 'h00000080;
	end

endmodule

