module singleCycle(
    input  logic clk,
    input  logic reset
);
    logic [31:0] PC, PCPlus4, PCTarget, PCNext;
    logic [31:0] Inst, SrcA, SrcB, ImmExt, ALUResult, ReadData, Result;
    logic        RegWrite, MemRead, MemWrite, ALUSrc, PCSrc, ResultSrc, zero;
    logic [1:0]  ImmSrc, ALUOp;
    logic [2:0]  alu_ctrl;

    // PC logic
    Adder           pc4_add(.A(PC), .B(32'd4), .Y(PCPlus4));
    Adder           branch_add(.A(PC), .B(ImmExt), .Y(PCTarget));
    Mux2 #(.WIDTH(32)) pc_mux(.in0(PCPlus4), .in1(PCTarget), .sel(PCSrc), .out(PCNext));
    ProgramCounter  pc_reg(.clk(clk), .reset(reset), .next_pc(PCNext), .pc(PC));

    // Fetch
    InstructionMemory im(.A(PC), .RD(Inst));

    // Decode
    RegisterFile    rf(.clk(clk), .WE3(RegWrite), .A1(Inst[19:15]), .A2(Inst[24:20]), .A3(Inst[11:7]), .WD3(Result), .RD1(SrcA), .RD2(SrcB));
    ControlUnit     ctrl(.opcode(Inst[6:0]), .funct3(Inst[14:12]), .zero(zero), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .PCSrc(PCSrc), .ResultSrc(ResultSrc), .ALUOp(ALUOp), .ImmSrc(ImmSrc));
    ImmediateGenerator imm(.instr(Inst), .ImmSrc(ImmSrc), .imm(ImmExt));

    // Execute
    ALUControlUnit  alu_ctrl_unit(.ALUOp(ALUOp), .funct3(Inst[14:12]), .funct7b5(Inst[30]), .ALUControl(alu_ctrl));
    Mux2 #(.WIDTH(32)) alu_mux(.in0(SrcB), .in1(ImmExt), .sel(ALUSrc), .out(SrcB));
    ALU             alu_unit(.A(SrcA), .B(SrcB), .ALUControl(alu_ctrl), .Result(ALUResult), .Zero(zero));

    // Memory
    DataMemory      dm(.clk(clk), .WE(MemWrite), .A(ALUResult), .WD(SrcB), .RD(ReadData));

    // Writeback
    Mux2 #(.WIDTH(32)) wb_mux(.in0(ALUResult), .in1(ReadData), .sel(ResultSrc), .out(Result));
endmodule
