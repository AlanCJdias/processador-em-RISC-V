// ALU combinacional (apenas as operacoes usadas neste exemplo: ADD, SUB,
// AND, OR). Selecao feita pelo controle simplificado do testbench.

module alu (
    input wire [31:0] SrcA,
    input wire [31:0] SrcB,

    //aqui deve ser atualizado, como eu vou fazer mais operações de ULA, deverá ser atualizado para mais bits.
    input wire [2:0] ALUControl, // apenas 3 bits para bater com o UnitControl


    output reg [31:0] ALUResult,
    output wire Zero
);

    localparam ALU_ADD = 3'b000;
    localparam ALU_SUB = 3'b001;
    localparam ALU_AND = 3'b010;
    localparam ALU_OR  = 3'b011;

    always @(*) begin
        case (ALUControl)
            ALU_ADD: ALUResult = SrcA + SrcB;
            ALU_SUB: ALUResult = SrcA - SrcB;
            ALU_AND: ALUResult = SrcA & SrcB;
            ALU_OR:  ALUResult = SrcA | SrcB;
            default: ALUResult = 32'd0;
        endcase
    end

    assign Zero = (ALUResult == 32'd0);

endmodule