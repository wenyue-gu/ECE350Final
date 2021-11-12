module test (
    output reg o1,
    output [4:0] score,
    //output led1,
    input in1
    //input clk,
);
    initial 
        o1 = 1'b1;
    //assign led1 = in1;
    reg [4:0] score = 5'd0;
    always @(posedge in1) begin
        if (o1) begin
            o1 = 1'b0;
            score <= score + 5'd1;
            #100
            o1 = 1'b1;
        end
    end
endmodule