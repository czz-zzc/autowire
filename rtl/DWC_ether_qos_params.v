//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2013 - 2013 SYNOPSYS, INC.
//                            ALL RIGHTS RESERVED
//
//  This software and the associated documentation are confidential and
//  proprietary to Synopsys, Inc.  Your use or disclosure of this
//  software is subject to the terms and conditions of a written
//  license agreement between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
//  ------------------------------------------------------------------------

//------------------------------------------------------------------------
// $Id: //dwh/ethernet_iip/dev/ETHER_QOS_4_00A/src/DWC_ether_qos_params.v#109 $
// Release version :  4.00a
// Date             : $Date: 2013/10/08 $
// File Version     : $Revision: #109 $
// Revision         : $Id: //dwh/ethernet_iip/dev/ETHER_QOS_4_00A/src/DWC_ether_qos_params.v#109 $
//
//------------------------------------------------------------------------
// DWC_ether_qos_params : Constants and derived parameters are defined in this file

// Constants defined in EQOS files and are not configurable
`define L 1'b0
`define H 1'b1

`define DWC_EQOS_DUMMY_STS 16'hA002

// Single bit logic 0 and logic 1 definitions.
`define DWC_EQOS_L 1'b0 
`define DWC_EQOS_H 1'b1 

`define DWC_EQOS_SNPS_VER 8'h40

// defines for the CDC synchronizers
`define DWC_EQOS_F_SYNC_TYPE 2
`define DWC_EQOS_VERIF_EN 2
`define DWC_EQOS_CLK_APP_F_SYNC_TYPE 2
`define DWC_EQOS_CLK_APP_VERIF_EN 2
`define DWC_EQOS_CLK_CSR_F_SYNC_TYPE 2
`define DWC_EQOS_CLK_CSR_VERIF_EN 2

// Shortened name for Data bus width 
`define DWC_EQOS_DW `DWC_EQOS_DATAWIDTH 

// Width of the byte enables signal.
//`define DWC_EQOS_BEW `DWC_EQOS_DATAWIDTH/8

// Data bus size in bytes
`define DWC_EQOS_DATA_BUS_SIZE `DWC_EQOS_DATAWIDTH/8

// Transmit Status bus width, ATI Tx status bus.
`define DWC_EQOS_TX_STSW 82

// Number of DMA Transmit channels abbreviated.
`define DWC_EQOS_NTXCH `DWC_EQOS_NUM_DMA_TX_CH

// Number of DMA Receive channels abbreviated.
`define DWC_EQOS_NRXCH `DWC_EQOS_NUM_DMA_RX_CH

// Width of MTL transmit queue number signal for reading Transmit status. Since
// number of transmit channels is same as number of transmit queues, the same
// constant DWC_EQOS_TX_CHW is used.
`define DWC_EQOS_TXSQW `DWC_EQOS_TX_CHW 

// Width of header length signal
`define DWC_EQOS_HLW 10

// Width of burst control signal on MDC interface.
`define DWC_EQOS_BCW 8

// Width of MCI Address bus for DMA configs.
`define DWC_EQOS_MDC_MCIAW 14

`define DWC_EQOS_MDC_MCI_CH_AW 5

// Width of the ari_qnum bus 
//`define DWC_EQOS_RXQW `DWC_EQOS_RX_QW

// Shortened name for Number of transmit queues for DCB.
`define DWC_EQOS_NTXQ `DWC_EQOS_NUM_TXQ

// Shortened name for Number of receive queues for DCB.
`define DWC_EQOS_NRXQ `DWC_EQOS_NUM_RXQ

// Address for MTL Registers 
// Common MTL registers bits 13:8
`define DWC_EQOS_MTL_CMN_REG_ADDR 6'b00_1100 

// MTL Queue registers 0 to 3 bits 13:8
`define DWC_EQOS_MTL_Q0_Q3_REG_ADDR 6'b00_1101 

// MTL Queue registers 4 to 7 bits 13:8
`define DWC_EQOS_MTL_Q4_Q7_REG_ADDR 6'b00_1110 

// Address decoding for DCR common CSR space using bits 15:8.
`define DWC_EQOS_DCR_ADDR 6'h10

// Datawidth of all DMA CSR registers 
`define DWC_EQOS_MDC_CSRW 32

// Address decoding for DCR Channel 0 CSR space, using the bits 12:3
`define DWC_EQOS_DCR_ADDR_12_3_CH0 6'b1_0001_0

// Address decoding for DCR Channel 1 CSR space.
`define DWC_EQOS_DCR_ADDR_12_3_CH1 6'b1_0001_1

// Address decoding for DCR Channel 2 CSR space.
`define DWC_EQOS_DCR_ADDR_12_3_CH2 6'b1_0010_0

// Address decoding for DCR Channel 3 CSR space.
`define DWC_EQOS_DCR_ADDR_12_3_CH3 6'b1_0010_1

// Address decoding for DCR Channel 4 CSR space.
`define DWC_EQOS_DCR_ADDR_12_3_CH4 6'b1_0010_1

// Address decoding for DCR Channel 5 CSR space.
`define DWC_EQOS_DCR_ADDR_12_3_CH5 6'b1_0010_1

// Address decoding for DCR Channel 6 CSR space.
`define DWC_EQOS_DCR_ADDR_12_3_CH6 6'b1_0010_1

// Address decoding for DCR Channel 7 CSR space.
`define DWC_EQOS_DCR_ADDR_12_3_CH7 6'b1_0010_1

// Shortened name for number of Channels for CSR 
`define DWC_EQOS_NCSRCH `DWC_EQOS_NUM_DMA_CSR_CH

// Shortened name for number of DMA receive channels
`define DWC_EQOS_NRXCH `DWC_EQOS_NUM_DMA_RX_CH

// Shortened name for number of DMA transmit channels
`define DWC_EQOS_NTXCH `DWC_EQOS_NUM_DMA_TX_CH

// Address Bits used to select a specific register among the common registers or
// a specific channel register.
`define DWC_EQOS_MDC_CSR_BITS 6:2 

// Address Bits 12:8 are used to select the common CSR space 
`define DWC_EQOS_MDC_CMN_BITS 12:8

// Common CSR addresses space bits 12:8 is 6'h10 derived from
// 12'b1_0000_0000_0000 -> bits 12:8 = 6'b1_0000 = 6'h10
`define DWC_EQOS_MDC_CMN_SPC  5'h10

// DMA Bus mode register offset 
`define DWC_EQOS_MDC_BMR_ADDR 5'b000_00

// DMA AHB/AXI register offset
`define DWC_EQOS_MDC_AMR_ADDR 5'b000_01

// DMA Interrupt Status register offset
`define DWC_EQOS_MDC_ISTS_ADDR 5'b000_10

// DMA Debug status register 0 offset
`define DWC_EQOS_MDC_DBS0_ADDR 5'b000_11

// DMA Debug status register 1 offset
`define DWC_EQOS_MDC_DBS1_ADDR 5'b001_00

