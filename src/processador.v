//aqui vai ficar a instanciação do pc por completo.

module processador(

    //ele só vai receber a entrada clk e a entrada o rst.
    input wire clk,
    input wire rst

);


//os testes estão funcionando de forma perfeita. (talvez eu adicione uma função para fazer multiplicação de forma nativa).

//=======================================================================
//=======================================================================
//aqui abaxo devem ficar todas as partes od processador já instanciadas:
//vou começar a fazer da esquerda para a diretia, como no livro.
//=======================================================================
//=======================================================================

//=======================================================================
//aqui vai ficar o primeiro multiplexador, que vai receber o pc e escolher de onde vem:
//=======================================================================

//eu tenho que fazer o wire das saídas para ão causar ume perca de dados.

wire [31:0] pcnovo; //a saída do multiplexador

mux2pc multiplexadorpc(

    .pcp4(saidapcPlus4), //nome bem autoexplicativo.
    .pcTarget(pctargetSaida), //nome bem autoexplicativo.

    //vou usar ese daqui só para parecer mais descolado (emoje oculós escuro).
    .saidaAlu(saidaMultiplexadorMult),//aqui fica a saida da ALU.

    .pcSrc(saidaPCSc),//não declarei ainda. nome será esse
    .saida(pcnovo)

);

//=======================================================================
//aqui vai ficar onde ficará o pc:
//=======================================================================

wire [31:0] pcResultante;

pc pcInstancioado(

    .pcRecebido(pcnovo), //vai receber a saída do multiplexador acima.
    .clk(clk), //sinal de clock para mudar o atual.
    .rst(rst), //apenas para resetar o pc
    .pcNovo(pcResultante) //aqui é a saída
    //será a saída, é a que irá ditar qual será a instrução realizada no momento.
    
);

//=======================================================================
//aqui ficará a memória de instruções:
//=======================================================================

wire [31:0] instru;

instr_mem InstrucoesInstanciadas(

    .addr(pcResultante),//aqui ele recebe o endereço da instrução.
    .instr(instru)

);

//=======================================================================
//aqui ficará o pcplus4:
//=======================================================================

wire [31:0] saidapcPlus4;//ficará a saída do pc + 4;

pcPlus4 instanciapcPlus4(

    .entrada(pcResultante),
    .saida(saidapcPlus4)

);

//=======================================================================
//aqui ficará a unidade de controle:
//=======================================================================

wire [2:0] aluopcode;
wire [1:0] tipoExtensao;
wire [1:0] resultSrcControle;
wire [1:0] saidaPCSc; //aqui fica a atualização que eu tive que fazer para incrementar o jalr.

//tenho que ter cuidado com os nomes aqui.

//vou ter que trocar os sinais daqui.


UnitControl unidade_Controle(

    //aqui são as entradas:
    //aqui eu tenho que separar de froma coreta a forma como os dados são separados.
    //eu tenho que pegar a instrução e dividir ela de forma correta.

    .opcode(instru[6:0]), 
    .funct3(instru[14:12]),
    .zero(AluSaidaZero), //aqui vem da Alu.
    .funct7(instru[30]),
    .funct7m(instru[25]), //aqui está uma parte importante para a implementação da extensão M.
    

    //aqui ficam as saídas:

    .resultadodoMux(entradaMuxMult), //como é apenas um bit, não precisa declarar wire.
    .aluControl(aluopcode), //aqui são 3 bits
    .RegWrite(regwrite), //apenas mum bit, não preciso criar um wire.
    .immSrc(tipoExtensao), //aqui são 2 bits
    .ALUSRC(asrc), //apenas mum bit, não preciso criar um wire.
    .MemWrite(mwrite), //apenas mum bit, não preciso criar um wire.
    .ResultSrc(resultSrcControle), //apenas mum bit, não preciso criar um wire.
    .PCSrc(saidaPCSc) //apenas mum bit, não preciso criar um wire.

);

//=======================================================================
//aqui ficará o banco de registradores: 
//=======================================================================

wire [31:0] rd1;
wire [31:0] rd2;

