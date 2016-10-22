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
    reg     [1:0]   ByteSelect;

    wire [31:0] ReadData;

    DataMemory DM(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData),
        .ByteSel(ByteSelect)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	   /* Write and Read Words */
       // Write
       ByteSelect <= 2'b00;
       MemRead <= 0;
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
       // Read
       MemRead <= 1;
       Address <= 4;
       #20
       Address <= 8;
       #20
       Address <= 12;
       #20
       MemRead <= 0;
       // Rewrite
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
       // Read
       MemRead <= 1;
       Address <= 4;
       #20
       Address <= 8;
       #20
       Address <= 12;
       #20
       MemRead <= 0;
       // Write Multi Bytes
       MemWrite <= 1;
       Address <= 16;
       WriteData <= 'b01010101010101010101010101010101;
       #20
       Address <= 20;
       WriteData <= 'b10101010101010101010101010101010;
       #20
       MemWrite <= 0;
       // Read Multi Bytes
       MemRead <= 1;
       Address <= 16;
       #20
       Address <= 20;
       #20
       MemRead <= 0;
       /* Write & Read Half-Words*/
       // Write
       ByteSelect <= 2'b11;
       MemWrite <= 1;
       Address <= 24;
       WriteData <= 'b0000000011111111;
       #20
       Address <= 26;
       WriteData <= 'b1111111100000000;
       #20
       Address <= 28;
       WriteData <= 'b0000111100001111;
       #20
       Address <= 30;
       WriteData <= 'b1111000011110000;
       #20
       MemWrite <= 0;
       // Read
       MemRead <= 1;
       Address <= 24;
       #20
       Address <= 26;
       #20
       Address <= 28;
       #20
       Address <= 30;
       #20
       MemRead <= 0;
       /* Write & Read Byte */
       // Write
       ByteSelect <= 2'b01;
       MemWrite <= 1;
       Address <= 32;
       WriteData <= 'b00000000;
       #20
       Address <= 33;
       WriteData <= 'b11111111;
       #20
       Address <= 34;
       WriteData <= 'b11111111;
       #20
       Address <= 35;
       WriteData <= 'b00000000;
       #20
       MemWrite <= 0;
       // Read
       MemRead <= 1;
       Address <= 32;
       #20
       Address <= 33;
       #20
       Address <= 34;
       #20
       Address <= 35;
       #20
       MemRead <= 0;
	end
endmodule
