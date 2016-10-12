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
    reg [31:0] Instructions [28:0];
    
    integer unsigned x;
    
    initial begin
        Instructions[0] = 32'b00000000000000001000100000100000; // add s1, $zero ,$zero
		Instructions[1] = 32'b00100100000100101111111111111111; // addi s2, s2, 2
		Instructions[2] = 32'b00000000000000000000000000000000; // sub s3, s2, $zero
		Instructions[3] = 32'b00100000000101000000000000000100; // and t0, s3, s2
		Instructions[4] = 32'b00000010100100101010100000100010; // or $t1, $s3, $s2
		Instructions[5] = 32'b01110010100101011011000000000010; // addi $t2, $zero, 0x4 
		Instructions[6] = 32'b00000010011101000000000000011001; // add $t2 $t2 $t2
		Instructions[7] = 32'b00000000000000000000000000011000;
		Instructions[8] = 32'b01110010100100110000000000000000;
		Instructions[9] = 32'b01110010100100110000000000000100;
		Instructions[10] = 32'b00000010010100100101100000100100;
		Instructions[11] = 32'b00110010010011000000000011111111;
		Instructions[12] = 32'b00000010010100110110100000100101;
		Instructions[13] = 32'b00000010010100110111000000100111;
		Instructions[14] = 32'b00110110010011110000111111110000;
		Instructions[15] = 32'b00111010010110001111000000001111;
		Instructions[16] = 32'b01111100000010111100111000100000;
		Instructions[17] = 32'b00000000000110000001000001000000;
		Instructions[18] = 32'b00000000000110000001100001000010;
		Instructions[19] = 32'b00000010001110001000100000000100;
		Instructions[20] = 32'b00000000011000101001000000101010;
		Instructions[21] = 32'b00101011000100110000000000000000;
		Instructions[22] = 32'b00000010011100101010000000001011;
		Instructions[23] = 32'b00000010011100101010100000001010;
		Instructions[24] = 32'b00000010011000101011000001000110;
		Instructions[25] = 32'b00000000001000101011100100000010;
		Instructions[26] = 32'b00000000000010110100000010000011;
		Instructions[27] = 32'b00000010011010110100100000000111;
		Instructions[28] = 32'b01111100000011000101010000100000;
		Instructions[29] = 32'b00101111000010110000000000000000;
		Instructions[30] = 32'b00000000011000100110000000101011;
    end

    assign Instruction = Instructions[Address[31:2]];
    
endmodule
