module FA(
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	
wire w1;
wire w2;
wire w3;

xor my_xor1(w1, a, b);
xor my_xor2(sum, w1, cin);
and my_and1(w2, cin, w1);
and my_and2(w3, a, b);
or  my_or1(cout, w2, w3);

endmodule