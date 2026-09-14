module completo(
    input logic [7:0] v,
    output logic [7:0] e
);

testeverilog complementa(//instancia um complementador.
    .entrada(v),
    .saida(e)
);

endmodule;