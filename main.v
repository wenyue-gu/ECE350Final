module main
(
    input clk,

    output reg o1,
    output reg o2,
    output reg o3,
    output reg o4,
    output reg o5,

    input in1,
    input in2,
    input in3,
    input in4,
    input in5,

	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,  // Blue Signal Bits
	inout ps2_clk,
	inout ps2_data,

    output       chSel,		// Channel select; 0 for rising edge, 1 for falling edge
    output       audioOut,	// PWM signal to the audio jack	
    output       audioEn	// Audio Enable
);

    reg hit;
            
    (* mark_debug = "true" *) reg was_writing;
    (* mark_debug = "true" *) reg [31:0] score_to_add;
    (* mark_debug = "true" *) wire write_status = (rwe_inst == 1'd0 && score_to_add != 32'd0 && was_writing == 1'd0);
    (* mark_debug = "true" *) reg in1m, in2m, in3m, in4m, in5m;

    // Processor 
    wire mwe;
    reg reset;
    wire[4:0] rs1, rs2;
	wire[31:0] instAddr, instData, regA, regB,
		memAddr, memDataIn, memDataOut;
	(* mark_debug = "true" *) wire rwe_actual, rwe_inst;
	(* mark_debug = "true" *) wire[4:0] rd_inst, rd_actual;
    (* mark_debug = "true" *) wire [31:0] score_stored, reg30, rData_inst, rData_actual;
    
    assign rwe_actual = write_status ? 1'd1 : rwe_inst;
	assign rd_actual = write_status ? 5'd30 : rd_inst;
	assign rData_actual = write_status ? score_to_add : rData_inst;

    integer clk_counter1, clk_counter2, clk_counter3, clk_counter4, endgameCounter;
    wire clk25; 
    reg ingame;

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
        ingame = 1'b1;

        o1 = 1'b1;
        o2 = 1'b1;
        o3 = 1'b1;
        o4 = 1'b1;
        o5 = 1'b0;

		in1m = in1;
		in2m = in2;
		in3m = in3;
		in4m = in4;
		in5m = in5;

        score_to_add = 32'd0;
        reset = 1'b0;
    end

    always @(posedge clk) begin
        processorCounter <= processorCounter + 1;
    end

    always @(posedge clk25) begin
        if (reset) begin
            reset <= 1'b0;
        end
        else begin
            
            if (ingame==1'b1) begin
                if (was_writing) begin
                        score_to_add = 32'd0;
                        was_writing <= 1'b0;
                    end

                    // led goes off after 1s if no hits 
                if (o1 == 1'b1 && clk_counter1 >= 25000000) begin
                        clk_counter1 = 0;
                        o1 <= 1'b0;

                        if (score_stored + score_to_add > 32'd0) begin
                            score_to_add = score_to_add - 1;
                        end
                    // led goes on after 1s	
                    end else if(o1 == 1'b0 && clk_counter1 >= 75000000) begin
                        clk_counter1 = 0;
                        o1 <= 1'b1;
                    end

                    // led goes off after 1s if no hits 
                if (o2 == 1'b1 && clk_counter2 >= 25000000) begin
                        clk_counter2 = 0;
                        o2 <= 1'b0;

                        if (score_stored + score_to_add > 32'd0) begin
                            score_to_add = score_to_add - 1;
                        end
                    // led goes on after 1s	
                    end else if(o2 == 1'b0 && clk_counter2 >= 125000000) begin
                        clk_counter2 = 0;
                        o2 <= 1'b1;
                    end

                    // led goes off after 1s if no hits 
                if (o3 == 1'b1 && clk_counter3 >= 25000000) begin
                        clk_counter3 = 0;
                        o3 <= 1'b0;
                        if (score_stored + score_to_add > 32'd0) begin
                            score_to_add = score_to_add - 1;
                        end
                    // led goes on after 1s	
                    end else if(o3 == 1'b0 && clk_counter3 >= 100000000) begin
                        clk_counter3 = 0;
                        o3 <= 1'b1;
                    end

                    // led goes off after 1s if no hits 
                if (o4 == 1'b1 && clk_counter4 >= 25000000) begin
                        clk_counter4 = 0;
                        o4 <= 1'b0;
                        if (score_stored + score_to_add > 32'd0) begin
                            score_to_add = score_to_add - 1;
                        end
                    // led goes on after 1s	
                    end else if(o4 == 1'b0 && clk_counter4 >= 175000000) begin
                        clk_counter4 = 0;
                        o4 <= 1'b1;
                    end

                // if pressing status changed & pressed & lights on
                if (in1 != in1m && in1 == 1'b1 && o1 == 1'b1) begin
                    o1 <= 1'b0;
                    clk_counter1 = 0;
                    score_to_add = score_to_add + 32'd1;
                    hit=1'b1;
                end

                if (in2 != in2m && in2 == 1'b1 && o2 == 1'b1) begin
                    o2 <= 1'b0;
                    clk_counter2 = 0;
                    score_to_add = score_to_add + 32'd1;
                    hit=1'b1;
                end

                if (in3 != in3m && in3 == 1'b1 && o3 == 1'b1) begin
                    o3 <= 1'b0;
                    clk_counter3 = 0;
                    score_to_add = score_to_add + 32'd1;
                    hit=1'b1;
                end

                
                if (in4 != in4m && in4 == 1'b1 && o4 == 1'b1) begin
                    o4 <= 1'b0;
                    clk_counter4 = 0;
                    score_to_add = score_to_add + 32'd1;
                    hit=1'b1;
                end

                clk_counter1 <= clk_counter1 + 1;
                clk_counter2 <= clk_counter2 + 1;
                clk_counter3 <= clk_counter3 + 1;
                clk_counter4 <= clk_counter4 + 1;

                if(score_stored >= 32'd12) begin
                    ingame <= 1'b0;
                end

                if (write_status) begin
                    was_writing <= 1;
                end
            end

            else begin
                o1 <= 1'b0;
                o2 <= 1'b0;
                o3 <= 1'b0;
                o4 <= 1'b0;
                o5 <= 1'b1;
                endgameCounter <= endgameCounter + 1;

                if (in5 == 1'b0 && in5 != in5m && endgameCounter > 1000) begin
                    ingame <= 1'b1;
                    o5 <= 1'b0;
                    score_to_add <= 0;
                    reset = 1'b1;
                    endgameCounter <= 0;
                end
                
            end

            in1m = in1;
            in2m = in2;
            in3m = in3;
            in4m = in4;
            in5m = in5;
        end
        hit=1'b0;
    end

    VGAController VGA(score_stored, clk25, reset, hSync, vSync, VGA_R, VGA_G, VGA_B, ps2_clk, ps2_data);
    AudioController Audio(hit, clk25, chSel, audioOut, audioEn);
endmodule
