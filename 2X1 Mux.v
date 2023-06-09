`timescale 1ns/1ps
module mux2_1(
  inout a,
  input b,
  input s,
  output out);
  
  assign out=s?b:a;
endmodule
