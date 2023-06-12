module ADC(
  input wire clk, start, [7:0] analog_input, output wire [7:0] digital_output);
  
  reg [7:0] counter;
  reg [7:0] adc_result;
  reg conversion_done;
  
  always @(posedge clk) 
    begin
      if (start)
        begin
          counter <=8'b00000000;
          adc_result <=8'b00000000;
          conversion_done <=0;
        end
      else if (counter < 8'b11111111)
        begin
          counter <= counter+1;
          adc_result <= adc_result + analog_input;
        end
      else begin
        counter <=8'b00000000;
        conversion_done <=1;
      end
    end
  
  assign digital_output= conversion_done ? adc_result : 8'b00000000;
  
endmodule
