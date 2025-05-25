module ControlUnit(
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic       zero,
    output logic       RegWrite,
    output logic       MemRead,
    output logic       MemWrite,
    output logic       ALUSrc,
    output logic       PCSrc,
    output logic       ResultSrc,
    output logic [1:0] ALUOp,
    output logic [1:0] ImmSrc
);
    logic branch;
    always_comb begin
        RegWrite  = 1'b0; MemRead = 1'b0; MemWrite = 1'b0;
        ALUSrc = 1'b0; ResultSrc = 1'b0; ALUOp = 2'b00; ImmSrc = 2'b00;
        branch = 1'b0;
        case (opcode)
            7'b0110011: begin RegWrite=1; ALUOp=2'b10; ImmSrc=2'b00; end
            7'b0000011: begin RegWrite=1; MemRead=1; ALUSrc=1; ResultSrc=1; ALUOp=2'b00; ImmSrc=2'b00; end
            7'b0100011: begin MemWrite=1; ALUSrc=1; ALUOp=2'b00; ImmSrc=2'b01; end
            7'b0010011: begin RegWrite=1; ALUSrc=1; ALUOp=2'b10; ImmSrc=2'b00; end
            7'b1100011: begin branch=1; ALUOp=2'b01; ImmSrc=2'b10; end
            7'b1101111: begin RegWrite=1; PCSrc=1; ResultSrc=0; ImmSrc=2'b11; end
        endcase
        PCSrc = branch & zero;
    end
endmodule
