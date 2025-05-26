module instruction_memory(
    input  [31:0] A,
    output [31:0] RD
);
    reg [31:0] mem [0:255];
    initial
        $readmemh("program.mem", mem);
    assign RD = mem[A[9:2]];
endmodule
