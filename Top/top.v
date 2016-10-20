`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// GROUP: 36
// TEAM MEMBERS: ANDRES REBEIL 50%
//               MIKE HARMON   50%
//////////////////////////////////////////////////////////////////////////////////


module top(Clk, Rst, out7, en_out, ClkOut);

    input Clk, Rst;
    // Data Signals
    wire [31:0] IM_Out, 	// Output of IM
        SL_Out,         	// Output of Shift Left
        JIBMux_Out,      	// Output of Jump/Increment Mux
        RF_RD1,         	// Output #1 of RF
        RF_RD2,         	// Output #2 of RF
        ALUSrc_Out,     	// Output of ALUSrcMux
        PC_Out,         	// Output of ProgramCounter
        SE_Out,         	// Output of SE
        ALU_Out,        	// Output of ALU
        DM_Out,         	// Output of DM
        PCI_Out,        	// Output of PCI (PC Incrementer)
        JA_Out,         	// Output of JA (Jump Adder)
        MemToReg_Out,   	// Output of MemToReg Mux
        RFAND_Out,      	// Output of the RFAND
        ALUReg_Out,			// Output of ALU Register
        PCReg_Out,			// Output of PC Register
        JumpShift_Out,		// Output of Jump Shifter
        BranchAdd_Out,		// Output of Branch Adder
        BranchShift_Out,	// Output of Branch Shifter
        JumpMux_Out;		// Output of Jump Mux
    wire ALU_Zero;      	// Output of ALU Zero Flag
    wire [4:0] RegDst_Out;	// Output of RegDstMux
    wire [63:0] HiLoRead, 	// Output of HiLoRead to ALU
    	HiLoWrite;			// Output of ALU to HiLoRead
    
    // Control Signals
    wire HiLoEn,			// HiLo Register Write Enable
        ALUSrc,             // ALUSrc Mux Control
        MemWrite,           // Data Memory Write Control
        MemRead,            // Data Memory Read Control
        RegWrite,           // Register File Write Control
        Branch,             // Branch Control
        Jump,               // Jump Control
        SignExt,            // Sign Extend Control
        BranchAnd_Out,      // PC Jump/Increment Mux Control
        JumpMuxControl;		// Jump Mux Control
    wire [1:0] MemToReg,	// MemToReg Mux Control
    	RegDst;				// RegDst Mux Control
    wire [4:0] ALUControl;  // ALU Controller to ALU Data
    wire [3:0] ALUOp;       // Controller to ALU Controller Data
    
    // Clocking Signals
    output wire ClkOut;
    
    // Seven Segment Display Outputs
    output [6:0] out7; //seg a, b, ... g
    output [7:0] en_out;
    
    // Output 8 x Seven Segment Display
    Two4DigitDisplay Display(
        .Clk(Clk), 
        .NumberA(ALUReg_Out), 
        .NumberB(PCReg_Out), 
        .out7(out7), 
        .en_out(en_out));
     Reg32 ALUReg(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .data(ALU_Out), 
        .Output(ALUReg_Out));
     Reg32 PCReg(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .data(PC_Out), 
        .Output(PCReg_Out));
    
    // Clock Divider
    Mod_Clk_Div MCD(
        .In(4'b1111), // For Testing
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
        .OpCode(IM_Out[31:26]),
        .AluOp(ALUOp),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .AluSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .MemToReg(MemToReg),
        .SignExt(SignExt),
        .Jump(Jump),
        .JumpMux(JumpMuxControl));
    
    // Data Path Components
    ProgramCounter PC(
        .Address(JIBMux_Out),
        .PC(PC_Out),
        .Reset(Rst),
        .Clk(ClkOut));  
    InstructionMemory IM(
        .Address(PC_Out),
        .Instruction(IM_Out));
    Mux32Bit4To1 RegDstMux(
        .In0(IM_Out[15:11]),
        .In1(IM_Out[20:16]),
        .In2(32'b11111),
        .In3(32'b0),
        .Out(RegDst_Out),
        .sel(RegDst));
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
        .ReadData2(RF_RD2),
        .Reset(Rst));
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
    Mux32Bit4To1 MemToRegMux(
        .Out(MemToReg_Out),
        .In0(ALU_Out),
        .In1(DM_Out),
        .In2(PCI_Out),
        .In3(32'b0),
        .sel(MemToReg));

    // Program Counter Data Path
    Adder PCI(
        .InA(PC_Out),
        .InB(32'd4),
        .Out(PCI_Out));
    ShiftLeft BranchShift(
        .In(SE_Out),
        .Out(BranchShift_Out),
        .Shift(32'd2));
    ShiftLeft JumpShift(
        .In(IM_Out[25:0]),
        .Out(JumpShift_Out),
        .Shift(32'd2));
    Adder BranchAdder(
        .InA(PCI_Out),
        .InB(BranchShift_Out),
        .Out(BranchAdd_Out));
    AND BranchAnd(
        .InA(ALU_Zero),
        .InB(Branch),
        .Out(BranchAnd_Out));
    Mux32Bit2To1 JumpMux(
        .In0({PCI_Out[31:28],JumpShift_Out[27:0]}),
        .In1(RF_RD1),
        .Out(JumpMux_Out),
        .sel(JumpMuxControl));
    Mux32Bit4To1 JIBMux(
        .Out(JIBMux_Out),
        .In0(PCI_Out),
        .In1(BranchAdd_Out),
        .In2(JumpMux_Out),
        .In3(32'b0),
        .sel({Jump,BranchAnd_Out}));
endmodule
