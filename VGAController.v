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

	// Clock divider 100 MHz -> 25 MHz
	wire clk25; // 25MHz clock

	reg[1:0] pixCounter = 0;      // Pixel counter to divide the clock
    assign clk25 = pixCounter[1]; // Set the clock high whenever the second bit (2) is high


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
		.clk25(clk25),  	   // 25MHz Pixel Clock
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

	// wire[PIXEL_ADDRESS_WIDTH-1:0] imgAddress;  	 // Image address for the image data
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr0; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr1; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr2; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr3; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr4; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr5; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr6; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr7; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr8; 	 // Color address for the color palette
	// wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr9; 	 // Color address for the color palette
	assign imgAddress = x + 640*y;				 // Address calculated coordinate




    // //0

	// RAM2 #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2  depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image0.mem"})) // Memory initialization
	// ImageData0(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr0),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData0; // 12-bit color data at current pixel

	// RAM2  #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors0.mem"}))  // Memory initialization
	// ColorPalette0(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr0),					       // Address from the ImageData RAM
	// 	.dataOut(colorData0),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading


    // //1

	// RAM2  #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2  depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image1.mem"})) // Memory initialization
	// ImageData1(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr1),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData1; // 12-bit color data at current pixel

	// RAM2  #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors1.mem"}))  // Memory initialization
	// ColorPalette1(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr1),					       // Address from the ImageData RAM
	// 	.dataOut(colorData1),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading



    // //2

	// RAM2  #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2  depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image2.mem"})) // Memory initialization
	// ImageData2(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr2),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData2; // 12-bit color data at current pixel

	// RAM2  #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors2.mem"}))  // Memory initialization
	// ColorPalette2(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr2),					       // Address from the ImageData RAM
	// 	.dataOut(colorData2),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading




    // //3

	// RAM2  #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2  depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image3.mem"})) // Memory initialization
	// ImageData3(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr3),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData3; // 12-bit color data at current pixel

	// RAM2  #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors3.mem"}))  // Memory initialization
	// ColorPalette3(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr3),					       // Address from the ImageData RAM
	// 	.dataOut(colorData3),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading


    // //4

	// RAM2  #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2 depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image4.mem"})) // Memory initialization
	// ImageData4(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr4),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData4; // 12-bit color data at current pixel

	// RAM2 #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors4.mem"}))  // Memory initialization
	// ColorPalette4(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr4),					       // Address from the ImageData RAM
	// 	.dataOut(colorData4),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading



    // //5

	// RAM2 #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2 depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image5.mem"})) // Memory initialization
	// ImageData5(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr5),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData5; // 12-bit color data at current pixel

	// RAM2 #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors5.mem"}))  // Memory initialization
	// ColorPalette5(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr5),					       // Address from the ImageData RAM
	// 	.dataOut(colorData5),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading



    // //6

	// RAM2 #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2 depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image6.mem"})) // Memory initialization
	// ImageData6(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr6),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData6; // 12-bit color data at current pixel

	// RAM2 #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors6.mem"}))  // Memory initialization
	// ColorPalette6(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr6),					       // Address from the ImageData RAM
	// 	.dataOut(colorData6),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading




    // //7

	// RAM2 #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2 depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image7.mem"})) // Memory initialization
	// ImageData7(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr7),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData7; // 12-bit color data at current pixel

	// RAM2 #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors7.mem"}))  // Memory initialization
	// ColorPalette7(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr7),					       // Address from the ImageData RAM
	// 	.dataOut(colorData7),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading


    // //8

	// RAM2 #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2 depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image8.mem"})) // Memory initialization
	// ImageData8(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr8),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData8; // 12-bit color data at current pixel

	// RAM2 #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors8.mem"}))  // Memory initialization
	// ColorPalette8(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr8),					       // Address from the ImageData RAM
	// 	.dataOut(colorData8),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading



    // //9

	// RAM2 #(		
	// 	.DEPTH(PIXEL_COUNT), 				     // Set RAM2 depth to contain every pixel
	// 	.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
	// 	.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
	// 	.MEMFILE({FILES_PATH, "image9.mem"})) // Memory initialization
	// ImageData9(
	// 	.clk(clk), 						 // Falling edge of the 100 MHz clk
	// 	.addr(imgAddress),					 // Image data address
	// 	.dataOut(colorAddr9),				 // Color palette address
	// 	.wEn(1'b0)); 						 // We're always reading

	// // Color Palette to Map Color Address to 12-Bit Color
	// wire[BITS_PER_COLOR-1:0] colorData9; // 12-bit color data at current pixel

	// RAM2 #(
	// 	.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
	// 	.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
	// 	.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
	// 	.MEMFILE({FILES_PATH, "colors9.mem"}))  // Memory initialization
	// ColorPalette9(
	// 	.clk(clk), 							   	   // Rising edge of the 100 MHz clk
	// 	.addr(colorAddr9),					       // Address from the ImageData RAM
	// 	.dataOut(colorData9),				       // Color at current pixel
	// 	.wEn(1'b0)); 						       // We're always reading







	

	// Assign to output color from register if active
	reg[BITS_PER_COLOR-1:0] colorOut; 			  // Output color 


	always @(posedge clk) begin
		pixCounter <= pixCounter + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
        // if(score % 5 == 32'd0) 
        //     colorOut = colorData0; 
        // if(score % 5 ==32'd1) 
        //     colorOut = colorData1; 
        // if(score % 5 ==32'd2) 
        //     colorOut = colorData2; 
        // if(score % 5 ==32'd3) 
        //     colorOut = colorData3; 
        // if(score % 5 ==32'd4) 
        //     colorOut = colorData4; 
        // if(score % 10 ==5) 
        //     colorOut = colorData5; 
        // if(score % 10 ==6) 
        //     colorOut = colorData6; 
        // if(score % 10 ==7) 
        //     colorOut = colorData7; 
        // if(score % 10 ==8) 
        //     colorOut = colorData8; 
        // if(score % 10 ==9) 
        //     colorOut = colorData9; 
        if (x < 10'd160 && x> 10'd0 && y < 9'd160 && y > 9'd0) begin
            if(score > 32'd0) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd320 && x > 10'd159 && y < 9'd160 && y > 9'd0) begin
            if(score > 32'd1) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd480 && x> 10'd319 && y < 9'd160 && y > 9'd0) begin
            if(score > 32'd2)begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd640 && x > 10'd479 && y < 9'd160 && y > 9'd0) begin
            if(score > 32'd3) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        
        if (x < 10'd160 && x > 10'd0 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd4) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd320 && x > 10'd159 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd5) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd480 && x > 10'd319 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd6) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd640 && x > 10'd479 && y < 9'd320 && y > 9'd159) begin
            if(score > 32'd7) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end

        
        if (x < 10'd160 && x > 10'd0 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd8) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd320 && x > 10'd159 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd9) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd480 && x > 10'd319 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd10) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
        if (x < 10'd640 && x > 10'd479 && y < 9'd480 && y > 9'd319) begin
            if(score > 32'd11) begin
                colorOut=12'd0;
            end else begin
                colorOut=12'b111111111111;
            end
        end
    end
    

	// Quickly assign the output colors to their channels using concatenation
	assign {VGA_R, VGA_G, VGA_B} = colorOut;
endmodule