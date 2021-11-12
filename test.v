`timescale 1s/1s
module test (
    output reg o1,
    
    input in1,
    input clk,

    output reg led0,
    output reg led1,
    output reg led2,
    output reg led3,
    output reg led4,
    output reg led5
);
    reg[2:0] score;
    initial begin
        o1 = 1'b1;
        score = 3'd0;
        led0 = 1'b0;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        led5 = 1'b0;
    end 

    always @(posedge in1) begin
        if (o1) begin
            o1 = 1'b0;
            score <= score + 3'd1;
            #1
            o1 = 1'b1;
        end
    end

    always @(posedge clk) begin
        if (score == 3'd0)
            led0 <= 1'b1;
        if (score == 3'd1)
            led1 <= 1'b1;
        if (score == 3'd2)
            led2 <= 1'b1;
        if (score == 3'd3)
            led3 <= 1'b1;
        if (score == 3'd4)
            led4 <= 1'b1;
        if (score == 3'd5)
            led5 <= 1'b1;
    end
endmodule