//é aqui que eu devo ter um cuidade maior para fazer os testes.

module UnitControl(

    //só tem 4 entradas.

    input wire [6:0] opcode, 
    input wire [2:0] funct3,
    input wire zero,
    input wire funct7, //recebe apenas um bit dessa função.

    //tem muitas saídas.
    //saídas:

    output wire [2:0] aluControl,
    output wire RegWrite,
    output wire [1:0] immSrc,
    output wire ALUSRC,
    output wire MemWrite,
    output wire [1:0] ResultSrc,
    output wire PCSrc

);

//variáveis para serem ligadas depois:

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
    .jump(j) //tem que fazer um wire para esse.

);

aluControl AluCOntrolPrincipal(

    .aluop(ALUOP),
    .op(opcode[5]), //deve receber apenas o quinto bit.
    .funct3(funct3),
    .funct7b(funct7),
    .aluControl(aluControl)//aqui é a saída que me interessa para a alu.
);

assign PCSrc = (b & zero) | j ;


//aqui deve ter a instancia dos dois módulos e a parte para branch que ve de onde irá sair o pc novo.


endmodule