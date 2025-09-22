module tb_traffic_light_controller;
  logic clk,rst_n;
  logic [2:0] North,East,South,West;
  localparam [2:0] RED 		= 3'b100;
  localparam [2:0] YELLOW	= 3'b010;
  localparam [2:0] GREEN	= 3'b001;

  traffic_light_controller dut(.clk(clk),.rst_n(rst_n),.North(North),.East(East),.South(South),.West(West));

initial clk = 0;
always #5 clk = ~clk;
  
  function string Light_name(input [2:0] light);
    case(light)
      RED : return "RED";
      YELLOW : return "YELLOW";
      GREEN : return "GREEN";
    endcase
  endfunction
initial begin
  rst_n = 0;
  #10 rst_n =1;
  
  repeat(30)begin
    @(posedge clk);
    
  assert (^North === 1) else $error("North signal invalid at %0t", $time);
  assert (^East  === 1) else $error("East signal invalid at %0t", $time);
  assert (^South === 1) else $error("South signal invalid at %0t", $time);
  assert (^West  === 1) else $error("West signal invalid at %0t", $time);
    
    $display("[%0t] | state=%b | North=%s | East=%s | South=%s |  West=%s",$time,dut.state,Light_name(North),Light_name(East),Light_name(South),Light_name(West));
  end
  $display("Test completed successfully.");
  $finish;
end
initial begin
  $dumpfile("traffic_light_controller.vcd");
  $dumpvars(0,tb_traffic_light_controller);
end
endmodule