`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
//
//
// Student(s) Name and Last Name: FILL IN YOUR INFO HERE!
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, 
    WriteData, RegWrite, Clk, ReadData1, ReadData2);
    input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    input [31:0] WriteData;
    input RegWrite;
    input Clk;
    
    output reg [31:0] ReadData1, ReadData2;
    
    reg [31:0] registers [0:31];
    
    initial begin
	   registers[0] =  32'b00000000000000000000000000000000;
	   registers[1] =  32'b00000000000000000000000000000001;
	   registers[2] =  32'b00000000000000000000000000000000;
	   registers[3] =  32'b00000000000000000000000000000000;
	   registers[4] =  32'b00000000000000000000000000000000;
	   registers[5] =  32'b00000000000000000000000000000000;
	   registers[6] =  32'b00000000000000000000000000000000;
	   registers[7] =  32'b00000000000000000000000000000000;
	   registers[8] =  32'b00000000000000000000000000000000;
	   registers[9] =  32'b00000000000000000000000000000000;
	   registers[10] = 32'b00000000000000000000000000000000;
	   registers[11] = 32'b00000000000000000000000000000000;
	   registers[12] = 32'b00000000000000000000000000000000;
	   registers[13] = 32'b00000000000000000000000000000000;
	   registers[14] = 32'b00000000000000000000000000000000;
	   registers[15] = 32'b00000000000000000000000000000000;
	   registers[16] = 32'b00000000000000000000000000000000;
	   registers[17] = 32'b00000000000000000000000000000000;
	   registers[18] = 32'b00000000000000000000000000000000;
	   registers[19] = 32'b00000000000000000000000000000000;
	   registers[20] = 32'b00000000000000000000000000000000;
	   registers[21] = 32'b00000000000000000000000000000000;
	   registers[22] = 32'b00000000000000000000000000000000;
	   registers[23] = 32'b00000000000000000000000000000000;
	   registers[24] = 32'b00000000000000000000000000000000;
	   registers[25] = 32'b00000000000000000000000000000000;
	   registers[26] = 32'b00000000000000000000000000000000;
	   registers[27] = 32'b00000000000000000000000000000000;
	   registers[28] = 32'b00000000000000000000000000000000;
	   registers[29] = 32'b00000000000000000000000000000000;
	   registers[30] = 32'b00000000000000000000000000000000;
	   registers[31] = 32'b00000000000000000000000000000000;
	end

    always @(negedge Clk) begin
        if(RegWrite == 1) begin
            registers[WriteRegister] <= WriteData;
        end
    end
    //Should not be clocked  else will cause intermittent delays on reads
    always @(ReadRegister1, ReadRegister2) begin
        ReadData1 <= registers[ReadRegister1];
        ReadData2 <= registers[ReadRegister2];
    end
endmodule
