module alu (
  input wire [31:0] operand_A,
  input wire [31:0] operand_B,
  input wire [2:0] alu_ctrl,
  output reg [31:0] alu_result,
  output reg zero
);

  always @* begin
    case (alu_ctrl)
      3'b000: alu_result = operand_A + operand_B;    // Add
      3'b001: alu_result = operand_A - operand_B;    // Subtract
      3'b010: alu_result = operand_A & operand_B;    // Bitwise AND
      3'b011: alu_result = operand_A | operand_B;    // Bitwise OR
      3'b100: alu_result = operand_A ^ operand_B;    // Bitwise XOR
      3'b101: alu_result = operand_A << operand_B;   // Shift left logical
      3'b110: alu_result = operand_A >> operand_B;   // Shift right logical
      3'b111: alu_result = (operand_A < operand_B) ? 1 : 0;   // Set if less than
      default: alu_result = 0;                       // Default value
    endcase
  end

  assign zero = (alu_result == 0) ? 1 : 0;    // Set zero flag

endmodule
