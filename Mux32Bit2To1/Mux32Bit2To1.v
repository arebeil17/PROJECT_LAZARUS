`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(Out, In0, In1, sel);
    output [31:0] Out;
    
    input [31:0] In0;
    input [31:0] In1;
    input sel;

    assign Out = (sel) ? (In1):(In0);

endmodule
