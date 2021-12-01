module main
(
    input clk,
    input in5,
    output reg o1,
    input in1,

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
            
    reg was_writing;
    // Create the clock
	// reg clk = 0;
	// reg in1;
	// always
	// 	#10 clk = ~clk; 

	// TODO: change this 
    (* mark_debug = "true" *) reg [31:0] score_to_add;
    (* mark_debug = "true" *) wire write_status = (rwe_inst == 0 && score_stored != 0);
    // wire write_status = (rwe_inst == 0 && score_to_add != 0 && was_writing == 0);
    (* mark_debug = "true" *) reg in1m;

    // Processor 
	(* mark_debug = "true" *) wire rwe_actual, rwe_inst, mwe, reset;
	wire[4:0] rd_inst, rd_actual, rs1, rs2;
	wire[31:0] instAddr, instData, 
		rData_inst, rData_actual, regA, regB,
		memAddr, memDataIn, memDataOut;
    (* mark_debug = "true" *) wire [31:0] score_stored, reg30;
    

	assign reset = 1'd0;
    assign rwe_actual = write_status ? 1'd1 : rwe_inst;
	assign rd_actual = write_status ? 5'd30 : rd_inst;
	assign rData_actual = write_status ? score_to_add : rData_inst;

    // leds 
    integer clk_counter1, counter;
	
	// Main Processing Unit
	processor CPU(.clock(clk), .reset(reset), 
								
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
	InstMem(.clk(clk), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
	// Register File
	regfile RegisterFile(.clock(clk), 
		.ctrl_writeEnable(rwe_actual), .ctrl_reset(reset), 
		.ctrl_writeReg(rd_actual),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData_actual), .data_readRegA(regA), .data_readRegB(regB), .data_score(score_stored), .data_rstatus(reg30));

						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clk), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut));


    initial begin
        clk_counter1 = 0;
		// counter = 0;
		in1m = in1;
        o1 = 1'b1;
        score_to_add = 32'd0;
        led0 = 1'b0;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        led5 = 1'b0;
        was_writing = 1'b0;

        $dumpfile("./output.vcd");
		// Module to capture and what level, 0 means all wires
		$dumpvars(0, main);

		// TODO:
		// in1 = 1'd0;
    end

    always @(posedge clk) begin
		// counter = counter + 1;

        // if (was_writing) begin
		// 	score_to_add = 0;
        //     was_writing <= 0;
        // end


		// // TODO:
		// if (clk_counter1 % 2 == 0) 
        //     in1 <= ~in1;

		$display("o1: %b, in1: %b, score_stored: %d, score_to_add: %d, write_status: %d, reg30: %d, rData_actual: %d, clk_counter: %d", o1, in1, score_stored, score_to_add, write_status, reg30, rData_actual, clk_counter1);
		// if (counter == 100)  
		// 	$finish;

		// led goes off after 1s if no hits 
       if (o1==1'b1 && clk_counter1 >= 100000000) begin
            clk_counter1 <= 0;
            o1 <= 1'b0;
		// led goes on after 2s	
        end else if(o1==1'b0 && clk_counter1 >= 100000000) begin
            clk_counter1 <= 0;
            o1 <= 1'b1;
        end

		// if pressing status changed & pressed & lights on
        if (in1 != in1m && in1==1'b0 && o1==1'b1) begin
            o1 <= 1'b0;
            clk_counter1 <= 0;
            score_to_add = score_to_add + 32'd1;
        end

        clk_counter1 <= clk_counter1 + 1;
        in1m = in1;

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

        // if (write_status) begin
        //     was_writing <= 1;
		// end
    end

endmodule