// DMA Debug status register 2 offset
`define DWC_EQOS_MDC_DBS2_ADDR 5'b001_01

// Address Bits 12:7 are used to select a specific channel CSR space 
`define DWC_EQOS_MDC_CHA_BITS 12:7 

// Channel CSR addresses have bits 12:7 beginning from 6'h22 derived from
// 12'b1_0001_0000_0000 -> bits 12:7 = 6'b10_0010 = 6'h22
`define DWC_EQOS_MDC_CHA_SPC  6'h22

// Common CSR addresses space bits 12:7 is 6'h20 derived from
// 12'b1_0000_0000_0000 -> bits 12:7 = 6'b10_0000 = 6'h20.To select status and
// interrupt enable registers, the common space should be selected.
`define DWC_EQOS_MDC_CMN_CH_SPC  6'h20

// DMA Channel control register offset 
`define DWC_EQOS_MDC_CTRL_ADDR 5'b000_00

// DMA Channel transmit control register offset 
`define DWC_EQOS_MDC_TX_CTRL_ADDR 5'b000_01

// DMA Channel receive control register offset 
`define DWC_EQOS_MDC_RX_CTRL_ADDR 5'b000_10

// DMA Channel transmit descriptor list address register offset 
`define DWC_EQOS_MDC_TDESL_ADDR 5'b001_01

// DMA Channel receive descriptor list address control register offset 
`define DWC_EQOS_MDC_RDESL_ADDR 5'b001_11

// DMA Channel transmit descriptor tail pointer register offset 
`define DWC_EQOS_MDC_TX_TPTR_ADDR 5'b010_00

// DMA Channel receive descriptor tail pointer register offset 
`define DWC_EQOS_MDC_RX_TPTR_ADDR 5'b010_10

// DMA Channel transmit descriptor length register offset 
`define DWC_EQOS_MDC_TX_LEN_ADDR 5'b010_11

// DMA Channel receive descriptor length register offset 
`define DWC_EQOS_MDC_RX_LEN_ADDR 5'b011_00

// DMA Channel interrupt enable register offset 
`define DWC_EQOS_MDC_INT_ADDR 5'b011_01

// DMA Channel receive watchdog interrupt register offset 
`define DWC_EQOS_MDC_RWT_ADDR 5'b011_10

// DMA Channel Slot Function Control and Status Register offset  
`define DWC_EQOS_MDC_SLFC_ST_ADDR 5'b011_11

// DMA Channel Current Transmit Descriptor Pointer Offset 
`define DWC_EQOS_MDC_CURR_TDES_ADDR 5'b100_01

// DMA Channel Current Receive Descriptor Pointer Offset 
`define DWC_EQOS_MDC_CURR_RDES_ADDR 5'b100_11

// DMA Channel Current Transmit Buffer Address Register Offset 
`define DWC_EQOS_MDC_CURR_TBUF_ADDR 5'b101_01

// DMA Channel Current Receive Buffer Address Register Offset 
`define DWC_EQOS_MDC_CURR_RBUF_ADDR 5'b101_11

// DMA Channel status register offset 
`define DWC_EQOS_MDC_STS_ADDR 5'b110_00

// DMA Channel AXI4 control register offset 
`define DWC_EQOS_MDC_AXI4_ADDR 5'b110_01

// DMA Buffer size field width in bits
`define DWC_EQOS_MDC_BUFSIZE_WIDTH 14

`define DWC_EQOS_NEEDED_BEATS_ONE {{`DWC_EQOS_NEEDED_BEATS_SIZE-1{`DWC_EQOS_L}},`DWC_EQOS_H}

`define DWC_EQOS_SIZE_BASE_INCR {{8{1'b0}},1'b1}

`define DWC_EQOS_ADDR_BASE_INCR {{`DWC_EQOS_DESC_ADDR_MSB{`DWC_EQOS_L}},`DWC_EQOS_H}

// Width of the bus synchronizer used in DMA Sync module (DWC_eqos_mdc_sync) 
// Given by :
// ( Process state (3) + Curr DESC Addr (DWC_EQOS_DESC_ADDR_MSB + 1) + Curr Buf Addr (32) ) * (NTXCH + NRXCH)
`define DWC_EQOS_MDC_BUS_SYNC_W ((35 + `DWC_EQOS_DESC_ADDR_MSB + 1) * (`DWC_EQOS_NTXCH + `DWC_EQOS_NRXCH))

// TX descriptor status write size
`define DWC_EQOS_TX_DESC_WR_SIZE 14'h10

// Width of DTX FSM state reg.
`define DWC_EQOS_DTX_FSMW 10

// C-VLAN Tag 
`define DWC_EQOS_CVLAN 16'h8100 

// S-VLAN Tag
`define DWC_EQOS_SVLAN 16'h88A8


// First VLAN Tag position in Ethernet header
`define DWC_EQOS_MDC_FIRST_VTAG_POS 1 

// Second VLAN Tag position in Ethernet header
`define DWC_EQOS_MDC_SEC_VTAG_POS 2 
`define DWC_EQOS_MDC_RX_DESC_DATAW 20

`define DWC_EQOS_MDC_ENDIAN_HI_CONCAT(signal)  \
  {signal[7:0], signal[15:8],       \
   signal[23:16], signal[31:24],    \
   signal[39:32], signal[47:40],    \
   signal[55:48], signal[63:56],    \
   signal[71:64], signal[79:72],    \
   signal[87:80], signal[95:88],    \
   signal[103:96], signal[111:104], \
   signal[119:112], signal[127:120]}

`define DWC_EQOS_MDC_STORED_DATA(data)\
 {data[15],data[14],data[13], data[12],data[11],data[10], data[9],data[8],data[7], \
  data[6],data[5],data[4], data[3],data[2],data[1], data[0]}
// Length of IPv6 expressed as number of data beats.
`define DWC_EQOS_IPV6_HDR_WORD_LEN 12'd3

