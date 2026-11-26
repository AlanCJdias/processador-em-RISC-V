//instruções de memória, deve receber o arquivo em formato hex.

// Memoria de instrucoes (ROM). Carregada a partir de um arquivo .hex via
module instr_mem #(
    parameter MEM_WORDS = 1024,
    parameter INIT_FILE = "src/firmware.hex"//aqui que via ficar o arquivo das instruções.
) (
    input wire [31:0]  addr, //aqui fica o pc
    output wire [31:0] instr //aqui vai ficar a instrucao.
);

    reg [31:0] mem [0:MEM_WORDS-1];

    // $readmemh (uma palavra de 32 bits por linha). Acesso combinacional.
    initial begin
        if (INIT_FILE != "")
            $readmemh(INIT_FILE, mem);
    end

    // pc e alinhado a 4 bytes, descarta os 2 bits menos significativos
    assign instr = mem[addr[31:2] % MEM_WORDS];

endmodule