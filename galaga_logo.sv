// galaga_logo.sv
// 
// used to print galaga_logo
// oof

module galaga_logo (input [9:0] DrawX, DrawY,	// drawing coordinates
							output is_galaga		// if current drawing coords match logo
							);
							
	// get data from ROM and temp logic
	logic [3:0] addr;
	logic [95:0] data;
	galaga_rom gl (.addr (addr), .data (data));
	
	// logic to get data from ROM
	always_comb begin
		if (DrawX >= 10'd272 && DrawX <= 10'd368
				&& DrawY >= 10'd232 && DrawY <= 10'd248) begin
				addr = DrawY - 10'd232;
				// if there is a 1 in sprite rom
				if (data[7'd95 - (DrawX - 10'd272)] == 1'b1)
					is_galaga = 1'b1;
				else
					is_galaga = 1'b0;
		end
		else begin
			addr = 4'b0;
			is_galaga = 1'b0;
		end
	end
endmodule

module gameover_logo (input [9:0] DrawX, DrawY,
								output is_gameover);
	// get data from ROM and temp logic
	logic [3:0] addr;
	logic [127:0] data;
	gameover_rom gr (.addr (addr), .data (data));
	
	// logic to get data from ROM
	always_comb begin
		if (DrawX >= 10'd256 && DrawX <= 10'd384
				&& DrawY >= 10'd232 && DrawY <= 10'd248) begin
				addr = DrawY - 10'd232;
				// if there is a 1 in sprite rom
				if (data[7'd127 - (DrawX - 10'd256)] == 1'b1)
					is_gameover = 1'b1;
				else
					is_gameover = 1'b0;
		end
		else begin
			addr = 4'b0;
			is_gameover = 1'b0;
		end
	end
endmodule

module press_start_logo (input [9:0] DrawX, DrawY,		// drawing coordinates
								output is_press_start				// if current drawing coords match logo
								);
							
	// get data from ROM and temp logic
	logic [2:0] addr;
	logic [55:0] data;
	press_start_rom psr (.addr (addr), .data (data));
	
	// logic to get data from ROM
	always_comb begin
		if (DrawX >= 10'd293 && DrawX <= 10'd348
				&& DrawY >= 10'd253 && DrawY <= 10'd258) begin
				addr = DrawY - 10'd253;
				// if there is a 1 in sprite rom
				if (data[6'd55 - (DrawX - 10'd293)] == 1'b1)
					is_press_start = 1'b1;
				else
					is_press_start = 1'b0;
		end
		else begin
			addr = 4'b0;
			is_press_start = 1'b0;
		end
	end
endmodule

module you_win_logo (input [9:0] DrawX, DrawY,		// drawing coordinates
								output is_you_win);				// if current drawing coords match logo
	// get data from ROM and temp logic
	logic [3:0] addr;
	logic [111:0] data;
	you_win_rom ywr (.addr (addr), .data (data));
	
	// logic to get data from ROM
	always_comb begin
		if (DrawX >= 10'd264 && DrawX <= 10'd376
				&& DrawY >= 10'd232 && DrawY <= 10'd248) begin
				addr = DrawY - 10'd232;
				// if there is a 1 in sprite rom
				if (data[7'd111 - (DrawX - 10'd264)] == 1'b1)
					is_you_win = 1'b1;
				else
					is_you_win = 1'b0;
		end
		else begin
			addr = 4'b0;
			is_you_win = 1'b0;
		end
	end
endmodule

module boss_logo (input [9:0] DrawX, DrawY,		// drawing coordinates
								output is_boss);				// if current drawing coords match logo
	// get data from ROM and temp logic
	logic [3:0] addr;
	logic [63:0] data;
	boss_rom br (.addr (addr), .data (data));
	
	// logic to get data from ROM
	always_comb begin
		if (DrawX >= 10'd288 && DrawX <= 10'd352
				&& DrawY >= 10'd232 && DrawY <= 10'd248) begin
				addr = DrawY - 10'd232;
				// if there is a 1 in sprite rom
				if (data[7'd63 - (DrawX - 10'd288)] == 1'b1)
					is_boss = 1'b1;
				else
					is_boss = 1'b0;
		end
		else begin
			addr = 4'b0;
			is_boss = 1'b0;
		end
	end
endmodule
