// signal_controller.sv
// 
// idek what im doing lets be real
// but pls work

module signal_controller (input logic   		Clk,         								// 50 MHz clock signal 
                                       Reset,         							// Reset signal 
								  input logic [7:0]	keycode,										// key pressed
								  input  logic		died, killed_all1, killed_all2, 		// ship has been hit or enemies have been eliminated
								  output	logic		start, play, gameover, win,			// states
													boss_logo, boss_fight
);				

	// states
	enum logic [2:0] { START, PLAY, BOSS_LOGO, BOSS_FIGHT, GAMEOVER, WIN } state, next_state;
	
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
				if (died == 1'b1)
					next_state = GAMEOVER;
				else if (killed_all1 == 1'b1) 
					next_state = BOSS_LOGO;
				else
					next_state = PLAY;
			end
			BOSS_LOGO: begin
				if (keycode == 8'h28)
					next_state = BOSS_FIGHT;
				else
					next_state = BOSS_LOGO;
			end
			BOSS_FIGHT: begin
				if (died == 1'b1)
					next_state = GAMEOVER;
				else if (killed_all2 == 1'b1)
					next_state = WIN;
				else
					next_state = BOSS_FIGHT;
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
				boss_logo = 1'b0;
				boss_fight = 1'b0;
				gameover = 1'b0;
				win = 1'b0;
			end
			PLAY: begin
				start = 1'b0;
				play = 1'b1;
				boss_logo = 1'b0;
				boss_fight = 1'b0;
				gameover = 1'b0;
				win = 1'b0;
			end
			BOSS_LOGO: begin
				start = 1'b0;
				play = 1'b0;
				boss_logo = 1'b1;
				boss_fight = 1'b0;
				gameover = 1'b0;
				win = 1'b0;
			end
			BOSS_FIGHT: begin
				start = 1'b0;
				play = 1'b0;
				boss_logo = 1'b0;
				boss_fight = 1'b1;
				gameover = 1'b0;
				win = 1'b0;
			end
			GAMEOVER: begin
				start = 1'b0;
				play = 1'b0;
				boss_logo = 1'b0;
				boss_fight = 1'b0;
				gameover = 1'b1;
				win = 1'b0;
			end
			WIN: begin
				start = 1'b0;
				play = 1'b0;
				boss_logo = 1'b0;
				boss_fight = 1'b0;
				gameover = 1'b0;
				win = 1'b1;
			end
		endcase
	end
endmodule
