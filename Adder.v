module adder_32bit (
  input wire [31:0] A,
  input wire [31:0] B,
  input wire carry_in,
  output wire [31:0] sum,
  output wire carry_out);
  
  wire [31:0] carry;
  wire [31:0] temp;
  
  genvar i;
  generate 
    for (i=0;i<32;i=i+1)
      begin
        assign temp[i]= A[i] & B[i];
        if (i==0) begin
          assign sum[i]=A[i]^B[i]^carry_in;
          assign carry[i]= temp[i] | (A[i] & carry_in) | (B[i] & carry_in) ;
        end
        else begin
          assign sum[i]=A[i]^B[i]^carry_in;
          assign carry[i]=temp[i] | (A[i] & carry[i-1]) | (B[i] & carry[i-1]);
        end
      end
  endgenerate
  
  assign carry_out = carry[31];
endmodule
          
                         
          
