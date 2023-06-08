module alu_control (
  input wire [6:0] opcode,
  input wire [2:0] funct3,
  input wire [4:0] funct7,
  output reg [2:0] alu_ctrl
);

  always @* begin
    case (opcode)
      7'b0110011: begin
        // R-type instructions
        case (funct7)
          7'b0000000:
            case (funct3)
              3'b000: alu_ctrl = 3'b000;    // ADD
              3'b001: alu_ctrl = 3'b001;    // SLL
              3'b010: alu_ctrl = 3'b010;    // SLT
              3'b011: alu_ctrl = 3'b011;    // SLTU
              3'b100: alu_ctrl = 3'b100;    // XOR
              3'b101: alu_ctrl = 3'b101;    // SRL
              3'b110: alu_ctrl = 3'b110;    // OR
              3'b111: alu_ctrl = 3'b111;    // AND
              default: alu_ctrl = 3'b000;    // Default: ADD
            endcase
          7'b0100000:
            case (funct3)
              3'b101: alu_ctrl = 3'b000;    // SRA
              default: alu_ctrl = 3'b000;    // Default: ADD
            endcase
          default: alu_ctrl = 3'b000;        // Default: ADD
        endcase
      end
      7'b0010011: begin
        // I-type instructions
        case (funct3)
          3'b000: alu_ctrl = 3'b000;        // ADDI
          3'b001: alu_ctrl = 3'b001;        // SLLI
          3'b010: alu_ctrl = 3'b010;        // SLTI
          3'b011: alu_ctrl = 3'b011;        // SLTIU
          3'b100: alu_ctrl = 3'b100;        // XORI
          3'b101:
            case (funct7[5:1])
              5'b00000: alu_ctrl = 3'b101;   // SRLI
              5'b01000: alu_ctrl = 3'b000;   // SRAI
              default: alu_ctrl = 3'b000;    // Default: ADDI
            endcase
          3'b110: alu_ctrl = 3'b110;        // ORI
          3'b111: alu_ctrl = 3'b111;        // ANDI
          default: alu_ctrl = 3'b000;        // Default: ADDI
        endcase
      end
      // Add more cases for other opcode values if needed
      default: alu_ctrl = 3'b000;            // Default: ADD
    endcase
  end

endmodule
