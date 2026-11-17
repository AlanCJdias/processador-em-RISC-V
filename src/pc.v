module pc(
    input wire [31:0] pcRecebido,
    input wire clk,
    input wire rst,
    output reg [31:0] pcNovo
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pcNovo <= 32'b0;
        end else begin
            pcNovo <= pcRecebido;
        end
    end

endmodule