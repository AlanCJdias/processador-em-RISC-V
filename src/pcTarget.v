//quando tiver um salto, ele vai calcular o imediato que deve ser calculado.
//deve receber o valor de entrada e o pc 

module pctarget(
    input wire [31:0] pc,
    input wire [31:0] immExtend,
    output wire [31:0] valorCalculado
);

assign valorCalculado = pc + immExtend;

endmodule