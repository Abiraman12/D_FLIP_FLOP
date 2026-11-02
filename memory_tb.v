`timescale 1ns/1ps

module memory_tb;
    reg        clk, we;
    reg  [3:0] addr;
    reg  [7:0] din;
    wire [7:0] dout;

    memory uut (.clk(clk), .we(we), .addr(addr), .din(din), .dout(dout));

    always #5 clk = ~clk;

    // Call this task to store data
    task write_data(input [3:0] a, input [7:0] d);
        begin
            @(negedge clk);
            we = 1; addr = a; din = d;
            @(negedge clk);
            we = 0;
        end
    endtask

    // Call this task to read data back
    task read_data(input [3:0] a);
        begin
            @(negedge clk);
            we = 0; addr = a;
            @(negedge clk);
            $display("Read addr %0d = %h", a, dout);
        end
    endtask

    initial begin
        clk = 0; we = 0; addr = 0; din = 0;

        write_data(4'd1, 8'hAA);
        write_data(4'd2, 8'hBB);

        read_data(4'd1);
        read_data(4'd2);

        #10 $finish;
    end
endmodule