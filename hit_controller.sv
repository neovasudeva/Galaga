// hit_controller.sv
// 
// creates ships and detects hits between them

module hit_controller ( input [9:0] user_x_pos, user_y_pos,
												user_laser_x_pos, user_laser_y_pos,
												enemy_x_pos, enemy_y_pos,
								output 		enemy_hit);

	// constants to use later
	parameter [9:0] user_ship_size = 10'd40;       // User_Ship's size (40x40)
	parameter [9:0] enemy_ship_size = 10'd30;      // enemy_ship's size (30x30)
	parameter [9:0] laser_X_Size = 10'd20;     		// laser's size (20x49 )
	parameter [9:0] laser_Y_Size = 10'd49;
	
	// temp logic to make my life eaiser
	logic sit1;
	assign sit1 = (((user_laser_x_pos + laser_X_Size) - enemy_x_pos < enemy_ship_size) || (user_laser_x_pos - enemy_x_pos < enemy_ship_size)
							&& user_laser_y_pos < (enemy_y_pos + laser_Y_Size));
	// ghetto hit detection lol
	always_comb begin 
		if (sit1) 
			enemy_hit = 1'b1;
		else
			enemy_hit = 1'b0;
	end
endmodule 