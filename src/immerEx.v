//esse aqui não mexe, já está pronto.

module extend (//aqui ele vai extender o imediato.
    input wire [24:0]  Instr31_7,
    input wire [1:0]   ImmSrc,
    output wire [31:0] ImmExt
);

    localparam IMM_I = 2'b00; //tipo imediato.
    localparam IMM_S = 2'b01; //tipo S.
    localparam IMM_B = 2'b10; //tipo b.
    localparam IMM_J = 2'b11; //tipo jump.

    reg [31:0] imm_ext;//eu tenho a impressão que isso daqui não é necessário. e que pode estar gastando "fios".
    //dava para fazer só trocando a variável de saída por reg, mas não acho necessário.
    
    always @(*) begin
        case (ImmSrc)
            IMM_I: imm_ext = {{20{Instr31_7[24]}}, Instr31_7[24:13]};
            IMM_S: imm_ext = {{20{Instr31_7[24]}}, Instr31_7[24:18], Instr31_7[4:0]};
            IMM_B: imm_ext = {{19{Instr31_7[24]}}, Instr31_7[24], Instr31_7[0], Instr31_7[23:18], Instr31_7[4:1], 1'b0};
            IMM_J: imm_ext = {{11{Instr31_7[24]}}, Instr31_7[24], Instr31_7[12:5], Instr31_7[13], Instr31_7[23:14], 1'b0};
            default: imm_ext = 32'd0;
        endcase
    end

    assign ImmExt = imm_ext;

endmodule