`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(In, Out);

    /* A 16-Bit input word */
    input [15:0] In;
    
    /* A 32-Bit output word */
    output [31:0] Out;
    
    assign Out = (In[15] == 0) ? (In) : (In | 'hffff0000);

endmodule
