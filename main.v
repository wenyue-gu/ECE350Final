module main
(
    input clk,

    output reg o1,
    output reg o2,
    output reg o3,
    output reg o4,

    input in1,
    input in2,
    input in3,
    input in4,

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
            
    (* mark_debug = "true" *) reg was_writing;
    (* mark_debug = "true" *) reg [31:0] score_to_add;
    (* mark_debug = "true" *) wire write_status = (rwe_inst == 1'd0 && score_to_add != 32'd0 && was_writing == 1'd0);
    (* mark_debug = "true" *) reg in1m, in2m, in3m, in4m;

    // Processor 
    wire reset, mwe;
    wire[4:0] rs1, rs2;
	wire[31:0] instAddr, instData, regA, regB,
		memAddr, memDataIn, memDataOut;
	(* mark_debug = "true" *) wire rwe_actual, rwe_inst;
	(* mark_debug = "true" *) wire[4:0] rd_inst, rd_actual;
    (* mark_debug = "true" *) wire [31:0] score_stored, reg30, rData_inst, rData_actual;
    
	assign reset = 1'b0;
    assign rwe_actual = write_status ? 1'd1 : rwe_inst;
	assign rd_actual = write_status ? 5'd30 : rd_inst;
	assign rData_actual = write_status ? score_to_add : rData_inst;

    // leds 
    integer clk_counter1;
    integer clk_counter2;
    integer clk_counter3;
    integer clk_counter4;
    
    wire clk25; 

	reg[1:0] processorCounter = 0; 
    assign clk25 = processorCounter[1];
	
	// Main Processing Unit
	processor CPU(.clock(clk25), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe_inst),     .ctrl_writeReg(rd_inst),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData_inst), .data_readRegA(regA), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({"main", ".mem"}))
	InstMem(.clk(clk25), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
	// Register File
	regfile RegisterFile(.clock(clk25), 
		.ctrl_writeEnable(rwe_actual), .ctrl_reset(reset), 
		.ctrl_writeReg(rd_actual),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData_actual), .data_readRegA(regA), .data_readRegB(regB), .data_score(score_stored), .data_rstatus(reg30));

						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clk25), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut));

    initial begin
        clk_counter1 = 0;
        clk_counter2 = 0;
        clk_counter3 = 0;
        clk_counter4 = 0;

        o1 = 1'b1;
        o2 = 1'b1;
        o3 = 1'b1;
        o4 = 1'b1;

		in1m = in1;
		in2m = in2;
		in3m = in3;
		in4m = in4;

        score_to_add = 32'd0;
        led0 = 1'b0;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        led5 = 1'b0;
        was_writing = 1'b0;

    end

    always @(posedge clk) begin
        processorCounter <= processorCounter + 1;
    end

    always @(posedge clk25) begin
      if (was_writing) begin
			score_to_add = 32'd0;
            was_writing <= 1'b0;
        end

		// led goes off after 1s if no hits 
       if (o1 == 1'b1 && clk_counter1 >= 25000000) begin
            clk_counter1 = 0;
            o1 <= 1'b0;
		// led goes on after 1s	
        end else if(o1 == 1'b0 && clk_counter1 >= 25000000) begin
            clk_counter1 = 0;
            o1 <= 1'b1;
        end

        // led goes off after 1s if no hits 
       if (o2 == 1'b1 && clk_counter2 >= 50000000) begin
            clk_counter2 = 0;
            o2 <= 1'b0;
		// led goes on after 1s	
        end else if(o2 == 1'b0 && clk_counter2 >= 25000000) begin
            clk_counter2 = 0;
            o2 <= 1'b1;
        end

        // led goes off after 1s if no hits 
       if (o3 == 1'b1 && clk_counter3 >= 20000000) begin
            clk_counter3 = 0;
            o3 <= 1'b0;
		// led goes on after 1s	
        end else if(o3 == 1'b0 && clk_counter3 >= 10000000) begin
            clk_counter3 = 0;
            o3 <= 1'b1;
        end

        // led goes off after 1s if no hits 
       if (o4 == 1'b1 && clk_counter4 >= 30000000) begin
            clk_counter4 = 0;
            o4 <= 1'b0;
		// led goes on after 1s	
        end else if(o4 == 1'b0 && clk_counter4 >= 25000000) begin
            clk_counter4 = 0;
            o4 <= 1'b1;
        end

		// if pressing status changed & pressed & lights on
        if (in1 != in1m && in1 == 1'b0 && o1 == 1'b1) begin
            o1 <= 1'b0;
            clk_counter1 = 0;
            score_to_add = score_to_add + 32'd1;
        end

        if (in2 != in2m && in2 == 1'b0 && o2 == 1'b1) begin
            o2 <= 1'b0;
            clk_counter2 = 0;
            score_to_add = score_to_add + 32'd1;
        end

        if (in3 != in3m && in3 == 1'b0 && o3 == 1'b1) begin
            o3 <= 1'b0;
            clk_counter3 = 0;
            score_to_add = score_to_add + 32'd1;
        end

        
        if (in4 != in4m && in4 == 1'b0 && o4 == 1'b1) begin
            o4 <= 1'b0;
            clk_counter4 = 0;
            score_to_add = score_to_add + 32'd1;
        end


        clk_counter1 <= clk_counter1 + 1;
        clk_counter2 <= clk_counter2 + 1;
        clk_counter3 <= clk_counter3 + 1;
        clk_counter4 <= clk_counter4 + 1;
        
        in1m = in1;
        in2m = in2;
        in3m = in3;
        in4m = in4;

		if (score_stored % 6 == 32'd0)
            led0 <= 1'b1;
        else
            led0 <= 1'b0;
        if (score_stored % 6 == 32'd1)
            led1 <= 1'b1;
        else
            led1 <= 1'b0;
        if (score_stored % 6 == 32'd2)
            led2 <= 1'b1;
        else
            led2 <= 1'b0;
        if (score_stored % 6 == 32'd3)
            led3 <= 1'b1;
        else
            led3 <= 1'b0;
        if (score_stored % 6 == 32'd4)
            led4 <= 1'b1;
        else
            led4 <= 1'b0;
        if (score_stored % 6 == 32'd5)
            led5 <= 1'b1;
        else
            led5 <= 1'b0;


        if (score_to_add % 6 == 32'd0)
            led6 <= 1'b1;
        else
            led6 <= 1'b0;
        if (score_to_add % 6 == 32'd1)
            led7 <= 1'b1;
        else
            led7 <= 1'b0;
        if (score_to_add % 6 == 32'd2)
            led8 <= 1'b1;
        else
            led8 <= 1'b0;
        if (score_to_add % 6 == 32'd3)
            led9 <= 1'b1;
        else
            led9 <= 1'b0;
        if (score_to_add % 6 == 32'd4)
            led10 <= 1'b1;
        else
            led10 <= 1'b0;
        if (score_to_add % 6 == 32'd5)
            led11 <= 1'b1;
        else
            led11 <= 1'b0;

        if (write_status) begin
            was_writing <= 1;
		end
    end

endmodule
