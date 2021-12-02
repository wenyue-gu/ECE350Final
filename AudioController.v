module AudioController(
	input 		hit,
    input        clk, 		// System Clock Input 100 Mhz
    output       chSel,		// Channel select; 0 for rising edge, 1 for falling edge
    output       audioOut,	// PWM signal to the audio jack	
    output       audioEn);	// Audio Enable

	localparam MHz = 1000000;
	localparam SYSTEM_FREQ = 100*MHz; // System clock frequency

	assign chSel   = 1'b0;  // Collect Mic Data on the rising edge 
	assign audioEn = 1'b1;  // Enable Audio Output

	// Initialize the frequency array. FREQs[0] = 261
	reg [10:0] FREQs[0:15];
	reg hit2;
	wire [31:0] hitthresh;
	assign hitthresh=10000000;
	reg [31:0] hitcounter=0;

	initial begin
		hit2 = 1'b0;
		$readmemh("FREQs.mem", FREQs);
	end
	
	////////////////////
	// Your Code Here //
	////////////////////
	wire [31:0] thresh;
	assign thresh = (SYSTEM_FREQ/FREQs[0]) >> 1;

	reg audioClk=0;
	reg[31:0] counter=0;


	always @(posedge clk) begin
		hitcounter = hitcounter + 1;
		if(hitcounter == hitthresh)
			hit2=1'b0;

		if (hit) begin
			hit2=1'b1;
			hitcounter=32'b0;
		end

		if(counter<thresh-1)
			counter<=count+1;
		else begin
			counter <=0;
			audioClk<=~audioClk;
		end
	end

	wire [6:0] duty_cycle;
	assign duty_cycle = audioClk ? 7'd90 : 7'd10;

	PWMSerializer ser(
		.hit(hit2),
		.clk(clk),
		.reset(1'b0),
		.duty_cycle(duty_cycle),
		.signal(audioOut)
	);

	

endmodule