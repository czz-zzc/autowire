// Project: DMA Controller
// Author: czz
// Date: 2025-06-07
// Description: DMA CSR module
// This module interfaces with the DMA controller's CSR (Control and Status Register)
module dma_csr (
input           pclk,
input           presetn,
input           psel,
input           penable,
input           pwrite,
input  [11:0]   paddr,
input  [31:0]   pwdata,
output [31:0]   prdata,
output          pready,
output [07:0]   csr_dma_maxburst,
output          csr_dma_start,
input  [15:0]   csr_dma_version,
input  [01:0]   csr_dma_status,
input           csr_dma_err,
input           csr_dma_done,
output          csr_dma_err_clr,
input  [01:0]   csr_dma_err_type,
input  [31:0]   csr_dma_err_addr,
output   [1:0]                csr_desc_read_mode,
output   [1:0]                csr_desc_write_mode,
output   [1:0]                csr_desc_enable,
output [31:0]   csr_desc_num_bytes[1:0],
output [31:0]   csr_desc_src_addr[1:0],
output [31:0]   csr_desc_dst_addr[1:0],
output [31:0]   csr_desc_read_jump_bytes[1:0],
output [31:0]   csr_desc_write_jump_bytes[1:0]
);

wire [11:0] reg_addr;
wire        wr_en;
wire        rd_en;
wire [3:0]  wr_msk;
wire [31:0] wr_data;
wire [31:0] rd_data;

// apb to register interface conversion
apb2reg_if u_apb2reg_if (
.pclk                       (pclk),
.presetn                    (presetn),
.psel                       (psel),
.penable                    (penable),
.pwrite                     (pwrite),
.paddr                      (paddr),
.pwdata                     (pwdata),
.prdata                     (prdata),
.pready                     (pready),           
.reg_addr                   (reg_addr),
.wr_en                      (wr_en),
.rd_en                      (rd_en),
.wr_msk                     (wr_msk),
.wr_data                    (wr_data),
.rd_data                    (rd_data)
);

// dma register interface
dma_reg u_dma_reg (
.clk                        (pclk),
.rst_n                      (presetn),
.reg_addr                   (reg_addr),
.wr_en                      (wr_en),
.rd_en                      (rd_en),
.wr_msk                     (wr_msk),
.wr_data                    (wr_data),
.rd_data                    (rd_data),
.csr_dma_maxburst           (csr_dma_maxburst),
.csr_dma_start              (csr_dma_start),
.csr_dma_version            (csr_dma_version),
.csr_dma_status             (csr_dma_status),
.csr_dma_err                (csr_dma_err),
.csr_dma_done               (csr_dma_done),
.csr_dma_err_clr            (csr_dma_err_clr),
.csr_dma_err_type           (csr_dma_err_type),
.csr_dma_err_addr           (csr_dma_err_addr),
.csr_desc_read_mode         (csr_desc_read_mode),
.csr_desc_write_mode        (csr_desc_write_mode),
.csr_desc_enable            (csr_desc_enable),
.csr_desc_num_bytes         (csr_desc_num_bytes),
.csr_desc_src_addr          (csr_desc_src_addr),
.csr_desc_dst_addr          (csr_desc_dst_addr),
.csr_desc_read_jump_bytes   (csr_desc_read_jump_bytes),
.csr_desc_write_jump_bytes  (csr_desc_write_jump_bytes)
);
endmodule
