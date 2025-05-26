module register_file(
    input         clk,
    input  [4:0]  A1, A2, A3,
    input  [31:0] WD3,
    input         WE3,
    output [31:0] RD1, RD2
);
    reg [31:0] regs [0:31];
    assign RD1 = regs[A1];
    assign RD2 = regs[A2];
    always @(posedge clk)
        if (WE3 && (A3 != 5'd0))
            regs[A3] <= WD3;
endmodule
