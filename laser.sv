// laser.sv
// used to control the movement of laser
// also gives control signals to color_mapper.sv for drawing



module  user_laser ( input        Clk,           // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [7:0]	  keycode,				 // pass key pressed into laser.sv
					input [9:0]	  user_x_pos,
					input [9:0]   user_y_pos,
					output 		  is_laser,				 // whether current drawing pixel is the laser
					output [23:0] laser_data,		    // sends color of user ship
					output [9:0]  user_laser_x_pos, 	 // location of laser
					output [9:0]  user_laser_y_pos
					//input 		  laser_hit				 // laser has hit enemy
              );
    
    parameter [9:0] laser_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] laser_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] laser_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] laser_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] laser_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] laser_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] laser_Y_Step = 10'd4;      // Step size on the Y axis
    parameter [9:0] laser_X_Size = 10'd20;     // laser's size (20x49 )
	 parameter [9:0] laser_Y_Size = 10'd49;
	 
	 // temp logic for storing old location of laser
	 logic [9:0] old_X_Pos;
	 assign user_laser_x_pos = laser_X_Pos;
	 assign user_laser_y_pos = laser_Y_Pos;
	 
	 // temp logic for is_laser
	 logic space_pressed;
	 logic space_pressed_in;
    
	 //NOTE: no X movement logic b/c laser isn't supposed to move sideways lol
    logic [9:0] laser_Y_Motion, laser_X_Pos, laser_Y_Pos;
    logic [9:0] laser_X_Pos_in, laser_Y_Pos_in, laser_Y_Motion_in;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	 
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            laser_X_Pos <= laser_X_Center; //x_pos + 10'd5;
				laser_Y_Pos <= laser_Y_Max; //y_pos - laser_Y_Size;
				laser_Y_Motion <= 10'd0;
				space_pressed <= 1'b0;
        end
        else
        begin
            laser_X_Pos <= laser_X_Pos_in; 
            laser_Y_Pos <= laser_Y_Pos_in; 
            laser_Y_Motion <= laser_Y_Motion_in;
				space_pressed <= space_pressed_in;
        end
    end
	 
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        laser_X_Pos_in = laser_X_Pos;
        laser_Y_Pos_in = laser_Y_Pos;
        laser_Y_Motion_in = laser_Y_Motion;
		  old_X_Pos = laser_X_Pos;
		  space_pressed_in = space_pressed;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
				// handle edges -> if laser is in movement, check if it hits edges
				if (space_pressed == 1'b1) begin
					// edge has been hit or enemy has been hit, but key is still pressed
					if (laser_Y_Pos >= laser_Y_Max && keycode == 8'h2C) begin
						laser_X_Pos_in = user_x_pos + 10'd8;
						laser_Y_Pos_in = user_y_pos - laser_Y_Size;
						laser_Y_Motion_in = (~(laser_Y_Step) + 1'b1); 
						old_X_Pos = user_x_pos + 10'd5;
						space_pressed_in = 1'b1;
					end
					// edge has been hit or has hit enemy
					else if (laser_Y_Pos >= laser_Y_Max) begin 
						space_pressed_in = 1'b0;
					end 
					// edge hasn't been hit
					else begin
						laser_Y_Motion_in = (~(laser_Y_Step) + 1'b1);
						laser_Y_Pos_in = laser_Y_Pos + laser_Y_Motion;
						laser_X_Pos_in = old_X_Pos;
						space_pressed_in = 1'b1;
					end
				end				
				else begin
					laser_X_Pos_in = user_x_pos + 10'd5;
					laser_Y_Pos_in = user_y_pos - laser_Y_Size;
					laser_Y_Motion_in = 10'd0; 
					old_X_Pos = user_x_pos + 10'd5;
					space_pressed_in = 1'b0;
				end
				
				// handle keys -> only account for space and default for no keys
				if (keycode == 8'h2C) begin // Space -> shoot laser
					space_pressed_in = 1'b1;
				end 		
		
          
        end
    end

	     // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
	 
	 logic [9:0] laser_addr;
    always_comb begin
        if ( DrawX >= laser_X_Pos && DrawX < laser_X_Pos + laser_X_Size &&
				DrawY >= laser_Y_Pos && DrawY < laser_Y_Pos + laser_Y_Size ) begin
				laser_addr = (DrawY - laser_Y_Pos) * laser_X_Size + (DrawX - laser_X_Pos);
				// don't color in background of laser
				if (laser_data == 24'h002000) 
					is_laser = 1'b0;
				else
					is_laser = 1'b1 && space_pressed;
		  end
        else begin
				laser_addr = 10'b0;	// match background
				is_laser = 1'b0;
		  end
    end
	 
	 // get color data of laser via on chip memory
	 laserRAM lr(.read_address (laser_addr), .Clk (Clk), .data_out(laser_data) );
    
endmodule