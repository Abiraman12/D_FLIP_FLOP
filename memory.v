module memory (
    input  wire       clk,
    input  wire       we,      // write enable
    input  wire [3:0] addr,
    input  wire [7:0] din,
    output reg  [7:0] dout
);
    reg [7:0] mem [0:15];      // 16 locations, 8 bits each

    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;  // store data
        dout <= mem[addr];     // read data
    end
endmodule