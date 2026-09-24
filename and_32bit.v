module and_32bit(
    input [31:0] a, 
    input [31:0] b,
    output [31:0] res
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : and_32bit
            and my_and (res[i], a[i], b[i]);
        end
    endgenerate
endmodule