`timescale 1ns/1ps

module tb_processador;

    reg clk;
    reg rst;

    // Instanciação do top-level do processador
    processador uut (
        .clk(clk),
        .rst(rst)
    );

    // Gerador de clock: período de 10ns (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Sequência de execução e validação
    initial begin
        // Arquivo de saída para análise no GTKWave
        $dumpfile("simulacao_recursiva.vcd");
        $dumpvars(0, tb_processador);

        // 1. Aplica o reset inicial
        rst = 1;
        #15;
        rst = 0;

        // 2. Aguarda 80 ciclos de clock (800ns) — tempo suficiente para
        //    executar toda a recursão soma(4) e gravar o resultado na memória
        #800;

        $display("=========================================================");
        $display("Simulacao encerrada em %0t ns!", $time);
        $display("PC Final: 0x%h", uut.pcResultante);
        $display("=========================================================");
        $finish;
    end

    // Monitoramento ciclo a ciclo no terminal
    always @(posedge clk) begin
        if (!rst) begin
            $display("T=%3t ns | PC=0x%02h | Instr=0x%h | ALUResult=%3d | MemWrite=%b | WriteData=%3d",
                     $time,
                     uut.pcResultante,
                     uut.instru,
                     $signed(uut.resultadoAlu),
                     uut.mwrite,
                     $signed(uut.rd2));

            // Alerta visual no terminal quando o resultado final (10) for gravado no endereço 0
            if (uut.mwrite && (uut.resultadoAlu == 32'd0)) begin
                $display(">>> SUCESSO: Resultado final gravado na DataMemory[0] = %0d <<<",
                         $signed(uut.rd2));
            end
        end
    end

endmodule