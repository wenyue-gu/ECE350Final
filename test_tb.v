module test_tb;
    reg in1;
    wire o1;
    reg clk;
    wire led0, led1,led2,led3,led4,led5;
    wire [3:0] counter;

    test t(o1, in1, clk, led0, led1,led2,led3,led4,led5);

    integer i;
    initial begin
        in1 = 1'b1;
        clk=1'b0;
        for (i = 0; i < 32; i = i + 1) begin
            in1 = ~in1;
            clk=~clk;
            $display(" o:%b, in1:%b,  led0:%b,  led1:%b,  led2:%b,  led3:%b,  led4:%b,  led5:%b",o1,in1,led0, led1,led2,led3,led4,led5);
            clk=~clk;
            #100;
        end
        $finish;
    end

endmodule
