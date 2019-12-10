// signal_controller.sv
// 
// idek what im doing lets be real
// but pls work

module signal_controller (input         Clk,         				// 50 MHz clock signal 
                                        Reset,         			// Reset signal 
								  input [7:0]	keycode,						// key pressed
								  input 			died, killed_all, 			// ship has been hit or enemies have been eliminated
								  output 		start, play, gameover, win	// states
);

	// states
	enum logic [1:0] { START, PLAY, GAMEOVER, WIN } state, next_state;
	
	// change state and rounds completed every clock cycle
	always_ff @ (posedge Clk) begin
		if (Reset) begin
			state <= PLAY;
		end
		else begin
			state <= next_state;
		end
	end
	
	// next state logic 
	always_comb begin
		// default -> set next_state to current state
		next_state = state;
		
		// state transitions
		unique case (state) 
			START: begin
				if (keycode == 8'h28)
					next_state = PLAY;
				else
					next_state = START;
			end
			PLAY: begin
				if (died == 1'b1)
					next_state = GAMEOVER;
				else if (killed_all == 1'b1) 
					next_state = WIN;
				else
					next_state = PLAY;
			end
			GAMEOVER: begin
				if (keycode == 8'h28)
					next_state = START;
				else
					next_state = GAMEOVER;
			end
			WIN: begin
				if (keycode == 8'h28)
					next_state = START;
				else
					next_state = WIN;
			end
		endcase 
	end

	// output signals from state
	always_comb begin 
		unique case (state)
			START: begin
				start = 1'b1;
				play = 1'b0;
				gameover = 1'b0;
				win = 1'b0;
			end
			PLAY: begin
				start = 1'b0;
				play = 1'b1;
				gameover = 1'b0;
				win = 1'b0;
			end
			GAMEOVER: begin
				start = 1'b0;
				play = 1'b0;
				gameover = 1'b1;
				win = 1'b0;
			end
			WIN: begin
				start = 1'b0;
				play = 1'b0;
				gameover = 1'b0;
				win = 1'b1;
			end
		endcase
	end
endmodule
