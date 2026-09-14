module csa_4bit (
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout,
    output c_in,
    output c_out
);
    wire [3:0] sum0, sum1;
    wire cout0, cout1;
    wire c_in0, c_in1;

    rca_4bit rca0 (
        .a(a),
        .b(b),
        .cin(1'b0),
        .sum(sum0),
        .cout(cout0),
        .c_in(c_in0)
    );
	 
	 rca_4bit rca1 (
        .a(a),
        .b(b),
        .cin(1'b1),
        .sum(sum1),
        .cout(cout1),
        .c_in(c_in1)
    );

    assign sum       = cin ? sum1 : sum0;
    assign cout      = cin ? cout1 : cout0;
    assign c_in  = cin ? c_in1 : c_in0;
    assign c_out = cout;

endmodule