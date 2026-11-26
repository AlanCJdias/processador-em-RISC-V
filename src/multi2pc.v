//multiplexador de duas entradas.
//tenho que fazer os dois baseados no livro, para pegar a enrada certa de cada um deles.
//são apenas dois registradores, vou fazer um para cada.

module mux2pc (

    input  wire [31:0] pcp4,
    input  wire [31:0] pcTarget,
    input  wire [31:0] saidaAlu, //aqui está a alteração para fazer a jalr.
    input  wire [1:0] pcSrc,     // 0 -> pcp4, 1 -> pcTarget
    output reg [31:0] saida

);

always @(*) begin
    case (pcSrc)
        2'b00: saida = pcp4;
        2'b01: saida = pcTarget;
        2'b10: saida = {saidaAlu[31:1], 1'b0}; //aqui tem uma bosta que ele desconsidera o ultimo bit.
        default: saida = 32'd0; //vai tratar tudo igual a 0.
    endcase    
end

endmodule