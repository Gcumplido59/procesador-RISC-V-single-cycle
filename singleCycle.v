module SingleCycle (
    input  clk
);

// ——— DECLARACIONES —————————————————————
wire [31:0] PCTarget, PCPlus4, PCNext;
wire [31:0] Inst;
reg  [31:0] PC;

// señales de control
wire        PCSrc, ResultSrc, ALUSrc, MemWrite, RegWrite;
wire        Zero;
wire [1:0]  ImmSrc, ALUOp;
wire [2:0]  ALUControl;

// buses de datos
wire [31:0] SrcA, RD2, ImmExt, ALUResult, ReadData;
wire [31:0] Result;

// ——— LOGICA DE PC ——————————————————————
assign PCTarget = PC + ImmExt;
assign PCPlus4  = PC + 4;
assign PCNext   = PCSrc ? PCTarget : PCPlus4;

always @(posedge clk) begin
    PC <= PCNext;
end

// ——— FETCH ——————————————————————————
instruction_memory IM (
    .A (PC),
    .RD(Inst)
);

// ——— DECODE / REGFILE ——————————————
register_file RF (
    .clk (clk),
    .A1  (Inst[19:15]),
    .A2  (Inst[24:20]),
    .A3  (Inst[11:7]),
    .WD3 (Result),
    .WE3 (RegWrite),
    .RD1 (SrcA),
    .RD2 (RD2)
);

// ——— CONTROL ————————————————————————
control_unit CONTROL (
    .op       (Inst[6:0]),
    .funct3   (Inst[14:12]),
    .funct7   (Inst[30]),
    .zero     (Zero),
    .PCSrc    (PCSrc),
    .ResultSrc(ResultSrc),
    .MemWrite (MemWrite),
    .ALUSrc   (ALUSrc),
    .ImmSrc   (ImmSrc),
    .RegWrite (RegWrite),
    .ALUOp    (ALUOp)
);

// ——— IMMEDIATE ————————————————————————
immediate_generator EXT (
    .instr   (Inst),
    .ImmSrc  (ImmSrc),
    .imm     (ImmExt)
);

// ——— ALU CONTROL ——————————————————————
alu_decoder ALUDEC (
    .ALUOp     (ALUOp),
    .funct3    (Inst[14:12]),
    .funct7    (Inst[30]),
    .ALUControl(ALUControl)
);

// ——— ALU ————————————————————————————
alu alu_mol (
    .A          (SrcA),
    .B          (ALUSrc ? ImmExt : RD2),
    .ALUControl (ALUControl),
    .Result     (ALUResult),
    .Zero       (Zero)
);

// ——— DATA MEMORY ——————————————————————
data_memory MEM_DATA (
    .clk (clk),
    .A   (ALUResult),
    .WD  (RD2),
    .WE  (MemWrite),
    .RD  (ReadData)
);

// ——— WRITE-BACK ——————————————————————
assign Result = ResultSrc ? ReadData : ALUResult;

endmodule
