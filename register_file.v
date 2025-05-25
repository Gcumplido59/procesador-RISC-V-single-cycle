module RegisterFile(
    input  logic        clk,
    input  logic        WE3,
    input  logic [4:0]  A1, A2, A3,
    input  logic [31:0] WD3,
    output logic [31:0] RD1, RD2
);
    logic [31:0] regs[0:31];
    assign RD1 = regs[A1];
    assign RD2 = regs[A2];
    always_ff @(posedge clk) begin
        if (WE3 && (A3 != 5'd0))
            regs[A3] <= WD3;
    end
endmodule
