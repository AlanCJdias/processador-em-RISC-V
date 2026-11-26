//é puramente combinacional.
//recebe os dois regostradores e a funct3.
//de onde saíra o resultado eu separo com um multiplexador depois.

module multiplicador(

    //entradas:
    input wire [31:0] rd1, //ele entra sem 
    input wire [31:0] rd2,
    input wire [2:0] funct3,

    //saída: 
    output reg [31:0] resultado //resulta apenas no resultado da operação e devolve;

);

//apenas para caso de usar sinais:
//salva as entradas como entradas com sinais.

wire signed [31:0] rds1 = rd1;
wire signed [31:0] rds2 = rd2;

//dependendo de como for o funct 3 eu uso a parte com sinal ou não.

//aqui tem que ser reg, animal.
reg [63:0] auxiliar; 

//só fazer um case.

always @(*) begin
    case (funct3)

        //se qualquer registrador for 0, resultado será 0.
        //tenhpo que fazer esse tratamento para a divisão.

        //abaixo estão as de multiplicação:
        //não mexe, estão funcionando de forma perfeita.

        3'b000: resultado = rd1 * rd2; //daqui para baixo é só baixaria.
        3'b001:begin//aqui é quando eu quero salvar o sinal dos dois.
            auxiliar = rds1 * rd2;
            resultado = auxiliar[63:32];
        end
        3'b010:begin
            auxiliar = rds1 * rd2;
            resultado = auxiliar[63:32];
        end
        3'b011:begin
            auxiliar = rd1 * rds2;
            resultado = auxiliar[63:32];
        end

        //abaixo estão as de multiplicação:
        //é aqui que a porca torce o rabo.

        3'b100:begin //aqui é com o sinal

            if (rd2 == 32'd0) begin
                resultado = -32'd1;//retor
            end else if (rds2 == -32'd1 && rds1 == 32'b10000000000000000000000000000000) begin //aqui vai começar o overflow.
                resultado = 32'b10000000000000000000000000000000;
            end else begin
                resultado = rds1 / rds2;
            end
            
            
        end

        3'b101: begin //aqui ele vai fazer uma divisão sem sinais.
            if (rd2 == 32'd0) begin 
                resultado = -32'd1;
            end else begin
                resultado = rd1 / rd2;
            end
        end


        3'b110: begin
            if (rd2 == 32'b0) begin
                resultado = rd1;
            end else if(rds2 == -32'd1 && rds1 == 32'b10000000000000000000000000000000) begin //aqui causa overflow;
                resultado = 32'b10000000000000000000000000000000;
            end else begin
                resultado = rds1 % rds2;
            end
        end


        3'b111:begin //aqui não tem overflow. 
            if (rd2 == 32'b0) begin
                resultado = rd1;
            end else begin
                resultado = rd1 % rd2;
            end
        end


        default: resultado = 32'd0; //se não for nenhum caso, retorna 0 ( o que é impossível ).
    endcase
end
endmodule