//aqui ele vai calcular o valor de pc+4

module pcPlus4(
    input wire [31:0] entrada,
    output wire [31:0] saida
);//aqui ele apenas vai somar mais 4 bits.

assign saida = entrada + 32'b100;//vai somar 4.

endmodule