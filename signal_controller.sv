// signal_controller.sv
// 
// idek what im doing lets be real
// but pls work

module signal_controller (input         Clk,         	// 50 MHz clock signal 
                                        Reset,         // Reset signal 
								  input [7:0]	keycode,			// key pressed
								  input 			hit, 				// ship has been hit
								  output 		start, play, gameover	// states
);

	// states
	enum logic [1:0] { START, PLAY, GAMEOVER } state, next_state;
	
	// change state and rounds completed every clock cycle
	always_ff @ (posedge Clk) begin
		if (Reset) begin
			state <= START;
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
				if (hit == 1'b1)
					next_state = GAMEOVER;
				else
					next_state = PLAY;
			end
			GAMEOVER: begin
				if (keycode == 8'h28)
					next_state = PLAY;
				else
					next_state = GAMEOVER;
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
			end
			PLAY: begin
				start = 1'b0;
				play = 1'b1;
				gameover = 1'b0;
			end
			GAMEOVER: begin
				start = 1'b0;
				play = 1'b0;
				gameover = 1'b1;
			end
		endcase
	end
endmodule
