module soc_top(
input                           clk,
input                           rst_n,
input                           debug_mode,
output                          tx,
input                           rx,
)

wire  [15:0]         haddr;
wire  [31:0]         hwdata;
wire  [31:0]         hrdata;
wire                 hwrite;
wire  [1:0]          htrans;
wire  [2:0]          hsize;
wire  [2:0]          hready_out;
wire                 hready;
wire                 hresp;

uart_controller #(
.BAUD_RATE(9600)
)u_uart(
.clk            (clk                ),
.rst_n          (rst_n              ),
.haddr          (haddr              ),
.hwdata         (hwdata             ),
.hrdata         (hrdata             ),
.hwrite         (hwrite             ),
.htrans         (htrans             ),
.hsel           (hsel               ),
.hready_out     (hready_out         ),
.hresp          (hresp              ),
.tx             (tx                 ),
.rx             (rx                 ),
.uart_irq       (uart_irq           )
);

cpu_core u_cpu(
.clk            (clk                ),
.rst_n          (rst_n              ),
.haddr          (haddr              ),
.hwdata         (hwdata             ),
.hrdata         (hrdata             ),
.hwrite         (hwrite             ),
.htrans         (htrans             ),
.hsize          (hsize              ),
.hburst         (hburst             ),
.hready         (hready_out         ),
.hresp          (hresp              ),
.debug_mode     (debug_mode         ),
.irq            ({6'b0, uart_irq}   )
);

endmodule