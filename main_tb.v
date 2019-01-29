module Vending_Machine_tb;
  reg clk, rst;
  reg [1:0] money;
  wire dispense, change;

  Vending_Machine U0 (
    .clk (clk),
    .rst (rst),
    .money (money),
    .dispense (dispense),
    .change (change)
  );

  initial begin
    clk = 0;
    rst = 1;
    money = 2'b0;
    #2
    rst = 0;
    money = 2'b10;
    #10
    money = 2'b10;
    #10
    money = 2'b01;
    #10
    money = 2'b01;
  end

  always
  #5 clk = !clk;

endmodule
