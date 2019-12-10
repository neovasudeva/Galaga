// hit_controller.sv
// 
// creates ships and detects hits between them

module hit_controller ( input 		Clk, Reset,
								input [9:0] enemy_ship_X_Pos, enemy_ship_Y_Pos,
								input [9:0]	user_laser_x_pos, user_laser_y_pos,
								output 		enemy_hit,
								input 		done);

	// constants to use later
	parameter [9:0] enemy_ship_size = 10'd30;      // enemy_ship's size (30x30)
	parameter [9:0] laser_X_Size = 10'd20;     		// laser's size (20x49 )
	parameter [9:0] laser_Y_Size = 10'd49;
	
	// ghetto hit detection lol
	logic temp = 1'b0;
	
	always_ff @ (posedge Clk or posedge Reset) begin
		if (Reset) 
			enemy_hit <= 1'b0;
		else if (done == 1'b1)
			enemy_hit <= 1'b0;
		else if (enemy_hit == 1'b0)
			enemy_hit <= temp;
		else
			enemy_hit <= 1'b1;
	end
	
	always_comb begin
		// detect a hit
		if (((user_laser_x_pos >= enemy_ship_X_Pos && user_laser_x_pos <= enemy_ship_X_Pos + enemy_ship_size) 
				|| (user_laser_x_pos + laser_X_Size >= enemy_ship_X_Pos && user_laser_x_pos + laser_X_Size <= enemy_ship_X_Pos + enemy_ship_size))
				&& ((user_laser_y_pos >= enemy_ship_Y_Pos && user_laser_y_pos <= enemy_ship_Y_Pos + enemy_ship_size)
				|| (user_laser_y_pos + laser_Y_Size >= enemy_ship_Y_Pos && user_laser_y_pos + laser_Y_Size <= enemy_ship_Y_Pos + enemy_ship_size))) begin
			//enemy_hit <= 1'b1;
			temp = 1'b1;
			//laser_hit = 1'b1;
		end
		else begin
			//enemy_hit <= 1'b0;
			temp = 1'b0;
			//laser_hit = 1'b0;
		end
	end
endmodule 