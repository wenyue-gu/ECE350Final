module dx_latch(out_pc, out_A, out_B, out_ir, in_pc, in_A, in_B, in_ir, in_enable, clock);
    output [31:0] out_pc, out_ir, out_A, out_B;
    input [31:0] in_pc, in_ir, in_A, in_B;
    input in_enable, clock;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop
            dffe_ref dpc0(out_pc[i], in_pc[i], clock, in_enable, 1'b0);
            dffe_ref dpc1(out_A[i], in_A[i], clock, in_enable, 1'b0);
            dffe_ref dpc2(out_B[i], in_B[i], clock, in_enable, 1'b0);
            dffe_ref dpr3(out_ir[i], in_ir[i], clock, in_enable, 1'b0);
        end
    endgenerate

endmodule