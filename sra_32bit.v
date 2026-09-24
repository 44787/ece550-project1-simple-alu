module sra_32bit(
    input [31:0] a, 
    input [4:0] ctrl_shiftamt,
    output [31:0] res
);

    wire [31:0] res_by_1, res_by_2, res_by_4, res_by_8, res_by_16;
    wire [31:0] sra_by_1, sra_by_2, sra_by_4, sra_by_8;
    
    genvar i;

    generate
        // right by 1
        for (i = 0; i < 32; i = i + 1) begin : sra_1bit
            if (i > 30) begin
                assign res_by_1[i] = a[31]; // sra remains the sign bit
            end else begin
                assign res_by_1[i] = a[i + 1];
            end
        end

        // right by 2
        for (i = 0; i < 32; i = i + 1) begin : sra_2bit
            if (i > 29) begin
                assign res_by_2[i] = sra_by_1[31];
            end else begin
                assign res_by_2[i] = sra_by_1[i + 2];
            end
        end
        
        // right by 4
        for (i = 0; i < 32; i = i + 1) begin : sra_4bit
            if (i > 27) begin
                assign res_by_4[i] = sra_by_2[31];
            end else begin
                assign res_by_4[i] = sra_by_2[i + 4];
            end
        end

        // right by 8
        for (i = 0; i < 32; i = i + 1) begin : sra_8bit
            if (i > 23) begin
                assign res_by_8[i] = sra_by_4[31];
            end else begin
                assign res_by_8[i] = sra_by_4[i + 8];
            end
        end
        
        // right by 16
        for (i = 0; i < 32; i = i + 1) begin : sra_16bit
            if (i > 15) begin
                assign res_by_16[i] = sra_by_8[31];
            end else begin
                assign res_by_16[i] = sra_by_8[i + 16];
            end
        end
    endgenerate
    
    // mux
    wire en_1 = ctrl_shiftamt[0];
    wire en_2 = ctrl_shiftamt[1];
    wire en_4 = ctrl_shiftamt[2];
    wire en_8 = ctrl_shiftamt[3];
    wire en_16 = ctrl_shiftamt[4];
    
    assign sra_by_1 = en_1 ? res_by_1 : a;
    assign sra_by_2 = en_2 ? res_by_2 : sra_by_1;
    assign sra_by_4 = en_4 ? res_by_4 : sra_by_2;
    assign sra_by_8 = en_8 ? res_by_8 : sra_by_4;
    assign res = en_16 ? res_by_16 : sra_by_8;

endmodule