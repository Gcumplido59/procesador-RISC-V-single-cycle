module data_memory(
    input         clk,
    input  [31:0] A,
    input  [31:0] WD,
    input         WE,
    output [31:0] RD
);
    reg [31:0] mem [0:255];
    assign RD = mem[A[9:2]];
    always @(posedge clk)
        if (WE)
            mem[A[9:2]] <= WD;
endmodule
