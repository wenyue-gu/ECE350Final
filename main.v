module main
(
	//TODO:
    // input clk,
    input in5,
    output reg o1,
    // input in1,

	output reg led0,
    output reg led1,
    output reg led2,
    output reg led3,
    output reg led4,
    output reg led5
);

    // Create the clock
	reg clk = 0;
	reg in1;
	always
		#10 clk = ~clk; 

	// TODO: change this 
    reg [2:0] score_to_add;
    wire write_status = (rwe_inst == 0 && score_to_add != 0);
    reg in1m;

    // Processor 
	wire rwe_actual, rwe_inst, mwe, reset;
	wire[4:0] rd_inst, rd_actual, rs1, rs2;
	wire[31:0] instAddr, instData, 
		rData_inst, rData_actual, regA, regB,
		memAddr, memDataIn, memDataOut, reg1, reg30;
        
    reg [31:0] was_writing;

	assign reset = in5;
    assign rwe_actual = write_status ? 1'd1 : rwe_inst;
	assign rd_actual = write_status ? 5'd30 : rd_inst;
	assign rData_actual = write_status ? score_to_add : rData_inst;

    // leds 
    integer clk_counter1, counter;

	// // ADD YOUR MEMORY FILE HERE
	// localparam INSTR_FILE = "";
	
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
		.data_writeReg(rData_actual), .data_readRegA(regA), .data_readRegB(regB), .data_score(reg1), .data_rstatus(reg30));

    wire [31:0] score_stored = reg1;
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clk), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut));


    initial begin
        clk_counter1 = 0;
		counter = 0;
		in1m = in1;
        o1 = 1'b1;
        score_to_add = 3'd0;
        led0 = 1'b0;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        led5 = 1'b0;

		// TODO:
		in1 = 1'd0;
    end

    always @(posedge clk) begin
		counter = counter + 1;

        if (write_status) begin
            was_writing = 1;
		end

		// TODO:
		if (clk_counter1 % 13 == 0) 
            in1 <= ~in1;

		$display("o1: %b, in1: %b, score_stored: %d, score_to_add: %d, write_status: %d, reg30: %d, rData_actual: %d, clk_counter: %d", o1, in1, score_stored, score_to_add, write_status, reg30, rData_actual, clk_counter1);
		if (counter ==100)  
			$finish;


		// led goes off after 1s if no hits 
       if (o1==1'b1 && clk_counter1 >= 10) begin
            clk_counter1 <= 0;
            o1 <= 1'b0;
		// led goes on after 0.5s	
        end else if(o1==1'b0 && clk_counter1 >= 15) begin
            clk_counter1 <= 0;
            o1 <= 1'b1;
        end

		// if pressing status changed & pressed & lights on
        if (in1 != in1m && in1==1'b0 && o1==1'b1) begin
            o1 = 1'b0;
            clk_counter1 = 0;
            score_to_add = score_to_add + 3'd1;
        end

        clk_counter1 <= clk_counter1 + 1;
        in1m = in1;

		if (score_stored % 6 == 3'd0)
            led0 <= 1'b1;
        else
            led0 <= 1'b0;
        if (score_stored % 6 == 3'd1)
            led1 <= 1'b1;
        else
            led1 <= 1'b0;
        if (score_stored % 6 == 3'd2)
            led2 <= 1'b1;
        else
            led2 <= 1'b0;
        if (score_stored % 6 == 3'd3)
            led3 <= 1'b1;
        else
            led3 <= 1'b0;
        if (score_stored % 6 == 3'd4)
            led4 <= 1'b1;
        else
            led4 <= 1'b0;
        if (score_stored % 6 == 3'd5)
            led5 <= 1'b1;
        else
            led5 <= 1'b0;

        if (was_writing) begin
			score_to_add = 0;
            was_writing = 0;
        end
    end

endmodule
