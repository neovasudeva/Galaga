// RAM for storing RGB values for user ship
module shipRAM
(
		input [10:0] read_address,
		input Clk,

		output logic [23:0] data_out
);

  // mem has width of 24 bits and a total of 2048 addresses
  logic [23:0] mem [0:1600];

  // store ship hex values into mem
  initial
  begin
  	 $readmemh("image.txt", mem);
  end

  // access hex at read_address
  always_ff @ (posedge Clk) begin
    if (read_address >= 11'b0 && read_address <= 11'd1600)
      data_out <= mem[read_address];
    else
      data_out <= 24'b0;
	end

endmodule



// RAM for storing RGB values for enemey ship
module enemyRAM
(
		input [9:0] read_address,
		input Clk,

		output logic [23:0] data_out
);

  // mem has width of 24 bits and a total of 1024 addresses
  logic [23:0] mem [0:900];

  // store ship hex values into mem
  initial
  begin
  	 $readmemh("bad-guy.txt", mem);
  end

  // access hex at read_address
  always_ff @ (posedge Clk) begin
    // validate address, then access address
    if (read_address >= 10'b0 && read_address <= 10'd900)
      data_out <= mem[read_address];

    // if invalid adress, return black pixel
	 else
		data_out <= 23'b0;
  end
	
endmodule



// RAM for storing RGB values for laser
module laserRAM
(
		input [9:0] read_address,
		input Clk,

		output logic [23:0] data_out
);

  // mem has width of 24 bits and a total of 1024 addresses
  logic [23:0] mem [0:980];

  // store ship hex values into mem
  initial
  begin
  	 $readmemh("laser.txt", mem);
  end

  // access hex at read_address
  always_ff @ (posedge Clk) begin
    // validate address, then access address
    if (read_address >= 10'b0 && read_address <= 10'd980)
      data_out <= mem[read_address];

	 // if invalid adress, return black pixel
	 else
		data_out <= 23'b0;
  end

endmodule
