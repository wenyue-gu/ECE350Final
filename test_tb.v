module test_tb;
    reg in1;
    wire o1;
    wire [4:0] score;

    test t(o1,score, in1);

    integer i;
    initial begin
        in1 = 1'b1;
        for (i = 0; i < 32; i = i + 1) begin
            in1 = ~in1;
            $display("o:%b, score:%b, in1:%b", o1,score,in1);
            #100;
        end
        $finish;
    end

endmodule
