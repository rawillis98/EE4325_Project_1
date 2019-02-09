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
  input [1:0] money;
  
  reg [2:0] current_state;
  reg change, dispense;

  initial begin
    //initialize the current state to $0 and turn dispense and change off
    current_state <= 3'b000;
    dispense <= 1'b0;
    change <= 1'b0;
  end
    
  always @ (posedge clk) begin
    if (rst) begin
      current_state <= 3'b000; //$0 state 
      dispense <= 1'b0;
      change <= 1'b0;
    end else begin
      case(current_state)
        3'b000: begin //$0 state		  
          if(money == 2'b01) begin //input $0.25
            current_state <= 3'b001; //go to $0.25 state
          end else if (money == 2'b10) begin //input $0.50
            current_state <= 3'b010; //go to $0.50 state
          end else if (money == 2'b11) begin //input $1
            current_state <= 3'b100; //go to $1 state
          end //end if else
        end//end 3'b000

        3'b001:begin //$0.25 state
          if(money == 2'b01) begin //input $0.25
            current_state <= 3'b010; //go to $0.50 state
          end else if (money == 2'b10) begin //input $0.50
            current_state <= 3'b011; //go to $0.75 state
          end else if (money == 2'b11) begin //input $1
            current_state <= 3'b110; //go to dispense state
			dispense <= 1'b1;
          end //end if else
        end//end 3'b001

        3'b010:begin //$0.50 state
          if(money == 2'b01) begin //input $0.25
            current_state <= 3'b011; //go to $0.75 state
          end else if (money == 2'b10) begin //input $0.50
            current_state <= 3'b100; //go to $1 state
          end else if (money == 2'b11) begin //input $1
            current_state <= 3'b101; //go to overflow state
			change <= 1;
          end //end if else
        end//end 3'b010

        3'b011:begin //$0.75 state
          if(money == 2'b01) begin //input $0.25
            current_state <= 3'b100; //go to $1 state
          end else if (money == 2'b10) begin //input $0.50
            current_state <= 3'b110; //go to dispense state
			dispense <= 1'b1;
          end else if (money == 2'b11) begin //input $1
            current_state <= 3'b101; //go to overflow state
			change <= 1'b1;
          end //end if else
        end//end 3'b011

        3'b100:begin //$1
          if (money == 2'b01) begin //input $0.25
            current_state <= 3'b110; //go to dispense state
			dispense <= 1'b0;
          end else if (money == 2'b10) begin //input $0.50
            current_state <= 3'b101; //go to overflow
			change <= 1'b0;
          end else if (money == 2'b11) begin //input $1
            current_state <= 3'b101; //go to overflow
			change <= 1'b0;
          end //end if else
        end //end 3'b100
		
		3'b101:begin //Overflow state
		  change <= 1'b0;
          if(money == 2'b01) begin //input $0.25
            current_state <= 3'b001; //go to $0.25 state
          end else if (money == 2'b10) begin //input $0.50
            current_state <= 3'b010; //go to $0.50 state
          end else if (money == 2'b11) begin //input $1
            current_state <= 3'b100; //go to dispense state
			dispense <= 1'b1;
          end //end if else
        end //end 3'b110
		
		3'b110:begin //$1.25
		  if(money == 2'b00) begin
		    current_state <= 3'b001;
          end else if(money == 2'b01) begin //input $0.25
            current_state <= 3'b001; //go to $0.25 state
          end else if (money == 2'b10) begin //input $0.50
            current_state <= 3'b010; //go to $0.50 state
          end else if (money == 2'b11) begin //input $1
            current_state <= 3'b100; //go to $1 state
          end //end if else
        end //end 3'b100
		
      endcase
    end
  end
endmodule