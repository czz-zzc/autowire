// Project: DMA Controller
// Author: czz
// Date: 2025-06-07
// Description: dma_core module for managing DMA operations, including read and write slices, AXI interface, and FSM control.

module dma_core #(
parameter DMA_ADDR_WIDTH  = 32,                     // Address width for DMA
parameter DMA_DATA_WIDTH  = 64,                     // Data width for DMA (32 or 64 bits)
parameter DMA_BYTES_WIDTH = 32,                     // Bytes width for DMA
parameter DMA_NUM_DESC    = 8,                      // Number of DMA descriptors
parameter AXI_ID_WIDTH    = 4,                      // AXI ID width
parameter AXI_STRB_WIDTH  = DMA_DATA_WIDTH/8,       // AXI strobe width for 32-bit or 64-bit data
parameter DESC_IDX_WIDTH  = $clog2(DMA_NUM_DESC),   // Descriptor index width
parameter RD_ADDR_BUFF_DEPTH  = 8,                  // Depth of read address buffer
parameter WR_ADDR_BUFF_DEPTH  = 8,                  // Depth of write address buffer
parameter DATA_BUFF_DEPTH     = 64                  // Depth of data buffer
)(
input                                           clk,
input                                           rst_n,
// From/To CSRs
input    [DMA_NUM_DESC-1:0]   csr_desc_enable,// Enable for each descriptor address
input   [DMA_ADDR_WIDTH-1:0]                    csr_desc_src_addr           [DMA_NUM_DESC-1:0],
input   [DMA_ADDR_WIDTH-1:0]                    csr_desc_dst_addr           [DMA_NUM_DESC-1:0],
input   [DMA_BYTES_WIDTH-1:0]                   csr_desc_num_bytes          [DMA_NUM_DESC-1:0],
input    [DMA_NUM_DESC-1:0]   csr_desc_write_mode,// 0:increment, 1:jump; when jump, busrt length is 0,the address must aligned to 4 bytes/8bytes.
input    [DMA_NUM_DESC-1:0]   csr_desc_read_mode,// 0:increment, 1:jump; when jump, busrt length is 0,the address must aligned to 4 bytes/8bytes.
input   [DMA_BYTES_WIDTH-1:0]                   csr_desc_write_jump_bytes   [DMA_NUM_DESC-1:0],
input   [DMA_BYTES_WIDTH-1:0]                   csr_desc_read_jump_bytes    [DMA_NUM_DESC-1:0],


input   [7:0]                                   csr_dma_maxburst,
input                                           csr_dma_start,
output                                          csr_dma_done,    
output  [1:0]                                   csr_dma_status,   // 00: idle, 01: check, 10: run, 11: done   
input                                           csr_dma_err_clr,
output                                          csr_dma_err, 
output  [1:0]                                   csr_dma_err_type, // 2'b10: config error; 2'b00: aix read resp error,2'b01: axi write resp error
output  [DMA_ADDR_WIDTH-1:0]                    csr_dma_err_addr,

// axim interface
output                                          axim_awlock,    // Lock signal        1'b0
output  [3:0]                                   axim_awcache,   // Cache type         4'b0011
output  [2:0]                                   axim_awprot,    // Protection type    3'b0
output  [3:0]                                   axim_awqos,     // Quality of Service 4'b0
output  [DMA_ADDR_WIDTH-1:0]                    axim_awaddr,    // Write address
output  [7:0]                                   axim_awlen,     // Burst length
output  [2:0]                                   axim_awsize,    // Burst size
output  [1:0]                                   axim_awburst,   // Burst type
output                                          axim_awvalid,   // Write address valid
input                                           axim_awready,   // Write address ready
output  [DMA_DATA_WIDTH-1:0]                    axim_wdata,     // Write data
output  [AXI_STRB_WIDTH-1:0]                    axim_wstrb,     // Write strobes
output                                          axim_wlast,     // Write last
output                                          axim_wvalid,    // Write data valid
input                                           axim_wready,    // Write data ready
input   [1:0]                                   axim_bresp,     // Write response
input                                           axim_bvalid,    // Write response valid
output                                          axim_bready,    // Write response ready
output                                          axim_arlock,    // Lock signal         1'b0
output  [3:0]                                   axim_arcache,   // Cache type          4'b0011
output  [2:0]                                   axim_arprot,    // Protection type     3'b0
output  [3:0]                                   axim_arqos,     // Quality of Service  4'b0
output  [DMA_ADDR_WIDTH-1:0]                    axim_araddr,    // Read address
output  [7:0]                                   axim_arlen,     // Burst length
output  [2:0]                                   axim_arsize,    // Burst size
output  [1:0]                                   axim_arburst,   // Burst type
output                                          axim_arvalid,   // Read address valid
input                                           axim_arready,   // Read address ready
input   [DMA_DATA_WIDTH-1:0]                    axim_rdata,     // Read data
input   [1:0]                                   axim_rresp,     // Read response
input                                           axim_rlast,     // Read last
input                                           axim_rvalid,    // Read data valid
output                                          axim_rready,    // Read data ready
output  [AXI_ID_WIDTH-1:0]                      axim_awid,      // Write ID
input   [AXI_ID_WIDTH-1:0]                      axim_bid,       // Write response ID 
output  [AXI_ID_WIDTH-1:0]                      axim_arid,      // Read ID
input   [AXI_ID_WIDTH-1:0]                      axim_rid        // Read response ID
);

