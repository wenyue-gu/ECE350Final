module test (
    input clk,

    output reg o1,
    output reg o2,
    output reg o3,
    output reg o4,

    input in1,
    input in2,
    input in3,
    input in4,

	input reset, 		// Reset Signal
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,  // Blue Signal Bits
	inout ps2_clk,
	inout ps2_data,

    output reg led0,
    output reg led1,
    output reg led2,
    output reg led3,
    output reg led4,
    output reg led5,
    output reg led6,
    output reg led7,
    output reg led8,
    output reg led9,
    output reg led10,
    output reg led11

    );

    reg[31:0] score;
    reg ingame;
    integer counter1, endgameCounter;
    integer counter2;
    integer counter3;
    integer counter4;
    reg in1m;
    reg in2m;
    reg in3m;
    reg in4m;
    reg in5m;

    wire clk25; 

	reg[1:0] processorCounter = 0; 
    assign clk25 = processorCounter[1];

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
        ingame = 1'b1;
        score = 32'd0;
        led0 = 1'b0;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        endgameCounter = 1'b0;
    end 

    always @(posedge clk) begin
        processorCounter <= processorCounter + 1;
    end

    always @(posedge clk25) begin
        if (ingame==1'b1) begin

            //button 1
            if (o1==1'b1 && counter1 >= 20000000) begin
                counter1 = 0;
                o1 <= 1'b0;
                if (score > 32'd0)
                    score <= score - 32'd1;

            end else if(o1==1'b0 && counter1 >= 25000000) begin
                counter1 = 0;
                o1 <= 1'b1;
            end
            if (in1 != in1m && in1==1'b0 && o1==1'b1) begin
                o1 = 1'b0;
                counter1 = 0;
                score = score + 32'd1;
            end
                
            //increment counters
            counter1 <= counter1 + 1;

                //end 
            if(score >= 32'd12) begin
                ingame <= 1'b0;
            end


            //use led to display score

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
        end 
        
        //button 5 (start game)
        else begin
            o1 <= 1'b1;
            endgameCounter <= endgameCounter + 1;

            if (in1 == 1'b0 && in1 != in1m && endgameCounter > 1000) begin
                ingame <= 1'b1;
                score <= 32'd3;
                o1 <= 1'b0;
                endgameCounter <= 0;
            end
            
        end
        in1m = in1;

    end

    VGAController VGA(ingame, score, clk25, reset, hSync, vSync, VGA_R, VGA_G, VGA_B, ps2_clk, ps2_data);

endmodule
