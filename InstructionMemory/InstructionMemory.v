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
    reg [31:0] memory [65:0];
    
    initial begin
        memory[0] = 32'b00100000000100000000000000000001;	//	main:	addi	$s0, $zero, 1
    memory[1] = 32'b00100000000100010000000000000001;    //        addi    $s1, $zero, 1
    memory[2] = 32'b00000010000100011000000000100100;    //        and    $s0, $s0, $s1
    memory[3] = 32'b00000010000000001000000000100100;    //        and    $s0, $s0, $zero
    memory[4] = 32'b00000010001100001000000000100010;    //        sub    $s0, $s1, $s0
    memory[5] = 32'b00000010000000001000000000100111;    //        nor    $s0, $s0, $zero
    memory[6] = 32'b00000010000000001000000000100111;    //        nor    $s0, $s0, $zero
    memory[7] = 32'b00000000000000001000000000100101;    //        or    $s0, $zero, $zero
    memory[8] = 32'b00000010001000001000000000100101;    //        or    $s0, $s1, $zero
    memory[9] = 32'b00000000000100001000000010000000;    //        sll    $s0, $s0, 2
    memory[10] = 32'b00000010001100001000000000000100;    //        sllv    $s0, $s0, $s1
    memory[11] = 32'b00000010000000001000000000101010;    //        slt    $s0, $s0, $zero
    memory[12] = 32'b00000010000100011000000000101010;    //        slt    $s0, $s0, $s1
    memory[13] = 32'b00000000000100011000000001000011;    //        sra    $s0, $s1, 1
    memory[14] = 32'b00000000000100011000000000000111;    //        srav    $s0, $s1, $zero
    memory[15] = 32'b00000000000100011000000001000010;    //        srl    $s0, $s1, 1
    memory[16] = 32'b00000000000100011000000011000000;    //        sll    $s0, $s1, 3
    memory[17] = 32'b00000000000100001000000011000010;    //        srl    $s0, $s0, 3
    memory[18] = 32'b00000010001100001000000000000100;    //        sllv    $s0, $s0, $s1
    memory[19] = 32'b00000010001100001000000000000110;    //        srlv    $s0, $s0, $s1
    memory[20] = 32'b00000010000100011000000000100110;    //        xor    $s0, $s0, $s1
    memory[21] = 32'b00000010000100011000000000100110;    //        xor    $s0, $s0, $s1
    memory[22] = 32'b00100000000100100000000000000100;    //        addi    $s2, $zero, 4
    memory[23] = 32'b01110010000100101000000000000010;    //        mul    $s0, $s0, $s2
    memory[24] = 32'b00100010000100000000000000000100;    //        addi    $s0, $s0, 4
    memory[25] = 32'b00110010000100000000000000000000;    //        andi    $s0, $s0, 0
    memory[26] = 32'b00110110000100000000000000000001;    //        ori    $s0, $s0, 1
    memory[27] = 32'b00101010000100000000000000000000;    //        slti    $s0, $s0, 0
    memory[28] = 32'b00101010000100000000000000000001;    //        slti    $s0, $s0, 1
    memory[29] = 32'b00111010000100000000000000000001;    //        xori    $s0, $s0, 1
    memory[30] = 32'b00111010000100000000000000000001;    //        xori    $s0, $s0, 1
    memory[31] = 32'b00100000000100001111111111111110;    //        addi    $s0, $zero, -2
    memory[32] = 32'b00100000000100010000000000000010;    //        addi    $s1, $zero, 2
    memory[33] = 32'b00000010001100001001000000101011;    //        sltu    $s2, $s1, $s0
    memory[34] = 32'b00101110001100001111111111111110;    //        sltiu    $s0, $s1, -2
    memory[35] = 32'b00000010001000001000000000001010;    //        movz    $s0, $s1, $zero
    memory[36] = 32'b00000000000100011000000000001011;    //        movn    $s0, $zero, $s1
    memory[37] = 32'b00000010001100101000000000100000;    //        add    $s0, $s1, $s2
    memory[38] = 32'b00100000000100001111111111111110;    //        addi    $s0, $zero, -2
    memory[39] = 32'b00000010001100001000100000100001;    //        addu    $s1, $s1, $s0
    memory[40] = 32'b00100100000100011111111111111111;    //        addiu    $s1, $zero, -1
    memory[41] = 32'b00100000000100100000000000100000;    //        addi    $s2, $zero, 32
    memory[42] = 32'b00000010001100100000000000011000;    //        mult    $s1, $s2
    memory[43] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
    memory[44] = 32'b00000000000000001010100000010010;    //        mflo    $s5
    memory[45] = 32'b00000010001100100000000000011001;    //        multu    $s1, $s2
    memory[46] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
    memory[47] = 32'b00000000000000001010100000010010;    //        mflo    $s5
    memory[48] = 32'b01110010001100100000000000000000;    //        madd    $s1, $s2
    memory[49] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
    memory[50] = 32'b00000000000000001010100000010010;    //        mflo    $s5
    memory[51] = 32'b00000010010000000000000000010001;    //        mthi    $s2
    memory[52] = 32'b00000010001000000000000000010011;    //        mtlo    $s1
    memory[53] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
    memory[54] = 32'b00000000000000001010100000010010;    //        mflo    $s5
    memory[55] = 32'b00110010001100011111111111111111;    //        andi    $s1, , $s1, 65535
    memory[56] = 32'b01110010100100100000000000000100;    //        msub    $s4, , $s2
    memory[57] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
    memory[58] = 32'b00000000000000001010100000010010;    //        mflo    $s5
    memory[59] = 32'b00100000000100100000000000000001;    //        addi    $s2, $zero, 1
    memory[60] = 32'b00000000001100101000111111000010;    //        rotr    $s1, $s2, 31
    memory[61] = 32'b00100000000101000000000000011111;    //        addi    $s4, $zero, 31
    memory[62] = 32'b00000010100100011000100001000110;    //        rotrv    $s1, $s1, $s4
    memory[63] = 32'b00110100000100010000111111110000;    //        ori    $s1, , $zero, 4080
    memory[64] = 32'b01111100000100011010010000100000;    //        seb    $s4, $s1
    memory[65] = 32'b01111100000100011010011000100000;    //        seh    $s4, , $s1
    end

    assign Instruction = memory[Address[31:2]];
    
endmodule