wire                         dma_axi_rd_req_valid;
wire [DMA_ADDR_WIDTH-1:0]    dma_axi_rd_req_addr;
wire [AXI_STRB_WIDTH-1:0]    dma_axi_rd_req_strb;
wire [2:0]                   dma_axi_rd_req_size;
wire [7:0]                   dma_axi_rd_req_alen;
wire                         dma_axi_rd_resp_ready;

wire                         dma_axi_wr_req_valid;
wire [DMA_ADDR_WIDTH-1:0]    dma_axi_wr_req_addr;
wire [AXI_STRB_WIDTH-1:0]    dma_axi_wr_req_strb;
wire [2:0]                   dma_axi_wr_req_size;
wire [7:0]                   dma_axi_wr_req_alen;
wire                         dma_axi_wr_resp_ready;

wire                         dma_axi_err_valid;
wire [DMA_ADDR_WIDTH-1:0]    dma_axi_err_addr;
wire                         dma_axi_err_type;

wire [DESC_IDX_WIDTH-1:0]    dma_rd_slice_idx;
wire                         dma_rd_slice_valid;
wire                         dma_rd_slice_done;

wire [DESC_IDX_WIDTH-1:0]    dma_tx_slice_idx;
wire                         dma_tx_slice_valid;
wire                         dma_tx_slice_done;
wire                         dma_axi_pending;

dma_fsm #(
.DMA_ADDR_WIDTH             (DMA_ADDR_WIDTH),
.DMA_DATA_WIDTH             (DMA_DATA_WIDTH),
.DMA_BYTES_WIDTH            (DMA_BYTES_WIDTH),
.DMA_NUM_DESC               (DMA_NUM_DESC),
.DESC_IDX_WIDTH             (DESC_IDX_WIDTH)
) u_dma_fsm (       
.clk                        (clk),
.rst_n                      (rst_n),
.csr_desc_enable            (csr_desc_enable),
.csr_desc_src_addr          (csr_desc_src_addr),
.csr_desc_dst_addr          (csr_desc_dst_addr),
.csr_desc_num_bytes         (csr_desc_num_bytes),
.csr_desc_write_mode        (csr_desc_write_mode),
.csr_desc_read_mode         (csr_desc_read_mode),
.csr_desc_write_jump_bytes  (csr_desc_write_jump_bytes),
.csr_desc_read_jump_bytes   (csr_desc_read_jump_bytes),
.csr_dma_start              (csr_dma_start),
.csr_dma_done               (csr_dma_done),
.csr_dma_status             (csr_dma_status),
.csr_dma_err_clr            (csr_dma_err_clr),
.csr_dma_err                (csr_dma_err),
.csr_dma_err_type           (csr_dma_err_type),
.csr_dma_err_addr           (csr_dma_err_addr),
.dma_axi_err_valid          (dma_axi_err_valid),
.dma_axi_err_addr           (dma_axi_err_addr),
.dma_axi_err_type           (dma_axi_err_type),
.dma_rd_slice_idx           (dma_rd_slice_idx),
.dma_rd_slice_valid         (dma_rd_slice_valid),
.dma_rd_slice_done          (dma_rd_slice_done),
.dma_tx_slice_idx           (dma_tx_slice_idx),
.dma_tx_slice_valid         (dma_tx_slice_valid),
.dma_tx_slice_done          (dma_tx_slice_done),
.dma_axi_pending            (dma_axi_pending)
);

// rd slice
dma_slice #(
.DMA_ADDR_WIDTH             (DMA_ADDR_WIDTH),
.DMA_DATA_WIDTH             (DMA_DATA_WIDTH),
.DMA_BYTES_WIDTH            (DMA_BYTES_WIDTH),
.DMA_NUM_DESC               (DMA_NUM_DESC),
.AXI_STRB_WIDTH             (AXI_STRB_WIDTH)
) u_dma_rd_slice (
.clk                        (clk),
.rst_n                      (rst_n),
.csr_desc_addr              (csr_desc_src_addr),
.csr_desc_mode              (csr_desc_read_mode),
.csr_desc_num_bytes         (csr_desc_num_bytes),
.csr_desc_jump_bytes        (csr_desc_read_jump_bytes),
.csr_dma_maxburst           (csr_dma_maxburst),
.dma_axi_req_valid          (dma_axi_rd_req_valid),
.dma_axi_req_addr           (dma_axi_rd_req_addr),
.dma_axi_req_strb           (dma_axi_rd_req_strb),
.dma_axi_req_size           (dma_axi_rd_req_size),
.dma_axi_req_alen           (dma_axi_rd_req_alen),
.dma_axi_resp_ready         (dma_axi_rd_resp_ready),
.dma_slice_idx              (dma_rd_slice_idx),
.dma_slice_valid            (dma_rd_slice_valid),
.dma_slice_done             (dma_rd_slice_done)
);


