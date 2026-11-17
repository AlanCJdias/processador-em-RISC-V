//multiplexador de duas entradas.
//tenho que fazer os dois baseados no livro, para pegar a enrada certa de cada um deles.
//são apenas dois registradores, vou fazer um para cada.

module mux2pc (
    input  wire [31:0] pcp4,
    input  wire [31:0] pcTarget,
    input  wire        pcSrc,     // 0 -> pcp4, 1 -> pcTarget
    output wire [31:0] saida
);

    // Se pcSrc for 1, escolhe pcTarget; se for 0, escolhe pcp4
    // é só uma atribuição simples.

    assign saida = pcSrc ? pcTarget : pcp4;

endmodule