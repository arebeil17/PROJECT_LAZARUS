`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 12:14:44 PM
// Design Name: 
// Module Name: top
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


module top();
    // Data Signals
    wire [31:0] ProgramCount,
        IM_Out,         // Ouput of IM
        RF_RD1,         // Ouptut #1 of RF
        RF_RD2,         // Output #2 of RF
        RegDst_Out,     // Output of RegDstMux
        ALUSrc_Out,     // Output of ALUSrcMux
        PC_Out,         // Output of ProgramCounter
        SE_Out,         // Output of SE
        ALU_Out,        // Output of ALU
        DM_Out,         // Output of DM
        ;
    // Control Signals
    wire RegDst,        // RegDst
        ALUSrc,
        MemWrite,
        MemRead,
        MemToReg,
        RegWrite;
    
    // Controller(s)
    ALU_Control ALUController(
        );
    DatapasthController Controller(
        );
    
    // Data Path Components
    ProgramCounter PC(
        .Address(ProgramCount),
        .PC(),
        .Reset(),
        .Clk());
    InstructionMemory IM(
        .Address(ProgramCount),
        .Instruction(InstructionMemOut));
    Mux32Bit2To1 RegDestMux(
        .Out(RegDst_Out),
        .In0(IM_Out[15:10]),
        .In1(IM_Out[20:16]),
        .Sel(RegDst));
    RegisterFile RF(
        .ReadRegister1(IM_Out[25:21]),
        .ReadRegister2(IM_Out[20:16]),
        .WriteRegister(RegDstMux_Out),
        .WriteData(MemToReg_Out),
        .RegWrite(RegWrite),
        .Clk(),
        .ReadData1(RF_RD1),
        .ReadData2(RF_RD2));
    SignExtension SE(
        .In(IM_Out[15:0]),
        .Out(SE_Out));
    Mux32Bit2To1 ALUSrcMux(
        .Out(ALUSrc_Out),
        .In0(RF_RD2),
        .In1(SE_Out),
        .Sel(ALUSrc));
    ALU32Bit ALU(
        .ALUControl(),
        .InA(RV_RD1),
        .InB(ALUSrc_Out),
        .SHAMT(IM_Out[10:6]),
        );
    DataMemory DM(
        .Address(ALU_Out),
        .WriteData(RF_RD2),
        .Clk(),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(DM_Out));
    Mux32Bit2To1 MemToRegMux(
        .Out(MemToReg_Out),
        .In0(ALU_Out),
        .In1(DM_Out),
        .Sel(MemToReg));
endmodule
