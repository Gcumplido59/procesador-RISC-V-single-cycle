module BranchComparator(
    input  [31:0] A,
    input  [31:0] B,
    output        eq,
    output        ne
);
    assign eq = (A == B);
    assign ne = (A != B);
endmodule
