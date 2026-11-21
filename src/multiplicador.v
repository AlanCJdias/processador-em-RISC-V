//é puramente combinacional.
//recebe os dois regostradores e a funct3.
//de onde saíra o resultado eu separo com um multiplexador depois.

module multiplicador(

    //entradas:
    input wire [31:0] rd1, //ele entra sem 
    input wire [31:0] rd2,
    input wire [2:0] funct3,

    //saída: 
    output reg [31:0] resoltado //resulta apenas no resultado da operação e devolve;

);

//apenas cara caso for usar sinais:

wire signed [31:0] rds1 = rd1;
wire signed [31:0] rds2 = rd2;

//só fazer um case.

always @(*) begin
    case (funct3)
        3'b000:
        3'b001:
        3'b010:
        3'b011:
        3'b100:
        3'b101:
        3'b110:
        3'b111: 
        default: resoltado = 32'd0;
    endcase
end
endmodule