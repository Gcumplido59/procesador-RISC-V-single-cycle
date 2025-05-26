module control_unit(
    input  [6:0] op,
    input  [2:0] funct3,
    input        funct7,
    input        zero,
    output reg   PCSrc,
    output reg   ResultSrc,
    output reg   MemWrite,
    output reg   ALUSrc,
    output reg [1:0] ImmSrc,
    output reg   RegWrite,
    output reg [1:0] ALUOp
);
    always @(*) begin
        // defaults
        PCSrc     = 1'b0;
        ResultSrc = 1'b0;
        MemWrite  = 1'b0;
        ALUSrc    = 1'b0;
        ImmSrc    = 2'b00;
        RegWrite  = 1'b0;
        ALUOp     = 2'b00;
        case (op)
            7'b0110011: begin // R-type
                RegWrite = 1;
                ALUOp     = 2'b10;
            end
            7'b0010011: begin // I-type ALU
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b10;
            end
            7'b0000011: begin // lw
                RegWrite  = 1;
                ALUSrc    = 1;
                ResultSrc = 1;
                ALUOp     = 2'b00;
            end
            7'b0100011: begin // sw
                MemWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b00;
                ImmSrc   = 2'b01;
            end
            7'b1100011: begin // beq
                ALUOp     = 2'b01;
                PCSrc     = zero;
                ImmSrc    = 2'b10;
            end
        endcase
    end
endmodule
