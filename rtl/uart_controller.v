`define TEST
module uart_controller #(
    parameter BAUD_RATE = 115200,
    parameter DATA_BITS = 8,
    parameter CLK_FREQ = 50000000
)(
    // Clock and Reset
    input                   clk,
    input                   rst_n,
    
    // AHB Slave Interface
    input  [`ADDR_WIDTH-1:0]           haddr_ahb,
    input  [`DATA_WIDTH-1:0]           hwdata_ahb,
    output [`DATA_WIDTH-1:0]           hrdata_ahb,
    input                   hwrite_ahb,
    input  [1:0]            htrans_ahb,
    input                   hsel_ahb,
    output                  hready_out_ahb,
    output                  hresp_ahb,
    
    // UART Interface
    output                  tx,
    input                   rx,
    output                  test_out,
    // Interrupt
    output                  uart_irq
);
endmodule