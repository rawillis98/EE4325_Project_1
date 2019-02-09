module Vending_Machine(
  clk,
  rst,
  money,
  dispense,
  change,
  current_state);
  
  output dispense;
  output change;
  output current_state;
  
  input clk, rst;
  input [1:0] money; //2 bit array " "
  
  reg [2:0] current_state; //3 bit array
  reg change, dispense;

  initial begin
    //initialize the current state to $0 and turn dispense and change off
    current_state <= 2'b00;
    dispense <= 1'b0;
    change <= 1'b0;
  end
    
  always @ (posedge clk) begin
    if (rst) begin
      current_state <= 2'b00; //$0 state 
      dispense <= 1'b0;
      change <= 1'b0;
    end else begin
      case(current_state)
        2'b00: begin //$0 state
          if(money == 2'b01) begin //input $0.50
            current_state <= 2'b01; //go to $0.50 state
          end else if (money == 2'b10) begin //input $1
            current_state <= 2'b11; //go to dispense state
          end //end if else
	    dispense <= 1'b0;
        change <= 1'b0;
        end//end 2'b00

        2'b01:begin //$0.50 state
          if(money == 2'b01) begin //input $0.50
            current_state <= 2'b11; //go to dispense state
          end else if (money == 2'b10) begin //input $1
            current_state <= 2'b10; //go to return money state
          end //end if else
	      dispense <= 1'b0;
          change <= 1'b0;
        end //end 2'b01
        
        2'b10:begin//return change state
          current_state <= 2'b00; //go back to $0 state
	      dispense <= 1'b0;
          change <= 1'b1;
        end //end 2'b10
        
        2'b11: begin//dispense soda state
          if(money == 2'b00) begin //if nothing else is put in
            current_state <= 2'b00; //go to $0 state
          end else if (money == 2'b01) begin //input $0.50
            current_state <= 2'b01; //go to $0.50 state
          end else if (money == 2'b10) begin //input $1
            current_state <= 2'b11; //dispense another soda
          end //end if else
	      dispense <= 1'b1;
          change <= 1'b0;
        end //end 2'b11
      endcase
    end
  end
endmodule