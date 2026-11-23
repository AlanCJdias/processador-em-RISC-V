// recebe apenas o op code.
module mainDecoder(
    input wire [6:0] opcode,

    //com a implementação da extensão de multiplicação:
    input wire funct7, //vai ser o que vai ditar se irá sair ou não para a multiplicação ou não.
    
    
    output reg regWrite,
    output reg [1:0] immSrc,    // aqui ele dita como o imediato vai ser extendido.
    output reg aluSrc,
    output reg memWrite,
    output reg [1:0] resultSrc, // ajustado para 2 bits com o livro (para suportar o jal)
    output reg branch,

    output reg [1:0] aluOP,     
    // essa parte daqui será a responsável por fazer a outra parte do decodificador funcionar

    output reg resultadoMux, //aqui será a parte que será responsável por selecionar o resultado do multiplexador.
    //quando for 1 ele vai para a multiplicação.
    
    output reg jump
);

always @(*) begin
    case(opcode) // aqui ele vai atribuir os valores certos com base no op code.
        // lw
        7'b0000011: begin
            regWrite  = 1'b1;
            immSrc    = 2'b00;
            aluSrc    = 1'b1;
            memWrite  = 1'b0;
            resultSrc = 2'b01;
            branch    = 1'b0;
            aluOP     = 2'b00;
            jump      = 1'b0;
            resultadoMux = 1'b0;
        end
        // sw
        7'b0100011: begin
            regWrite  = 1'b0;
            immSrc    = 2'b01;
            aluSrc    = 1'b1;
            memWrite  = 1'b1;
            resultSrc = 2'bxx;
            branch    = 1'b0;
            aluOP     = 2'b00;
            jump      = 1'b0;
            resultadoMux = 1'b0;
        end
        // R-type
        //todas as instruçoes do tipo M possuem o mesmo op code.
        7'b0110011: begin
            regWrite  = 1'b1;
            immSrc    = 2'bxx;
            aluSrc    = 1'b0;
            memWrite  = 1'b0;
            resultSrc = 2'b00;
            branch    = 1'b0;
            aluOP     = 2'b10;
            jump      = 1'b0;
            if( funct7 == 1'b0 )begin
                resultadoMux = 1'b0;
            end else begin
                resultadoMux = 1'b1; //aqui ele seleciona a multiplicação.
            end
        end
        // beq
        7'b1100011: begin
            regWrite  = 1'b0;
            immSrc    = 2'b10;
            aluSrc    = 1'b0;
            memWrite  = 1'b0;
            resultSrc = 2'bxx;
            branch    = 1'b1;
            aluOP     = 2'b01;
            jump      = 1'b0;
            resultadoMux = 1'b0;
        end
        // I-type ALU
        7'b0010011: begin
            regWrite  = 1'b1;
            immSrc    = 2'b00;
            aluSrc    = 1'b1;
            memWrite  = 1'b0;
            resultSrc = 2'b00;
            branch    = 1'b0;
            aluOP     = 2'b10;
            jump      = 1'b0;
            resultadoMux = 1'b0;
        end
        // jal
        7'b1101111: begin
            regWrite  = 1'b1;
            immSrc    = 2'b11;
            aluSrc    = 1'bx;
            memWrite  = 1'b0;
            resultSrc = 2'b10;
            branch    = 1'b0;
            aluOP     = 2'bxx;
            jump      = 1'b1;
            resultadoMux = 1'b0;
        end
        // Caso padrão só pra segurança do hardware
        //só para caso a instrução que eu passei não exista (não é compatível).
        default: begin
            regWrite  = 1'b0;
            immSrc    = 2'b00;
            aluSrc    = 1'b0;
            memWrite  = 1'b0;
            resultSrc = 2'b00;
            branch    = 1'b0;
            aluOP     = 2'b00;
            jump      = 1'b0;
            resultadoMux = 1'b0;
        end
    endcase
end

endmodule