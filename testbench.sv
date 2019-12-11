module testbench();

timeunit 10ns;
timeprecision 1ns;

logic Clk;        
logic Reset;
logic [7:0]  keycode;
logic died;
logic killed_all1;
logic killed_all2;
logic start;
logic play;
logic gameover;
logic win;
logic boss_fight;
logic boss_logo;
		
signal_controller test (.*);

always begin : CLOCK_GENERATION

#1 Clk=~Clk;

end

initial begin : CLOCK_INITIALIZATION
	Clk = 0;
end		

initial begin : TEST_VECTORS
	Reset = 1'b1;
#2 Reset = 1'b0;
#2 keycode = 8'h28;
#2 keycode = 8'h00;
#15 died = 1'b1;
	
end
endmodule 