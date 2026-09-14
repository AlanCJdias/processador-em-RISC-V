module compDois(//módulo para fazer o complementa a dois de um valor.

    input logic [7:0] entrada, //entrada.
    output logic [7:0] saida//saída.

);

assign saida = ~(entrada) + 8'b1;//inverte o valor e soma um bit;

endmodule;