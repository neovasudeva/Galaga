	// game_controller.sv
//
// controls the game duh
// prolly won't work tho b/c of my garbage verilog skillz
//
// ok here we go

module game_controller ( input         Clk,         	// 50 MHz clock signal   
                                       Reset,         // Reset signal 
                                       frame_clk,     // ~60 MHz clock signal
                         input [9:0]   DrawX, DrawY,  // Current drawing coordinates
                         input [7:0]	keycode,			// key pressed
								 output [23:0] color_data		// color data that will be passed to the color mapper
);

	 // SIGNAL CONTROLLER LOGIC
	 logic start;
	 logic play, done;
	 logic gameover;
	 signal_controller(.Clk (Clk), .Reset (Reset), .keycode (keycode), 
								.done (1'b0), .start (start), .play (play), .gameover (gameover));
	 
	 // temp logic for ships
	 logic is_user_ship;
	 logic [23:0] user_ship_data;
	 logic is_enemy_ship;
	 logic [23:0] enemy_ship_data;
	 logic is_laser;
	 logic [23:0] laser_data;
	 
	 // position logic
	 logic [9:0] user_x_pos, user_y_pos;
	 logic [9:0] user_laser_x_pos, user_laser_y_pos;
	 logic [9:0] enemy_x_pos, enemy_y_pos;
	 
	 // hit logic
	 logic enemy_hit;
	 
	 // ships to be used
	 user_ship ship(.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .keycode(keycode), 
							.is_user_ship (is_user_ship), .user_ship_data (user_ship_data), 
							.user_x_pos (user_x_pos), .user_y_pos (user_y_pos));
							
	 enemy_ship eship (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .keycode(keycode), 
							.is_enemy_ship (is_enemy_ship), .enemy_ship_data (enemy_ship_data), 
							.enemy_x_pos (enemy_x_pos), .enemy_y_pos (enemy_y_pos));
									
	 user_laser ulaser (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .keycode(keycode), 
							.user_x_pos (user_x_pos), .user_y_pos (user_y_pos),
							.is_laser (is_laser), .laser_data (laser_data), 
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos));
							
	 // hit detector
	 hit_controller hitter (.user_x_pos (user_x_pos), .user_y_pos (user_y_pos),
	                        .user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
									.enemy_x_pos (enemy_x_pos), .enemy_y_pos (enemy_y_pos),
	                        .enemy_hit (enemy_hit));
									
	 // logo controllers
	 logic is_galaga;
	 logic is_pressed_start;
	 galaga_logo gl (.DrawX (DrawX), .DrawY (DrawY), .is_galaga (is_galaga));	
	 press_start_logo psl (.DrawX (DrawX), .DrawY (DrawY), .is_press_start (is_press_start));
							
							
	 // COLOR ASSIGNMENT -> assigns color to color_data to display on monitor
	 logic [7:0] Red, Green, Blue;
	 assign color_data = {Red, Green, Blue};	// RBG lol
	 always_comb begin
		// start state
		if (start == 1'b1) begin
			// draw galaga logo
			if (is_galaga == 1'b1) begin
				Red = 8'hFF;
				Green = 8'hFF;
				Blue = 8'hFF;
			end
			// press start logo
			else if (is_press_start == 1'b1) begin
				Red = 8'hFF;
				Green = 8'hFF;
				Blue = 8'hFF;
			end
			// ship
			else if (is_user_ship == 1'b1) begin
				// user ship
				Red = user_ship_data[15:8];
				Green = user_ship_data[23:16];
				Blue = user_ship_data[7:0];
			end
			// laser
			else if (is_laser == 1'b1) begin 
				// enemy ship
				Red = laser_data[15:8];
				Green = laser_data[23:16];
				Blue = laser_data[7:0];
			end
			// background
			else begin
				Red = 8'h20; 
				Green = 8'h00;
				Blue = 8'h00;
			end
		end
		
		// play state
		else if (play == 1'b1) begin
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
			else if (is_enemy_ship == 1'b1 && ~enemy_hit == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data[15:8];
				Green = enemy_ship_data[23:16];
				Blue = enemy_ship_data[7:0];
			end
			//background
			else 
			begin
				Red = 8'h20; 
				Green = 8'h00;
				Blue = 8'h00;
			end
		end
		
		// gameover
		else if (gameover == 1'b1) begin
			Red = 8'h50;
			Green = 8'h50;
			Blue = 8'h50;
		end
		
		// default -> white screen
		else begin
			Red = 8'hFF;
			Green = 8'hFF;
			Blue = 8'hFF;
		end
	end 
endmodule 