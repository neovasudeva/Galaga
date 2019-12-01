// enemy_ship.sv
// used to control the movement of enemy_ship
// also gives control signals to color_mapper.sv for drawing



module  enemy_ship ( input         Clk,           // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [7:0]	  keycode,				 // pass key pressed into enemy_ship.sv
					output 		  is_enemy_ship,		 // whether current drawing pixel is the enemy_ship
					output [23:0] enemy_ship_data,	 // sends color of user ship
					output [9:0]  enemy_x_pos, 		 // position of enemy
					output [9:0]  enemy_y_pos
              );
    
    parameter [9:0] enemy_ship_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] enemy_ship_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] enemy_ship_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] enemy_ship_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] enemy_ship_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] enemy_ship_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] enemy_ship_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] enemy_ship_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] enemy_ship_Size = 10'd30;       // enemy_ship's size (30x30)
    
    logic [9:0] enemy_ship_X_Motion, enemy_ship_Y_Motion, enemy_ship_X_Pos, enemy_ship_Y_Pos;
    logic [9:0] enemy_ship_X_Pos_in, enemy_ship_X_Motion_in, enemy_ship_Y_Pos_in, enemy_ship_Y_Motion_in;
	 
	 // assign current position to outputs
	 assign enemy_x_pos = enemy_ship_X_Pos;
	 assign enemy_y_pos = enemy_ship_Y_Pos;
    
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
            enemy_ship_X_Pos <= enemy_ship_X_Center;
            enemy_ship_Y_Pos <= enemy_ship_Y_Center;	// start at the bottom
            enemy_ship_X_Motion <= 10'd0; //enemy_ship_X_Step;
            enemy_ship_Y_Motion <= 10'd0; //enemy_ship_Y_Step;
        end
        else
        begin
            enemy_ship_X_Pos <= enemy_ship_X_Pos_in;
            enemy_ship_Y_Pos <= enemy_ship_Y_Pos_in;
            enemy_ship_X_Motion <= 10'd0; //enemy_ship_X_Motion_in;
            enemy_ship_Y_Motion <= 10'd0; //enemy_ship_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        enemy_ship_X_Pos_in = enemy_ship_X_Pos;
        enemy_ship_Y_Pos_in = enemy_ship_Y_Pos;
        enemy_ship_X_Motion_in = enemy_ship_X_Motion;
        enemy_ship_Y_Motion_in = enemy_ship_Y_Motion;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. enemy_ship_Y_Pos - Ball_Size <= enemy_ship_Y_Min 
            // If enemy_ship_Y_Pos is 0, then enemy_ship_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
				
				// handle keys -> don't lmao
					
				// handle edges -> left and right edges
				if (enemy_ship_X_Pos + enemy_ship_Size >= enemy_ship_X_Max) begin // Ball is at right edge, BOUNCE!
					 enemy_ship_X_Motion_in = (~(enemy_ship_Y_Step) + 1'b1);
					 enemy_ship_Y_Motion_in = 10'd0;
				end
				else if (enemy_ship_X_Pos <= enemy_ship_X_Min + enemy_ship_Size)	begin // Ball is at left edge, BOUNCE!
					 enemy_ship_X_Motion_in = enemy_ship_X_Step;
					 enemy_ship_Y_Motion_in = 10'd0;
				end
        
            // Update the ball's position with its motion
            enemy_ship_X_Pos_in = enemy_ship_X_Pos + enemy_ship_X_Motion;
            enemy_ship_Y_Pos_in = enemy_ship_Y_Pos + enemy_ship_Y_Motion;
        end
    end
	 
	     // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
	 
	 logic [10:0] enemy_ship_addr;
    always_comb begin
        if ( DrawX >= enemy_ship_X_Pos && DrawX < enemy_ship_X_Pos + enemy_ship_Size &&
				DrawY >= enemy_ship_Y_Pos && DrawY < enemy_ship_Y_Pos + enemy_ship_Size ) begin
				enemy_ship_addr = (DrawY - enemy_ship_Y_Pos) * enemy_ship_Size + (DrawX - enemy_ship_X_Pos);
				// don't color in background of ship
				if (enemy_ship_data == 24'h002000) 
					is_enemy_ship = 1'b0;
				else
					is_enemy_ship = 1'b1;
		  end
        else begin
				enemy_ship_addr = 10'h00;	// match background
            is_enemy_ship = 1'b0;
		  end
    end
	 
	 // get color data of enemy_ship via on chip memory
	 enemyRAM er(.read_address (enemy_ship_addr), .Clk (Clk), .data_out(enemy_ship_data) );
    
endmodule