// Used by FRX to check for good frame reception based on RPE status.
`define DWC_EQOS_STATUS_OK {{(`DWCE_RPESW-44){`DWC_EQOS_L}},44'h00010060040}
`define DWC_EQOS_PFC_STS_OK {{(`DWCE_RPESW-44){`DWC_EQOS_L}},44'h01010060040}

`define DWC_EQOS_OS_S    `DWC_EQOS_K27_7
`define DWC_EQOS_OS_R    `DWC_EQOS_K23_7
`define DWC_EQOS_OS_T    `DWC_EQOS_K29_7

`define DWC_EQOS_K28_0   8'h1C
`define DWC_EQOS_K28_1   8'h3C
`define DWC_EQOS_K28_2   8'h5C
`define DWC_EQOS_K28_3   8'h7C
`define DWC_EQOS_K28_4   8'h9C
`define DWC_EQOS_K28_5   8'hBC
`define DWC_EQOS_K28_6   8'hDC
`define DWC_EQOS_K28_7   8'hFC
`define DWC_EQOS_K23_7   8'hF7
`define DWC_EQOS_K27_7   8'hFB
`define DWC_EQOS_K29_7   8'hFD
`define DWC_EQOS_K30_7   8'hFE

`define DWC_EQOS_D5_6    8'hC5
`define DWC_EQOS_D16_2   8'h50
`define DWC_EQOS_D21_5   8'hB5
`define DWC_EQOS_D2_2    8'h42
`define DWC_EQOS_D0_0    8'h00

`ifdef DWC_EQOS_FAST_SIM
  `define      DWC_EQOS_LINK_TMR_TBI     21'h01E1FF   // timeout of 1 uS
  `define      DWC_EQOS_LINK_TMR_SGMII   21'h01E1FF   // timeout of 1 uS
`else
  `define      DWC_EQOS_LINK_TMR_TBI     1122695   // timeout of 10 ms
  `define      DWC_EQOS_LINK_TMR_SGMII   898566    // timeout of 1.6 ms in SGMII
`endif

`define DWC_NO_CDC_INIT

`define DWC_DISALLOW_LATCHES

`define DWC_EQOS_AHB_RST_MODE posedge hclk_i or negedge hreset_n
`define DWC_EQOS_RST_GM_MODE posedge gm_clk or negedge gm_reset_n
`define DWC_EQOS_RST_GS_MODE posedge gs_clk or negedge gs_reset_n
`define DWC_EQOS_APP_RST_MODE posedge clk_app_i or negedge rst_clk_app_n
`define DWC_EQOS_CSR_RST_MODE posedge clk_csr_i or negedge rst_clk_csr_n
`define DWC_EQOS_PTP_RST_MODE posedge clk_ptp_ref_i or negedge rst_clk_ptp_ref_n
`define DWC_EQOS_TX_RST_MODE posedge clk_tx_i or negedge rst_clk_tx_n
`define DWC_EQOS_TX_180_RST_MODE posedge clk_tx_180_i or negedge rst_clk_tx_180_n
`define DWC_EQOS_RX_RST_MODE posedge clk_rx_i or negedge rst_clk_rx_n
`define DWBB_RST_MODE or negedge reset_n
`define DWC_EQOS_RX_180_RST_MODE posedge clk_rx_180_i or negedge rst_clk_rx_180_n
`define DWC_EQOS_RMII_RST_MODE posedge clk_rmii_i or negedge rst_clk_rmii_n
`define DWC_EQOS_REVMII_MDC_RST_MODE posedge revmii_mdc_i or negedge revmii_mdc_rst_n
`define DWC_EQOS_REVMII_TXCLK_RST_MODE posedge clk_revmii_tx_i or negedge rst_clk_revmii_tx_n
`define DWC_EQOS_REVMII_RXCLK_RST_MODE posedge clk_revmii_rx_i or negedge rst_clk_revmii_rx_n
`define DWC_EQOS_CLK_125_RST_MODE posedge clk_125_i or negedge rst_clk_125_i_n
`define DWC_EQOS_TX_125_RST_MODE posedge clk_tx_125_i or negedge rst_clk_tx_125_n  
`define DWC_EQOS_RX_125_RST_MODE posedge clk_rx_125_i or negedge rst_clk_rx_125_n  
`define DWC_EQOS_RST_PMARX0_MODE posedge clk_pmarx0_i or negedge rst_clk_pmarx1_n
`define DWC_EQOS_RST_PMARX1_MODE posedge clk_pmarx1_i or negedge rst_clk_pmarx1_n
`define DWC_EQOS_RST_MODE posedge clk_i or negedge rst_clk_n
`define DWC_EQOS_APP_RST_MODE posedge clk_app_i or negedge rst_clk_app_n
`define DWC_EQOS_TS_SYNC_RST_MODE posedge clk_d_i or negedge rst_clk_d_n

// Reference slot number width
`define DWC_EQOS_RSN_WIDTH 4

`define DWC_EQOS_PTP_SEC_OVF_WIDTH 2

`define DWC_EQOS_HASH_IDX 6

// Auxillary snapshot data width. 1 bit per auxiliary trigger is added only if
// more than 1 trigger is selected. If only 1 trigger is chosen, there is no
// need for the extra bit. 
`define DWC_EQOS_AUX_FIFO_WIDTH 63
`define DWC_EQOS_AUX_FIFO_PTR_WDTH 3

//--------------------------------------------------------------------------- 
// MAC Core defines
//--------------------------------------------------------------------------- 

// MAC CSR address space used for bits 13:8
`define DWC_EQOS_MAC_CSR_ADDR 6'b00_0000
`define DWC_EQOS_MAC_DBG_ADDR 6'b00_0001

`define DWC_EQOS_MAC_TS_CSR_ADDR 6'b00_1011

`define DWC_EQOS_MAC_GMII_ADDR 6'b00_0010

`define DWC_EQOS_L3_L4_FILTER_ADDR0 6'b00_1001
`define DWC_EQOS_L3_L4_FILTER_ADDR1 10'b00_1001_1111
`define DWC_EQOS_L3_L4_FILTER_ADDR2 10'b00_1010_1110
`define DWC_EQOS_ARP_ADDR 10'b00_1010_1110
`define DWC_EQOS_ARP_ADDR_CSR0 2'b00



`define DWC_EQOS_RFCSW 8
`define DWC_EQOS_CR_REG2_BYTE1_C2R_WDW 3

`define DWC_EQOS_MACADDR_SYNC_REG_MODE 1

`define DWC_EQOS_MACADDR0_SYNC_REG_MODE 1

`define DWC_EQOS_VTAG_SYNC_REG_MODE 1

`define DWC_EQOS_PAUSETIME_SYNC_REG_MODE 1

// First 32 MAC Address registers 
`define DWC_EQOS_MAC_ADDR0_31  6'b000011

// Additional 32 MAC Address registers 
`define DWC_EQOS_MAC_ADDR32_63 6'b000100

// Additional 64 MAC Address registers 
`define DWC_EQOS_MAC_ADDR64_95  6'b00_0101
`define DWC_EQOS_MAC_ADDR96_127 6'b00_0110

// Generic defines to decode Lower 6 bits of CSR address
`define DWC_EQOS_MAC_CSR_ADDR0 6'b00_0000
`define DWC_EQOS_MAC_CSR_ADDR1 6'b00_0001
`define DWC_EQOS_MAC_CSR_ADDR2 6'b00_0010
`define DWC_EQOS_MAC_CSR_ADDR3 6'b00_0011
`define DWC_EQOS_MAC_CSR_ADDR4 6'b00_0100
`define DWC_EQOS_MAC_CSR_ADDR5 6'b00_0101
`define DWC_EQOS_MAC_CSR_ADDR6 6'b00_0110
`define DWC_EQOS_MAC_CSR_ADDR7 6'b00_0111
`define DWC_EQOS_MAC_CSR_ADDR8 6'b00_1000
`define DWC_EQOS_MAC_CSR_ADDR9 6'b00_1001
`define DWC_EQOS_MAC_CSR_ADDR10 6'b00_1010
`define DWC_EQOS_MAC_CSR_ADDR11 6'b00_1011
`define DWC_EQOS_MAC_CSR_ADDR12 6'b00_1100
`define DWC_EQOS_MAC_CSR_ADDR13 6'b00_1101
`define DWC_EQOS_MAC_CSR_ADDR14 6'b00_1110
`define DWC_EQOS_MAC_CSR_ADDR15 6'b00_1111
`define DWC_EQOS_MAC_CSR_ADDR16 6'b01_0000
`define DWC_EQOS_MAC_CSR_ADDR17 6'b01_0001
`define DWC_EQOS_MAC_CSR_ADDR18 6'b01_0010
`define DWC_EQOS_MAC_CSR_ADDR19 6'b01_0011
`define DWC_EQOS_MAC_CSR_ADDR20 6'b01_0100
`define DWC_EQOS_MAC_CSR_ADDR21 6'b01_0101
`define DWC_EQOS_MAC_CSR_ADDR22 6'b01_0110
`define DWC_EQOS_MAC_CSR_ADDR23 6'b01_0111
`define DWC_EQOS_MAC_CSR_ADDR24 6'b01_1000
`define DWC_EQOS_MAC_CSR_ADDR25 6'b01_1001
`define DWC_EQOS_MAC_CSR_ADDR26 6'b01_1010
`define DWC_EQOS_MAC_CSR_ADDR27 6'b01_1011
`define DWC_EQOS_MAC_CSR_ADDR28 6'b01_1100
`define DWC_EQOS_MAC_CSR_ADDR29 6'b01_1101
`define DWC_EQOS_MAC_CSR_ADDR30 6'b01_1110
`define DWC_EQOS_MAC_CSR_ADDR31 6'b01_1111
`define DWC_EQOS_MAC_CSR_ADDR32 6'b10_0000
`define DWC_EQOS_MAC_CSR_ADDR33 6'b10_0001
`define DWC_EQOS_MAC_CSR_ADDR34 6'b10_0010
`define DWC_EQOS_MAC_CSR_ADDR35 6'b10_0011
`define DWC_EQOS_MAC_CSR_ADDR36 6'b10_0100
`define DWC_EQOS_MAC_CSR_ADDR37 6'b10_0101
`define DWC_EQOS_MAC_CSR_ADDR38 6'b10_0110
`define DWC_EQOS_MAC_CSR_ADDR39 6'b10_0111
`define DWC_EQOS_MAC_CSR_ADDR40 6'b10_1000
`define DWC_EQOS_MAC_CSR_ADDR41 6'b10_1001
`define DWC_EQOS_MAC_CSR_ADDR42 6'b10_1010
`define DWC_EQOS_MAC_CSR_ADDR43 6'b10_1011
`define DWC_EQOS_MAC_CSR_ADDR44 6'b10_1100
`define DWC_EQOS_MAC_CSR_ADDR45 6'b10_1101
`define DWC_EQOS_MAC_CSR_ADDR46 6'b10_1110
`define DWC_EQOS_MAC_CSR_ADDR47 6'b10_1111
`define DWC_EQOS_MAC_CSR_ADDR48 6'b11_0000
`define DWC_EQOS_MAC_CSR_ADDR49 6'b11_0001
`define DWC_EQOS_MAC_CSR_ADDR50 6'b11_0010
`define DWC_EQOS_MAC_CSR_ADDR51 6'b11_0011
`define DWC_EQOS_MAC_CSR_ADDR52 6'b11_0100
`define DWC_EQOS_MAC_CSR_ADDR53 6'b11_0101
`define DWC_EQOS_MAC_CSR_ADDR54 6'b11_0110
`define DWC_EQOS_MAC_CSR_ADDR55 6'b11_0111
`define DWC_EQOS_MAC_CSR_ADDR56 6'b11_1000
`define DWC_EQOS_MAC_CSR_ADDR57 6'b11_1001
`define DWC_EQOS_MAC_CSR_ADDR58 6'b11_1010
`define DWC_EQOS_MAC_CSR_ADDR59 6'b11_1011
`define DWC_EQOS_MAC_CSR_ADDR60 6'b11_1100
`define DWC_EQOS_MAC_CSR_ADDR61 6'b11_1101
`define DWC_EQOS_MAC_CSR_ADDR62 6'b11_1110
`define DWC_EQOS_MAC_CSR_ADDR63 6'b11_1111

// MMC Register addresses
`define DWC_EQOS_MMC_ADDR_13_8 6'b00_0111
`define DWC_EQOS_MMC_IPC_ADDR_13_8 6'b00_1000

// MAC Address register defines 
`define DWC_EQOS_MACADDR_CSR0 7'b100_0000
`define DWC_EQOS_MACADDR_CSR1 7'b100_0001
`define DWC_EQOS_MACADDR_CSR2 7'b100_0010
`define DWC_EQOS_MACADDR_CSR3 7'b100_0011
`define DWC_EQOS_MACADDR_CSR4 7'b100_0100
`define DWC_EQOS_MACADDR_CSR5 7'b100_0101
`define DWC_EQOS_MACADDR_CSR6 7'b100_0110
`define DWC_EQOS_MACADDR_CSR7 7'b100_0111
`define DWC_EQOS_MACADDR_CSR8 7'b100_1000
`define DWC_EQOS_MACADDR_CSR9 7'b100_1001
`define DWC_EQOS_MACADDR_CSR10 7'b100_1010
`define DWC_EQOS_MACADDR_CSR11 7'b100_1011
`define DWC_EQOS_MACADDR_CSR12 7'b100_1100
`define DWC_EQOS_MACADDR_CSR13 7'b100_1101
`define DWC_EQOS_MACADDR_CSR14 7'b100_1110
`define DWC_EQOS_MACADDR_CSR15 7'b100_1111
`define DWC_EQOS_MACADDR_CSR16 7'b101_0000
`define DWC_EQOS_MACADDR_CSR17 7'b101_0001
`define DWC_EQOS_MACADDR_CSR18 7'b101_0010
`define DWC_EQOS_MACADDR_CSR19 7'b101_0011
`define DWC_EQOS_MACADDR_CSR20 7'b101_0100
`define DWC_EQOS_MACADDR_CSR21 7'b101_0101
`define DWC_EQOS_MACADDR_CSR22 7'b101_0110
`define DWC_EQOS_MACADDR_CSR23 7'b101_0111
`define DWC_EQOS_MACADDR_CSR24 7'b101_1000
`define DWC_EQOS_MACADDR_CSR25 7'b101_1001
`define DWC_EQOS_MACADDR_CSR26 7'b101_1010
`define DWC_EQOS_MACADDR_CSR27 7'b101_1011
`define DWC_EQOS_MACADDR_CSR28 7'b101_1100
`define DWC_EQOS_MACADDR_CSR29 7'b101_1101
`define DWC_EQOS_MACADDR_CSR30 7'b101_1110
`define DWC_EQOS_MACADDR_CSR31 7'b101_1111
`define DWC_EQOS_MACADDR_CSR32 7'b110_0000
`define DWC_EQOS_MACADDR_CSR33 7'b110_0001
`define DWC_EQOS_MACADDR_CSR34 7'b110_0010
`define DWC_EQOS_MACADDR_CSR35 7'b110_0011
`define DWC_EQOS_MACADDR_CSR36 7'b110_0100
`define DWC_EQOS_MACADDR_CSR37 7'b110_0101
`define DWC_EQOS_MACADDR_CSR38 7'b110_0110
`define DWC_EQOS_MACADDR_CSR39 7'b110_0111
`define DWC_EQOS_MACADDR_CSR40 7'b110_1000
`define DWC_EQOS_MACADDR_CSR41 7'b110_1001
`define DWC_EQOS_MACADDR_CSR42 7'b110_1010
`define DWC_EQOS_MACADDR_CSR43 7'b110_1011
`define DWC_EQOS_MACADDR_CSR44 7'b110_1100
`define DWC_EQOS_MACADDR_CSR45 7'b110_1101
`define DWC_EQOS_MACADDR_CSR46 7'b110_1110
`define DWC_EQOS_MACADDR_CSR47 7'b110_1111
`define DWC_EQOS_MACADDR_CSR48 7'b111_0000
`define DWC_EQOS_MACADDR_CSR49 7'b111_0001
`define DWC_EQOS_MACADDR_CSR50 7'b111_0010
`define DWC_EQOS_MACADDR_CSR51 7'b111_0011
`define DWC_EQOS_MACADDR_CSR52 7'b111_0100
`define DWC_EQOS_MACADDR_CSR53 7'b111_0101
`define DWC_EQOS_MACADDR_CSR54 7'b111_0110
`define DWC_EQOS_MACADDR_CSR55 7'b111_0111
`define DWC_EQOS_MACADDR_CSR56 7'b111_1000
`define DWC_EQOS_MACADDR_CSR57 7'b111_1001
`define DWC_EQOS_MACADDR_CSR58 7'b111_1010
`define DWC_EQOS_MACADDR_CSR59 7'b111_1011
`define DWC_EQOS_MACADDR_CSR60 7'b111_1100
`define DWC_EQOS_MACADDR_CSR61 7'b111_1101
`define DWC_EQOS_MACADDR_CSR62 7'b111_1110
`define DWC_EQOS_MACADDR_CSR63 7'b111_1111
`define DWC_EQOS_MACADDR_CSR64 7'b000_0000
`define DWC_EQOS_MACADDR_CSR65 7'b000_0001
`define DWC_EQOS_MACADDR_CSR66 7'b000_0010
`define DWC_EQOS_MACADDR_CSR67 7'b000_0011
`define DWC_EQOS_MACADDR_CSR68 7'b000_0100
`define DWC_EQOS_MACADDR_CSR69 7'b000_0101
`define DWC_EQOS_MACADDR_CSR70 7'b000_0110
`define DWC_EQOS_MACADDR_CSR71 7'b000_0111
`define DWC_EQOS_MACADDR_CSR72 7'b000_1000
`define DWC_EQOS_MACADDR_CSR73 7'b000_1001
`define DWC_EQOS_MACADDR_CSR74 7'b000_1010
`define DWC_EQOS_MACADDR_CSR75 7'b000_1011
`define DWC_EQOS_MACADDR_CSR76 7'b000_1100
`define DWC_EQOS_MACADDR_CSR77 7'b000_1101
`define DWC_EQOS_MACADDR_CSR78 7'b000_1110
`define DWC_EQOS_MACADDR_CSR79 7'b000_1111
`define DWC_EQOS_MACADDR_CSR80 7'b001_0000
`define DWC_EQOS_MACADDR_CSR81 7'b001_0001
`define DWC_EQOS_MACADDR_CSR82 7'b001_0010
`define DWC_EQOS_MACADDR_CSR83 7'b001_0011
`define DWC_EQOS_MACADDR_CSR84 7'b001_0100
`define DWC_EQOS_MACADDR_CSR85 7'b001_0101
`define DWC_EQOS_MACADDR_CSR86 7'b001_0110
`define DWC_EQOS_MACADDR_CSR87 7'b001_0111
`define DWC_EQOS_MACADDR_CSR88 7'b001_1000
`define DWC_EQOS_MACADDR_CSR89 7'b001_1001
`define DWC_EQOS_MACADDR_CSR90 7'b001_1010
`define DWC_EQOS_MACADDR_CSR91 7'b001_1011
`define DWC_EQOS_MACADDR_CSR92 7'b001_1100
`define DWC_EQOS_MACADDR_CSR93 7'b001_1101
`define DWC_EQOS_MACADDR_CSR94 7'b001_1110
`define DWC_EQOS_MACADDR_CSR95 7'b001_1111
`define DWC_EQOS_MACADDR_CSR96 7'b010_0000
`define DWC_EQOS_MACADDR_CSR97 7'b010_0001
`define DWC_EQOS_MACADDR_CSR98 7'b010_0010
`define DWC_EQOS_MACADDR_CSR99 7'b010_0011
`define DWC_EQOS_MACADDR_CSR100 7'b010_0100
`define DWC_EQOS_MACADDR_CSR101 7'b010_0101
`define DWC_EQOS_MACADDR_CSR102 7'b010_0110
`define DWC_EQOS_MACADDR_CSR103 7'b010_0111
`define DWC_EQOS_MACADDR_CSR104 7'b010_1000
`define DWC_EQOS_MACADDR_CSR105 7'b010_1001
`define DWC_EQOS_MACADDR_CSR106 7'b010_1010
`define DWC_EQOS_MACADDR_CSR107 7'b010_1011
`define DWC_EQOS_MACADDR_CSR108 7'b010_1100
`define DWC_EQOS_MACADDR_CSR109 7'b010_1101
`define DWC_EQOS_MACADDR_CSR110 7'b010_1110
`define DWC_EQOS_MACADDR_CSR111 7'b010_1111
`define DWC_EQOS_MACADDR_CSR112 7'b011_0000
`define DWC_EQOS_MACADDR_CSR113 7'b011_0001
`define DWC_EQOS_MACADDR_CSR114 7'b011_0010
`define DWC_EQOS_MACADDR_CSR115 7'b011_0011
`define DWC_EQOS_MACADDR_CSR116 7'b011_0100
`define DWC_EQOS_MACADDR_CSR117 7'b011_0101
`define DWC_EQOS_MACADDR_CSR118 7'b011_0110
`define DWC_EQOS_MACADDR_CSR119 7'b011_0111
`define DWC_EQOS_MACADDR_CSR120 7'b011_1000
`define DWC_EQOS_MACADDR_CSR121 7'b011_1001
`define DWC_EQOS_MACADDR_CSR122 7'b011_1010
`define DWC_EQOS_MACADDR_CSR123 7'b011_1011
`define DWC_EQOS_MACADDR_CSR124 7'b011_1100
`define DWC_EQOS_MACADDR_CSR125 7'b011_1101
`define DWC_EQOS_MACADDR_CSR126 7'b011_1110
`define DWC_EQOS_MACADDR_CSR127 7'b011_1111

`define DWC_EQOS_MAC_CFG_REGW 32
`define DWC_EQOS_RXQCR1W 9

`define DWC_EQOS_RXQCR2W (`DWC_EQOS_NUM_RXQ*8)


`define DWC_EQOS_RSN_WIDTH 4

`define DWC_EQOS_TXD_IOW  `DWC_EQOS_TXD_WIDTH
`define DWC_EQOS_RXD_IOW  `DWC_EQOS_RXD_WIDTH

`define DWC_EQOS_TXEN_OP

`define DWC_EQOS_TXER_OP

`define DWC_EQOS_RXDV_IP

`define DWC_EQOS_RXER_IP

`define DWC_EQOS_CRS_IP

`define DWC_EQOS_COL_IP

`define DWC_EQOS_PMT_WKUP_CSR_ADDR0  5'b0_0000
`define DWC_EQOS_PMT_WKUP_CSR_ADDR1  5'b0_0001
`define DWC_EQOS_PMT_WKUP_CSR_ADDR2  5'b0_0010
`define DWC_EQOS_PMT_WKUP_CSR_ADDR3  5'b0_0011
`define DWC_EQOS_PMT_WKUP_CSR_ADDR4  5'b0_0100
`define DWC_EQOS_PMT_WKUP_CSR_ADDR5  5'b0_0101
`define DWC_EQOS_PMT_WKUP_CSR_ADDR6  5'b0_0110
`define DWC_EQOS_PMT_WKUP_CSR_ADDR7  5'b0_0111
`define DWC_EQOS_PMT_WKUP_CSR_ADDR8  5'b0_1000
`define DWC_EQOS_PMT_WKUP_CSR_ADDR9  5'b0_1001
`define DWC_EQOS_PMT_WKUP_CSR_ADDR10 5'b0_1010
`define DWC_EQOS_PMT_WKUP_CSR_ADDR11 5'b0_1001
`define DWC_EQOS_PMT_WKUP_CSR_ADDR12 5'b0_1100
`define DWC_EQOS_PMT_WKUP_CSR_ADDR13 5'b0_1101
`define DWC_EQOS_PMT_WKUP_CSR_ADDR14 5'b0_1110
`define DWC_EQOS_PMT_WKUP_CSR_ADDR15 5'b0_1111
`define DWC_EQOS_PMT_WKUP_CSR_ADDR16 5'b1_0000
`define DWC_EQOS_PMT_WKUP_CSR_ADDR17 5'b1_0001
`define DWC_EQOS_PMT_WKUP_CSR_ADDR18 5'b1_0010
`define DWC_EQOS_PMT_WKUP_CSR_ADDR19 5'b1_0011
`define DWC_EQOS_PMT_WKUP_CSR_ADDR20 5'b1_0100
`define DWC_EQOS_PMT_WKUP_CSR_ADDR21 5'b1_0101
`define DWC_EQOS_PMT_WKUP_CSR_ADDR22 5'b1_0110
`define DWC_EQOS_PMT_WKUP_CSR_ADDR23 5'b1_0111
`define DWC_EQOS_PMT_WKUP_CSR_ADDR24 5'b1_1000
`define DWC_EQOS_PMT_WKUP_CSR_ADDR25 5'b1_1001
`define DWC_EQOS_PMT_WKUP_CSR_ADDR26 5'b1_1010
`define DWC_EQOS_PMT_WKUP_CSR_ADDR27 5'b1_1001
`define DWC_EQOS_PMT_WKUP_CSR_ADDR28 5'b1_1100
`define DWC_EQOS_PMT_WKUP_CSR_ADDR29 5'b1_1101
`define DWC_EQOS_PMT_WKUP_CSR_ADDR30 5'b1_1110
`define DWC_EQOS_PMT_WKUP_CSR_ADDR31 5'b1_1111

`define DWC_EQOS_TS_RSEL_W 36 

 `define DWC_EQOS_TS_STS_WIDTH 3

`define DWC_EQOS_TSCROW 20

`define DWC_EQOS_TSCRW 16

/// sub-seconds increment width
`define DWC_EQOS_TSSSINCW 8

/// width of sub-seconds portion of timestamp
`define DWC_EQOS_TSSSW 32

/// start bit position of sub-seconds field
`define DWC_EQOS_TSSS_ST 0

/// width of internal timestamp (higher word of seconds field is not
/// considered here)
`define DWC_EQOS_INT_TSW 64

/// Width of the timestamp correction field (used mainly for egress correction)
`define DWC_EQOS_TSCORW 32

`define DWC_EQOS_REG_WR32_BE4(register) \
  register[31:24] <= mci_be_i[3] ? mci_wdata_i[31:24] : register[31:24] ; \
  register[23:16] <= mci_be_i[2] ? mci_wdata_i[23:16] : register[23:16] ; \
  register[15:8]  <= mci_be_i[1] ? mci_wdata_i[15:8]  : register[15:8] ; \
  register[7:0]   <= mci_be_i[0] ? mci_wdata_i[7:0]   : register[7:0] ; 

`define DWC_EQOS_TWO_REG_WR32_BE4(register1,register2) \
  register1[7:0]  <= mci_be_i[0] ? mci_wdata_i[7:0]   : register1[7:0] ; \
  register1[15:8] <= mci_be_i[1] ? mci_wdata_i[15:8]  : register1[15:8] ; \
  register2[7:0]  <= mci_be_i[2] ? mci_wdata_i[23:16] : register2[7:0] ; \
  register2[15:8] <= mci_be_i[3] ? mci_wdata_i[31:24] : register2[15:8] ;

`define DWC_EQOS_UDP_HDR 8'h11
`define DWC_EQOS_TCP_HDR 8'h06
`define DWC_EQOS_ICMP_IPV4_HDR 8'h01
`define DWC_EQOS_ICMP_IPV6_HDR 8'h3A
`define DWC_EQOS_HOPBYHOP_HDR 8'h00
`define DWC_EQOS_ROUTING_HDR 8'h2B
`define DWC_EQOS_DESTOPTS_HDR 8'h3C
`define DWC_EQOS_AUTH_HDR 8'h33
`define DWC_EQOS_IPV4 4'h4
`define DWC_EQOS_IPV6 4'h6


// -----------------------------------------------------------------------------
// Defines that follow are used in the hardware config register   
// -----------------------------------------------------------------------------

`define SAVINS 0

`define INT_TS 2'b11

`define MACADDR_ADD64 0

`define MACADDR_ADD32 0

`define MACADDR_ADD 5'b00010

`define RXCOE 1

`define TXCOE 1

`define AVBEN 1

`define DBGMEMA 0

`define ADVTSHW 1

`define EEEN 1

`define TSEN 1

`define ARPEN 0

`define VHASHEN 1

`define MMCEN 1

`define PMTRWK 1

`define PMTMGK 1

`define SMAEN 1

`define L3L4FNUM 4'b0001

`define AUXNUM 3'b001

`define PPSNUM 3'b001

`define PCSREG 1

`define HASHSZ 2'b01

`define UPF_EN 1

`define HD_EN 1

`define SPEED 2'b11

 `define TSOEN 0

 `define SPHEN 0

`define DCBEN 1

`define TXFIFOSIZE `DWC_EQOS_TX_FIFO_PTR_WIDTH+((`DWC_EQOS_DATAWIDTH/64)+2)
`define RXFIFOSIZE `DWC_EQOS_RX_FIFO_PTR_WIDTH+((`DWC_EQOS_DATAWIDTH/64)+2)

`define DWC_EQOS_DAF_STS_WIDTH 2

`define DWC_EQOS_CORE_STSW 112
`define DWCE_VTSW 16
`define DWCE_RPESW 62

`define DWC_EQOS_CR_REG0_BYTE1_C2R_WDW 5

`define DWC_EQOS_SFD 8'b1101_0101
`define DWC_EQOS_MIN_FRAME_LEN 16'd46
`define DWC_EQOS_MAX_FRAME_LEN 16'd1500

// Selection of PHY
`define PHY_SELECT_VAL 3'b000

`define DWC_EQOS_TPE_LFSR_CNT_1 4'hF 
`define DWC_EQOS_TPE_LFSR_CNT_3 4'hD 
`define DWC_EQOS_TPE_LFSR_CNT_4 4'hA 
`define DWC_EQOS_TPE_LFSR_CNT_5 4'h5 
`define DWC_EQOS_TPE_LFSR_CNT_6 4'hB 
`define DWC_EQOS_TPE_LFSR_CNT_7 4'h6 
`define DWC_EQOS_TPE_LFSR_CNT_8 4'hC 
`define DWC_EQOS_TPE_LFSR_CNT_10 4'h2 
`define DWC_EQOS_TPE_LFSR_CNT_14 4'h3

`define DWC_EQOS_EXSSDEF_LMT_GMII 15'h4BEB
`define DWC_EQOS_EXSSDEF_LMT_MII 15'h17B7

`define DWC_EQOS_EARLY_BST_LMT 14'h1FF4

`define DWC_EQOS_TPE_STW 12

`define DWC_EQOS_IFG_CW 5 

`define DWC_EQOS_FDUPLX_SYNC_REG_MODE 1

`define DWC_EQOS_FDUPLX_M110_SYNC_REG_MODE 1

`define DWC_EQOS_HASH_SYNC_REG_MODE 3

`define DWC_EQOS_L3L4_SYNC_REG_MODE 3

`define DWC_EQOS_CR_REG0_BYTE1_C2T_WDW 6

`define DWC_EQOS_CR_REG62_BYTE0_C2T_WDW 2

`define DWC_EQOS_AN_CTL_RW 10

`define DWC_EQOS_RANDOM_SEED_1   32'h93B42B67
`define DWC_EQOS_RANDOM_SEED_2   32'hB9573FC8
`define DWC_EQOS_RANDOM_SEED_3   32'h4697A252
`define DWC_EQOS_RANDOM_SEED_4   32'h675A42BF

`define DWC_EQOS_MASK_1  14'h3FFE   
`define DWC_EQOS_MASK_2  30'h3FFFFFF8
`define DWC_EQOS_MASK_3  25'h1FFFFF0
`define DWC_EQOS_MASK_4  19'h7FF80

`ifdef DWC_EQOS_FAST_SIM
  `define DWC_EQOS_MII_USEC  17'h0004  //200ns 
  `define DWC_EQOS_GMII_USEC 17'h0018  
  `define DWC_EQOS_MII_MSEC  17'h0031  //2 uS 
  `define DWC_EQOS_GMII_MSEC 17'h00F9 
`else
  `define DWC_EQOS_MII_USEC  17'h0018  //1uS 
  `define DWC_EQOS_GMII_USEC 17'h007C 
  `define DWC_EQOS_MII_MSEC  17'h61A7  //1mS 
  `define DWC_EQOS_GMII_MSEC 17'h1E847 
`endif

`define DWC_EQOS_GMII_TX_CGC_VAL   17'h0000B


`define DWC_EQOS_MARW 56

`define DWC_EQOS_TFC_FPW 3
`define DWC_EQOS_TFC_FFSW 8


`define DWC_EQOS_TFC_FW 11

`define DWC_EQOS_TBU_CF 80

`define DWC_EQOS_TBU_CFNBW 4

`define DWC_EQOS_VLT_RW 25

`define DWC_EQOS_CR_REG20_BYTE3_C2R_WDW 2

`define DWC_EQOS_IDWI `DWC_EQOS_CHW+1
`define DWC_EQOS_CNTW       16

`define DWC_EQOS_ADD_IDW   `DWC_EQOS_AXI_GM_AXI_ID_WIDTH -`DWC_EQOS_AXI_GM_GM_ID_WIDTH

//Parameter indicates whether Read Data buffer depth
`define DWC_EQOS_AXI_GM_RDATA_BUFFER  2

`define DWC_EQOS_AXI_LPI_CNTW 5   

`define DWC_EQOS_DATW      `DWC_EQOS_AXI_GM_DATA_WIDTH

`define DWC_EQOS_AXI_IDW   `DWC_EQOS_AXI_GM_AXI_ID_WIDTH

`define DWC_EQOS_IDW       `DWC_EQOS_AXI_GM_GM_ID_WIDTH

//Parameter indicating Posted Write command
`define DWC_EQOS_GMW_PW   2'b01

//Parameter indicating non-Posted Write command
`define DWC_EQOS_GMW_WR   2'b10

//Parameter indicating Command Interface Idle
`define DWC_EQOS_CMD_IDLE 2'b00

//Parameter indicating Increment Aligned burst type
`define DWC_EQOS_INC_A    2'b00

//Parameter indicating Increment (without Alignment) burst type
`define DWC_EQOS_INC      2'b01

//Parameter indicating Wrap burst type
`define DWC_EQOS_WRAP     2'b10

//Parameter indicating OK Resposne for Read (slave Interface)
`define DWC_EQOS_OK_R     2'b00

//Parameter indicating OK Resposne for Write (slave Interface)
`define DWC_EQOS_OK_W     2'b01

//Parameter indicating OK Resposne on GM
`define DWC_EQOS_OK_RESP  2'b00

//Parameter indicating Error Resposne on GM
`define DWC_EQOS_ERR_RESP 2'b01

//Parameter indicating Additional Error Resposne on GM
`define DWC_EQOS_ADD_RESP 2'b11

`define DWC_EQOS_AW        `DWC_EQOS_AXI_GM_ADDR_WIDTH

`define DWC_EQOS_AXI_IDW   `DWC_EQOS_AXI_GM_AXI_ID_WIDTH

`define DWC_EQOS_IDW       `DWC_EQOS_AXI_GM_GM_ID_WIDTH

//Parameter indicating Out-of-Order FIFO Depth
`define DWC_EQOS_OO_DRQW  `DWC_EQOS_BSA+`DWC_EQOS_BSA+`DWC_EQOS_BLW+`DWC_EQOS_IDW+1+1+1

//Parameter indicating Data FIFO Width
`define DWC_EQOS_DATFW    `DWC_EQOS_DATAWIDTH+`DWC_EQOS_BSA+`DWC_EQOS_BSA+`DWC_EQOS_IDW+1+1+1+1

//Parameter indicating Write Response FIFO Width
`define DWC_EQOS_WRSFW    3+`DWC_EQOS_IDW 

//Parameter indicating Read Response FIFO Width
`define DWC_EQOS_RRSFW    1+3+`DWC_EQOS_IDW+`DWC_EQOS_DATAWIDTH


// Parameter indicating GM Command Width
`define DWC_EQOS_CMDW     `DWC_EQOS_IDW+`DWC_EQOS_AW+1+`DWC_EQOS_CNTW+2+1 




`define  DIV20TO35    6'd07
`define  DIV35TO60    6'd12
`define  DIV60TO100   6'd20
`define  DIV100TO150  6'd30
`define  DIV150TO250  6'd50
`define  DIV250TO300  6'd61

`define  DIVBY4    6'd01
`define  DIVBY6    6'd02
`define  DIVBY8    6'd03
`define  DIVBY10   6'd04
`define  DIVBY12   6'd05
`define  DIVBY14   6'd06
`define  DIVBY16   6'd07
`define  DIVBY18   6'd08

`define DWC_EQOS_RX_MMC_FIFO_WIDTH 65

`define DWC_EQOS_MMC_TXADDR_RNG_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXOCTGB_CNT_WIDTH 32
`define DWC_EQOS_MMC_TXPKTGB_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXBCASTG_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXMCASTG_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXUCASTGB_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXMCASTGB_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXBCASTGB_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXUNDRFLW_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXSNGLCOLG_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXMULTCOLG_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXDEFRD_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXLATECOL_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXEXSCOL_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXCARR_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXOCTG_CNT_WIDTH 32
`define DWC_EQOS_MMC_TXPKTG_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXEXSDEF_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXPAUSE_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXVLAN_CNT_WIDTH 16
`define DWC_EQOS_MMC_TXOVERSZG_CNT_WIDTH 16

`define DWC_EQOS_MMC_RXPKTGB_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXOCTGB_CNT_WIDTH 32
`define DWC_EQOS_MMC_RXOCTG_CNT_WIDTH 32
`define DWC_EQOS_MMC_RXBCASTG_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXMCASTG_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXCRCERR_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXALGNERR_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXRUNTERR_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXJABERR_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXUNDERSZG_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXOVERSZG_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXADDR_RNG_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXUCASTG_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXLENERR_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXOUTOFRNG_TYP_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXPAUSEPKT_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXFIFOOVFL_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXVLANPKTGB_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXWDGERR_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXRCVERR_CNT_WIDTH 16
`define DWC_EQOS_MMC_RXCTRLPKT_CNT_WIDTH 16

`define DWC_EQOS_MMC_RX_IPV4_GD_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV4_HDRERR_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV4_NOPAY_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV4_FRAG_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV4_UDSBL_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV6_GD_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV6_HDRERR_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV6_NOPAY_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_UDP_GD_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_UDP_ERR_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_TCP_GD_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_TCP_ERR_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_ICMP_GD_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_ICMP_ERR_PKTS_CNT_WIDTH 16
`define DWC_EQOS_MMC_RX_IPV4_GD_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_IPV4_HDRERR_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_IPV4_NOPAY_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_IPV4_FRAG_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_IPV4_UDSBL_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_IPV6_GD_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_IPV6_HDRERR_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_IPV6_NOPAY_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_UDP_GD_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_UDP_ERR_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_TCP_GD_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_TCP_ERR_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_ICMP_GD_OCTET_CNT_WIDTH 32
`define DWC_EQOS_MMC_RX_ICMP_ERR_OCTET_CNT_WIDTH 32

`define DWC_EQOS_MMC_PRSET_FCNT_VAL 31'h7FFF_FFF0
`define DWC_EQOS_MMC_PRSET_OCNT_VAL 31'h7FFF_F800

`define DWC_EQOS_TXFCR0W 21
`define DWC_EQOS_TXFCR1T7W 21
// Number of bits in the TX flow control register, excluding bit 0 (FCB)
`define DWC_EQOS_TXFCRW 22

`define DWC_EQOS_NANOSEC_CARRY_CONST     30'h3B9A_CA00
`define DWC_EQOS_NANOSEC_CARRY_CONST_2X  31'h7735_9400

`define DWC_EQOS_UNSEL_TX_L { (`DWC_EQOS_NUM_DMA_CSR_CH-`DWC_EQOS_NUM_DMA_TX_CH) { `DWC_EQOS_L } }

`define DWC_EQOS_UNSEL_RX_L { (`DWC_EQOS_NUM_DMA_CSR_CH-`DWC_EQOS_NUM_DMA_RX_CH)  { `DWC_EQOS_L } }

`define DWC_EQOS_PPSOW `DWC_EQOS_PPS_OUT_NUM

`define DWC_EQOS_AHM_STW 8

`define DWC_EQOS_FRXSW 8

`define DWC_EQOS_RFCRW 3

`define DWC_EQOS_PTW 128

`define DWC_EQOS_TXFCBW `DWC_EQOS_NUM_RXQ

`define DWC_EQOS_PMTCSRW 3

`define DWC_EQOS_CSR_CR_REG2_WD 15

`define DWC_EQOS_CSR_CR_REG1_WD 17

  `define DWC_EQOS_MDC_SYNC_CHCTRL_BYTE0_W 5

   `define DWC_EQOS_CR_REG2_BYTE2_C2R_WDW 3

`define DWC_EQOS_RXQCR1W 9

`define DWC_EQOS_AXI_AWLOCK_VAL 2'b00
`define DWC_EQOS_AXI_AWCACHE_VAL 4'h0
`define DWC_EQOS_AXI_AWPROT_VAL 3'b010
`define DWC_EQOS_AXI_ARLOCK_VAL 2'b00
`define DWC_EQOS_AXI_ARCACHE_VAL 4'h0
`define DWC_EQOS_AXI_ARPROT_VAL 3'b010

`define DWC_EQOS_EXT_OVLPW 5
`define DWC_EQOS_BYTOFFW 4

