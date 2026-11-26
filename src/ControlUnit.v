//é aqui que eu devo ter um cuidade maior para fazer os testes.

module UnitControl(

    //só tem 4 entradas.

    input wire [6:0] opcode, 
    input wire [2:0] funct3,
    input wire zero,
    input wire funct7, //recebe apenas um bit dessa função.

    //vai ter mais uma entrada.

    input wire funct7m, //essa entra irá servir apenas para diferenciar de quandoe u precisarei usar a extensão m.
    //vai ser o bit 25.

    //tem muitas saídas.
    //saídas:

    //aqui eu vou ter que modificar também;
    output wire [2:0] aluControl,
    output wire RegWrite,
    output wire [1:0] immSrc,
    output wire ALUSRC,
    output wire MemWrite,
    output wire [1:0] ResultSrc,
    output wire PCSrc,

    //adição de mais uma saída: 

    output wire resultadodoMux //com base nesse sinal ele vai falar se vai usar multiplicação ou a ALU normal.'

);

//variáveis para serem ligadas depois:

wire [1:0] j;
wire [1:0] ALUOP;
wire b;
wire j;

//módulos instanciados:

mainDecoder decoderPrincipal(
    //aqui deve ficar todas as entradas e saídas.

    .opcode(opcode), //vai passar o pop code inteiro.
    .regWrite(RegWrite),
    .immSrc(immSrc),
    .aluSrc(ALUSRC),
    .memWrite(MemWrite),
    .resultSrc(ResultSrc),
    .branch(b),//tem que fazer um wire para esse.
    .aluOP(ALUOP), //tem que fazer um wire para esse.    
    .jump(j), //tem que fazer um wire para esse.
    .funct7(funct7m), //aqui é a nova entrada.
    .resultadoMux(resultadodoMux)

);

//não é necessário mexer no controle da ALU.
aluControl AluCOntrolPrincipal(

    .aluop(ALUOP),
    .op(opcode[5]), //deve receber apenas o quinto bit.
    .funct3(funct3),
    .funct7b(funct7),
    .aluControl(aluControl)//aqui é a saída que me interessa para a alu.
);

assign pcSrc = (j == 2'b10) ? 2'b10 :// aqui ele vai fazer um jalr
               ((j == 2'b01) || (b & zero)) ? 2'b01 : // pega o pctarget
               2'b00;//pega o normal, pc + 4.


//aqui deve ter a instancia dos dois módulos e a parte para branch que ve de onde irá sair o pc novo.


endmodule