module test (
    output reg o1,
    input in1,
    output reg o2,
    input in2,
    output reg o3,
    input in3,
    output reg o4,
    input in4,
    output reg o5,
    input in5,

    input clk,

    output reg led0,
    output reg led1,
    output reg led2,
    output reg led3,
    output reg led4,
    output reg led5,
    output reg led15,


	input reset, 		// Reset Signal
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,  // Blue Signal Bits
	inout ps2_clk,
	inout ps2_data
    );
    
    reg[31:0] miss;
    reg[31:0] score;
    reg ingame;
    integer counter1;
    integer counter2;
    integer counter3;
    integer counter4;
    reg in1m;
    reg in2m;
    reg in3m;
    reg in4m;

    initial begin
        counter1 = 0;
        counter2 = 0;
        counter3 = 0;
        counter4 = 0;
        in1m = in1;
        in2m = in2;
        in3m = in3;
        in4m = in4;
        o1 = 1'b1;
        o2 = 1'b1;
        o3 = 1'b1;
        o4 = 1'b1;
        o5 = 1'b1;
        ingame = 1'b0;
        score = 3'd0;
        led0 = 1'b0;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        led5 = 1'b0;
        led15 = 1'b0;
    end 

// 100 000000 - 1s
    always @(posedge clk) begin
        if (ingame==1'b1) begin

            //button 1
            if (o1==1'b1 && counter1 >= 50000000) begin
                counter1 <= 0;
                o1 <= 1'b0;
            end else if(o1==1'b0 && counter1 >= 250000000) begin
                counter1 <= 0;
                o1 <= 1'b1;
            end
            if (in1 != in1m && in1==1'b0 && o1==1'b1) begin
                o1=1'b0;
                counter1=0;
                score <= score + 3'd1;
            end
            
            //button 2
            if (o2==1'b1 && counter2 >= 50000000) begin
                counter2 <= 0;
                o2 <= 1'b0;
            end else if(o2==1'b0 && counter2 >= 350000000) begin
                counter2 <= 0;
                o2 <= 1'b1;
            end
            if (in2 != in2m && in2==1'b0 && o2==1'b1) begin
                o2=1'b0;
                counter2=0;
                score <= score + 3'd1;
            end

            //button 3
            if (o3==1'b1 && counter3 >= 50000000) begin
                counter3 <= 0;
                o3 <= 1'b0;
            end else if(o3==1'b0 && counter3 >= 400000000) begin
                counter3 <= 0;
                o3 <= 1'b1;
            end
            if (in3 != in3m && in3==1'b0 && o3==1'b1) begin
                o3=1'b0;
                counter3=0;
                score <= score + 3'd1;
            end

            //button 4
            if (o4==1'b1 && counter4 >= 50000000) begin
                counter4 <= 0;
                o4 <= 1'b0;
            end else if(o4==1'b0 && counter4 >= 350000000) begin
                counter4 <= 0;
                o4 <= 1'b1;
            end
            if (in4 != in4m && in4==1'b0 && o4==1'b1) begin
                o4=1'b0;
                counter4=0;
                score <= score + 3'd1;
            end

            //end game
            if(miss >= 10) begin
                ingame <= 1'b0;
                score <= 32'b0;
                o1 = 1'b1;
                o2 = 1'b1;
                o3 = 1'b1;
                o4 = 1'b1;
                o5 = 1'b1;
            end

            //increment counters
            counter1 = counter1 + 1;
            in1m = in1;
            counter2 = counter2 + 1;
            in2m = in2;
            counter3 = counter3 + 1;
            in3m = in3;
            counter4 = counter4 + 1;
            in4m = in4;


            //use led to display score
            VGAController VGA(score,clk,reset, hSync, vSync,VGA_R,VGA_G, VGA_B,ps2_clk,ps2_data);

            if (score % 6 == 32'd0)
                led0 <= 1'b1;
            else
                led0 <= 1'b0;
            if (score % 6 == 32'd1)
                led1 <= 1'b1;
            else
                led1 <= 1'b0;
            if (score % 6 == 32'd2)
                led2 <= 1'b1;
            else
                led2 <= 1'b0;
            if (score % 6 == 32'd3)
                led3 <= 1'b1;
            else
                led3 <= 1'b0;
            if (score % 6 == 32'd4)
                led4 <= 1'b1;
            else
                led4 <= 1'b0;
            if (score % 6 == 32'd5)
                led5 <= 1'b1;
            else
                led5 <= 1'b0;
        end else begin
            //button 5 (start game)
            if (in5==1'b0) begin
                ingame <= 1'b1;
                o1 = 1'b0;
                o2 = 1'b0;
                o3 = 1'b0;
                o4 = 1'b0;
                o5 = 1'b0;
            end
        end
    end
endmodule
