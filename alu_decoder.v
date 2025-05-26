module alu_decoder(
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input         funct7,
    output reg [2:0] ALUControl
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b010;
            2'b01: ALUControl = 3'b110;
            2'b10: case (funct3)
                3'b000: ALUControl = (funct7) ? 3'b110 : 3'b010;
                3'b111: ALUControl = 3'b000;
                3'b110: ALUControl = 3'b001;
                default: ALUControl = 3'b111;
            endcase
            default: ALUControl = 3'b010;
        endcase
    end
endmodule
