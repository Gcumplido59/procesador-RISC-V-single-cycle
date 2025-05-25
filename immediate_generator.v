module ImmediateGenerator(
    input  logic [31:0] instr,
    input  logic [1:0]  ImmSrc,
    output logic [31:0] imm
);
    logic [31:0] imm_i, imm_s, imm_b, imm_j;
    assign imm_i = {{20{instr[31]}}, instr[31:20]};
    assign imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    assign imm_b = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
    assign imm_j = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
    always_comb begin
        case (ImmSrc)
            2'b00: imm = imm_i;
            2'b01: imm = imm_s;
            2'b10: imm = imm_b;
            2'b11: imm = imm_j;
            default: imm = 32'd0;
        endcase
    end
endmodule
