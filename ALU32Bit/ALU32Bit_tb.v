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

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	   ALUControl <= 4'b0010;// ADD  | 0010
	   A <= 0; B <= 0; #50;
	   A <= 2; B <= 2; #50;
	   A <= 15; B <= 0; #50;
	   A <= 15; B <= 10; #50;
       ALUControl <= 4'b0110;// SUB  | 0110
       A <= 0; B <= 0; #50;
       A <= 2; B <= 2; #50;
       A <= 15; B <= 5; #50;
       A <= 5; B <= 15; #50;
       ALUControl <= 4'b0000;// AND  | 0000
       A <= 0; B <= 0; #50;
       A <= 2; B <= 2; #50;
       A <= 15; B <= 0; #50;
       ALUControl <= 4'b0001;// OR   | 0001
       A <= 0; B <= 0; #50;
       A <= 15; B <= 0; #50;
       ALUControl <= 4'b0111;// SLT  | 0111
       A <= 0; B <= 0; #50;
       A <= 15; B <= 0; #50;
       A <= 0; B <= 15; #50;
	end

endmodule

