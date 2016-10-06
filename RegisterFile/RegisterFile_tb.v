`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;


	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	   // Write a Bunch of Registers
	   RegWrite <= 1;
	   WriteData <= 11;
	   WriteRegister <= 1;
	   #20
	   WriteData <= 22;
	   WriteRegister <= 2;
	   #20
       WriteData <= 33;
       WriteRegister <= 3;
       #20
       WriteData <= 44;
       WriteRegister <= 4;
       #20
       WriteData <= 55;
       WriteRegister <= 5;
       #20
       WriteData <= 66;
       WriteRegister <= 6;
       #20
       WriteData <= 77;
       WriteRegister <= 7;
       #20
       WriteData <= 88;
       WriteRegister <= 8;
       #20
       WriteData <= 99;
       WriteRegister <= 9;
       #20
       RegWrite <= 0;
       // Read a Bunch of Registers
       ReadRegister1 <= 0;
       ReadRegister2 <= 1;
       #20
       ReadRegister1 <= 2;
       ReadRegister2 <= 3;
       #20
       ReadRegister1 <= 4;
       ReadRegister2 <= 5;
       #20
       ReadRegister1 <= 6;
       ReadRegister2 <= 7;
       #20
       ReadRegister1 <= 8;
       ReadRegister2 <= 9;
       #20
       // (Re-)Write a Bunch of Memory
       RegWrite <= 1;
       WriteData <= 111;
       WriteRegister <= 1;
       #20
       WriteData <= 222;
       WriteRegister <= 2;
       #20
       WriteData <= 333;
       WriteRegister <= 3;
       #20
       WriteData <= 444;
       WriteRegister <= 4;
       #20
       WriteData <= 555;
       WriteRegister <= 5;
       #20
       WriteData <= 666;
       WriteRegister <= 6;
       #20
       WriteData <= 777;
       WriteRegister <= 7;
       #20
       WriteData <= 888;
       WriteRegister <= 8;
       #20
       WriteData <= 999;
       WriteRegister <= 9;
       #20
       RegWrite <= 0;
       // (Re-)Read a Bunch of Memory
       ReadRegister1 <= 9;
       ReadRegister2 <= 8;
       #20
       ReadRegister1 <= 7;
       ReadRegister2 <= 6;
       #20
       ReadRegister1 <= 5;
       ReadRegister2 <= 4;
       #20
       ReadRegister1 <= 3;
       ReadRegister2 <= 2;
       #20
       ReadRegister1 <= 1;
       ReadRegister2 <= 0;
	end

endmodule
