`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output [31:0] Instruction;    // Instruction at memory location Address
    
	// Modify the size of the Instructions Array to Be The Total Lines of Code
    reg [31:0] Instructions [14:0];
    
    integer unsigned x;
    
    initial begin
        Instructions[0] = 32'b00000000000000001000100000100000; // add s1, $zero ,$zero
		Instructions[1] = 32'b00100010001100100000000000000010; // addi s2, s2, 2
		Instructions[2] = 32'b00000010010000001001100000100010; // sub s3, s2, $zero
		Instructions[3] = 32'b00000010011100100100000000100100; // and t0, s3, s2
		Instructions[4] = 32'b00000010011100100100100000100101; // or $t1, $s3, $s2
		Instructions[5] = 32'b00100000000010100000000000000100; // addi $t2, $zero, 0x4 
		Instructions[6] = 32'b00000010010010100000000000011000; // mult $s2, $t2
		Instructions[7] = 32'b00000000000000000000000000000000;
		Instructions[8] = 32'b00000000000000000000000000000000;
		Instructions[9] = 32'b00000000000000000000000000000000;
		Instructions[10] = 32'b00000000000000000000000000000000;
		Instructions[11] = 32'b00000000000000000000000000000000;
		Instructions[12] = 32'b00000000000000000000000000000000;
		Instructions[13] = 32'b00000000000000000000000000000000;
		Instructions[14] = 32'b00000000000000000000000000000000;
    end

    assign Instruction = Instructions[Address[31:2]];
    
endmodule
