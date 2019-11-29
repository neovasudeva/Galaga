//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input 		[23:0]	color_data,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
		
	// Output colors to VGA
	assign VGA_R = color_data[23:16];
	assign VGA_G = color_data[15:8];
	assign VGA_B = color_data[7:0];

endmodule

