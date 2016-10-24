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
    reg [31:0] memory [57:0];
    
    initial begin
        memory[0] = 32'b00110100000001000000000000000000;	//	main:		ori	$a0, $zero, 0
    memory[1] = 32'b00001000000000000000000000000100;    //            j    start
    memory[2] = 32'b00100000000001000000000000001010;    //            addi    $a0, $zero, 10
    memory[3] = 32'b00100000000001000000000000001010;    //            addi    $a0, $zero, 10
    memory[4] = 32'b10001100100100000000000000000100;    //    start:        lw    $s0, 4($a0)
    memory[5] = 32'b10001100100100000000000000001000;    //            lw    $s0, 8($a0)
    memory[6] = 32'b10101100100100000000000000000000;    //            sw    $s0, 0($a0)
    memory[7] = 32'b10101100100100000000000000001100;    //            sw    $s0, 12($a0)
    memory[8] = 32'b10001100100100010000000000000000;    //            lw    $s1, 0($a0)
    memory[9] = 32'b10001100100100100000000000001100;    //            lw    $s2, 12($a0)
    memory[10] = 32'b00010010000000000000000000000011;    //            beq    $s0, $zero, branch1
    memory[11] = 32'b00000010000000001000100000100000;    //            add    $s1, $s0, $zero
    memory[12] = 32'b00010010000100010000000000000001;    //            beq    $s0, $s1, branch1
    memory[13] = 32'b00001000000000000000000000110111;    //            j    error
    memory[14] = 32'b00100000000100001111111111111111;    //    branch1:    addi    $s0, $zero, -1
    memory[15] = 32'b00000110000000011111111111110110;    //            bgez    $s0, start
    memory[16] = 32'b00100010000100000000000000000001;    //            addi    $s0, $s0, 1
    memory[17] = 32'b00000110000000010000000000000001;    //            bgez    $s0, branch2
    memory[18] = 32'b00001000000000000000000000110111;    //            j    error
    memory[19] = 32'b00100000000100001111111111111111;    //    branch2:    addi    $s0, $zero, -1
    memory[20] = 32'b00011110000000000000000000000110;    //            bgtz $s0, branch3
    memory[21] = 32'b00100000000100000000000000000001;    //            addi    $s0, $zero, 1
    memory[22] = 32'b00011110000000000000000000000001;    //            bgtz $s0, branch3
    memory[23] = 32'b00001000000000000000000000110111;    //            j    error
    memory[24] = 32'b00000110000000000000000000000011;    //    branch3:    bltz    $s0, branch4
    memory[25] = 32'b00100000000100001111111111111111;    //            addi    $s0, $zero, -1
    memory[26] = 32'b00000110000000000000000000000001;    //            bltz    $s0, branch4
    memory[27] = 32'b00001000000000000000000000110111;    //            j    error
    memory[28] = 32'b00100000000100011111111111111111;    //    branch4:    addi    $s1, $zero, -1
    memory[29] = 32'b00010110000100010000000000000010;    //            bne    $s0, $s1, branch5
    memory[30] = 32'b00010110000000000000000000000001;    //            bne    $s0, $zero, branch5
    memory[31] = 32'b00001000000000000000000000110111;    //            j    error
    memory[32] = 32'b00100000000100000000000010000000;    //    branch5:    addi    $s0, $zero, 128
    memory[33] = 32'b10100000100100000000000000000000;    //            sb    $s0, 0($a0)
    memory[34] = 32'b10000000100100000000000000000000;    //            lb    $s0, 0($a0)
    memory[35] = 32'b00011010000000000000000000000001;    //            blez    $s0, branch6
    memory[36] = 32'b00001000000000000000000000110111;    //            j    error
    memory[37] = 32'b00100000000100001111111111111111;    //    branch6:    addi    $s0, $zero, -1
    memory[38] = 32'b10100100100100000000000000000000;    //            sh    $s0, 0($a0)
    memory[39] = 32'b00100000000100000000000000000000;    //            addi    $s0, $zero, 0
    memory[40] = 32'b10000100100100000000000000000000;    //            lh    $s0, 0($a0)
    memory[41] = 32'b00011010000000000000000000000001;    //            blez    $s0, branch7
    memory[42] = 32'b00001000000000000000000000110111;    //            j    error
    memory[43] = 32'b00100000000100001111111111111111;    //    branch7:    addi    $s0, $zero, -1
    memory[44] = 32'b00111100000100000000000000000001;    //            lui    $s0, 1
    memory[45] = 32'b00000110000000010000000000000001;    //            bgez    $s0, branch8
    memory[46] = 32'b00001000000000000000000000110111;    //            j    error
    memory[47] = 32'b00001000000000000000000000110011;    //    branch8:    j    jump1
    memory[48] = 32'b00100010000100001111111111111110;    //            addi    $s0, $s0, -2
    memory[49] = 32'b00001100000000000000000000110101;    //    jump1:        jal    jal1
    memory[50] = 32'b00001000000000000000000000000100;    //            j    start
    memory[51] = 32'b00000011111000000000000000001000;    //    jal1:        jr    $ra
    memory[52] = 32'b00001000000000000000000000110111;    //            j    error
    memory[53] = 32'b00000000000000000000000000001000;    //    error:        jr    $zero
    memory[54] = 32'b00110100000000100000000000001010;    //            ori    $v0, $zero, 10
    memory[55] = 32'b00000000000000000000000000000000;    //            nop
    end

    assign Instruction = memory[Address[31:2]];
    
endmodule
