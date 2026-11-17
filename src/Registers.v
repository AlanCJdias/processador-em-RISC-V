//aqui vai ficar o banco de registradores.

// Banco de 32 registradores de 32 bits. x0 e sempre zero.
// Leitura assincrona, escrita sincrona na borda de subida do clock.
// Conteudo inicial (x1..x31) carregado via $readmemh a partir de INIT_FILE,
// mantendo os valores de entrada separados do arquivo de instrucoes.
// o teste eu ponho no pc.v: `timescale 1ns/1ps

module register_file #(
    parameter INIT_FILE = ""
) (
    input wire        CLK,
    input wire        WE3,
    input wire [4:0]  A1,
    input wire [4:0]  A2,
    input wire [4:0]  A3,
    input wire [31:0] WD3,
    output wire [31:0] RD1,
    output wire [31:0] RD2
);

    reg [31:0] regs [1:31];
    integer i;

    initial begin
        for (i = 1; i <= 31; i = i + 1)
            regs[i] = 32'd0;
        if (INIT_FILE != "")
            $readmemh(INIT_FILE, regs);//apenas se tiver valores já slavos para os registradores.
    end

    assign RD1 = (A1 == 5'd0) ? 32'd0 : regs[A1];
    assign RD2 = (A2 == 5'd0) ? 32'd0 : regs[A2];

    always @(posedge CLK) begin
        if (WE3 && A3 != 5'd0)
            regs[A3] <= WD3;
    end

endmodule