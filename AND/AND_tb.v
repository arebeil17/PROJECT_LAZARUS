`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 03:00:04 PM
// Design Name: 
// Module Name: AND_tb
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


module AND_tb();
    reg ONE,TWO;
    wire RESULT;
    
    AND AND1(ONE,TWO,RESULT);
    
    initial begin
        ONE <= 0;
        TWO <= 0;
        #10
        ONE <= 1;
        TWO <= 0;
        #10
        ONE <= 0;
        TWO <= 1;
        #10
        ONE <= 1;
        TWO <= 1;
        #10
        ONE <= 0;
        TWO <= 0;
    end 
endmodule
