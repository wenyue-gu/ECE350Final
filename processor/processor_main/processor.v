/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	
    ,test_var
);
    output [31:0] test_var;
    assign test_var = bypass_B_mux;
    // assign test_var = {30'd0, bypass_A_mux};
	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */
    // bypass
    wire [31:0] mxbypass = address_dmem;
    wire [31:0] wxbypass = data_writeReg;
    wire [31:0] wmbypass = data_writeReg;

    wire is_wmbypass = is_lw_tail && is_sw_mw && ir_tail[26:22] == ir_mw[26:22];

    wire [1:0] bypass_A_mux = ((is_r_mw || is_addi_mw) && (((is_r_xm || is_sw_xm || is_addi_xm) && ir_xm[21:17] == ir_mw[26:22]) || ((is_blt_xm || is_bne_xm) && ir_xm[26:22] == ir_mw[26:22])) && ir_mw[26:22] != 5'd0) ? 2'd0 :
                                (
                                    ((is_r_tail || is_addi_tail || is_lw_tail) && (((is_r_xm || is_sw_xm || is_addi_xm) && ir_xm[21:17] == ir_tail[26:22]) || ((is_blt_xm || is_bne_xm) && ir_xm[26:22] == ir_tail[26:22])) && ir_tail[26:22] != 5'd0) ? 2'd1 : 2'd2
                                );
    wire [1:0] bypass_B_mux = ((is_r_mw || is_addi_mw) && ir_mw[26:22] != 5'd0 && (((is_sw_xm || is_j2_xm) && ir_xm[26:22] == ir_mw[26:22]) || (is_r_xm && ir_xm[16:12] == ir_mw[26:22]) || ((is_blt_xm || is_bne_xm) && ir_xm[21:17] == ir_mw[26:22]))) ? 2'd0 : 
                                (
                                    ((is_r_tail || is_addi_tail || is_lw_tail) && ir_tail[26:22] != 5'd0 && (((is_sw_xm || is_j2_xm) && ir_xm[26:22] == ir_tail[26:22]) || (is_r_xm && ir_xm[16:12] == ir_tail[26:22]) || ((is_blt_xm || is_bne_xm) && ir_xm[21:17] == ir_tail[26:22]))) ? 2'd1 : 2'd2
                                );

    wire stall = is_lw_xm && (((is_r_dx || is_i_dx_no_lwsw) && !is_sw_dx && ir_dx[21:17] == ir_xm[26:22]) || ((is_r_dx && ir_dx[16:12] == ir_xm[26:22]) || (is_j2_dx && ir_dx[26:2] == ir_xm[26:22])));

    // controls 
    wire is_i_dx_no_lwsw = is_addi_dx || is_blt_dx || is_bne_dx;
    wire is_i_xm_no_lwsw = is_addi_xm || is_blt_xm || is_bne_xm;
    wire is_i_mw_no_lwsw = is_addi_mw || is_blt_mw || is_bne_mw;
    wire is_i_tail_no_lwsw = is_addi_tail || is_blt_tail || is_bne_tail;
    wire is_j2_dx = (ir_dx[31:27] == 5'b00100);
    wire is_j2_xm = (ir_xm[31:27] == 5'b00100);

    wire is_r_dx = (ir_dx[31:27] == 5'd0) && (ir_dx != 32'd0);
    wire is_r_xm = (ir_xm[31:27] == 5'd0) && (ir_xm != 32'd0);
    wire is_r_mw = (ir_mw[31:27] == 5'd0) && (ir_mw != 32'd0);
    wire is_r_tail = (ir_tail[31:27] == 5'd0) && (ir_tail != 32'd0);

    wire is_lw_dx = (ir_dx[31:27] == 5'd8);
    wire is_lw_xm = (ir_xm[31:27] == 5'd8);
    wire is_lw_mw = (ir_mw[31:27] == 5'd8);
    wire is_lw_tail = (ir_tail[31:27] == 5'd8);

    wire is_sw_dx = (ir_dx[31:27] == 5'd7);
    wire is_sw_xm = (ir_xm[31:27] == 5'd7);
    wire is_sw_mw = (ir_mw[31:27] == 5'd7);
    wire is_sw_tail = (ir_tail[31:27] == 5'd7);

    wire is_addi_dx = (ir_dx[31:27] == 5'b00101);
    wire is_addi_xm = (ir_xm[31:27] == 5'b00101);
    wire is_addi_mw = (ir_mw[31:27] == 5'b00101);
    wire is_addi_tail = (ir_tail[31:27] == 5'b00101);

    wire is_bne_dx = (ir_dx[31:27] == 5'b00010);
    wire is_bne_xm = (ir_xm[31:27] == 5'b00010);
    wire is_bne_mw = (ir_mw[31:27] == 5'b00010);
    wire is_bne_tail = (ir_tail[31:27] == 5'b00010);

    wire is_blt_dx = (ir_dx[31:27] == 5'b00110);
    wire is_blt_xm = (ir_xm[31:27] == 5'b00110);
    wire is_blt_mw = (ir_mw[31:27] == 5'b00110);
    wire is_blt_tail = (ir_tail[31:27] == 5'b00110);

    wire is_bex_dx = (ir_dx[31:27] == 5'b10110);

    wire is_nop_tail = (ir_tail == 32'b0);
 
    wire ALUinB = (is_lw_xm | is_sw_xm | is_addi_xm) ? 1 : 0;
    wire Rwd = is_lw_tail ? 1 : 0;
    wire [4:0] ALUop = is_r_xm ? op_code : 5'b0;

    assign wren = is_sw_mw ? 1 : 0;
    assign ctrl_writeEnable = is_nop_tail ? 0 : ((is_r_tail | is_lw_tail | is_addi_tail) ? 1 : 0); 

    // - fd
    wire [31:0] pc_next, pc_current;
    wire [31:0] pc_dx, ir_dx;
    wire w0, w1, w2;
    pc_reg pc(address_imem, pc_next, clock, stall ? 1'b0 : 1'b1, reset);
    alu add_one(address_imem, 32'b1, 5'b0, 5'b0, pc_current, w0, w1, w2);
    assign pc_next = (branch_res == 2'd2) ? jump_addr : 
                    ((branch_res == 2'b1) ? branched: pc_current);

    // branch
    wire [31:0] q_imem_2 = branch_res != 2'd0 ? 32'd0 : q_imem;
    fd_latch fd(pc_dx, ir_dx, pc_current, q_imem_2, stall ? 1'b0 : 1'b1, clock);
    
    // fd - dx
    wire [31:0] pc_xm, ir_xm, data_A, data_B;
    assign ctrl_readRegA = is_bex_dx ? 32'd0 : ((is_blt_dx || is_bne_dx) ? ir_dx[26:22] : ir_dx[21:17]);
    assign ctrl_readRegB = is_bex_dx ? 32'd30 : (is_r_dx ? ir_dx[16:12] : ((is_blt_dx || is_bne_dx) ? ir_dx[21:17] : ir_dx[26:22]));
    wire [31:0] ir_dx_2 = stall || (branch_res != 2'd0) ? 32'd0 : ir_dx;
    dx_latch dx(pc_xm, data_A, data_B, ir_xm, pc_dx, data_readRegA, data_readRegB, ir_dx_2, 1'b1, clock);

    // dx - xm
    wire [31:0] extended_immed, alu_out;

    assign extended_immed[16:0] = ir_xm[16:0];
    assign extended_immed[31:17] = ir_xm[16] ? 15'b111111111111111 : 15'b0;
    wire [4:0] op_code = ir_xm[6:2]; 
    wire [4:0] shiftamt = ir_xm[11:7];
    
    wire [31:0] alu_in_A, data_B_2;
    mux_4 m41(alu_in_A, bypass_A_mux, mxbypass, wxbypass, data_A, 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    mux_4 m42(data_B_2, bypass_B_mux, mxbypass, wxbypass, data_B, 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    wire [31:0] alu_in_B = ALUinB ? extended_immed : data_B_2;

    wire isNotEqual, isLessThan, overflow;
    wire [31:0] data_0;
    alu math(alu_in_A, alu_in_B, ALUop, shiftamt, alu_out, isNotEqual, isLessThan, overflow);
    wire [31:0] ir_mw;
    wire [31:0] ir_xm_2 = overflow ? 32'b00101111100000000000000000000001 : 
                        (is_xm_jal ? 32'b00101111110000000000000000000000 : 
                        (is_xm_setx ? 32'b00101111100000000000000000000000 : ir_xm));
    wire [31:0] alu_out_2 = overflow ? 32'd1 : 
                            (is_xm_jal ? pc_xm :
                            (is_xm_setx ? {5'd0, ir_xm[26:0]} : alu_out));
    xm_latch xm(ir_mw, address_dmem, data_0, ir_xm_2, alu_out_2, data_B_2, 1'b1, clock);
    assign data = is_wmbypass ? wmbypass : data_0;

    // branch & jump 
    wire [31:0] branched;
    wire w3, w4, w5;
    alu branch_add(pc_xm, extended_immed, 5'b0, 5'b0, branched, w3, w4, w5);
    wire [31:0] jump_addr = is_xm_jr ? data_B_2 : {5'b0, ir_xm[26:0]}; 

    wire is_xm_bne = (ir_xm[31:27] == 5'b00010);
    wire is_xm_blt = (ir_xm[31:27] == 5'b00110);
    wire is_xm_jal = (ir_xm[31:27] == 5'b00011);
    wire is_xm_jr = (ir_xm[31:27] == 5'b00100);
    wire is_xm_j = (ir_xm[31:27] == 5'b00001);
    wire is_xm_setx = (ir_xm[31:27] == 5'b10101);
    wire is_xm_bex = (ir_xm[31:27] == 5'b10110);

    wire [1:0] branch_res = is_xm_jr | is_xm_jal | is_xm_j | (is_xm_bex & isNotEqual) ? 2'd2 : 
                        ((is_xm_bne & isNotEqual) ? 2'b1 : 
                        ((is_xm_blt & isLessThan) ? 2'b1 : 2'b0));

    // xm - mw
    wire [31:0] ir_tail;
    wire [31:0] alu_mw, mem_mw;
    mw_latch mw(ir_tail, alu_mw, mem_mw, ir_mw, address_dmem, q_dmem, 1'b1, clock);

    // tail
    assign ctrl_writeReg = ir_tail[26:22];
    assign data_writeReg = Rwd ? mem_mw: alu_mw;

endmodule
