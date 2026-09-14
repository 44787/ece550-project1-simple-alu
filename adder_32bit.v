module adder_32bit(
	input [31:0] a, 
	input [31:0] b_actual,
   input cin,
	output [31:0] sum,
   output overflow
);

	wire [7:0] w;
	wire c_in, c_out;
	//first rca
	rca_4bit my_adder0(
		.a(a[3:0]),
      .b(b_actual[3:0]),
      .cin(cin),
      .sum(sum[3:0]),
      .cout(w[0]),
		.c_in()
   );
	
	//7 csa
	csa_4bit my_adder1(
		.a(a[7:4]),
      .b(b_actual[7:4]),
      .cin(w[0]),
      .sum(sum[7:4]),
      .cout(w[1]),
		.c_in(),
		.c_out()
	);
	
	csa_4bit my_adder2(
		.a(a[11:8]),
      .b(b_actual[11:8]),
      .cin(w[1]),
      .sum(sum[11:8]),
      .cout(w[2]),
		.c_in(),
		.c_out()
	);
	
	csa_4bit my_adder3(
		.a(a[15:12]),
      .b(b_actual[15:12]),
      .cin(w[2]),
      .sum(sum[15:12]),
      .cout(w[3]),
		.c_in(),
		.c_out()
	);
	
	csa_4bit my_adder4(
		.a(a[19:16]),
      .b(b_actual[19:16]),
      .cin(w[3]),
      .sum(sum[19:16]),
      .cout(w[4]),
		.c_in(),
		.c_out()
	);
	
	csa_4bit my_adder5(
		.a(a[23:20]),
      .b(b_actual[23:20]),
      .cin(w[4]),
      .sum(sum[23:20]),
      .cout(w[5]),
		.c_in(),
		.c_out()
	);
	
	csa_4bit my_adder6(
		.a(a[27:24]),
      .b(b_actual[27:24]),
      .cin(w[5]),
      .sum(sum[27:24]),
      .cout(w[6]),
		.c_in(),
		.c_out()
	);
	
	//last csa
	csa_4bit my_adder7(
		.a(a[31:28]),
      .b(b_actual[31:28]),
      .cin(w[6]),
      .sum(sum[31:28]),
      .cout(w[7]),
		.c_in(c_in),
		.c_out(c_out)
	);
	
	xor my_xor(overflow, c_in, c_out);

endmodule
	