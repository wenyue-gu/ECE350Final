module fd_latch(out_pc, out_ir, in_pc, in_ir, in_enable, clock);
    output [31:0] out_pc, out_ir;
    input [31:0] in_pc, in_ir;
    input in_enable, clock;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop
            dffe_ref dpc0(out_pc[i], in_pc[i], clock, in_enable, 1'b0);
            dffe_ref dpr1(out_ir[i], in_ir[i], clock, in_enable, 1'b0);
        end
    endgenerate

endmodule