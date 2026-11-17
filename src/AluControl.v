module aluControl(
    input wire [1:0] aluop,      // vem do mainDecoder
    input wire op,               // bit 5 do opcode (instr[5])
    input wire [2:0] funct3,     // instr[14:12]
    input wire funct7b,          // bit 5 do funct7 (instr[30])
    output reg [2:0] aluControl  // saída de 3 bits para a ALU
);

    wire [1:0] licacao = {op, funct7b}; // ponto e vírgula adicionado

    always @(*) begin
        case (aluop)
            2'b00: begin
                aluControl = 3'b000; // add (lw, sw)
            end
            2'b01: begin
                aluControl = 3'b001; // sub (beq)
            end
            2'b10: begin
                case (funct3)
                    3'b000: begin
                        case (licacao)
                            2'b11:   aluControl = 3'b001; // sub
                            default: aluControl = 3'b000; // add, addi
                        endcase
                    end
                    3'b010:  aluControl = 3'b101; // slt, slti
                    3'b110:  aluControl = 3'b011; // or, ori
                    3'b111:  aluControl = 3'b010; // and, andi
                    default: aluControl = 3'b000;
                endcase
            end
            default: aluControl = 3'b000;
        endcase
    end

endmodule