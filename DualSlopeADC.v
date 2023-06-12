module DualSlopeADC (
  input wire clk,
  input wire start,
  output wire done,
  output wire [7:0] digital_output
);

  reg [31:0] counter;
  reg [7:0] integration_result;
  reg [7:0] adc_result;
  reg conversion_done;

  // Constants for integration time and reference voltage
  parameter INTEGER_TIME = 16; // Integration time in clock cycles
  parameter REF_VOLTAGE = 1.0; // Reference voltage in volts

  always @(posedge clk) begin
    if (start) begin
      counter <= 32'b00000000000000000000000000000000;
      integration_result <= 8'b00000000;
      adc_result <= 8'b00000000;
      conversion_done <= 0;
      done <= 0;
    end
    else if (counter < INTEGER_TIME) begin
      counter <= counter + 1;
      integration_result <= integration_result + analog_input;
    end
    else if (counter == INTEGER_TIME) begin
      counter <= counter + 1;
      integration_result <= integration_result - analog_input;
    end
    else begin
      if (integration_result > 0) begin
        adc_result <= integration_result * REF_VOLTAGE / INTEGER_TIME;
      end
      else begin
        adc_result <= (integration_result * -1) * REF_VOLTAGE / INTEGER_TIME;
      end
      counter <= 32'b00000000000000000000000000000000;
      conversion_done <= 1;
      done <= 1;
    end
  end

  assign digital_output = conversion_done ? adc_result : 8'b00000000;

endmodule
