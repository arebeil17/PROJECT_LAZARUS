`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// Laboratory 1 
// Module - Adder_tb.v
// Description - Test the 'PCAdder.v' module.
////////////////////////////////////////////////////////////////////////////////

module Adder_tb();

    reg [31:0] Ouput;

    wire [31:0] Input1, Input2;

    Adder Adder(
        .IN1(Input1), 
		.IN2(32'd4),
        .OUT(Output)
    );

	initial begin
		Input1 <= 0;
		#200 Input1 <= PCAddResult;
		#200 Input1 <= PCAddResult;
		#200 Input1 <= PCAddResult;
	end

endmodule

