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
module  color_mapper ( input 			is_user_ship,
							  input 			[23:0] user_ship_data,
							  input 			is_enemy_ship,
							  input 			[23:0] enemy_ship_data,
							  input 			is_laser,
							  input 			[23:0] laser_data,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
	// VGA Colors
	logic [7:0] Red, Green, Blue;
		
	// Output colors to VGA
	assign VGA_R = Red;
	assign VGA_G = Green;
	assign VGA_B = Blue;
	
	// Assign color based on sprite font data
	always_comb
	begin
		if (is_laser == 1'b1) begin 
			// enemy ship
			Red = laser_data[15:8];
			Green = laser_data[23:16];
			Blue = laser_data[7:0];
	  end
	  else if (is_user_ship == 1'b1) begin
			// user ship
			Red = user_ship_data[15:8];
			Green = user_ship_data[23:16];
			Blue = user_ship_data[7:0];
	  end
	  else if (is_enemy_ship == 1'b1) begin
			// enemy ship
			Red = enemy_ship_data[15:8];
			Green = enemy_ship_data[23:16];
			Blue = enemy_ship_data[7:0];
	  end
	  else 
	  begin
			// Black background 
			Red = 8'h20; 
			Green = 8'h00;
			Blue = 8'h00;
	  end
	end 

endmodule

