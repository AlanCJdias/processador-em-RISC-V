`timescale 1ns/1ps

module teste;
    reg clk;
    reg rst;

    // Instanciação do módulo top-level do processador
    processador uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock de 10ns (5ns alto, 5ns baixo)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Estímulos e dump de ondas para o GTKWave
    initial begin
        $dumpfile("simulacao_rv32im.vcd");
        $dumpvars(0, teste);

        // Pulso inicial de reset
        rst = 1;
        #15;
        rst = 0;

        // Aguarda 80 ciclos (800ns): suficiente para executar 4! recursivo + testes div/rem por 0
        #800;

        $display("Simulacao concluida! Abra simulacao_rv32im.vcd no GTKWave.");
        
        $finish;
    end
endmodule