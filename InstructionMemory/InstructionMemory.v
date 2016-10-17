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
    reg [31:0] memory [113:0];
    
    initial begin
memory[0] = 32'b00100000000010000000000000000001;	//		addi	$t0, $0, 1
    memory[1] = 32'b00100000000010010000000000000010;    //        addi    $t1, $0, 2
    memory[2] = 32'b00100000000010100000000000000011;    //        addi    $t2, $0, 3
    memory[3] = 32'b00100000000010110000000000000100;    //        addi    $t3, $0, 4
    memory[4] = 32'b00100000000011000000000011111111;    //        addi    $t4, $0, 255
    memory[5] = 32'b00100000000011011111111111111111;    //        addi    $t5, $0, 65535
    memory[6] = 32'b00100000000011101111111111111111;    //        addi    $t6, $0, -1
    memory[7] = 32'b00100000000011111111111111111110;    //        addi    $t7, $0, -2
    memory[8] = 32'b00100000000110001111111111111101;    //        addi    $t8, $0, -3
    memory[9] = 32'b00100000000110011111111111111100;    //        addi    $t9, $0, -4
    memory[10] = 32'b00000001010010111000000000100000;    //        add    $s0, $t2, $t3
    memory[11] = 32'b00000001011011101000100000100000;    //        add    $s1, $t3, $t6
    memory[12] = 32'b00000001111010101001000000100000;    //        add    $s2, $t7, $t2
    memory[13] = 32'b00000011000011111001100000100000;    //        add    $s3, $t8, $t7
    memory[14] = 32'b00100001000101000000000000000001;    //        addi    $s4, $t0, 1
    memory[15] = 32'b00100001001101011111111111111111;    //        addi    $s5, $t1, -1
    memory[16] = 32'b00100001110101100000000000000010;    //        addi    $s6, $t6, 2
    memory[17] = 32'b00100001111101111111111111111110;    //        addi    $s7, $t7, -2
    memory[18] = 32'b00000001010010111000000000100001;    //        addu    $s0, $t2, $t3
    memory[19] = 32'b00000001011011101000100000100001;    //        addu    $s1, $t3, $t6
    memory[20] = 32'b00000001111010101001000000100001;    //        addu    $s2, $t7, $t2
    memory[21] = 32'b00000011000011111001100000100001;    //        addu    $s3, $t8, $t7
    memory[22] = 32'b00100101000101000000000000000001;    //        addiu    $s4, $t0, 1
    memory[23] = 32'b00100101001101011111111111111111;    //        addiu    $s5, $t1, -1
    memory[24] = 32'b00100101110101100000000000000010;    //        addiu    $s6, $t6, 2
    memory[25] = 32'b00100101111101111111111111111110;    //        addiu    $s7, $t7, -2
    memory[26] = 32'b00000001000010011000000000100010;    //        sub    $s0, $t0, $t1
    memory[27] = 32'b00000001001010001000100000100010;    //        sub    $s1, $t1, $t0
    memory[28] = 32'b00000001010011111001000000100010;    //        sub    $s2, $t2, $t7
    memory[29] = 32'b00000001110110001001100000100010;    //        sub    $s3, $t6, $t8
    memory[30] = 32'b01110001001010101000000000000010;    //        mul    $s0, $t1, $t2
    memory[31] = 32'b01110001010011111000100000000010;    //        mul    $s1, $t2, $t7
    memory[32] = 32'b01110011000010101001000000000010;    //        mul    $s2, $t8, $t2
    memory[33] = 32'b01110001110011111001100000000010;    //        mul    $s3, $t6, $t7
    memory[34] = 32'b00000001001010100000000000011000;    //        mult    $t1, $t2
    memory[35] = 32'b00000001010011110000000000011000;    //        mult    $t2, $t7
    memory[36] = 32'b00000011000010100000000000011000;    //        mult    $t8, $t2
    memory[37] = 32'b00000001110011110000000000011000;    //        mult    $t6, $t7
    memory[38] = 32'b00000001001010100000000000011001;    //        multu    $t1, $t2
    memory[39] = 32'b00000001010011110000000000011001;    //        multu    $t2, $t7
    memory[40] = 32'b00000011000010100000000000011001;    //        multu    $t8, $t2
    memory[41] = 32'b00000001110011110000000000011001;    //        multu    $t6, $t7
    memory[42] = 32'b00000000000000001010000000010010;    //        mflo    $s4
    memory[43] = 32'b00000000000000001010100000010000;    //        mfhi    $s5
    memory[44] = 32'b00000001110000000000000000010011;    //        mtlo    $t6
    memory[45] = 32'b00000001000000000000000000010011;    //        mtlo    $t0
    memory[46] = 32'b00000000000000000000000000010011;    //        mtlo    $0
    memory[47] = 32'b00000001110000000000000000010001;    //        mthi    $t6
    memory[48] = 32'b00000001000000000000000000010001;    //        mthi    $t0
    memory[49] = 32'b00000000000000000000000000010001;    //        mthi    $0
    memory[50] = 32'b01110001001010100000000000000000;    //        madd    $t1, $t2
    memory[51] = 32'b01110001010011110000000000000000;    //        madd    $t2, $t7
    memory[52] = 32'b01110011000010100000000000000000;    //        madd    $t8, $t2
    memory[53] = 32'b01110001110011110000000000000000;    //        madd    $t6, $t7
    memory[54] = 32'b01110001001010100000000000000100;    //        msub    $t1, $t2
    memory[55] = 32'b01110001010011110000000000000100;    //        msub    $t2, $t7
    memory[56] = 32'b01110011000010100000000000000100;    //        msub    $t8, $t2
    memory[57] = 32'b01110001110011110000000000000100;    //        msub    $t6, $t7
    memory[58] = 32'b00000000000000001011000000010010;    //        mflo    $s6
    memory[59] = 32'b00000000000000001011100000010000;    //        mfhi    $s7
    memory[60] = 32'b00000001000010011000000000100100;    //        and    $s0, $t0, $t1
    memory[61] = 32'b00000001010010011000100000100100;    //        and    $s1, $t2, $t1
    memory[62] = 32'b00110001011100100000000000000100;    //        andi    $s2, $t3, 4
    memory[63] = 32'b00110001001100110000000000001000;    //        andi    $s3, $t1, 8
    memory[64] = 32'b00000001001010101000000000100101;    //        or    $s0, $t1, $t2
    memory[65] = 32'b00000001011010111000100000100101;    //        or    $s1, $t3, $t3
    memory[66] = 32'b00110101010100100000000000000001;    //        ori    $s2, $t2, 1
    memory[67] = 32'b00110101011100110000000000000011;    //        ori    $s3, $t3, 3
    memory[68] = 32'b00000001000010011000000000100111;    //        nor    $s0, $t0, $t1
    memory[69] = 32'b00000000000000001000100000100111;    //        nor    $s1, $0, $0
    memory[70] = 32'b00000001001010101000000000100110;    //        xor    $s0, $t1, $t2
    memory[71] = 32'b00000001010010111000100000100110;    //        xor    $s1, $t2, $t3
    memory[72] = 32'b00111001011100100000000000000001;    //        xori    $s2, $t3, 1
    memory[73] = 32'b00111001100100110000000100000000;    //        xori    $s3, $t4, 256
    memory[74] = 32'b00000000000011001000000001000000;    //        sll    $s0, $t4, 1
    memory[75] = 32'b00000000000000001000100010000000;    //        sll    $s1, $0, 2
    memory[76] = 32'b00000001000011001001000000000100;    //        sllv    $s2, $t4, $t0
    memory[77] = 32'b00000001001000001001100000000100;    //        sllv    $s3, $0, $t1
    memory[78] = 32'b00000000000011001000000001000010;    //        srl    $s0, $t4, 1
    memory[79] = 32'b00000000000000001000100010000010;    //        srl    $s1, $0, 2
    memory[80] = 32'b00000001000011001001000000000110;    //        srlv    $s2, $t4, $t0
    memory[81] = 32'b00000001001000001001100000000110;    //        srlv    $s3, $0, $t1
    memory[82] = 32'b01111100000011011000011000100000;    //        seh    $s0, $t5
    memory[83] = 32'b01111100000011001000111000100000;    //        seh    $s1, $t4
    memory[84] = 32'b01111100000010111001010000100000;    //        seb    $s2, $t3
    memory[85] = 32'b01111100000011001001110000100000;    //        seb    $s3, $t4
    memory[86] = 32'b00000001000010011000000000101010;    //        slt    $s0, $t0, $t1
    memory[87] = 32'b00000001011010101000100000101010;    //        slt    $s1, $t3, $t2
    memory[88] = 32'b00000011000011111001000000101010;    //        slt    $s2, $t8, $t7
    memory[89] = 32'b00000000000011101001100000101010;    //        slt    $s3, $0, $t6
    memory[90] = 32'b00000001000010011010000000101011;    //        sltu    $s4, $t0, $t1
    memory[91] = 32'b00000001011010101010100000101011;    //        sltu    $s5, $t3, $t2
    memory[92] = 32'b00000011000011111011000000101011;    //        sltu    $s6, $t8, $t7
    memory[93] = 32'b00000000000011101011100000101011;    //        sltu    $s7, $0, $t6
    memory[94] = 32'b00101001000100000000000000000010;    //        slti    $s0, $t0, 2
    memory[95] = 32'b00101001011100010000000000000011;    //        slti    $s1, $t3, 3
    memory[96] = 32'b00101011000100101111111111111110;    //        slti    $s2, $t8, -2
    memory[97] = 32'b00101000000100111111111111111111;    //        slti    $s3, $0, -1
    memory[98] = 32'b00101101000101000000000000000010;    //        sltiu    $s4, $t0, 2
    memory[99] = 32'b00101101011101010000000000000011;    //        sltiu    $s5, $t3, 3
    memory[100] = 32'b00101111000101101111111111111110;    //        sltiu    $s6, $t8, -2
    memory[101] = 32'b00101100000101111111111111111111;    //        sltiu    $s7, $0, -1
    memory[102] = 32'b00000001000000001000000000001011;    //        movn    $s0, $t0, $0
    memory[103] = 32'b00000001001010001000100000001011;    //        movn    $s1, $t1, $t0
    memory[104] = 32'b00000001010000001001000000001010;    //        movz    $s2, $t2, $0
    memory[105] = 32'b00000001011010001001100000001010;    //        movz    $s3, $t3, $t0
    memory[106] = 32'b00000000001010011000000001000010;    //        rotr    $s0, $t1, 1
    memory[107] = 32'b00000000001010101000100010000010;    //        rotr    $s1, $t2, 2
    memory[108] = 32'b00000001000010011001000001000110;    //        rotrv    $s2, $t1, $t0
    memory[109] = 32'b00000001001010101001100001000110;    //        rotrv    $s3, $t2, $t1
    memory[110] = 32'b00000000000010001000000001000011;    //        sra    $s0, $t0, 1
    memory[111] = 32'b00000000000011101000100010000011;    //        sra    $s1, $t6, 2
    memory[112] = 32'b00000001000010001001000000000111;    //        srav    $s2, $t0, $t0
    memory[113] = 32'b00000001001011101001100000000111;    //        srav    $s3, $t6, $t1

    end

    assign Instruction = memory[Address[31:2]];
    
endmodule
