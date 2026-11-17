//aqui vai ficar toda a unidade de memória.

// MEMORIA DE DADOS
module dmem (
    input clk, memwrite,
    input [31:0] addr, writedata,
    output [31:0] readdata
);

    reg [31:0] RAM [63:0]; // 32x64 RAM

    // le dado da memoria
    assign readdata = RAM[addr[31:2]];

    // escreve dado na memoria
    always @(posedge clk)
        if (memwrite)
            RAM[addr[31:2]] <= writedata;

endmodule