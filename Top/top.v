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


module top(Clk, Rst, out7, en_out, ClkOut);

    input Clk, Rst;
    // Data Signals
    wire [31:0] IM_Out, // Ouput of IM
        SL_Out,         // Output of Shift Left
        JIMux_Out,      // Output of Jump/Increment Mux
        RF_RD1,         // Ouptut #1 of RF
        RF_RD2,         // Output #2 of RF
        RegDst_Out,     // Output of RegDstMux
        ALUSrc_Out,     // Output of ALUSrcMux
        PC_Out,         // Output of ProgramCounter
        SE_Out,         // Output of SE
        ALU_Out,        // Output of ALU
        DM_Out,         // Output of DM
        PCI_Out,        // Output of PCI (PC Incrementer)
        JA_Out,         // Output of JA (Jump Adder)
        MemToReg_Out,   // Output
        RFAND_Out,      // Output of the RFAND
        AluOutReg,
        PC_OutReg;
        
    wire ALU_Zero;      // Output of ALU Zero Flag
    
    wire HiLoEn;
    wire [63:0] HiLoRead, HiLoWrite;
    
    // Control Signals
    wire RegDst,            // RegDst Mux Control
        ALUSrc,             // ALUSrc Mux Contorl
        MemWrite,           // Data Memory Write Control
        MemRead,            // Data Memory Read Control
        MemToReg,           // MemToReg Mux Control
        RegWrite,           // Register File Write Control
        Branch,             // Branch Control
        SignExt,            // Sign Extend Control
        JIMuxControl;       // PC Jump/Increment Mux Control
    
    wire [4:0] ALUControl;  // ALU Controller to ALU Data
    wire [3:0] ALUOp;       // Controller to ALU Controller Data
    
    output wire ClkOut;
    
    output [6:0] out7; //seg a, b, ... g
    output [7:0] en_out;
    
    // Output 8 x Seven Segment
    Two4DigitDisplay Display(
        .Clk(Clk), 
        .NumberA(AluOutReg), 
        .NumberB(PC_OutReg), 
        .out7(out7), 
        .en_out(en_out));
        
     Reg32 AluOutput(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .data(ALU_Out), 
        .Output(AluOutReg));
        
     Reg32 PCOutput(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .data(PC_Out), 
        .Output(PC_OutReg));
    
    // Clock Divider
    Mod_Clk_Div MCD(
        .In(4'b0001), // For Testing
        //.In(4'b0000), // For Use 
        .Clk(Clk), 
        .Rst(Rst), 
        .ClkOut(ClkOut));
    
    // Controller(s)
    ALU_Controller ALUController(
        .Rst(Rst),
        .AluOp(ALUOp),
        .Funct(IM_Out[5:0]),
        .ALUControl(ALUControl));
        
    DatapathController Controller(
        //.Rst(Rst),
        .OpCode(IM_Out[31:26]),
        .AluOp(ALUOp),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .AluSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .MemToReg(MemToReg),
        .SignExt(SignExt));
    
    // Data Path Components
    ProgramCounter PC(
        .Address(JIMux_Out),
        .PC(PC_Out),
        .Reset(Rst),
        .Clk(ClkOut));  
    InstructionMemory IM(
        .Address(PC_Out),
        .Instruction(IM_Out));
    Mux5bit_2to1 RegDstMux(
        .In0(IM_Out[15:11]),
        .In1(IM_Out[20:16]), 
        .sel(RegDst), 
        .Out(RegDst_Out[4:0]));
	AND RF_AND(
		.InA(RegWrite),
		.InB(ALU_RegWrite),
		.Out(RFAND_Out));
	RegisterFile RF(
        .ReadRegister1(IM_Out[25:21]),
        .ReadRegister2(IM_Out[20:16]),
        .WriteRegister(RegDst_Out[4:0]),
        .WriteData(MemToReg_Out),
        .RegWrite(RFAND_Out),
		.Clk(ClkOut),
        .ReadData1(RF_RD1),
        .ReadData2(RF_RD2));
    SignExtension SE(
        .In(IM_Out[15:0]),
        .Out(SE_Out));
    Mux32Bit2To1 ALUSrcMux(
        .Out(ALUSrc_Out),
        .In0(RF_RD2),
        .In1(SE_Out),
        .sel(ALUSrc));
    ALU32Bit ALU(
        .ALUControl(ALUControl),
        .A(RF_RD1),
        .B(ALUSrc_Out),
        .Shamt(IM_Out[10:6]),
        .ALUResult(ALU_Out),
        .Zero(ALU_Zero),
        .HiLoEn(HiLoEn),
        .HiLoWrite(HiLoWrite), 
        .HiLoRead(HiLoRead),
        .RegWrite(ALU_RegWrite));
    HiLoRegister HiLo(
        .WriteEnable(HiLoEn) , 
        .WriteData(HiLoWrite), 
        .HiLoReg(HiLoRead), 
        .Clk(ClkOut), 
        .Reset(Rst));
    DataMemory DM(
        .Address(ALU_Out),
        .WriteData(RF_RD2),
        .Clk(ClkOut),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(DM_Out));
    Mux32Bit2To1 MemToRegMux(
        .Out(MemToReg_Out),
        .In0(ALU_Out),
        .In1(DM_Out),
        .sel(MemToReg));

    // Program Counter Data Path
    Adder PCI(
        .InA(PC_Out),
        .InB(32'd4),
        .Out(PCI_Out));
    ShiftLeft SL(
        .In(SE_Out),
        .Out(SL_Out),
        .Shift(32'd2));
    Adder JA(
        .InA(PCI_Out),
        .InB(SL_Out),
        .Out(JA_Out));
    AND JumpAnd(
        .InA(ALU_Zero),
        .InB(Branch),
        .Out(JIMuxControl));
    Mux32Bit2To1 JIMux(
        .Out(JIMux_Out),
        .In0(PCI_Out),
        .In1(JA_Out),
        .sel(JIMuxControl));
        
endmodule
