`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 12:18:18 PM
// Design Name: 
// Module Name: HiLORegister_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HiLoRegister_tb();
    reg Clk, RST, LoWriteEnable, HiWriteEnable;
    reg [31:0] HiWriteData, LoWriteData;
    
    wire [31:0] HiReadData, LoReadData;
    
    HiLoRegister HiLo(.HiWriteEnable(HiWriteEnable), .LoWriteEnable(LoWriteEnable), 
        .HiWriteData(HiWriteData), .LoWriteData(LoWriteData),
        .HiReadData(HiReadData), .LoReadData(LoReadData), .Clk(Clk), .Reset(RST));
        
    initial begin
        Clk <= 1;
        forever #10 Clk = ~Clk;
    end
    
    initial begin
    // Check Initial Values (Should Be Zero)
    #20
    // Write Hi Register
    HiWriteData <= 32'h7f00;
    HiWriteEnable <= 1;
    #20
    HiWriteEnable <= 0;
    // Write Lo Register
    LoWriteData <= 32'h00ff;
    LoWriteEnable <= 1;
    #20
    LoWriteEnable <= 0;
    // Write Hi and Lo
    LoWriteData <= 32'h0ff0;
    HiWriteData <= 32'h700f;
    LoWriteEnable <= 1;
    HiWriteEnable <= 1;
    #20
    LoWriteEnable <= 0;
    HiWriteEnable <= 0;
    // Test Reset
    RST <= 1;
    #20
    RST <= 0;
    end
endmodule
