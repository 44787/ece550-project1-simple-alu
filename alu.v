module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	wire symbol;
	assign symbol = ctrl_ALUopcode[0];
	
	wire [31:0] b_actual;
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin : select_b
			xor xor_b (b_actual[i], data_operandB[i], symbol);
		end
	endgenerate
	
	adder_32bit my_adder(
		.a(data_operandA),
      .b_actual(b_actual),
      .cin(symbol),
		.sum(data_result),
      .overflow(overflow)
	);
endmodule
