module sll_32bit(
	input [31:0] a, 
	input [4:0] ctrl_shiftamt,
	output [31:0] res
);

	wire [31:0] res_by_1, res_by_2, res_by_4, res_by_8, res_by_16;
	wire [31:0] sll_by_1, sll_by_2, sll_by_4, sll_by_8;
	
	genvar i;

	generate
		//left by 1
		for (i = 0; i < 32; i = i + 1) begin : sll_1bit
			 if (i < 1) begin
				  assign res_by_1[i] = 1'b0;
			 end else begin
				  assign res_by_1[i] = a[i - 1];
			 end
		end

		// left by 2
		for (i = 0; i < 32; i = i + 1) begin : sll_2bit
          if (i < 2) begin
              assign res_by_2[i] = 1'b0;
          end else begin
				  assign res_by_2[i] = sll_by_1[i - 2];
          end
		end

		// left by 4
		for (i = 0; i < 32; i = i + 1) begin : sll_4bit
          if (i < 4) begin
              assign res_by_4[i] = 1'b0;
          end else begin
              assign res_by_4[i] = sll_by_2[i - 4];
          end
		end

      // left by 8
	   for (i = 0; i < 32; i = i + 1) begin : sll_8bit
          if (i < 8) begin
              assign res_by_8[i] = 1'b0;
          end else begin
              assign res_by_8[i] = sll_by_4[i - 8];
          end
      end
		
      // left by 16
	   for (i = 0; i < 32; i = i + 1) begin : sll_16bit
          if (i < 16) begin
              assign res_by_16[i] = 1'b0;
          end else begin
              assign res_by_16[i] = sll_by_8[i - 16];
          end
      end
	endgenerate
	
	// mux
	wire en_1 = ctrl_shiftamt[0];
	wire en_2 = ctrl_shiftamt[1];
	wire en_4 = ctrl_shiftamt[2];
	wire en_8 = ctrl_shiftamt[3];
	wire en_16 = ctrl_shiftamt[4];
	
	assign sll_by_1 = en_1 ? res_by_1 : a;
	assign sll_by_2 = en_2 ? res_by_2 : sll_by_1;
	assign sll_by_4 = en_4 ? res_by_4 : sll_by_2;
	assign sll_by_8 = en_8 ? res_by_8 : sll_by_4;
	assign res = en_16 ? res_by_16 : sll_by_8;

endmodule