// wr slice
dma_slice #(
.DMA_ADDR_WIDTH             (DMA_ADDR_WIDTH),
.DMA_DATA_WIDTH             (DMA_DATA_WIDTH),
.DMA_BYTES_WIDTH            (DMA_BYTES_WIDTH),
.DMA_NUM_DESC               (DMA_NUM_DESC),
.AXI_STRB_WIDTH             (AXI_STRB_WIDTH)
) u_dma_wr_slice (
.clk                        (clk),
.rst_n                      (rst_n),
.csr_desc_addr              (csr_desc_dst_addr),
.csr_desc_mode              (csr_desc_write_mode),
.csr_desc_num_bytes         (csr_desc_num_bytes),
.csr_desc_jump_bytes        (csr_desc_write_jump_bytes),
.csr_dma_maxburst           (csr_dma_maxburst),
.dma_axi_req_valid          (dma_axi_wr_req_valid),
.dma_axi_req_addr           (dma_axi_wr_req_addr),
.dma_axi_req_strb           (dma_axi_wr_req_strb),
.dma_axi_req_size           (dma_axi_wr_req_size),
.dma_axi_req_alen           (dma_axi_wr_req_alen),
.dma_axi_resp_ready         (dma_axi_wr_resp_ready),
.dma_slice_idx              (dma_tx_slice_idx),
.dma_slice_valid            (dma_tx_slice_valid),
.dma_slice_done             (dma_tx_slice_done)
);

// AXI2FIFO
dma_axi2fifo #(
.DMA_ADDR_WIDTH             (DMA_ADDR_WIDTH),
.DMA_DATA_WIDTH             (DMA_DATA_WIDTH),
.DMA_NUM_DESC               (DMA_NUM_DESC),
.AXI_ID_WIDTH               (AXI_ID_WIDTH),
.AXI_STRB_WIDTH             (AXI_STRB_WIDTH),
.RD_ADDR_BUFF_DEPTH         (RD_ADDR_BUFF_DEPTH),
.WR_ADDR_BUFF_DEPTH         (WR_ADDR_BUFF_DEPTH),
.DATA_BUFF_DEPTH            (DATA_BUFF_DEPTH)
) u_dma_axi2fifo (
.clk                        (clk),
.rst_n                      (rst_n),

.axim_awlock                (axim_awlock),
.axim_awcache               (axim_awcache),
.axim_awprot                (axim_awprot),
.axim_awqos                 (axim_awqos),
.axim_awaddr                (axim_awaddr),
.axim_awlen                 (axim_awlen),
.axim_awsize                (axim_awsize),
.axim_awburst               (axim_awburst),
.axim_awvalid               (axim_awvalid),
.axim_awready               (axim_awready),
.axim_wdata                 (axim_wdata),
.axim_wstrb                 (axim_wstrb),
.axim_wlast                 (axim_wlast),
.axim_wvalid                (axim_wvalid),
.axim_wready                (axim_wready),
.axim_bresp                 (axim_bresp),
.axim_bvalid                (axim_bvalid),
.axim_bready                (axim_bready),
.axim_arlock                (axim_arlock),
.axim_arcache               (axim_arcache),
.axim_arprot                (axim_arprot),
.axim_arqos                 (axim_arqos),
.axim_araddr                (axim_araddr),
.axim_arlen                 (axim_arlen),
.axim_arsize                (axim_arsize),
.axim_arburst               (axim_arburst),
.axim_arvalid               (axim_arvalid),
.axim_arready               (axim_arready),
.axim_rdata                 (axim_rdata),
.axim_rresp                 (axim_rresp),
.axim_rlast                 (axim_rlast),
.axim_rvalid                (axim_rvalid),
.axim_rready                (axim_rready),
.axim_awid                  (axim_awid),                 
.axim_bid                   (axim_bid), 
.axim_arid                  (axim_arid),
.axim_rid                   (axim_rid),

.dma_axi_rd_req_valid       (dma_axi_rd_req_valid),
.dma_axi_rd_req_addr        (dma_axi_rd_req_addr),
.dma_axi_rd_req_strb        (dma_axi_rd_req_strb),
.dma_axi_rd_req_size        (dma_axi_rd_req_size),
.dma_axi_rd_req_alen        (dma_axi_rd_req_alen),
.dma_axi_rd_resp_ready      (dma_axi_rd_resp_ready),
.dma_axi_wr_req_valid       (dma_axi_wr_req_valid),
.dma_axi_wr_req_addr        (dma_axi_wr_req_addr),
.dma_axi_wr_req_strb        (dma_axi_wr_req_strb),
.dma_axi_wr_req_size        (dma_axi_wr_req_size),
.dma_axi_wr_req_alen        (dma_axi_wr_req_alen),
.dma_axi_wr_resp_ready      (dma_axi_wr_resp_ready),

.axi_pending                (dma_axi_pending),
.dma_axi_err_clr            (csr_dma_err_clr),
.dma_axi_err_valid          (dma_axi_err_valid),
.dma_axi_err_addr           (dma_axi_err_addr),
.dma_axi_err_type           (dma_axi_err_type)
);

endmodule
