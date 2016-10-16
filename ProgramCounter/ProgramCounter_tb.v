`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// Laboratory 1
// Module - ProgramCounter_tb.v
// Description - Test the 'ProgramCounter.v' module.
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_tb(); 

	reg [31:0] Address;
	reg Reset, Clk;

	wire [31:0] PCResult;

    ProgramCounter PC(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk)
    );

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
        Address <= 0;
        Reset <= 0;
        #100 Address <= 100;
        #100 Address <= 200;
        #100 Address <= 300;
        #10 Reset <= 1;
        #10 Reset <= 0;
        #100 Address <= 50;
        #100 Address <= 150;
        #100 Address <= 250;
        #10 Reset <= 1;
        #10 Reset <= 0;
	
	end

endmodule

