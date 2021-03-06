module Vending_Machine_tb;
  reg clk, rst;
  reg [1:0] money;
  wire [2:0] current_state;
  wire dispense, change;

  //Instantiate a vending machine
  Vending_Machine U0 (
    .clk (clk),
    .rst (rst),
    .money (money),
    .dispense (dispense),
    .change (change), 
    .current_state (current_state)
  );

  initial begin
    //Set the clock and reset the system with the async reset
    clk = 0;
    rst = 1;
    money = 2'b0;
    #1
	//Turn reset off
    rst = 0;
    #1
    money = 2'b00; //input $0 (should do nothing)
	#10
	money = 2'b01;
	#10 
	money = 2'b01;
	#10
	money = 2'b01;
	#10
	money = 2'b01;
	#10
	money = 2'b00;
	#10
	money = 2'b10;
	#10
	money = 2'b11;
    
  end

  always
  #5 clk = !clk; //flip the clock every 5ns

endmodule
