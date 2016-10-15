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
    reg [31:0] memory [29:0];
    
    initial begin
        memory[0] = 32'b00100000000010000000000000000010;   //	main:	addi	$t0, $0, 2
        memory[1] = 32'b00100000000010010000000000000011;   //        addi    $t1, $0, 3
        memory[2] = 32'b00100000000010100000000000000100;   //        addi    $t2, $0, 4
        memory[3] = 32'b00100000000010110000000000000101;   //        addi    $t3, $0, 5
        memory[4] = 32'b00100000000011000000000000000001;   //        addi    $t4, $0, 1
        memory[5] = 32'b00100000000011010000000011111111;   //        addi    $t5, $0, 255
        memory[6] = 32'b00100000000011101111111111111111;   //        addi    $t6, $0, 65535
        memory[7] = 32'b00000001010010111000000000100100;   //        and    $s0, $t2, $t3
        memory[8] = 32'b00110001001100010000000000000001;   //        andi    $s1, $t1, 1
        memory[9] = 32'b00000001010010011001000000100101;   //        or    $s2, $t2, $t1
        memory[10] = 32'b00110101001100110000000000000010;  //        ori    $s3, $t1, 2
        memory[11] = 32'b00000001010010011010000000100111;  //        nor    $s4, $t2, $t1
        memory[12] = 32'b00000001010010111010100000100110;  //        xor    $s5, $t2, $t3
        memory[13] = 32'b00111001010101100000000010000000;  //        xori    $s6, $t2, 128
        memory[14] = 32'b01111100000011011011110000100000;  //        seb    $s7, $t5
        memory[15] = 32'b01111100000011011011111000100000;  //        seh    $s7, $t6
        memory[16] = 32'b00000000000010101000000001000000;  //        sll    $s0, $t2, 1
        memory[17] = 32'b00000001100010101000100000000100;  //        sllv    $s1, $t2, $t4
        memory[18] = 32'b00000000000010101001000001000010;  //        srl    $s2, $t2, 1
        memory[19] = 32'b00000001100010101001100000000110;  //        srlv    $s3, $t2, $t4
        memory[20] = 32'b00000001100010001010000000101010;  //        slt    $s4, $t4, $t0
        memory[21] = 32'b00101001100101010000000000000000;  //        slti    $s5, $t4, 0
        memory[22] = 32'b00000010111101111011000000101011;  //        sltu    $s6, $s7, $s7
        memory[23] = 32'b00101110111101110000000000000000;  //        sltiu    $s7, $s7, 0
        memory[24] = 32'b00000001100010001000100000001011;  //        movn    $s1, $t4, $t0
        memory[25] = 32'b00000001100010001001000000001010;  //        movz    $s2, $t4, $t0
        memory[26] = 32'b00000000001010011001100001000010;  //        rotr    $s3, $t1, 1
        memory[27] = 32'b00000001100010011010000001000110;  //        rotrv    $s4, $t1, $t4
        memory[28] = 32'b00000000000101111010100001000011;  //        sra    $s5, $s7, 1
        memory[29] = 32'b00000001100101111011000000000111;  //        srav    $s6, $s7, $t4
    end

    assign Instruction = memory[Address[31:2]];
    
endmodule
