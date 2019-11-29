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
				