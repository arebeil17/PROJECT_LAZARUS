`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// Laboratory 1
// Module - pc_register.v
// Description - 32-Bit program counter (PC) register.
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module. Hence, please add a synchronous 'Reset' 
// signal to your PC register to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000H).
////////////////////////////////////////////////////////////////////////////////

module Register(In, Out, Reset, Clk);

	input [31:0] In;
	input Reset, Clk;

	output reg [31:0] Out = 0;
	
	reg hold = 0; //Used after reset to stabilze PC
    
    always @(posedge Clk, posedge Reset) begin
        if(Reset == 1)begin
            Out <= 0;
            hold <= 1;
        end else if(In >= 36)begin
            Out <= 0;
            //hold <= 1;
        end else if(hold) begin
            Out <= PC;
            hold <= 0; 
        end else begin
            Out <= In;
        end
    end

endmodule

