// eship_row.sv
//
// used to represent a row of enemy ships 

module eship_row (input         Clk,         	// 50 MHz clock signal   
											Reset,         // Reset signal 
											frame_clk,     // ~60 MHz clock signal
						 input [9:0]   DrawX, DrawY,  // Current drawing coordinates
						 input			play, 			// are we currently in play state?
						 input [9:0] 	y_offset,
						 output 			gameover, 		// enemies have won
						 input 			done, 			// game has finished, reset ships and restart score
						 input [9:0] 	user_laser_x_pos,
						 input [9:0] 	user_laser_y_pos,
						 output is_enemy_ship1,
                   output [23:0] enemy_ship_data1,
                   output is_enemy_ship2,
                   output [23:0] enemy_ship_data2,
                   output is_enemy_ship3,
                   output [23:0] enemy_ship_data3,
                   output is_enemy_ship4,
                   output [23:0] enemy_ship_data4,
                   output is_enemy_ship5,
                   output [23:0] enemy_ship_data5,
                   output is_enemy_ship6,
                   output [23:0] enemy_ship_data6,
						 output [4:0] score_row);

	// gameover logic 
	logic gameover1, gameover2, gameover3, gameover4, gameover5, gameover6;
	assign gameover = gameover1 || gameover2 || gameover3 || gameover4 || gameover5 || gameover6;
	
	// bounce logic
	logic [4:0] count1, count2, count3, count4, count5, count6;
	assign score_row = count1 + count2 + count3 + count4 + count5 + count6;
	
	// enemy ships	
	enemy_ship eship1 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), 
							.is_enemy_ship (is_enemy_ship1), .enemy_ship_data (enemy_ship_data1), 
							.enemy_x_pos (10'd50), .enemy_y_pos(y_offset), .play (play), .gameover (gameover1),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
							.count (count1), .done (done));
							
							
	enemy_ship eship2 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), 
							.is_enemy_ship (is_enemy_ship2), .enemy_ship_data (enemy_ship_data2),
							.enemy_x_pos (10'd100), .enemy_y_pos(y_offset), .play (play), .gameover (gameover2),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
							.count (count2), .done (done));
							
	enemy_ship eship3 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), 
							.is_enemy_ship (is_enemy_ship3), .enemy_ship_data (enemy_ship_data3),
							.enemy_x_pos (10'd150), .enemy_y_pos(y_offset), .play (play), .gameover (gameover3),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
							.count (count3), .done (done));
							
	enemy_ship eship4 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), 
							.is_enemy_ship (is_enemy_ship4), .enemy_ship_data (enemy_ship_data4),
							.enemy_x_pos (10'd200), .enemy_y_pos(y_offset), .play (play), .gameover (gameover4),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos), 
							.count (count4), .done (done));
							
	enemy_ship eship5 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), 
							.is_enemy_ship (is_enemy_ship5), .enemy_ship_data (enemy_ship_data5),
							.enemy_x_pos (10'd250), .enemy_y_pos(y_offset), .play (play), .gameover (gameover5),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
							.count (count5), .done (done));
							
	enemy_ship eship6 (.Clk (Clk), .Reset (Reset), .frame_clk (frame_clk), .DrawX(DrawX), .DrawY(DrawY), 
							.is_enemy_ship (is_enemy_ship6), .enemy_ship_data (enemy_ship_data6),
							.enemy_x_pos (10'd300), .enemy_y_pos(y_offset), .play (play), .gameover (gameover6),
							.user_laser_x_pos (user_laser_x_pos), .user_laser_y_pos (user_laser_y_pos),
							.count (count6), .done (done));

endmodule 