`timescale 1ns/1ps

module async_FIFO(
  input wire clk_rd,
  input wire clk_wr,
  input wire rst,
  input wire wr_en,
  input wire rd_en,
  input [31:0] data_in,
  output reg [31:0] data_out,
  output full,
  output empty
);
  
  parameter DEEPTH = 128;
  parameter WORD_SIZE= 32;
  
  reg [WORD_SIZE-1:0] fifo_mem [0: DEPTH-1];
  reg [6:0]read_ptr;
  reg [6:0]write_ptr;
  reg [7:0]count;
  
  assign full = (count==DEPTH);
  assign empty = (count==0);
  
  always @(posedge clk_wr)
    begin
      if (wr_en && !full) begin
        fifo_mem[write_ptr]<=data_in;
        write_ptr<=write_ptr+1;
        count= count+1;
      end
    end
  
  always @(posedge clk_rd)
    begin
      if (rd_en && !empty) begin
        data_out<=fifo_mem[read_ptr];
        read_ptr<=read_ptr+1;
        count=count-1;
      end
    end  
endmodule
