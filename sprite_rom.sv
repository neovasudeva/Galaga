module sprite_rom (input [10:0] addr,
						output [15:0] data);
						
	parameter ADDR_WIDTH = 11;
	parameter DATA_WIDTH = 16;
	logic [ADDR_WIDTH-1:0] addr_reg;
	
	// rom stuff
	// parameter [0:2**ADDR_WIDTH-1][DATA_WIDTH-1:0] ROM = {
	logic [47:0][15:0] ROM;
	assign ROM = {
		
		// enemy ship
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0010000100001000,
		16'b 0010001110001000,
		16'b 0011111111111000,
		16'b 0011111111111000,
		16'b 0011111111111000,
		16'b 0001111111110000,
		16'b 0000111111100000,
		16'b 0000010101000000,
		16'b 0000000100000000,
		16'b 0000000100000000,
		16'b 0000000100000000,
		16'b 0000000000000000,
		
		// shooty boi
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000110000000,
		16'b 0000001111000000,
		16'b 0000011111100000,
		16'b 0000011111100000,
		16'b 0000001111000000,
		16'b 0000000110000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		16'b 0000000000000000,
		
		// user ship
		16'b 0000000100000000,
		16'b 0000000100000000,
		16'b 0000000100000000,
		16'b 0000001110000000,
		16'b 0000001110000000,
		16'b 0001001110010000,
		16'b 0001001110010000,
		16'b 0001011111010000,
		16'b 1001111111110010,
		16'b 1001111111110010,
		16'b 1001111111110010,
		16'b 1011111111111010,
		16'b 1111111111111110,
		16'b 1110111111101110,
		16'b 1100110101100110,
		16'b 1000000100000010
		
	};
	
	assign data = ROM[addr];
		
endmodule		

		
		
		
		