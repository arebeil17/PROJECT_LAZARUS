`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2016 12:35:28 PM
// Design Name: 
// Module Name: ALU_Control_And_ALU_TB
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
module ALU_Control_And_ALU_TB();
    
    reg Rst, SRL_Select;
    
    reg [3:0] AluOp;
    reg [5:0] Funct;
    reg [31:0] A, B;
    
    wire [31:0] ALUResult;
    wire Zero;
    
    ALU_Controller_And_ALU32bit_TOP   ALU_MODULE_TEST(Rst, AluOp, Funct, A, B, SRL_Select, ALUResult, Zero);
    
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
        Rst <= 0; AluOp <= DC; Funct <= FC_add; A <= 0; B <= 0; SRL_Select <= 0;
        #50 Rst <= 1;
        //Test Add
        #50 Rst <= 0; AluOp <= DC; Funct <= FC_add; A <= 1; B <= 1; SRL_Select <= 0;
        #50 Rst <= 0; AluOp <= DC; Funct <= FC_add; A <= 4; B <= 2; SRL_Select <= 0;
        //Test Sub
        #50 Rst <= 0; AluOp <= DC; Funct <= FC_sub; A <= 1; B <= 1; SRL_Select <= 0;
        #50 Rst <= 0; AluOp <= DC; Funct <= FC_sub; A <= 4; B <= 2; SRL_Select <= 0;
    end
    
endmodule
