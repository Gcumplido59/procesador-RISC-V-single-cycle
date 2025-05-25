module DataMemory(
    input  logic        clk,
    input  logic        WE,
    input  logic [31:0] A,
    input  logic [31:0] WD,
    output logic [31:0] RD
);
    logic [31:0] mem [0:255];
    initial begin
        //$readmemh("data.mem", mem);
    end
    assign RD = mem[A[9:2]];
    always_ff @(posedge clk) if (WE) mem[A[9:2]] <= WD;
endmodule
