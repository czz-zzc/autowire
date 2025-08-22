`define TEST
module irqqqq #(
    parameter BAUD_RATE = 115200,
    parameter DATA_BITS = 8,
    parameter CLK_FREQ = 50000000
)(
    // Clock and Reset
    input                   clk,
    input                   rst_n,
    
    output   [1:0]          irq
);
endmodule