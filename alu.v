module alu(
    input  [31:0] A,
    input  [31:0] B,
    input  [2:0]  ALUControl,
    output [31:0] Result,
    output        Zero
);
    reg [31:0] res;
    always @(*) begin
        case (ALUControl)
            3'b000: res = A & B;
            3'b001: res = A | B;
            3'b010: res = A + B;
            3'b110: res = A - B;
            3'b111: res = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
            default: res = 32'd0;
        endcase
    end
    assign Result = res;
    assign Zero   = (res == 32'd0);
endmodule
