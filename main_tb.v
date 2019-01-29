module Vending_Machine_tb;
  reg clk, rst;
  reg [1:0] money;
  wire [1:0] current_state;
  wire dispense, change;

  Vending_Machine U0 (
    .clk (clk),
    .rst (rst),
    .money (money),
    .dispense (dispense),
    .change (change), 
    .current_state (current_state)
  );

  initial begin
    clk = 0;
    rst = 1;
    money = 2'b0;
    #1
    rst = 0;
    #1
    money = 2'b00;
    #10
    money = 2'b10;
    #10
    money = 2'b00;
    #10
    money = 2'b00;
    #10
    money = 2'b01;
    #10
    money = 2'b10;
    #10
    money = 2'b00;
  end

  always
  #5 clk = !clk;

endmodule
