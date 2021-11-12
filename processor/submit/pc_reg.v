module pc_reg (
    out, in, 
    clk, in_enable, reset
);

    input [31:0] in;
    input clk, in_enable, reset;
    output [31:0] out;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop
            dffe_ref pc(out[i], in[i], clk, in_enable, reset);
        end
    endgenerate
endmodule