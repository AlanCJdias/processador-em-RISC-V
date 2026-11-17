//aqui vai ficar a parte que vai decidir de onde vem a informação da fonte B para a ALU.

module mux2SrcB (
    input wire [31:0] registrador,
    input wire [31:0] valorExtendido,
    input wire aluSrc,
    output wire [31:0] saida //é apenas combinacional, fazer com assign,
);

assign saida = aluSrc ? valorExtendido : registrador;

endmodule