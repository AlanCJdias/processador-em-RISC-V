//aqui ele vai ser o último multiplexador do processador.

module muxFinal (
    input wire [31:0] DataMemory,
    input wire [31:0] resultadoAlu,
    input wire [31:0] pcPlus4,
    input wire [1:0] ResultSrc, //agora tem que fazaer uma outra lógica, são 2 bits de separação.
    output reg [31:0] saida
);

//tenho que fazer os testes para ver se está prefeitamente funcionando.

always @(*) begin
    case (ResultSrc)
        2'b00: saida = resultadoAlu;
        2'b01: saida = DataMemory;
        2'b10: saida = pcPlus4;
        default: saida = 32'b0;
    endcase
 
end
endmodule