
module cpu_core (
    // Clock and Reset
    input                           clk,
    input                           rst_n,
    
    // AHB Master Interface
    output [`ADDR_WIDTH-1:0]        a_haddr,
    output [`DATA_WIDTH-1:0]        a_hwdata,
    input  [`DATA_WIDTH-1:0]        a_hrdata,
    output                          a_hwrite,
    output [1:0]                    a_htrans,
    output [2:0]                    a_hsize,
    output [2:0]                    a_hburst,
    input                           a_hready,
    input                           a_hresp,
    
    // Debug Interface
    input                           debug_mode,
`ifdef TEST
    output [7:0]                    test_out,
`endif
    // Interrupt
    input  [1:0]                    test_in,
    input  [7:0]                    irq
);
endmodule