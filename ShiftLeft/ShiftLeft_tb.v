`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 03:18:33 PM
// Design Name: 
// Module Name: ShiftLeft_tb
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


module ShiftLeft_tb();
    reg [31:0] in;
    reg [4:0] s;
    
    wire [31:0] o;
    
    ShiftLeft SL(in,o,s);
    
    initial begin
        s <= 1;
        in <= 32'b0101;
        #10
        s <= 1;
        in <= 32'b0110;
        #10
        s <= 2;
        in <= 32'b0011;
        #10
        s <= 3;
        in <= 32'b1100;
        #10
        s <= 0;
        in <= 32'd0;
    end
endmodule
