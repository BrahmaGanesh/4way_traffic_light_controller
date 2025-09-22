module traffic_light_controller(
input clk,
input rst_n,
  output reg [2:0] North,
  output reg [2:0] East,
  output reg [2:0] South,
  output reg [2:0] West);
  
  localparam logic [2:0] RED    = 3'b100;
  localparam logic [2:0] YELLOW = 3'b010;
  localparam logic [2:0] GREEN  = 3'b001;
  
  typedef enum bit [2:0] {s0,s1,s2,s3,s4,s5,s6,s7} state_t;
  state_t state,next_state;
  
  always_ff @(posedge clk or negedge rst_n)begin
    if(!rst_n)
       state <= s0;
    else
      state <= next_state;
  end
  
  always_comb begin
    case(state)
      s0 : next_state = s1;
      s1 : next_state = s2;
      s2 : next_state = s3;
      s3 : next_state = s4;
      s4 : next_state = s5;
      s5 : next_state = s6;
      s6 : next_state = s7;
      s7 : next_state = s0;
      default : next_state = s0;
    endcase
  end
  
  always_comb begin
    North	= RED;
    East	= RED;
    South	= RED;
    West	= RED;
    
    case(state)
      s0 : North	= GREEN;
      s1 : North	= YELLOW;
      s2 : East		= GREEN;
      s3 : East 	= YELLOW;
      s4 : South 	= GREEN;
      s5 : South 	= YELLOW;
      s6 : West 	= GREEN;
      s7 : West 	= YELLOW;
    endcase
  end
endmodule