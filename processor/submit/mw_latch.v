module mw_latch(out_ir, out_O, out_D, in_ir, in_O, in_D, in_enable, clock);
    output [31:0] out_ir, out_O, out_D;
    input [31:0] in_ir, in_O, in_D;
    input in_enable, clock;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop
            dffe_ref dpr0(out_ir[i], in_ir[i], clock, in_enable, 1'b0);
            dffe_ref dpc1(out_O[i], in_O[i], clock, in_enable, 1'b0);
            dffe_ref dpc2(out_D[i], in_D[i], clock, in_enable, 1'b0);
        end
    endgenerate

endmodule