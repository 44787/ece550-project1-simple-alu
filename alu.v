module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

	input [31:0] data_operandA, data_operandB;
	input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

	output [31:0] data_result;
	output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	// decoder
	wire state2 = ctrl_ALUopcode[2];
	wire state1 = ctrl_ALUopcode[1];
	wire state0 = ctrl_ALUopcode[0];
	
	wire not_state2, not_state1, not_state0;
   not mynot2 (not_state2, state2);
   not mynot1 (not_state1, state1);
   not mynot0 (not_state0, state0);
	
	// and 010
	wire not_state2_and_state1, en_and;
	and myandnot2_1 (not_state2_and_state1, not_state2, state1);
	and myand1_1not1 (en_and, not_state2_and_state1, not_state0);
	
	// or 011
	wire en_or;
	and myand2_11 (en_or, not_state2_and_state1, state0);
	
	// sll 100
	wire state2_and_not_state1, en_sll;
	and myand2_not1 (state2_and_not_state1, state2, not_state1);
	and myand3_1not1 (en_sll, state2_and_not_state1, not_state0);
	
	// sra 101
	wire en_sra;
	and myand4_11 (en_sra, state2_and_not_state1, state0);
	
	wire [31:0] add_sub_res;
	wire [31:0] and_res;
	wire [31:0] or_res;
	wire [31:0] sll_res;
	wire [31:0] sra_res;
	
	
	// adder and subtract
	wire [31:0] b_actual;
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin : select_b
			xor xor_b (b_actual[i], data_operandB[i], state0);
		end
	endgenerate
	
	adder_32bit my_adder(
		.a(data_operandA),
		.b_actual(b_actual),
		.cin(state0),
		.sum(add_sub_res),
		.overflow(overflow),
		.isNotEqual(isNotEqual),
		.isLessThan(isLessThan)
	);
	
	// and
	and_32bit my_and(
		.a(data_operandA),
		.b(data_operandB),
		.res(and_res)
	);
	
	// or
	or_32bit my_or(
		.a(data_operandA),
		.b(data_operandB),
		.res(or_res)
	);
	
	// sll
	sll_32bit my_sll(
		.a(data_operandA),
		.ctrl_shiftamt(ctrl_shiftamt),
		.res(sll_res)
	);
	
	// sra
	sra_32bit my_sra(
		.a(data_operandA),
		.ctrl_shiftamt(ctrl_shiftamt),
		.res(sra_res)
	);
	
	

	//mux
	wire [31:0] mux_sra_addsub;
   wire [31:0] mux_sll_sra_addsub;
   wire [31:0] mux_or_sll_sra_addsub;
	
	assign mux_sra_addsub = en_sra ? sra_res : add_sub_res;
	assign mux_sll_sra_addsub = en_sll ? sll_res : mux_sra_addsub;
	assign mux_or_sll_sra_addsub = en_or ? or_res : mux_sll_sra_addsub;
	assign data_result = en_and ? and_res : mux_or_sll_sra_addsub;
	
	
endmodule
