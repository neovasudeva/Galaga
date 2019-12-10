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
								 output [23:0] color_data,		// color data that will be passed to the color mapper
								 output [4:0]  score 			// final overall score
);

	 // SIGNAL CONTROLLER LOGIC
	 logic start, play, gameover;
	 logic done;
	 assign done = (gameover1 || gameover2 || gameover3) || (score == 5'h12);
	 signal_controller(.Clk (Clk), .Reset (Reset), .keycode (keycode), 
								.done (done), .start (start), .play (play), .gameover (gameover));
	 
	 // user ship and laser
	 logic is_user_ship;
	 logic [23:0] user_ship_data;
	 logic is_laser;
	 logic [23:0] laser_data;
	 logic [9:0] user_x_pos, user_y_pos;
	 logic [9:0] user_laser_x_pos, user_laser_y_pos;
	 
	 //logic bounce;
	 //logic laser_hit;
	 
	 // row 1 of enemy ships
	 logic is_enemy_ship11;
	 logic [23:0] enemy_ship_data11;
	 logic is_enemy_ship12;
	 logic [23:0] enemy_ship_data12;
	 logic is_enemy_ship13;
	 logic [23:0] enemy_ship_data13;
	 logic is_enemy_ship14;
	 logic [23:0] enemy_ship_data14;
	 logic is_enemy_ship15;
	 logic [23:0] enemy_ship_data15;
	 logic is_enemy_ship16;
	 logic [23:0] enemy_ship_data16;
	 
	 // row 2 of enemy ships
	 logic is_enemy_ship21;
	 logic [23:0] enemy_ship_data21;
	 logic is_enemy_ship22;
	 logic [23:0] enemy_ship_data22;
	 logic is_enemy_ship23;
	 logic [23:0] enemy_ship_data23;
	 logic is_enemy_ship24;
	 logic [23:0] enemy_ship_data24;
	 logic is_enemy_ship25;
	 logic [23:0] enemy_ship_data25;
	 logic is_enemy_ship26;
	 logic [23:0] enemy_ship_data26;
	 
	 // row 3 of enemy ships
	 logic is_enemy_ship31;
	 logic [23:0] enemy_ship_data31;
	 logic is_enemy_ship32;
	 logic [23:0] enemy_ship_data32;
	 logic is_enemy_ship33;
	 logic [23:0] enemy_ship_data33;
	 logic is_enemy_ship34;
	 logic [23:0] enemy_ship_data34;
	 logic is_enemy_ship35;
	 logic [23:0] enemy_ship_data35;
	 logic is_enemy_ship36;
	 logic [23:0] enemy_ship_data36;
	 
	 // score and gameover logic
	 logic gameover1, gameover2, gameover3;
	 logic [4:0] score1, score2, score3;
	 assign score = score1 + score2 + score3;
	 
	 // ships to be used
	 user_ship ship (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .keycode(keycode), 
							.is_user_ship (is_user_ship), .user_ship_data (user_ship_data),
							.user_x_pos (user_x_pos), .user_y_pos (user_y_pos));
						
	 // row 1
	 eship_row row1 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .y_offset (10'd0), .play (play), .gameover (gameover1), .done (done),
					.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
					.is_enemy_ship1 (is_enemy_ship11), .enemy_ship_data1 (enemy_ship_data11),
					.is_enemy_ship2 (is_enemy_ship12), .enemy_ship_data2 (enemy_ship_data12),
					.is_enemy_ship3 (is_enemy_ship13), .enemy_ship_data3 (enemy_ship_data13),
					.is_enemy_ship4 (is_enemy_ship14), .enemy_ship_data4 (enemy_ship_data14),
					.is_enemy_ship5 (is_enemy_ship15), .enemy_ship_data5 (enemy_ship_data15),
					.is_enemy_ship6 (is_enemy_ship16), .enemy_ship_data6 (enemy_ship_data16),
					.score_row (score1));
					
	 // row 2
	 eship_row row2 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .y_offset (10'd80), .play (play), .gameover (gameover2), .done (done),
					.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
					.is_enemy_ship1 (is_enemy_ship21), .enemy_ship_data1 (enemy_ship_data21),
					.is_enemy_ship2 (is_enemy_ship22), .enemy_ship_data2 (enemy_ship_data22),
					.is_enemy_ship3 (is_enemy_ship23), .enemy_ship_data3 (enemy_ship_data23),
					.is_enemy_ship4 (is_enemy_ship24), .enemy_ship_data4 (enemy_ship_data24),
					.is_enemy_ship5 (is_enemy_ship25), .enemy_ship_data5 (enemy_ship_data25),
					.is_enemy_ship6 (is_enemy_ship26), .enemy_ship_data6 (enemy_ship_data26),
					.score_row (score2));
					
	 // row 3
	 eship_row row3 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .y_offset (10'd160), .play (play), .gameover (gameover3), .done (done),
					.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
					.is_enemy_ship1 (is_enemy_ship31), .enemy_ship_data1 (enemy_ship_data31),
					.is_enemy_ship2 (is_enemy_ship32), .enemy_ship_data2 (enemy_ship_data32),
					.is_enemy_ship3 (is_enemy_ship33), .enemy_ship_data3 (enemy_ship_data33),
					.is_enemy_ship4 (is_enemy_ship34), .enemy_ship_data4 (enemy_ship_data34),
					.is_enemy_ship5 (is_enemy_ship35), .enemy_ship_data5 (enemy_ship_data35),
					.is_enemy_ship6 (is_enemy_ship36), .enemy_ship_data6 (enemy_ship_data36),
					.score_row (score3));
	
		
		/*
	 enemy_ship eship (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), 
							.is_enemy_ship (is_enemy_ship11), .enemy_ship_data (enemy_ship_data11), 
							.enemy_x_pos (10'd50), .enemy_y_pos(10'd0), .gameover (done),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos));
							//.laser_hit (laser_hit));
		*/
					
	 // laser
	 user_laser ulaser (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), .keycode(keycode), 
							.user_x_pos (user_x_pos), .user_y_pos (user_y_pos),
							.is_laser (is_laser), .laser_data (laser_data),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos));
							//.laser_hit (laser_hit));
									
	 // logo controllers
	 logic is_galaga;
	 logic is_pressed_start;
	 logic is_gameover;
	 galaga_logo gl (.DrawX (DrawX), .DrawY (DrawY), .is_galaga (is_galaga));	
	 press_start_logo psl (.DrawX (DrawX), .DrawY (DrawY), .is_press_start (is_press_start));
	 gameover_logo go (.DrawX (DrawX), .DrawY (DrawY), .is_gameover (is_gameover));
							
							
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
				// laser
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
			
			// row 1
			else if (is_enemy_ship11 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data11[15:8];
				Green = enemy_ship_data11[23:16];
				Blue = enemy_ship_data11[7:0];
			end
			else if (is_enemy_ship12 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data12[15:8];
				Green = enemy_ship_data12[23:16];
				Blue = enemy_ship_data12[7:0];
			end
			else if (is_enemy_ship13 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data13[15:8];
				Green = enemy_ship_data13[23:16];
				Blue = enemy_ship_data13[7:0];
			end
			else if (is_enemy_ship14 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data14[15:8];
				Green = enemy_ship_data14[23:16];
				Blue = enemy_ship_data14[7:0];
			end
			else if (is_enemy_ship15 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data15[15:8];
				Green = enemy_ship_data15[23:16];
				Blue = enemy_ship_data15[7:0];
			end
			else if (is_enemy_ship16 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data16[15:8];
				Green = enemy_ship_data16[23:16];
				Blue = enemy_ship_data16[7:0];
			end
			
			// row 2
			else if (is_enemy_ship21 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data21[15:8];
				Green = enemy_ship_data21[23:16];
				Blue = enemy_ship_data21[7:0];
			end
			else if (is_enemy_ship22 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data22[15:8];
				Green = enemy_ship_data22[23:16];
				Blue = enemy_ship_data22[7:0];
			end
			else if (is_enemy_ship23 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data23[15:8];
				Green = enemy_ship_data23[23:16];
				Blue = enemy_ship_data23[7:0];
			end
			else if (is_enemy_ship24 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data24[15:8];
				Green = enemy_ship_data24[23:16];
				Blue = enemy_ship_data24[7:0];
			end
			else if (is_enemy_ship25 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data25[15:8];
				Green = enemy_ship_data25[23:16];
				Blue = enemy_ship_data25[7:0];
			end
			else if (is_enemy_ship26 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data26[15:8];
				Green = enemy_ship_data26[23:16];
				Blue = enemy_ship_data26[7:0];
			end
			
			// row 3
			else if (is_enemy_ship31 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data31[15:8];
				Green = enemy_ship_data31[23:16];
				Blue = enemy_ship_data31[7:0];
			end
			else if (is_enemy_ship32 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data32[15:8];
				Green = enemy_ship_data32[23:16];
				Blue = enemy_ship_data32[7:0];
			end
			else if (is_enemy_ship33 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data33[15:8];
				Green = enemy_ship_data33[23:16];
				Blue = enemy_ship_data33[7:0];
			end
			else if (is_enemy_ship34 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data34[15:8];
				Green = enemy_ship_data34[23:16];
				Blue = enemy_ship_data34[7:0];
			end
			else if (is_enemy_ship35 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data35[15:8];
				Green = enemy_ship_data35[23:16];
				Blue = enemy_ship_data35[7:0];
			end
			else if (is_enemy_ship36 == 1'b1) begin
				// enemy ship
				Red = enemy_ship_data36[15:8];
				Green = enemy_ship_data36[23:16];
				Blue = enemy_ship_data36[7:0];
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
			// draw galaga logo
			if (is_gameover == 1'b1) begin
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
			else begin
				Red = 8'h20;
				Green = 8'h00;
				Blue = 8'h00;
			end
		end
		
		// default -> white screen
		else begin
			Red = 8'hFF;
			Green = 8'hFF;
			Blue = 8'hFF;
		end
	end 
endmodule 