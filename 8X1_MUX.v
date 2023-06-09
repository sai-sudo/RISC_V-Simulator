`timescale 1ns/1ps
module Mux_8x1 (
  input [7:0] data,
  input [2:0] sel,
  output out
);
  
  wire [3:0] mux_level_1 [0:3];
  wire [1:0] mux_level_2 [0:1];
  
  // Level 1 MUXes
  genvar i;
  generate
    for (i=0;i<4;i=i+1) begin
      Mux_4x1 mux_instance (.data({data[2*i+1],data[2*i]}), .sel (sel[1:0]), .out(mux_level_1[i]));
    end
  endgenerate

  // Level 2 Mux
  Mux_4x1 mux_instance (.data ({mux_level_1[1], mux_level_1[0]}), .sel(sel[2]), .out(mux_level_2[0]));
  
  // Final Mux
  Mux_4x1 mux_inst_1(.data({mux_level_2[1], mux_level_2[0]}), .sel(sel[2]), .out(out));
  
endmodule
