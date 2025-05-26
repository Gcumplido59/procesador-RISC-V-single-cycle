module extend(
    input  [31:0] extend_in,
    input  [1:0]  immsrc,
    output [31:0] imm_ext
);
    reg [11:0] aux_extend;
    always @(*) begin
        case (immsrc)
            2'b00: aux_extend = extend_in[31:20];
            2'b01: aux_extend = {extend_in[31:25], extend_in[11:7]};
            2'b10: aux_extend = {extend_in[31], extend_in[7], extend_in[30:25], extend_in[11:8]};
            2'b11: aux_extend = {extend_in[31], extend_in[19:12], extend_in[20], extend_in[30:21]};
            default: aux_extend = 12'd0;
        endcase
    end
    assign imm_ext = {{20{aux_extend[11]}}, aux_extend};
endmodule
