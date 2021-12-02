`timescale 1 ns/ 100 ps
module VGAController(     

    input [31:0] score,

	input clk, 			// 100 MHz System Clock
	input reset, 		// Reset Signal
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,  // Blue Signal Bits
	inout ps2_clk,
	inout ps2_data);

	
	// Lab Memory Files Location
	localparam FILES_PATH = "./images/";

	// VGA Timing Generation for a Standard VGA Screen
	localparam  
		VIDEO_WIDTH = 640,  // Standard VGA Width
		VIDEO_HEIGHT = 480; // Standard VGA Height

	wire active, screenEnd;
	wire[9:0] x;
	wire[8:0] y;
	
	VGATimingGenerator #(
		.HEIGHT(VIDEO_HEIGHT), // Use the standard VGA Values
		.WIDTH(VIDEO_WIDTH))
	Display( 
		.clk25(clk),  	   // 25MHz Pixel Clock
		.reset(reset),		   // Reset Signal
		.screenEnd(screenEnd), // High for one cycle when between two frames
		.active(active),	   // High when drawing pixels
		.hSync(hSync),  	   // Set Generated H Signal
		.vSync(vSync),		   // Set Generated V Signal
		.x(x), 				   // X Coordinate (from left)
		.y(y)); 			   // Y Coordinate (from top)	   

	// Image Data to Map Pixel Location to Color Address
	localparam  
		PIXEL_COUNT = VIDEO_WIDTH*VIDEO_HEIGHT, 	             // Number of pixels on the screen
		PIXEL_ADDRESS_WIDTH = $clog2(PIXEL_COUNT) + 1,           // Use built in log2 command
		BITS_PER_COLOR = 12, 	  								 // Nexys A7 uses 12 bits/color
		PALETTE_COLOR_COUNT = 256, 								 // Number of Colors available
		PALETTE_ADDRESS_WIDTH = $clog2(PALETTE_COLOR_COUNT) + 1; // Use built in log2 Command

	wire[PIXEL_ADDRESS_WIDTH-1:0] imgAddress;  	 // Image address for the image data
	// wire[PALETTE_ADDRESS_WIDTH-1:0] endScreenColorPalatte; 	 // Color address for the color palette
	wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr1; 	 // Color address for the color palette
	assign imgAddress = x + 640*y;				 // Address calculated coordinate

	RAM2  #(		
		.DEPTH(PIXEL_COUNT), 				     // Set RAM2  depth to contain every pixel
		.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
		.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
		.MEMFILE({FILES_PATH, "image.mem"})) // Memory initialization
	ImageData1(
		.clk(clk), 						 // Falling edge of the 100 MHz clk
		.addr(imgAddress),					 // Image data address
		.dataOut(colorAddr1),				 // Color palette address
		.wEn(1'b0)); 						 // We're always reading

	// Color Palette to Map Color Address to 12-Bit Color
	wire[BITS_PER_COLOR-1:0] colorData1; // 12-bit color data at current pixel

	RAM2  #(
		.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
		.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
		.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
		.MEMFILE({FILES_PATH, "colors.mem"}))  // Memory initialization
	ColorPalette1(
		.clk(clk), 							   	   // Rising edge of the 100 MHz clk
		.addr(colorAddr1),					       // Address from the ImageData RAM
		.dataOut(colorData1),				       // Color at current pixel
		.wEn(1'b0)); 						       // We're always reading
	// Assign to output color from register if active
	reg[BITS_PER_COLOR-1:0] colorOut; 			  // Output color 


	always @(posedge clk) begin

        if (x < 10'd160 && x >= 10'd0 && y < 9'd160 && y >= 9'd0) begin
            if(score > 32'd0) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd320 && x > 10'd159 && y < 9'd160 && y >= 9'd0) begin
            if(score > 32'd1) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd480 && x> 10'd319 && y < 9'd160 && y >= 9'd0) begin
            if(score > 32'd2)begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd640 && x > 10'd479 && y < 9'd160 && y >= 9'd0) begin
            if(score > 32'd3) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        
        if (x < 10'd160 && x >= 10'd0 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd9) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd320 && x > 10'd159 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd10) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd480 && x > 10'd319 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd11) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd640 && x > 10'd479 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd4) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end

        if (x < 10'd160 && x >= 10'd0 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd8) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd320 && x > 10'd159 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd7) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd480 && x > 10'd319 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd6) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
        if (x < 10'd640 && x > 10'd479 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd5) begin
                colorOut=colorData1;
            end else begin
                colorOut=12'd0;
            end
        end
    end

	assign {VGA_R, VGA_G, VGA_B} = colorOut;
endmodule