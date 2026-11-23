//aqui ficará o multiplexador do resultado.
//esse é o novo multiplexador que foi implementado.

module muxresultado(

    //entradas:
    input wire [31:0] resultadoALU,
    input wire [31:0] resultadoMULT,
    input wire ConUnitMult,

    //saídas:
    output wire [31:0] saida

);

// Se sair um do controle, será a multiplicação.
//a unidade de controe terá que ter mais uma saída(fazer isso depois).

assign saida = ConUnitMult ? resultadoMULT : resultadoALU;

endmodule