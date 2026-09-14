module rca_4bit(
	input [3:0]a,
	input [3:0]b,
	input cin,
	output [3:0]sum,
	output cout,
	output c_in  //examine overflow
);

wire w1;
wire w2;
wire w3;

FA my_fa1(a[0], b[0], cin, sum[0], w1);
FA my_fa2(a[1], b[1], w1, sum[1], w2);
FA my_fa3(a[2], b[2], w2, sum[2], w3);

assign c_in = w3;

FA my_fa4(a[3], b[3], w3, sum[3], cout);

endmodule