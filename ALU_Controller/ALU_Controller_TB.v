`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2016 07:54:54 PM
// Design Name: 
// Module Name: ALU_Controller_TB
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
module ALU_Controller_TB();
    
    reg Rst;
    reg [3:0] AluOp;
    reg [5:0] Funct;
    wire [4:0] ALUControl;
    
    ALU_Controller  ALUControl_TEST(Rst, AluOp, Funct, ALUControl);
    
    //Controller AluOp 4 bit inputs (also are the state encodings)
    localparam [3:0] DC =      'b0000, //DONT CARE
                     ADD_I =   'b0001, //ADD IMMEDIATE
                     SUB_I =   'b0010, //SUB IMMEDIATE
                     OR_I =    'b0011, //OR IMMEDIATE
                     AND_I =   'b0100, //AND IMMEDIATE
                     XOR_I =   'b0101, //XOR IMMEDIATE
                     NOR_I =   'b0110, //NOR IMMDEIATE
                     ADDU_I =  'b0111, //ADDU IMMEDIATE
                     SUBU_I =  'b1000, //SUBU IMMEDIATE
                     MULTU_I = 'b1001, //MULTU IMMDEDIATE
                     SLT_I =   'b1010, //SLT IMMEDIATE
                     SLT_IU =  'b1011, //SLTU IMMEDIATE
                     MUL_OP =  'b1100; //ALL MULTIPLY OPERATIONS
    
    //Instruction Function code 6 bit input definitions
    //---------------Dont Care FUNCTION FIELDS                
    localparam [5:0] FC_add  =  'b100000,  //add
                     FC_addu =  'b100001,  //addu
                     FC_sub  =  'b100010,  //sub
                     FC_mult =  'b011000,  //mult
                     FC_multu=  'b010001,  //multu
                     FC_and  =  'b100100,  //and
                     FC_or   =  'b100101,  //or
                     FC_nor  =  'b100111,  //nor
                     FC_xor  =  'b100110,  //xor
                     FC_sll  =  'b000000,  //sll
                     FC_srl  =  'b000010,  //srl
                     FC_sllv =  'b000100,  //sllv
                     FC_slt  =  'b101010,  //slt
                     FC_movn =  'b001011,  //movn
                     FC_movz =  'b001010,  //movz
                     FC_rotrv=  'b000110,  //rotrv
                     FC_sra  =  'b000011,  //sra
                     FC_srav =  'b000111,  //srav
                     FC_sltu =  'b101011,  //sltu
     //---------------MUL FUNCTION FIELDS
                     FC_mul  =  'b000010,  //mul
                     FC_madd =  'b000000,  //madd
                     FC_msub =  'b000100,  //msub
     //---------------SEH & SEB FUNCTION FIELDS
                     FC_seh_seb  =  'b100000;  //seh
    
    initial begin
        //Performing tests for AluOP = 0000 -> dont care
        Rst <= 0; AluOp <= DC; Funct <= FC_add;
        #100 Rst <= 1;
        #50 Rst <= 0;
        #50 AluOp <= DC; Funct <= FC_add;
        #50 AluOp <= DC; Funct <= FC_addu;
        #50 AluOp <= DC; Funct <= FC_sub;
        #50 AluOp <= DC; Funct <= FC_mult;
        #50 AluOp <= DC; Funct <= FC_multu;
        #50 AluOp <= DC; Funct <= FC_and;
        #50 AluOp <= DC; Funct <= FC_or;
        #50 AluOp <= DC; Funct <= FC_nor;
        #50 AluOp <= DC; Funct <= FC_xor;
        #50 AluOp <= DC; Funct <= FC_sll;
        #50 AluOp <= DC; Funct <= FC_srl;
        #50 AluOp <= DC; Funct <= FC_sllv;
        #50 AluOp <= DC; Funct <= FC_slt;
        #50 AluOp <= DC; Funct <= FC_movn;
        #50 AluOp <= DC; Funct <= FC_movz;
        #50 AluOp <= DC; Funct <= FC_rotrv;
        #50 AluOp <= DC; Funct <= FC_sra;
        #50 AluOp <= DC; Funct <= FC_srav;
        #50 AluOp <= DC; Funct <= FC_sltu;
        #50 AluOp <= MUL_OP; Funct <= FC_mul;
        #50 AluOp <= MUL_OP; Funct <= FC_madd;
        #50 AluOp <= MUL_OP; Funct <= FC_msub;
        #50 AluOp <= DC; Funct <= FC_seh_seb;
        //Immediates
        #50 AluOp <= ADD_I; Funct <= FC_add;
        #50 AluOp <= ADD_I; Funct <= FC_or;
        #50 AluOp <= SUB_I; Funct <= FC_add;
        #50 AluOp <= OR_I; Funct <= FC_add;
        #50 AluOp <= AND_I; Funct <= FC_add;
        #50 AluOp <= XOR_I; Funct <= FC_add;
        #50 AluOp <= NOR_I; Funct <= FC_add;
        #50 AluOp <= ADDU_I; Funct <= FC_add;
        #50 AluOp <= SUBU_I; Funct <= FC_add;
        #50 AluOp <= MULTU_I; Funct <= FC_add;
        #50 AluOp <= SLT_I; Funct <= FC_add;
        #50 AluOp <= SLT_IU; Funct <= FC_add;
    end
endmodule
