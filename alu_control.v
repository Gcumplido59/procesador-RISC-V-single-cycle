module ALUControlUnit(
    input  logic [1:0]  ALUOp,
    input  logic [2:0]  funct3,
    input  logic        funct7b5,
    output logic [2:0]  ALUControl
);
    always_comb begin
        case (ALUOp)
            2'b00: ALUControl = 3'b010;
            2'b01: ALUControl = 3'b110;
            2'b10: begin
                case (funct3)
                    3'b000: ALUControl = funct7b5 ? 3'b110 : 3'b010;
                    3'b111: ALUControl = 3'b000;
                    3'b110: ALUControl = 3'b001;
                    3'b100: ALUControl = 3'b111;
                    default: ALUControl = 3'b010;
                endcase
            end
            default: ALUControl = 3'b010;
        endcase
    end
endmodule
