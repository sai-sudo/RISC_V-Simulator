module fifo(
  inout wire clk,
  input wire rst,
  input wire wr_en,
  input wire rd_en,
  input wire [31:0] data_in,
  output reg [31:0] data_out,
  output wire full,
  output wire empty
);
  
  parameter DEPTH = 128;
  parameter WORD_SIZE = 32;
  
  reg [WORD_SIZE-1:0] memory [0:DEPTH-1];
  reg [6:0] write_ptr;
  reg [6:0] read_ptr;
  reg [6:0] count;
  
  assign full = (count == DEPTH);
  assign empty = (count == 0);
  assign data_out = memory[read_ptr];
  
  always @(posedge clk) begin
    if (rst) begin 
      write_ptr <=0;
      read_ptr <=0;
      count <=0;
    end
  else begin
    if (wr_en && !full)
      begin
        memory[write_ptr] <=data_in;
        write_ptr <= write_ptr+1;
        count <= count+1;
      end
    if (rd_en && !empty)
      begin
        data_out<=memory[read_ptr];
        read_ptr <= read_ptr+1;
        count <=count-1;
      end
  end
  end
endmodule
