module test (
    output reg o1,
    
    input in1,
    input clk,

    output reg led0,
    output reg led1,
    output reg led2,
    output reg led3,
    output reg led4,
    output reg led5,
    output reg led15
);
    reg[2:0] score;
    integer counter;
    reg in1m;

    initial begin
        counter = 0;
        o1 = 1'b1;
        score = 3'd0;
        led0 = 1'b0;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        led5 = 1'b0;
        led15 = 1'b0;
    end 

//    always @(posedge in1) begin
//        if (o1) begin
//            o1 <= 1'b0;
//            counter = 0;
//            score <= score + 3'd1;
//        end
//    end

    always @(posedge clk) begin
       
       if (counter >= 50000000) begin
           counter <= 0;
           o1 <= !o1;
           end
       else
       counter = counter + 1;
       if (in1 != in1m && in1==1'b0 && o1==1'b1) begin
            o1=1'b0;
            counter=0;
            score <= score + 3'd1;
        end
        
        if (score % 6 == 3'd0)
            led0 <= 1'b1;
        else
            led0 <= 1'b0;
        if (score % 6 == 3'd1)
            led1 <= 1'b1;
        else
            led1 <= 1'b0;
        if (score % 6 == 3'd2)
            led2 <= 1'b1;
        else
            led2 <= 1'b0;
        if (score % 6 == 3'd3)
            led3 <= 1'b1;
        else
            led3 <= 1'b0;
        if (score % 6 == 3'd4)
            led4 <= 1'b1;
        else
            led4 <= 1'b0;
        if (score % 6 == 3'd5)
            led5 <= 1'b1;
        else
            led5 <= 1'b0;
        in1=in1m;
    end
endmodule
