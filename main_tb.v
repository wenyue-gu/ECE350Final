module main_tb;
    
	// Inputs to the processor
	reg clock = 0, reset = 0;

    // Create the clock
	always
		#10 clock = ~clock; 
    

endmodule