register_file registradores(

    //entradas:
    .CLK(clk),//clock do sistema principal.
    .WE3(regwrite), //vei direto da unidade de controle.
    .A1(instru[19:15]),
    .A2(instru[24:20]),
    .A3(instru[11:7]),
    .WD3(saidaMultiplexador),//aqui deve ser a sáida da parte final do multiplexador.

    //saídas:

    .RD1(rd1),
    .RD2(rd2)

);


//=======================================================================
//aqui ficará o extensor do imediato:
//=======================================================================

wire [31:0] valorExtendido;

extend extensordeSinal(

    //entradas:

    .Instr31_7(instru[31:7]), //tenho que unir, de forma correta os sinais de entrada.
    .ImmSrc(tipoExtensao),//vei da unudade de controle.

    //saídas:

    .ImmExt(valorExtendido)//aqui eu terei o valor extendido da entrada.
);

//=======================================================================
//aqui ficará o seletor de informações da ALU regb:
//=======================================================================

wire [31:0] registradorb;//será a saída do multiplexador.

mux2SrcB multiplexadorSrcB(

    //entradas:

    .registrador(rd2), //pega o segundo registrador.
    .valorExtendido(valorExtendido), //pega o valor que saio do extensor.
    .aluSrc(asrc), //vei direto da unidade de controle.

    //saídas:

    .saida(registradorb) //será a informaçaõ que irá ser escolhida pelo multiplexador.

);

//=======================================================================
//aqui ficará a alu:
//=======================================================================

wire [31:0] resultadoAlu;//apenas para guardar o valor que irá sair da alu.

alu alu_instanciada(

    //entradas:

    .SrcA(rd1),
    .SrcB(registradorb), //vem direto do multiplexador.
    .ALUControl(aluopcode), // apenas 3 bits para bater com o UnitControl

    //saídas:

    .ALUResult(resultadoAlu),
    .Zero(AluSaidaZero) //é só um bit, não precisa de wire.(vai para a unidade de controle.)

);

//aqui abaico ficará uma instanciação do módulo de multilicação;

wire [31:0] saidaMultiplicador; //apenas para "salvar" o resultado do multiplicador.

multiplicador multiplicador_Instanciado(

    //entradas:

    .rd1(rd1),
    .rd2(rd2),
    .funct3(instru[14:12]),//aqui que ele vai selecionar qual é o tipo da instrução.

    //saída: 
    .resultado(saidaMultiplicador)
);

//aqui também ficará a uma instancia do multiplexador que irá ditar qual é a saída, se é da ALU ou do módulo da multiplicação.

wire [31:0] saidaMultiplexadorMult;

muxresultado muxMultiplicacao(

    .resultadoALU(resultadoAlu),
    .resultadoMULT(saidaMultiplicador),
    .ConUnitMult(entradaMuxMult), //aqui ficará o seletor.

    //saídas:
    .saida(saidaMultiplexadorMult) //a partir de agora, irei usar esse.
);

//=======================================================================
//aqui ficará o pctarget:
//=======================================================================

wire [31:0] pctargetSaida;

pctarget pctargetInstanciado(
    
    //entradas:

    .pc(pcResultante),//recebe o endereço da instrução atual .
    .immExtend(valorExtendido),

    //saídas:

    .valorCalculado(pctargetSaida) //vai retornar o valor calculado.

);

//=======================================================================
// aqui ficará e memória:
//=======================================================================

wire [31:0] dadoBuscado;

dmem memoria(
    
    //entradas:

    .clk(clk), //clock de funcionamento.
    .memwrite(mwrite), //aqui é da unidade de controle.
    .addr(saidaMultiplexadorMult), //resultado da ALU
    .writedata(rd2), //dado a ser inscrito.

    //saidas:

    .readdata(dadoBuscado)

);

//aqui ficará o último multiplexador:

wire [31:0] saidaMultiplexador;

muxFinal ultumoMUltiplexador(

    //entradas:

    .DataMemory(dadoBuscado),
    .resultadoAlu(saidaMultiplexadorMult),
    .pcPlus4(saidapcPlus4),
    .ResultSrc(resultSrcControle),

    //saidas:

    .saida(saidaMultiplexador)
);

endmodule