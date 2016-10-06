`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
        // Write a Bunch of Memory
        MemWrite <= 1;
        Address <= 4;
        WriteData <= 4;
        #20
        Address <= 8;
        WriteData <= 8;
        #20
        Address <= 12;
        WriteData <= 12;
        #20
        MemWrite <= 0;
        // Read a Bunch of Memory
        MemRead <= 1;
        Address <= 4;
        #20
        Address <= 8;
        #20
        Address <= 12;
        #20
        MemRead <= 0;
        // (Re-)Write a Bunch of Memory
        MemWrite <= 1;
        Address <= 4;
        WriteData <= 44;
        #20
        Address <= 8;
        WriteData <= 88;
        #20
        Address <= 12;
        WriteData <= 132;
        #20        
        MemWrite <= 0;
        // (Re-)Read a Bunch of Memory
        MemRead <= 1;
        Address <= 4;
        #20
        Address <= 8;
        #20
        Address <= 12;
        #20
        MemRead <= 0;
	end

endmodule
