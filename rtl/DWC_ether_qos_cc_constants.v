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
// $Id: //dwh/ethernet_iip/dev/ETHER_QOS_4_00A/src/DWC_ether_qos_cc_constants.v#109 $
// Release version :  4.00a
// Date             :        $Date: 2013/10/16 $
// File Version     :        $Revision: #109 $
//
//------------------------------------------------------------------------
// DWC_ether_qos_cc_constants : CoreTools Parameters defined here


// Name:         DW_MODEL_MISSAMPLES
// Default:      0
// Values:       0, 1
// 
// Random delay insertion for Double synchronizers in simulation
// `define DW_MODEL_MISSAMPLES


// Name:         DWC_EQOS_USE_DPRAM_MODEL
// Default:      VERILOG
// Values:       VERILOG (0), CYPRESS (1), ARTISAN (2), VIRAGE (3), FLOWTRHU (4)
// 
// Parameter for internal regressions.
`define DWC_EQOS_USE_DPRAM_MODEL 0


// Name:         USE_DWMM
// Default:      0 (DWC_EQOS_USE_DPRAM_MODEL != 0)
// Values:       0, 1
// 
// Parameter for internal regressions.
// `define USE_DWMM


// Name:         DWC_EQOS_CODECOV
// Default:      0
// Values:       0, 1
// 
// Parameter for internal regressions.
// `define DWC_EQOS_CODECOV


// Name:         RCE_SIM
// Default:      0
// Values:       0, 1
// 
// Parameter for internal regressions.
// `define RCE_SIM


// Name:         USE_FOUNDATION
// Default:      0
// Values:       0, 1
// 
// Designware Foundation Library used in Gray-code converter
// `define USE_FOUNDATION


// Name:         DWC_EQOS_FAST_SIM
// Default:      0
// Values:       0, 1
// 
// Use of values for faster simulation of large timers
// `define DWC_EQOS_FAST_SIM


// Name:         DWC_EQOS_SYS
// Default:      EQOS-AHB
// Values:       EQOS-CORE (0), EQOS-MTL (1), EQOS-DMA (2), EQOS-AHB (3), EQOS-AXI 
//               (4)
// 
// Specifies the top-level Application Interface and configuration.
`define DWC_EQOS_SYS 4


// Name:         DWC_EQOS_CSR_PORT
// Default:      AXI Interface ((DWC_EQOS_SYS==3) ? 2 : (DWC_EQOS_SYS==4) ? 3 : 0)
// Values:       MCI Interface (0), APB Interface (1), AHB Interface (2), AXI 
//               Interface (3), APB3 Interface (4)
// 
// Provides Slave port for CSR access (MCI/APB/APB3 for ETHER_QOS-CORE/ETHER-QOS-MTL/ETHER_QOS-DMA configurations, 
// APB/AHB/APB3 for ETHER_QOS-SYS-AHB configurations and APB/AHB/AXI/APB3 for ETHER_QOS-AXI configurations).
`define DWC_EQOS_CSR_PORT 4


// Name:         DWC_EQOS_AHB_SLAVE
// Default:      0 (DWC_EQOS_CSR_PORT==2)
// Values:       0, 1
// 
// Provides AHB port for CSR access.
// `define DWC_EQOS_AHB_SLAVE


// Name:         DWC_EQOS_CSR_SLV_CLK
// Default:      0 (DWC_EQOS_SYS==4&&DWC_EQOS_AHB_SLAVE)
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS!=0&&!(DWC_EQOS_SYS==4&&DWC_EQOS_AHB_SLAVE)
// 
// Uses a separate clock port instead of the default application clock for the CSR interface.
`define DWC_EQOS_CSR_SLV_CLK


// Name:         DWC_EQOS_APB_SLAVE
// Default:      0 (DWC_EQOS_CSR_PORT==1)
// Values:       0, 1
// 
// Provides APB port for CSR access.
// `define DWC_EQOS_APB_SLAVE


// Name:         DWC_EQOS_AXI_SLAVE
// Default:      0 (DWC_EQOS_CSR_PORT==3)
// Values:       0, 1
// 
// Provides AXI port for CSR access.
// `define DWC_EQOS_AXI_SLAVE


// Name:         DWC_EQOS_APB3_SLAVE
// Default:      1 (DWC_EQOS_CSR_PORT==4)
// Values:       0, 1
// 
// Provides APB3 port for CSR access.
`define DWC_EQOS_APB3_SLAVE


// Name:         DWC_EQOS_MCI_SLAVE
// Default:      0 (DWC_EQOS_CSR_PORT==0)
// Values:       0, 1
// 
// Provides MCI port for CSR access.
// `define DWC_EQOS_MCI_SLAVE

// DATA WIDTH PARAMETERS


// Name:         DWC_EQOS_DATAWIDTH
// Default:      32
// Values:       32 64 128
// 
// Configures the width of the data bus on the Application interface.
`define DWC_EQOS_DATAWIDTH 128


// Name:         DWC_EQOS_BEW
// Default:      4 ((DWC_EQOS_DATAWIDTH==32) ? 2 : (DWC_EQOS_DATAWIDTH==64) ? 3 : 
//               (DWC_EQOS_DATAWIDTH==128) ? 4 : 5)
// Values:       -2147483648, ..., 2147483647
// 
// Configures the Byte Enables Width
`define DWC_EQOS_BEW 4


// Name:         DWC_EQOS_MEMW
// Default:      133 ((DWC_EQOS_DATAWIDTH==32) ? 35 : (DWC_EQOS_DATAWIDTH==64) ? 68 
//               : (DWC_EQOS_DATAWIDTH==128) ? 133 : 262)
// Values:       -2147483648, ..., 2147483647
// 
// Configures the Byte Enables Width
`define DWC_EQOS_MEMW 133


// Name:         DWC_EQOS_ENDIAN_NESS
// Default:      LITTLE_ENDIAN
// Values:       LITTLE_ENDIAN (0), BIG_ENDIAN (1), BOTH_OPTIONS (2)
// 
// Configures the DWC_eqos to operate in either little-endian or big-endian mode, or to have an input pin 
// (sbd_data_endianess_i) to configure both modes.
`define DWC_EQOS_ENDIAN_NESS 0


// Name:         DWC_EQOS_CORE
// Default:      0 (DWC_EQOS_SYS == 0)
// Values:       0, 1
// 
// Selects the CORE without the AHB subsystem.
// `define DWC_EQOS_CORE


// Name:         DWC_EQOS_MTL_SUBSYS
// Default:      0 (DWC_EQOS_SYS == 1)
// Values:       0, 1
// 
// Selects the CORE with MTL only subsystem.
// `define DWC_EQOS_MTL_SUBSYS


// Name:         DWC_EQOS_AHB_SUBSYS
// Default:      0 (DWC_EQOS_SYS==3)
// Values:       0, 1
// 
// Selects the CORE with the AHB subsystem.
// `define DWC_EQOS_AHB_SUBSYS


// Name:         DWC_EQOS_DMA_SUBSYS
// Default:      0 (DWC_EQOS_SYS == 2)
// Values:       0, 1
// 
// Selects the CORE without the AHB/AXI but DMA subsystem.
// `define DWC_EQOS_DMA_SUBSYS


// Name:         DWC_EQOS_AXI_SUBSYS
// Default:      1 (DWC_EQOS_SYS == 4)
// Values:       0, 1
// 
// Selects the CORE with the AXI subsystem.
`define DWC_EQOS_AXI_SUBSYS


// Name:         DWC_EQOS_AXI4_SUBSYS
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS == 4
// 
// Selects the CORE with the AXI4 subsystem.
// `define DWC_EQOS_AXI4_SUBSYS


// Name:         DWC_EQOS_DATA_ENDIAN_NESS_BOTH
// Default:      0 (DWC_EQOS_ENDIAN_NESS == 2)
// Values:       0, 1
// 
// Indicates whether additional input to select data endianness is present.
// `define DWC_EQOS_DATA_ENDIAN_NESS_BOTH


// Name:         DWC_EQOS_DATA_ENDIAN_NESS_HI
// Default:      0 (DWC_EQOS_ENDIAN_NESS == 1)
// Values:       0, 1
// 
// Indicates whether data endianness is Big.
// `define DWC_EQOS_DATA_ENDIAN_NESS_HI


// Name:         DWC_EQOS_ENDIAN_LO
// Default:      1 (DWC_EQOS_ENDIAN_NESS == 0||(DWC_EQOS_AHB_SUBSYS == 
//               1||DWC_EQOS_DMA_SUBSYS == 1||DWC_EQOS_AXI_SUBSYS == 1))
// Values:       0, 1
// 
// Enables the little-endian mode.
`define DWC_EQOS_ENDIAN_LO


// Name:         DWC_EQOS_ENDIAN_HI
// Default:      0 (DWC_EQOS_ENDIAN_NESS == 1&&(DWC_EQOS_AHB_SUBSYS != 
//               1&&DWC_EQOS_DMA_SUBSYS != 1&&DWC_EQOS_AXI_SUBSYS != 1))
// Values:       0, 1
// 
// Enables the big-endian mode.
// `define DWC_EQOS_ENDIAN_HI


// Name:         DWC_EQOS_AXI_ENDIAN_HI
// Default:      0 (DWC_EQOS_ENDIAN_NESS == 1&&DWC_EQOS_AXI_SUBSYS == 1)
// Values:       0, 1
// 
// Enables the big-endian mode when AXI interface is selected.
// `define DWC_EQOS_AXI_ENDIAN_HI


// Name:         DWC_EQOS_AXI_ENDIAN_LO
// Default:      1 (DWC_EQOS_ENDIAN_NESS == 0&&DWC_EQOS_AXI_SUBSYS == 1)
// Values:       0, 1
// 
// Enables the little-endian mode when AXI interface is selected.
`define DWC_EQOS_AXI_ENDIAN_LO


// Name:         DWC_EQOS_AHB_ENDIAN_HI
// Default:      0 (DWC_EQOS_ENDIAN_NESS == 1&&DWC_EQOS_AHB_SUBSYS == 1)
// Values:       0, 1
// 
// Enables the big-endian mode when AHB interface is selected.
// `define DWC_EQOS_AHB_ENDIAN_HI


// Name:         DWC_EQOS_AHB_ENDIAN_LO
// Default:      0 (DWC_EQOS_ENDIAN_NESS == 0&&DWC_EQOS_AHB_SUBSYS == 1)
// Values:       0, 1
// 
// Enables the little-endian mode when AHB interface is selected.
// `define DWC_EQOS_AHB_ENDIAN_LO


// Name:         DWC_EQOS_MDC_ENDIAN_HI
// Default:      0 (DWC_EQOS_ENDIAN_NESS == 1&&DWC_EQOS_DMA_SUBSYS == 1)
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Enables the big-endian mode.
// `define DWC_EQOS_MDC_ENDIAN_HI


// Name:         DWC_EQOS_MDC_ENDIAN_LO
// Default:      1 
//               ((DWC_EQOS_ENDIAN_NESS==0&&DWC_EQOS_DMA_SUBSYS==1)||DWC_EQOS_AHB_SUBSYS == 1||DWC_EQOS_AXI_SUBSYS == 1)
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Enables the little-endian mode.
`define DWC_EQOS_MDC_ENDIAN_LO


// Name:         DWC_EQOS_DESC_ENDIAN_NESS
// Default:      SAME_ENDIANNESS (DWC_EQOS_ENDIAN_NESS)
// Values:       SAME_ENDIANNESS (0), REVERSE_ENDIANNESS (1), BOTH_OPTIONS (2)
// Enabled:      DWC_EQOS_SYS!=0&&DWC_EQOS_SYS!=1
// 
// Configures the format (endianness) of the DMA Descriptors with respect to the data bus endianness.
`define DWC_EQOS_DESC_ENDIAN_NESS 0


// Name:         DWC_EQOS_DESC_ENDIAN_NESS_REV
// Default:      0 ((DWC_EQOS_ENDIAN_NESS) == 1)
// Values:       0, 1
// 
// Indicates whether descriptor endianess is reverse.
// `define DWC_EQOS_DESC_ENDIAN_NESS_REV


// Name:         DWC_EQOS_SVA
// Default:      0
// Values:       0, 1
// 
// Enables assertions for Core Simulation.
// `define DWC_EQOS_SVA


// Name:         DWC_EQOS_MDC_SVA
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Enables sssertions for Subsys (MDC) Simulation.
// `define DWC_EQOS_MDC_SVA


// Name:         DWC_EQOS_AXI_SVA
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==4
// 
// Enables assertions for Subsys (AXI) Simulation.
// `define DWC_EQOS_AXI_SVA


// Name:         DWC_EQOS_MTL_SVA
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==1||DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Enables Assertions for Subsys (MTL) Simulation.
// `define DWC_EQOS_MTL_SVA


// Name:         DWC_EQOS_OP_MODE
// Default:      10/100/1000 Mbps
// Values:       10/100/1000 Mbps (0), 10/100 Mbps (1), 1000 Mbps (2)
// Enabled:      Always
// 
// Configures the DWC_eqos to work in the 10/100/1000-Mbps mode. Select 10/100/1000 Mbps for enabling both Fast Ethernet 
// and Gigabit operations. Select 10/100 Mbps for Fast Ethernet-only operations. Select 1000 Mbps for Gigabit-only operations.
`define DWC_EQOS_OP_MODE 0


// Name:         DWC_EQOS_DATAWIDTH_32
// Default:      0 (DWC_EQOS_DATAWIDTH == 32)
// Values:       0, 1
// 
// Enables the 32-bit data width for the Application Interface.
// `define DWC_EQOS_DATAWIDTH_32


// Name:         DWC_EQOS_DATAWIDTH_64
// Default:      0 (DWC_EQOS_DATAWIDTH == 64)
// Values:       0, 1
// 
// Enables the 64-bit data width for the Application Interface.
// `define DWC_EQOS_DATAWIDTH_64


// Name:         DWC_EQOS_DATAWIDTH_128
// Default:      1 (DWC_EQOS_DATAWIDTH == 128)
// Values:       0, 1
// 
// Enables the 128-bit data width for the Application Interface.
`define DWC_EQOS_DATAWIDTH_128


// Name:         DWC_EQOS_DATAWIDTH_256
// Default:      0 (DWC_EQOS_DATAWIDTH == 256)
// Values:       0, 1
// 
// Enables the 256-bit data width for the Application Interface.
// `define DWC_EQOS_DATAWIDTH_256


// Name:         DWC_EQOS_TSO_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// Enables TCP Segmentation on the transmit side
// `define DWC_EQOS_TSO_EN


// Name:         DWC_EQOS_SPLIT_HDR_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Enables Split Header Descriptor structure
// `define DWC_EQOS_SPLIT_HDR_EN


// Name:         DWC_EQOS_DCB_EN
// Default:      0
// Values:       0, 1
// 
// Enables Data Center Bridging Feature.
`define DWC_EQOS_DCB_EN


// Name:         DWC_EQOS_AV_ENABLE
// Default:      0
// Values:       0, 1
// 
// Adds logic for supporting the Audio Video functionality and provides the option to select additional channels for 
// queueing the time-sensitive traffic.
`define DWC_EQOS_AV_ENABLE


// Name:         DWC_EQOS_NUM_TXQ
// Default:      2 (DWC_EQOS_AV_ENABLE ? 2 : 1)
// Values:       1 2 3 4 5 6 7 8
// Enabled:      Always
// 
// Selects the number of transmit queues
`define DWC_EQOS_NUM_TXQ 2


// Name:         DWC_EQOS_NUM_DMA_TX_CH
// Default:      2 ( (DWC_EQOS_SYS>1) ? DWC_EQOS_NUM_TXQ : 1)
// Values:       1 2 3 4 5 6 7 8
// Enabled:      DWC_EQOS_SYS>1
// 
// Selects the number of DMA Channels on the transmit side.
`define DWC_EQOS_NUM_DMA_TX_CH 2


// Name:         DWC_EQOS_NUM_DMA_TX_CHW
// Default:      1 (DWC_EQOS_NUM_DMA_TX_CH<=2 ? 1 : DWC_EQOS_NUM_DMA_TX_CH <=4 ? 2 : 
//               3)
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Selects DMA Channel width on the transmit side.
`define DWC_EQOS_NUM_DMA_TX_CHW 1


// Name:         DWC_EQOS_TXQW
// Default:      1 ((DWC_EQOS_NUM_TXQ<=2) ? 1 : (DWC_EQOS_NUM_TXQ<=4) ? 2 : 3)
// Values:       -2147483648, ..., 2147483647
// 
// Tx Queue Width
`define DWC_EQOS_TXQW 1


// Name:         DWC_EQOS_TX_Q0_AV_EN
// Default:      1 (DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>1)
// Values:       0, 1
// Enabled:      0
// 
// Enables AV Support in Tx Queue 0
`define DWC_EQOS_TX_Q0_AV_EN


// Name:         DWC_EQOS_TX_Q1_EN
// Default:      1 (DWC_EQOS_NUM_TXQ!=1)
// Values:       0, 1
// 
// Enables Tx Queue 1
`define DWC_EQOS_TX_Q1_EN


// Name:         DWC_EQOS_TX_Q1_AV_EN
// Default:      1 (DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ==2)
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>2
// 
// Enables AV Support in Tx Queue 1
`define DWC_EQOS_TX_Q1_AV_EN


// Name:         DWC_EQOS_TX_Q2_EN
// Default:      0 
//               (DWC_EQOS_NUM_TXQ==3||DWC_EQOS_NUM_TXQ==4||DWC_EQOS_NUM_TXQ==5||DWC_EQOS_NUM_TXQ==6||DWC_EQOS_NUM_TXQ==7||DWC_EQOS_NUM_TXQ==8)
// Values:       0, 1
// 
// Enables Tx Queue 2
// `define DWC_EQOS_TX_Q2_EN


// Name:         DWC_EQOS_TX_Q2_AV_EN
// Default:      0 
//               (DWC_EQOS_AV_ENABLE&&((DWC_EQOS_NUM_TXQ>2&&(DWC_EQOS_TX_Q1_AV_EN))||DWC_EQOS_NUM_TXQ==3))
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>3&&!DWC_EQOS_TX_Q1_AV_EN
// 
// Enables AV Support in Tx Queue 2
// `define DWC_EQOS_TX_Q2_AV_EN


// Name:         DWC_EQOS_TX_Q3_EN
// Default:      0 
//               (DWC_EQOS_NUM_TXQ==4||DWC_EQOS_NUM_TXQ==5||DWC_EQOS_NUM_TXQ==6||DWC_EQOS_NUM_TXQ==7||DWC_EQOS_NUM_TXQ==8)
// Values:       0, 1
// 
// Enables Tx Queue 3
// `define DWC_EQOS_TX_Q3_EN


// Name:         DWC_EQOS_TX_Q3_AV_EN
// Default:      0 
//               (DWC_EQOS_AV_ENABLE&&((DWC_EQOS_NUM_TXQ>3&&(DWC_EQOS_TX_Q2_AV_EN))||DWC_EQOS_NUM_TXQ==4))
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>4&&!DWC_EQOS_TX_Q2_AV_EN
// 
// Enables AV Support in Tx Queue 3
// `define DWC_EQOS_TX_Q3_AV_EN


// Name:         DWC_EQOS_TX_Q4_EN
// Default:      0 
//               (DWC_EQOS_NUM_TXQ==5||DWC_EQOS_NUM_TXQ==6||DWC_EQOS_NUM_TXQ==7||DWC_EQOS_NUM_TXQ==8)
// Values:       0, 1
// 
// Enables Tx Queue 4
// `define DWC_EQOS_TX_Q4_EN


// Name:         DWC_EQOS_TX_Q4_AV_EN
// Default:      0 
//               (DWC_EQOS_AV_ENABLE&&((DWC_EQOS_NUM_TXQ>4&&(DWC_EQOS_TX_Q3_AV_EN))||DWC_EQOS_NUM_TXQ==5))
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>5&&!DWC_EQOS_TX_Q3_AV_EN
// 
// Enables AV Support in Tx Queue 4
// `define DWC_EQOS_TX_Q4_AV_EN


// Name:         DWC_EQOS_TX_Q5_EN
// Default:      0 (DWC_EQOS_NUM_TXQ==6||DWC_EQOS_NUM_TXQ==7||DWC_EQOS_NUM_TXQ==8)
// Values:       0, 1
// 
// Enables Tx Queue 5
// `define DWC_EQOS_TX_Q5_EN


// Name:         DWC_EQOS_TX_Q5_AV_EN
// Default:      0 
//               (DWC_EQOS_AV_ENABLE&&((DWC_EQOS_NUM_TXQ>5&&(DWC_EQOS_TX_Q4_AV_EN))||DWC_EQOS_NUM_TXQ==6))
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>6&&!DWC_EQOS_TX_Q4_AV_EN
// 
// Enables AV Support in Tx Queue 5
// `define DWC_EQOS_TX_Q5_AV_EN


// Name:         DWC_EQOS_TX_Q6_EN
// Default:      0 (DWC_EQOS_NUM_TXQ==7||DWC_EQOS_NUM_TXQ==8)
// Values:       0, 1
// 
// Enables Tx Queue 6
// `define DWC_EQOS_TX_Q6_EN


// Name:         DWC_EQOS_TX_Q6_AV_EN
// Default:      0 
//               (DWC_EQOS_AV_ENABLE&&((DWC_EQOS_NUM_TXQ>6&&(DWC_EQOS_TX_Q5_AV_EN))||DWC_EQOS_NUM_TXQ==7))
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>7&&!DWC_EQOS_TX_Q5_AV_EN
// 
// Enables AV Support in Tx Queue 6
// `define DWC_EQOS_TX_Q6_AV_EN


// Name:         DWC_EQOS_TX_Q7_EN
// Default:      0 (DWC_EQOS_NUM_TXQ==8)
// Values:       0, 1
// 
// Enables Tx Queue 7
// `define DWC_EQOS_TX_Q7_EN


// Name:         DWC_EQOS_TX_Q7_AV_EN
// Default:      0 
//               (DWC_EQOS_AV_ENABLE&&((DWC_EQOS_NUM_TXQ>7&&(DWC_EQOS_TX_Q6_AV_EN))||DWC_EQOS_NUM_TXQ==8))
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>8&&!DWC_EQOS_TX_Q6_AV_EN
// 
// Enables AV Support in Tx Queue 7
// `define DWC_EQOS_TX_Q7_AV_EN


// Name:         DWC_EQOS_TX_AV_STRTQ
// Default:      1 (DWC_EQOS_TX_Q1_AV_EN==1 ? 1 : DWC_EQOS_TX_Q2_AV_EN==1 ? 2 : 
//               DWC_EQOS_TX_Q3_AV_EN==1 ? 3 : DWC_EQOS_TX_Q4_AV_EN==1 ? 4 : 
//               DWC_EQOS_TX_Q5_AV_EN==1 ? 5 : DWC_EQOS_TX_Q6_AV_EN==1 ? 6 : 
//               DWC_EQOS_TX_Q7_AV_EN==1 ? 7 : 0)
// Values:       -2147483648, ..., 2147483647
// 
// AV Tx Queue Start Number
`define DWC_EQOS_TX_AV_STRTQ 1


// Name:         DWC_EQOS_NUM_DMA_RX_CH
// Default:      1
// Values:       1 2 3 4 5 6 7 8
// Enabled:      DWC_EQOS_SYS>1
// 
// Selects the number of DMA Channels on the receive side.
`define DWC_EQOS_NUM_DMA_RX_CH 1


// Name:         DWC_EQOS_NUM_DMA_RX_CHW
// Default:      1 (DWC_EQOS_NUM_DMA_RX_CH<=2 ? 1 : DWC_EQOS_NUM_DMA_RX_CH <=4 ? 2 : 
//               3)
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Selects DMA Channel width on the transmit side.
`define DWC_EQOS_NUM_DMA_RX_CHW 1


// Name:         DWC_EQOS_NUM_DMA_RX_4_MNS_CHW
// Default:      3 ([<functionof> (4-DWC_EQOS_NUM_DMA_RX_CHW)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Memory Map Parameter
`define DWC_EQOS_NUM_DMA_RX_4_MNS_CHW 3


// Name:         DWC_EQOS_NUM_DMA_RX_CHW_PLS8
// Default:      9 ([<functionof> (8+DWC_EQOS_NUM_DMA_RX_CHW)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Memory Map Parameter
`define DWC_EQOS_NUM_DMA_RX_CHW_PLS8 9


// Name:         DWC_EQOS_NUM_DMA_RX_CHW_PLS16
// Default:      17 ([<functionof> (16+DWC_EQOS_NUM_DMA_RX_CHW)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Memory Map Parameter
`define DWC_EQOS_NUM_DMA_RX_CHW_PLS16 17


// Name:         DWC_EQOS_NUM_DMA_RX_CHW_PLS24
// Default:      25 ([<functionof> (24+DWC_EQOS_NUM_DMA_RX_CHW)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Memory Map Parameter
`define DWC_EQOS_NUM_DMA_RX_CHW_PLS24 25


// Name:         DWC_EQOS_NUM_DMA_RX_8_MNS_CHW
// Default:      3 ([<functionof> (4-DWC_EQOS_NUM_DMA_RX_CHW)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Memory Map Parameter
`define DWC_EQOS_NUM_DMA_RX_8_MNS_CHW 3


// Name:         DWC_EQOS_SIZE_BASE_SIZE
// Default:      9 ([<functionof> 11-(DWC_EQOS_DATAWIDTH/64)])
// Values:       5, ..., 11
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// Base size for MDC block.
`define DWC_EQOS_SIZE_BASE_SIZE 9


// Name:         DWC_EQOS_NEEDED_BEATS_SIZE
// Default:      12 ([<functionof> 14-(DWC_EQOS_DATAWIDTH/64)])
// Values:       8, ..., 14
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// Required Beats Size for MDC block.
`define DWC_EQOS_NEEDED_BEATS_SIZE 12


// Name:         DWC_EQOS_REG_DMA_INTF
// Default:      0 (DWC_EQOS_SYS==2)
// Values:       0, 1
// 
// Uses registered interface signals from DMA towards AHB.
// `define DWC_EQOS_REG_DMA_INTF


// Name:         DWC_EQOS_AV_SLOT_EN
// Default:      1 (DWC_EQOS_AV_ENABLE&&DWC_EQOS_NUM_TXQ>1&&DWC_EQOS_SYS>1)
// Values:       0, 1
// 
// Enables the DMA data fetching based on the slot interval.
`define DWC_EQOS_AV_SLOT_EN


// Name:         DWC_EQOS_NUM_RXQ
// Default:      2 (DWC_EQOS_DCB_EN ? 2 : 1)
// Values:       1 2 3 4 5 6 7 8
// Enabled:      Always
// 
// Selects the number of receive queues
`define DWC_EQOS_NUM_RXQ 2


// Name:         DWC_EQOS_RXQW
// Default:      1 ((DWC_EQOS_NUM_RXQ<=2) ? 1 : (DWC_EQOS_NUM_RXQ<=4) ? 2 : 3)
// Values:       -2147483648, ..., 2147483647
// 
// RXQ Queue Width
`define DWC_EQOS_RXQW 1


// Name:         DWC_EQOS_RX_Q1_EN
// Default:      1 (DWC_EQOS_NUM_RXQ!=1)
// Values:       0, 1
// 
// Enables Rx Queue 1
`define DWC_EQOS_RX_Q1_EN


// Name:         DWC_EQOS_RX_Q2_EN
// Default:      0 
//               (DWC_EQOS_NUM_RXQ==3||DWC_EQOS_NUM_RXQ==4||DWC_EQOS_NUM_RXQ==5||DWC_EQOS_NUM_RXQ==6||DWC_EQOS_NUM_RXQ==7||DWC_EQOS_NUM_RXQ==8)
// Values:       0, 1
// 
// Enables Rx Queue 2
// `define DWC_EQOS_RX_Q2_EN


// Name:         DWC_EQOS_RX_Q3_EN
// Default:      0 
//               (DWC_EQOS_NUM_RXQ==4||DWC_EQOS_NUM_RXQ==5||DWC_EQOS_NUM_RXQ==6||DWC_EQOS_NUM_RXQ==7||DWC_EQOS_NUM_RXQ==8)
// Values:       0, 1
// 
// Enables Rx Queue 3
// `define DWC_EQOS_RX_Q3_EN


// Name:         DWC_EQOS_RX_Q4_EN
// Default:      0 
//               (DWC_EQOS_NUM_RXQ==5||DWC_EQOS_NUM_RXQ==6||DWC_EQOS_NUM_RXQ==7||DWC_EQOS_NUM_RXQ==8)
// Values:       0, 1
// 
// Enables Rx Queue 4
// `define DWC_EQOS_RX_Q4_EN


// Name:         DWC_EQOS_RX_Q5_EN
// Default:      0 (DWC_EQOS_NUM_RXQ==6||DWC_EQOS_NUM_RXQ==7||DWC_EQOS_NUM_RXQ==8)
// Values:       0, 1
// 
// Enables Rx Queue 5
// `define DWC_EQOS_RX_Q5_EN


// Name:         DWC_EQOS_RX_Q6_EN
// Default:      0 (DWC_EQOS_NUM_RXQ==7||DWC_EQOS_NUM_RXQ==8)
// Values:       0, 1
// 
// Enables Rx Queue 6
// `define DWC_EQOS_RX_Q6_EN


// Name:         DWC_EQOS_RX_Q7_EN
// Default:      0 (DWC_EQOS_NUM_RXQ==8)
// Values:       0, 1
// 
// Enables Rx Queue 7
// `define DWC_EQOS_RX_Q7_EN


// Name:         DWC_EQOS_TX_CHW
// Default:      1 ([<functionof> (DWC_EQOS_NUM_DMA_TX_CH>4 ? 3 : 
//               (DWC_EQOS_NUM_DMA_TX_CH > 2 ? 2 : 1))])
// Values:       1, ..., 3
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Sets the width of bus to drive the transmit DMA Channel number.
`define DWC_EQOS_TX_CHW 1


// Name:         DWC_EQOS_RX_CHW
// Default:      1 ([<functionof> (DWC_EQOS_NUM_DMA_RX_CH>4 ? 3 : 
//               (DWC_EQOS_NUM_DMA_RX_CH > 2 ? 2 : 1))])
// Values:       1, ..., 3
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Sets the width of bus to drive the receive DMA Channel number.
`define DWC_EQOS_RX_CHW 1


// Name:         DWC_EQOS_RX_QW
// Default:      1 ([<functionof> (DWC_EQOS_NUM_RXQ>4 ? 3 : (DWC_EQOS_NUM_RXQ>2 ? 2 
//               : 1))])
// Values:       1, ..., 3
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Sets the width of bus to drive the receive MTL queue number.
`define DWC_EQOS_RX_QW 1


// Name:         DWC_EQOS_NUM_DMA_CSR_CH
// Default:      2 ([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH ? 
//               DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])
// Values:       1, ..., 8
// Enabled:      DWC_EQOS_NUM_DMA_TX_CH!=1||DWC_EQOS_NUM_DMA_RX_CH!=1
// 
// Sets the number of DMA CSR channel instances that are required.
`define DWC_EQOS_NUM_DMA_CSR_CH 2


// Name:         DWC_EQOS_DMA_CSR_CH0_EN
// Default:      1 (!DWC_EQOS_CORE&&!DWC_EQOS_MTL_SUBSYS)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
`define DWC_EQOS_DMA_CSR_CH0_EN


// Name:         DWC_EQOS_DMA_CSR_CH1_EN
// Default:      1 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])!=1)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
`define DWC_EQOS_DMA_CSR_CH1_EN


// Name:         DWC_EQOS_DMA_CSR_CH2_EN
// Default:      0 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])>2)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
// `define DWC_EQOS_DMA_CSR_CH2_EN


// Name:         DWC_EQOS_DMA_CSR_CH3_EN
// Default:      0 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])>3)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
// `define DWC_EQOS_DMA_CSR_CH3_EN


// Name:         DWC_EQOS_DMA_CSR_CH4_EN
// Default:      0 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])>4)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
// `define DWC_EQOS_DMA_CSR_CH4_EN


// Name:         DWC_EQOS_DMA_CSR_CH5_EN
// Default:      0 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])>5)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
// `define DWC_EQOS_DMA_CSR_CH5_EN


// Name:         DWC_EQOS_DMA_CSR_CH6_EN
// Default:      0 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])>6)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
// `define DWC_EQOS_DMA_CSR_CH6_EN


// Name:         DWC_EQOS_DMA_CSR_CH7_EN
// Default:      0 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])==8)
// Values:       0, 1
// 
// Parameter detects if DMA Channel 1 CSR is Enabled
// `define DWC_EQOS_DMA_CSR_CH7_EN


// Name:         DWC_EQOS_CHW
// Default:      1 ([<functionof> (DWC_EQOS_NUM_DMA_CSR_CH>4 ? 3 : 
//               ((DWC_EQOS_NUM_DMA_CSR_CH> 2) ? 2 : 1))])
// Values:       1, ..., 3
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS==3||DWC_EQOS_SYS==4
// 
// Sets the width of bus to drive DMA Channel number for RX and TX.
`define DWC_EQOS_CHW 1


// Name:         DWC_EQOS_ASYNC_RST
// Default:      Asynchronous
// Values:       Synchronous (0), Asynchronous (1)
// 
// Enables the asynchronous or synchronous reset for all flip-flops.
`define DWC_EQOS_ASYNC_RST 1


// Name:         DWC_EQOS_DESC_ADDR_MSB
// Default:      27 ([<functionof> 29-(DWC_EQOS_DATAWIDTH/64)])
// Values:       25, ..., 29
// Enabled:      DWC_EQOS_SYS==2||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// Descriptor Address MSB for MDC block.
`define DWC_EQOS_DESC_ADDR_MSB 27


// Name:         DWC_EQOS_NUM_DMA_TSO_CH
// Default:      1
// Values:       1 2 3 4 5 6 7 8
// Enabled:      DWC_EQOS_TSO_EN
// 
// Selects the number of Tx DMA Channels Enabled for TSO.
`define DWC_EQOS_NUM_DMA_TSO_CH 1


// Name:         DWC_EQOS_TSO_MEM_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_TSO_EN
// 
// Enables use of a separate Memory for TCP/IP headers used in TCP Segmentation Offloading
// `define DWC_EQOS_TSO_MEM_EN


// Name:         DWC_EQOS_TSO_MEM_SIZE
// Default:      256
// Values:       64 128 256 512 1024
// Enabled:      DWC_EQOS_TSO_MEM_EN
// 
// Specifies the size allocated (in bytes) for each TSO channel.
`define DWC_EQOS_TSO_MEM_SIZE 256


// Name:         DWC_EQOS_NUM_DMA_TSO_CH_POW2
// Default:      1 ([ <functionof> (DWC_EQOS_NUM_DMA_TSO_CH > 8 ? 16 : 
//               DWC_EQOS_NUM_DMA_TSO_CH > 4 ? 8 : DWC_EQOS_NUM_DMA_TSO_CH > 2 ? 4 : 
//               DWC_EQOS_NUM_DMA_TSO_CH > 1 ? 2 : 1 ) ])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_TSO_EN
// 
// Number of Tx DMA Channels Enabled for TSO Rounded to nearest power of 2.
`define DWC_EQOS_NUM_DMA_TSO_CH_POW2 1


// Name:         DWC_EQOS_TSO_MEM_ADDR_WIDTH
// Default:      4 ([<functionof> 
//               ((log(DWC_EQOS_TSO_MEM_SIZE*DWC_EQOS_NUM_DMA_TSO_CH_POW2)/log(2)) - (DWC_EQOS_BEW))])
// Values:       2, ..., 11
// Enabled:      DWC_EQOS_TSO_MEM_EN
// 
// Address width of the Memory for TCP Segmentation on the transmit side
`define DWC_EQOS_TSO_MEM_ADDR_WIDTH 4


// Name:         DWC_EQOS_MDC_INTF_SBD_IO_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==3
// 
// Enables DMA internal Interface Control Signals as SideBand I/O ports.
// `define DWC_EQOS_MDC_INTF_SBD_IO_EN


// Name:         DWC_EQOS_FDUPLX_ONLY
// Default:      0
// Values:       0, 1
// 
// Configures the DWC_eqos to work only in the full-duplex mode.
// `define DWC_EQOS_FDUPLX_ONLY


// Name:         DWC_EQOS_M110_ONLY
// Default:      0 (DWC_EQOS_OP_MODE == 1)
// Values:       0, 1
// 
// Enables the 10/100 Mbps-only mode.
// `define DWC_EQOS_M110_ONLY


// Name:         DWC_EQOS_M1000_ONLY
// Default:      0 (DWC_EQOS_OP_MODE == 2)
// Values:       0, 1
// 
// Enables the 1000 Mbps-only mode.
// `define DWC_EQOS_M1000_ONLY


// Name:         DWC_EQOS_USER_VER
// Default:      0x10
// Values:       0x0, ..., 0xff
// 
// Configurable 8-bit value that is hard-coded into bits[15:8] of the GMAC Version Register (for example, 8'h10 for version 
// 1.0).
`define DWC_EQOS_USER_VER 8'h10


// Name:         DWC_EQOS_RXFIFO_SIZE
// Default:      2048
// Values:       256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 
//               262144
// Enabled:      DWC_EQOS_SYS != 0
// 
// Size (Depth = Size/(Data-bus width in bytes)) in data-bytes (excludes overhead bits) of MTL Receive FIFO
`define DWC_EQOS_RXFIFO_SIZE 2048


// Name:         DWC_EQOS_TXFIFO_SIZE
// Default:      2048
// Values:       256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072
// Enabled:      DWC_EQOS_SYS != 0
// 
// Size (Depth = Size/(Data-bus width in bytes)) in data-bytes (excludes overhead bits) of MTL Transmit FIFO
`define DWC_EQOS_TXFIFO_SIZE 2048


// Name:         DWC_EQOS_MAX_FRAME_IN_TXFIFO
// Default:      2
// Values:       2 4 8
// Enabled:      DWC_EQOS_SYS == 1 && !DWC_EQOS_TX_STS_DROP
// 
// Specifies the maximum number of packets that can be pushed into the Tx FIFO at a time without any transmit status being 
// read out on the ATI interface.
`define DWC_EQOS_MAX_FRAME_IN_TXFIFO 2


// Name:         DWC_EQOS_ASYNC_RAM
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==1||DWC_EQOS_SYS == 2||DWC_EQOS_SYS == 3||DWC_EQOS_SYS 
//               ==4
// 
// Specifies the synchronous or asynchronous DPRAM interface. Default is Synchronous DPRAM interface.
// `define DWC_EQOS_ASYNC_RAM


// Name:         DWC_EQOS_STS_PTR_WIDTH
// Default:      1 ([<functionof> (log(DWC_EQOS_MAX_FRAME_IN_TXFIFO)/log(2))])
// Values:       1, ..., 3
// 
// Specifies the address width of Tx status FIFO.
`define DWC_EQOS_STS_PTR_WIDTH 1


// Name:         DWC_EQOS_MAX_FRAME_IN_TXFIFO_2
// Default:      1 (DWC_EQOS_MAX_FRAME_IN_TXFIFO == 2)
// Values:       0, 1
// 
// Indicates that maximum Number of Frames in Tx FIFO is two.
`define DWC_EQOS_MAX_FRAME_IN_TXFIFO_2


// Name:         DWC_EQOS_RX_FIFO_PTR_WIDTH
// Default:      7 ([<functionof> (log(DWC_EQOS_RXFIFO_SIZE)/log(2)) - 
//               ((DWC_EQOS_DATAWIDTH/64)+2)])
// Values:       3, ..., 16
// Enabled:      DWC_EQOS_SYS!=0
// 
// Specifies the address bus width for selected Receive FIFO depth.
`define DWC_EQOS_RX_FIFO_PTR_WIDTH 7


// Name:         DWC_EQOS_RXFIFOSZ
// Default:      4 (DWC_EQOS_SYS!=0 ? [<functionof> 
//               (log(DWC_EQOS_RXFIFO_SIZE)/log(2)) - 7] : 0)
// Values:       -2147483648, ..., 2147483647
// 
// Specifies the Encoded MTL Rx FIFO Size
`define DWC_EQOS_RXFIFOSZ 4


// Name:         DWC_EQOS_ARI_PBL_WIDTH
// Default:      8 ( (DWC_EQOS_SYS==1) ? (DWC_EQOS_RX_FIFO_PTR_WIDTH-1) : 8)
// Values:       2, ..., 15
// Enabled:      DWC_EQOS_SYS == 1
// 
// Specifies the width of ari_pbl_i signal.
`define DWC_EQOS_ARI_PBL_WIDTH 8


// Name:         DWC_EQOS_FIFO_DATA_WIDTH
// Default:      133 ([<functionof> (DWC_EQOS_DATAWIDTH/64)+3+DWC_EQOS_DATAWIDTH])
// Values:       35, ..., 263
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the data bus width to DPRAM including overhead bits.
`define DWC_EQOS_FIFO_DATA_WIDTH 133


// Name:         DWC_EQOS_TX_FIFO_PTR_WIDTH
// Default:      7 ([<functionof> (log(DWC_EQOS_TXFIFO_SIZE)/log(2)) - 
//               ((DWC_EQOS_DATAWIDTH/64)+2)])
// Values:       4, ..., 15
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the address bus width for selected Transmit FIFO depth.
`define DWC_EQOS_TX_FIFO_PTR_WIDTH 7


// Name:         DWC_EQOS_TXFIFOSZ
// Default:      4 (DWC_EQOS_SYS!=0 ? [<functionof> 
//               (log(DWC_EQOS_TXFIFO_SIZE)/log(2)) - 7] : 0)
// Values:       -2147483648, ..., 2147483647
// 
// Specifies the Encoded MTL Tx FIFO Size
`define DWC_EQOS_TXFIFOSZ 4


// Name:         DWC_EQOS_L256_TXMS
// Default:      3 (DWC_EQOS_TXFIFO_SIZE <= 512 ? 1 : DWC_EQOS_TXFIFO_SIZE <= 1024 ? 
//               2 : DWC_EQOS_TXFIFO_SIZE <= 2048 ? 3 : DWC_EQOS_TXFIFO_SIZE <= 4096 
//               ? 4 : DWC_EQOS_TXFIFO_SIZE <= 8192 ? 5 : DWC_EQOS_TXFIFO_SIZE <= 
//               16384 ? 6 : DWC_EQOS_TXFIFO_SIZE <= 32768 ? 7 : DWC_EQOS_TXFIFO_SIZE <= 
//               65536 ? 8 : DWC_EQOS_TXFIFO_SIZE <= 131072 ? 9 : 10)
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the width TXQ Size Field (Log256 of TX Mem Size)
`define DWC_EQOS_L256_TXMS 3


// Name:         DWC_EQOS_L256_TXMS_MAX
// Default:      0 (DWC_EQOS_NUM_TXQ>1 ? 0 : (DWC_EQOS_TXFIFO_SIZE == 256 ? 0 : 
//               DWC_EQOS_TXFIFO_SIZE <= 512 ? 1 : DWC_EQOS_TXFIFO_SIZE <= 1024 ? 3 : 
//               DWC_EQOS_TXFIFO_SIZE <= 2048 ? 7 : DWC_EQOS_TXFIFO_SIZE <= 4096 ? 15 : 
//               DWC_EQOS_TXFIFO_SIZE <= 8192 ? 31 : DWC_EQOS_TXFIFO_SIZE <= 16384 ? 63 
//               : DWC_EQOS_TXFIFO_SIZE <= 32768 ? 127 : DWC_EQOS_TXFIFO_SIZE <= 65536 
//               ? 255 : DWC_EQOS_TXFIFO_SIZE <= 131072 ? 511 : 1023))
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the Maximum Value of TXQ Size Field
`define DWC_EQOS_L256_TXMS_MAX 0


// Name:         DWC_EQOS_L256_TXMS_OFF
// Default:      19 ([<functionof> (DWC_EQOS_L256_TXMS+16)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the width TXQ Size Field Offset
`define DWC_EQOS_L256_TXMS_OFF 19


// Name:         DWC_EQOS_L256_TXMS_SIZE
// Default:      13 ([<functionof> (8+8-DWC_EQOS_L256_TXMS)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the width TXQ Size Field Offset
`define DWC_EQOS_L256_TXMS_SIZE 13


// Name:         DWC_EQOS_L256_RXMS
// Default:      3 (DWC_EQOS_RXFIFO_SIZE <= 512 ? 1 : DWC_EQOS_RXFIFO_SIZE <= 1024 ? 
//               2 : DWC_EQOS_RXFIFO_SIZE <= 2048 ? 3 : DWC_EQOS_RXFIFO_SIZE <= 4096 
//               ? 4 : DWC_EQOS_RXFIFO_SIZE <= 8192 ? 5 : DWC_EQOS_RXFIFO_SIZE <= 
//               16384 ? 6 : DWC_EQOS_RXFIFO_SIZE <= 32768 ? 7 : DWC_EQOS_RXFIFO_SIZE <= 
//               65536 ? 8 : DWC_EQOS_RXFIFO_SIZE <= 131072 ? 9 : 10)
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the width RXQ Size Field (Log256 of RX Mem Size)
`define DWC_EQOS_L256_RXMS 3


// Name:         DWC_EQOS_L256_RXMS_MAX
// Default:      0 (DWC_EQOS_NUM_RXQ>1 ? 0 : (DWC_EQOS_RXFIFO_SIZE == 256 ? 0 : 
//               DWC_EQOS_RXFIFO_SIZE <= 512 ? 1 : DWC_EQOS_RXFIFO_SIZE <= 1024 ? 3 : 
//               DWC_EQOS_RXFIFO_SIZE <= 2048 ? 7 : DWC_EQOS_RXFIFO_SIZE <= 4096 ? 15 : 
//               DWC_EQOS_RXFIFO_SIZE <= 8192 ? 31 : DWC_EQOS_RXFIFO_SIZE <= 16384 ? 63 
//               : DWC_EQOS_RXFIFO_SIZE <= 32768 ? 127 : DWC_EQOS_RXFIFO_SIZE <= 65536 
//               ? 255 : DWC_EQOS_RXFIFO_SIZE <= 131072 ? 511 : 1023))
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the Maximum Value of RXQ Size Field
`define DWC_EQOS_L256_RXMS_MAX 0


// Name:         DWC_EQOS_L256_RXMS_OFF
// Default:      23 ([<functionof> (DWC_EQOS_L256_RXMS+20)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the width RXQ Size Field Offset
`define DWC_EQOS_L256_RXMS_OFF 23


// Name:         DWC_EQOS_L256_RXMS_SIZE
// Default:      9 ([<functionof> (8+4-DWC_EQOS_L256_RXMS)])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the width RXQ Size Field Offset
`define DWC_EQOS_L256_RXMS_SIZE 9


// Name:         DWC_EQOS_ATI_PBL_WIDTH
// Default:      8 ((DWC_EQOS_SYS==1) ? (DWC_EQOS_TX_FIFO_PTR_WIDTH-1) : 8)
// Values:       3, ..., 14
// Enabled:      DWC_EQOS_SYS == 1
// 
// Specifies the width of ati_pbl_i signal.
`define DWC_EQOS_ATI_PBL_WIDTH 8


// Name:         DWC_EQOS_ADDR_OFFSET_MSB
// Default:      3 ([<functionof> (DWC_EQOS_DATAWIDTH/64)+1])
// Values:       1, ..., 5
// Enabled:      DWC_EQOS_SYS != 0
// 
// Specifies the MSB of ADDR OFFSET.
`define DWC_EQOS_ADDR_OFFSET_MSB 3


// Name:         DWC_EQOS_FAST_FLUSH_ON_ABT
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS == 2||DWC_EQOS_SYS == 
//               3||DWC_EQOS_SYS==1||DWC_EQOS_SYS==4
// 
// Enables Fast flush on abort in the MTL FIFO.
// `define DWC_EQOS_FAST_FLUSH_ON_ABT


// Name:         DWC_EQOS_DBG_FIFO_ACCESS
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS>0
// 
// Enables Debug Memory Access
// `define DWC_EQOS_DBG_FIFO_ACCESS


// Name:         DWC_EQOS_TSO_MEM_DBG_ACCESS
// Default:      0 (DWC_EQOS_TSO_MEM_EN&&DWC_EQOS_DBG_FIFO_ACCESS)
// Values:       0, 1
// Enabled:      DWC_EQOS_TSO_MEM_EN
// 
// Enables TSO Memory Debug access.
// `define DWC_EQOS_TSO_MEM_DBG_ACCESS


// Name:         DWC_EQOS_ADDR_BASE_LSB
// Default:      4 ([<functionof> (DWC_EQOS_DATAWIDTH/64)+2])
// Values:       2, ..., 6
// Enabled:      DWC_EQOS_SYS==0||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// Address Base LSB for MDC block.
`define DWC_EQOS_ADDR_BASE_LSB 4


// Name:         DWC_EQOS_ADDR_BASE_SIZE
// Default:      28 ([<functionof> 30 -(DWC_EQOS_DATAWIDTH/64)])
// Values:       26, ..., 30
// Enabled:      DWC_EQOS_SYS==0||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// Address Base size for MDC block.
`define DWC_EQOS_ADDR_BASE_SIZE 28


// Name:         DWC_EQOS_ADDR_OFFSET_SIZE
// Default:      4 ([<functionof> (DWC_EQOS_DATAWIDTH/64)+2])
// Values:       2, ..., 6
// Enabled:      DWC_EQOS_SYS==0||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// Address Offset size for MDC block.
`define DWC_EQOS_ADDR_OFFSET_SIZE 4


// Name:         DWC_EQOS_RX_BUF_SIZE_MSB
// Default:      6 ([<functionof> 8-(DWC_EQOS_DATAWIDTH/64)])
// Values:       4, ..., 8
// Enabled:      DWC_EQOS_SYS==0||DWC_EQOS_SYS == 3||DWC_EQOS_SYS==4
// 
// RX Buffer Size MSB
`define DWC_EQOS_RX_BUF_SIZE_MSB 6



// Name:         TBU_NO_OF_STATES
// Default:      6 ((DWC_EQOS_DATAWIDTH==32)?3:(DWC_EQOS_DATAWIDTH==64)?4:6)
// Values:       3, ..., 6
// 
// Calculates number of states in the TBU.
`define TBU_NO_OF_STATES 6


// Name:         DWC_EQOS_CSR_DATAWIDTH
// Default:      32 ((DWC_EQOS_CSR_PORT==3) ? DWC_EQOS_DATAWIDTH : 
//               (DWC_EQOS_CSR_PORT!=2) ? 32 : [<functionof> "%item"])
// Values:       32 64 128
// Enabled:      DWC_EQOS_CSR_PORT==2||DWC_EQOS_CSR_PORT==3
// 
// Configures the width of the data bus on the AHB/AXI Slave port.
`define DWC_EQOS_CSR_DATAWIDTH 32


// Name:         DWC_EQOS_CSR_DATAWIDTH_32
// Default:      1 (DWC_EQOS_CSR_DATAWIDTH == 32)
// Values:       0, 1
// 
// Enables 32-bit data width for the CSR system interface.
`define DWC_EQOS_CSR_DATAWIDTH_32


// Name:         DWC_EQOS_CSR_DATAWIDTH_64
// Default:      0 (DWC_EQOS_CSR_DATAWIDTH == 64)
// Values:       0, 1
// 
// Enables 64-bit data width for the CSR system interface.
// `define DWC_EQOS_CSR_DATAWIDTH_64


// Name:         DWC_EQOS_CSR_DATAWIDTH_128
// Default:      0 (DWC_EQOS_CSR_DATAWIDTH == 128)
// Values:       0, 1
// 
// Enables 128-bit data width for the CSR system interface.
// `define DWC_EQOS_CSR_DATAWIDTH_128


// Name:         DWC_EQOS_CSR_DATAWIDTH_256
// Default:      0 (DWC_EQOS_CSR_DATAWIDTH == 256)
// Values:       0, 1
// 
// Enables 256-bit data width for the CSR system interface.
// `define DWC_EQOS_CSR_DATAWIDTH_256

// Enable Mac Addresses 1 to 31


// Name:         DWC_EQOS_ADD_MAC_ADDR_REG
// Default:      0
// Values:       0, ..., 31
// 
// Enables number of MAC Address registers from 1 to 31 for the Address Filter block.
`define DWC_EQOS_ADD_MAC_ADDR_REG 2


// Name:         DWC_EQOS_ADD32_MAC_ADDR_REG
// Default:      0
// Values:       0, 1
// 
// Enables MAC Address registers 32-63 for the Address Filter block.
// `define DWC_EQOS_ADD32_MAC_ADDR_REG


// Name:         DWC_EQOS_ADD64_MAC_ADDR_REG
// Default:      0
// Values:       0, 1
// 
// Enables MAC Address registers 64-127 for the Address Filter block.
// `define DWC_EQOS_ADD64_MAC_ADDR_REG


// Name:         DWC_EQOS_FLTRVALID_DLY
// Default:      0
// Values:       0, 1
// 
// Registers the filter valid signal in Address filter block.
// `define DWC_EQOS_FLTRVALID_DLY



// Name:         DWC_EQOS_RGMII_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Enables Reduced GMI Interface as Line Interface.
`define DWC_EQOS_RGMII_EN


// Name:         DWC_EQOS_RMII_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 1||DWC_EQOS_OP_MODE == 0
// 
// Enables Reduced Media Independent Interface as Line Interface.
`define DWC_EQOS_RMII_EN


// Name:         DWC_EQOS_SMII_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 1||DWC_EQOS_OP_MODE == 0
// 
// Enables Serial Media Independent Interface as Line Interface.
// `define DWC_EQOS_SMII_EN


// Name:         DWC_EQOS_REVMII_EN
// Default:      0
// Values:       0, 1
// 
// Enables Reverse MII Interface as Line Interface.
// `define DWC_EQOS_REVMII_EN


// Name:         DWC_EQOS_SGMII_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Enables SGMI Interface as Line Interface.
`define DWC_EQOS_SGMII_EN


// Name:         DWC_EQOS_TBI_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Enables Ten Bit Interface as Line Interface.
// `define DWC_EQOS_TBI_EN


// Name:         DWC_EQOS_RTBI_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Enables Reduced Ten Bit Interface as Line Interface.
// `define DWC_EQOS_RTBI_EN


// Name:         DWC_EQOS_RGMII_OR_SGMII
// Default:      1 (DWC_EQOS_RGMII_EN||DWC_EQOS_SGMII_EN)
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Indicates that RGMII or SGMII is chosen as Line Interface.
`define DWC_EQOS_RGMII_OR_SGMII


// Name:         DWC_EQOS_RGMII_OR_RTBI
// Default:      1 (DWC_EQOS_RGMII_EN||DWC_EQOS_RTBI_EN)
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Indicates that RGMII or RTBI is chosen as Line Interface.
`define DWC_EQOS_RGMII_OR_RTBI


// Name:         DWC_EQOS_RGMII_SGMII_EN
// Default:      1 (DWC_EQOS_RGMII_EN&&DWC_EQOS_SGMII_EN)
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Indicates that RGMII and SGMII is chosen as Line Interface.
`define DWC_EQOS_RGMII_SGMII_EN


// Name:         DWC_EQOS_PCS_EN
// Default:      1 (DWC_EQOS_TBI_EN||DWC_EQOS_SGMII_EN||DWC_EQOS_RTBI_EN)
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Indicates that PCS with TBI, SGMII, or RTBI is chosen as Line Interface.
`define DWC_EQOS_PCS_EN


// Name:         DWC_EQOS_TBI_SGMII_EN
// Default:      0 (DWC_EQOS_TBI_EN&&DWC_EQOS_SGMII_EN)
// Values:       0, 1
// Enabled:      DWC_EQOS_OP_MODE == 0||DWC_EQOS_OP_MODE == 2
// 
// Indicates that TBI and SGMII is chosen as Line Interface.
// `define DWC_EQOS_TBI_SGMII_EN


// Name:         DWC_EQOS_XLNX_2V
// Default:      0
// Values:       0, 1
// Enabled:      (DWC_EQOS_RGMII_EN||DWC_EQOS_RTBI_EN)&&DWC_EQOS_SINGLE_PHY_INTF
// 
// Uses the dual edge flip-flop from Xilinx Virtex 2V FPGA Library for the RGMII or RTBI only (for synthesis).
// `define DWC_EQOS_XLNX_2V


// Name:         DWC_EQOS_SINGLE_PHY_INTF
// Default:      0 
//               
//               (!DWC_EQOS_SGMII_EN&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN)
// Values:       0, 1
// Enabled:       
//               !DWC_EQOS_SGMII_EN&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN) 
//               ? 0 : 
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               
//               ((DWC_EQOS_SGMII_EN&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN)||(DWC_EQOS_RGMII_EN&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_SGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN)||(DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SGMII_EN&&!DWC_EQOS_SMII_EN&&DWC_EQOS_M110_ONLY&&!DWC_EQOS_REVMII_EN)||(DWC_EQOS_TBI_EN&&DWC_EQOS_M1000_ONLY&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SGMII_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN)||(DWC_EQOS_RTBI_EN&&DWC_EQOS_M1000_ONLY&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_SGMII_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN)||(!DWC_EQOS_RTBI_EN&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_SGMII_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN)||(DWC_EQOS_SMII_EN&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SGMII_EN&&DWC_EQOS_M110_ONLY&&!DWC_EQOS_REVMII_EN)||(DWC_EQOS_REVMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_RTBI_EN&&!DWC_EQOS_SGMII_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_RMII_EN))
// 
// Enables a single PHY interface without any MUX logic at the input or output. When this option is enabled, the 
// phy_intf_sel_i input port is removed.
// `define DWC_EQOS_SINGLE_PHY_INTF


// Name:         DWC_EQOS_SSSMII_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SMII_EN
// 
// Enables the Source Synchronous mode for Serial Media Independent Interface (SSSMII).
// `define DWC_EQOS_SSSMII_EN


// Name:         DWC_EQOS_SSSMII_TXSYNC_IN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SMII_EN&&DWC_EQOS_SSSMII_EN
// 
// Converts the TXSYNC as input signal in the Source Synchronous mode for Serial Media Independent Interface (SSSMII).
// `define DWC_EQOS_SSSMII_TXSYNC_IN


// Name:         DWC_EQOS_RGMII_INTF_ONLY
// Default:      0 (DWC_EQOS_RGMII_EN&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Selects only RGMI Interface without the multiplexer at the output.
// `define DWC_EQOS_RGMII_INTF_ONLY


// Name:         DWC_EQOS_SGMII_INTF_ONLY
// Default:      0 (DWC_EQOS_SGMII_EN&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Selects only SGMI Interface without the multiplexer at the output.
// `define DWC_EQOS_SGMII_INTF_ONLY


// Name:         DWC_EQOS_RMII_INTF_ONLY
// Default:      0 (DWC_EQOS_RMII_EN&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Selects only RMI Interface without the multiplexer at the output.
// `define DWC_EQOS_RMII_INTF_ONLY


// Name:         DWC_EQOS_SMII_INTF_ONLY
// Default:      0 (DWC_EQOS_SMII_EN&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Selects only SMI Interface without the multiplexer at the output.
// `define DWC_EQOS_SMII_INTF_ONLY


// Name:         DWC_EQOS_REVMII_INTF_ONLY
// Default:      0 (DWC_EQOS_REVMII_EN&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Selects only REVMII Interface without the multiplexer at the output.
// `define DWC_EQOS_REVMII_INTF_ONLY


// Name:         DWC_EQOS_TBI_INTF_ONLY
// Default:      0 (DWC_EQOS_TBI_EN&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Selects only TB Interface without the multiplexer at the output.
// `define DWC_EQOS_TBI_INTF_ONLY


// Name:         DWC_EQOS_RTBI_INTF_ONLY
// Default:      0 (DWC_EQOS_RTBI_EN&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Select only RTB Interface without the multiplexer at the output.
// `define DWC_EQOS_RTBI_INTF_ONLY


// Name:         DWC_EQOS_GMII_INTF_ONLY
// Default:      0 
//               
//               ((!DWC_EQOS_RTBI_EN&&!DWC_EQOS_RMII_EN&&!DWC_EQOS_RGMII_EN&&!DWC_EQOS_TBI_EN&&!DWC_EQOS_SGMII_EN&&!DWC_EQOS_SMII_EN&&!DWC_EQOS_REVMII_EN)&&DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// 
// Select only GMI Interface without the multiplexer at the output.
// `define DWC_EQOS_GMII_INTF_ONLY


// Name:         DWC_EQOS_GMII_EN
// Default:      1 (DWC_EQOS_GMII_INTF_ONLY||!DWC_EQOS_SINGLE_PHY_INTF)
// Values:       0, 1
// Enabled:      0
// 
// Enables GMI/MI Interface as Line Interface.
`define DWC_EQOS_GMII_EN


// Name:         DWC_EQOS_SMA_EN
// Default:      1 ((DWC_EQOS_REVMII_EN&&DWC_EQOS_SINGLE_PHY_INTF) == 0)
// Values:       0, 1
// Enabled:      (DWC_EQOS_REVMII_EN&&DWC_EQOS_SINGLE_PHY_INTF) == 0
// 
// Enables the Station Management block (MDIO Master Interface).
`define DWC_EQOS_SMA_EN


// Name:         DWC_EQOS_HASH_EN
// Default:      0
// Values:       0, 1
// 
// Enables the Hash Table registers and related address filter logic.
`define DWC_EQOS_HASH_EN


// Name:         DWC_EQOS_HASH_TABLE
// Default:      64 ((DWC_EQOS_HASH_EN) ? 64 : 0)
// Values:       0 64 128 256
// Enabled:      DWC_EQOS_HASH_EN
// 
// Specifies the size (width) of the Hash Table filter.
`define DWC_EQOS_HASH_TABLE 64


// Name:         DWC_EQOS_HASH_TBL_SIZE_64
// Default:      1 (DWC_EQOS_HASH_TABLE==64)
// Values:       0, 1
// 
// Enables 64-bit size for Hash Filter Table.
`define DWC_EQOS_HASH_TBL_SIZE_64


// Name:         DWC_EQOS_HASH_TBL_SIZE_128
// Default:      0 (DWC_EQOS_HASH_TABLE==128)
// Values:       0, 1
// 
// Enables 128-bit size for Hash Filter Table.
// `define DWC_EQOS_HASH_TBL_SIZE_128


// Name:         DWC_EQOS_HASH_TBL_SIZE_256
// Default:      0 (DWC_EQOS_HASH_TABLE==256)
// Values:       0, 1
// 
// Enables 256-bit size for Hash Filter Table.
// `define DWC_EQOS_HASH_TBL_SIZE_256


// Name:         DWC_EQOS_VLAN_HASH_EN
// Default:      0
// Values:       0, 1
// 
// Enables the VLAN Hash Table register and related filter logic.
`define DWC_EQOS_VLAN_HASH_EN


// Name:         DWC_EQOS_L3_L4_FILTER_EN
// Default:      0
// Values:       0, 1
// Enabled:      Always
// 
// Enables Layer 3 and Layer 4 based frame filtering for receive packets.
`define DWC_EQOS_L3_L4_FILTER_EN


// Name:         DWC_EQOS_L3_L4_FILTER_NUM
// Default:      1 ((DWC_EQOS_L3_L4_FILTER_EN==1) ? 1 : 0)
// Values:       0 1 2 3 4 5 6 7 8
// Enabled:      DWC_EQOS_L3_L4_FILTER_EN==1
// 
// Specifies the number of additional Layer 3 and Layer 4 packet filters.
`define DWC_EQOS_L3_L4_FILTER_NUM 1


// Name:         DWC_EQOS_L3_L4_FILTER_NUM_1
// Default:      0 
//               
//               
//               (DWC_EQOS_L3_L4_FILTER_NUM==2||DWC_EQOS_L3_L4_FILTER_NUM==3||DWC_EQOS_L3_L4_FILTER_NUM==4||DWC_EQOS_L3_L4_FILTER_NUM==5||DWC_EQOS_L3_L4_FILTER_NUM==6||DWC_EQOS_L3_L4_FILTER_NUM==7||DWC_EQOS_L3_L4_FILTER_NUM==8)
// Values:       0, 1
// 
// Enables two Layer 3 and Layer 4 frame filters.
// `define DWC_EQOS_L3_L4_FILTER_NUM_1


// Name:         DWC_EQOS_L3_L4_FILTER_NUM_2
// Default:      0 
//               
//               (DWC_EQOS_L3_L4_FILTER_NUM==3||DWC_EQOS_L3_L4_FILTER_NUM==4||DWC_EQOS_L3_L4_FILTER_NUM==5||DWC_EQOS_L3_L4_FILTER_NUM==6||DWC_EQOS_L3_L4_FILTER_NUM==7||DWC_EQOS_L3_L4_FILTER_NUM==8)
// Values:       0, 1
// 
// Enables three Layer 3 and Layer 4 frame filters.
// `define DWC_EQOS_L3_L4_FILTER_NUM_2


// Name:         DWC_EQOS_L3_L4_FILTER_NUM_3
// Default:      0 
//               
//               (DWC_EQOS_L3_L4_FILTER_NUM==4||DWC_EQOS_L3_L4_FILTER_NUM==5||DWC_EQOS_L3_L4_FILTER_NUM==6||DWC_EQOS_L3_L4_FILTER_NUM==7||DWC_EQOS_L3_L4_FILTER_NUM==8)
// Values:       0, 1
// 
// Enables four Layer 3 and Layer 4 frame filters.
// `define DWC_EQOS_L3_L4_FILTER_NUM_3


// Name:         DWC_EQOS_L3_L4_FILTER_NUM_4
// Default:      0 
//               (DWC_EQOS_L3_L4_FILTER_NUM==5||DWC_EQOS_L3_L4_FILTER_NUM==6||DWC_EQOS_L3_L4_FILTER_NUM==7||DWC_EQOS_L3_L4_FILTER_NUM==8)
// Values:       0, 1
// 
// Enables five Layer 3 and Layer 4 frame filters.
// `define DWC_EQOS_L3_L4_FILTER_NUM_4


// Name:         DWC_EQOS_L3_L4_FILTER_NUM_5
// Default:      0 
//               (DWC_EQOS_L3_L4_FILTER_NUM==6||DWC_EQOS_L3_L4_FILTER_NUM==7||DWC_EQOS_L3_L4_FILTER_NUM==8)
// Values:       0, 1
// 
// Enables six Layer 3 and Layer 4 frame filters.
// `define DWC_EQOS_L3_L4_FILTER_NUM_5


// Name:         DWC_EQOS_L3_L4_FILTER_NUM_6
// Default:      0 (DWC_EQOS_L3_L4_FILTER_NUM==7||DWC_EQOS_L3_L4_FILTER_NUM==8)
// Values:       0, 1
// 
// Enables seven Layer 3 and Layer 4 frame filters.
// `define DWC_EQOS_L3_L4_FILTER_NUM_6


// Name:         DWC_EQOS_L3_L4_FILTER_NUM_7
// Default:      0 (DWC_EQOS_L3_L4_FILTER_NUM==8)
// Values:       0, 1
// 
// Enables eight Layer 3 and Layer 4 frame filters.
// `define DWC_EQOS_L3_L4_FILTER_NUM_7

// Synchronization Group


// Name:         DWC_EQOS_SYNC_MACADDR
// Default:      0
// Values:       0, 1
// 
// Enables the synchronization of MAC address registers to the transmit or receive clock domain. Otherwise, the CSR MAC 
// Address Register value, written with the application clock, is directly used in the transmit or receive clock domain. Default 
// is direct usage.
`define DWC_EQOS_SYNC_MACADDR


// Name:         DWC_EQOS_SYNC_PAUSETIME
// Default:      0
// Values:       0, 1
// 
// Enables the synchronization of the Pause Timer register to the transmit clock domain.Default is direct usage.
`define DWC_EQOS_SYNC_PAUSETIME


// Name:         DWC_EQOS_SYNC_VLANTAG
// Default:      0
// Values:       0, 1
// 
// Enables the synchronization of the VLAN Tag register to the receive clock domain. Default is direct usage.
`define DWC_EQOS_SYNC_VLANTAG


// Name:         DWC_EQOS_SYNC_HASHTABLE
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_HASH_EN==1
// 
// Enables the synchronization of the Hash Table register to the receive clock domain.Default is direct usage.
// `define DWC_EQOS_SYNC_HASHTABLE


// Name:         DWC_EQOS_SYNC_L3_L4_ADDR
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_L3_L4_FILTER_EN==1
// 
// Enables the synchronization of the Layer 3 and Layer 4 Address Registers to the receive clock domain. Default is direct 
// usage.
// `define DWC_EQOS_SYNC_L3_L4_ADDR


// Name:         DWC_EQOS_TIME_STAMPING
// Default:      1 (DWC_EQOS_AV_ENABLE==1)
// Values:       0, 1
// Enabled:      DWC_EQOS_AV_ENABLE==0
// 
// Adds logic for supporting IEEE1588 timestamping protocol. Snoops receive packets and captures Timestamp for packets 
// marked as PTP packets. The Timestamp is also captured for transmit packets marked as PTP packets.
`define DWC_EQOS_TIME_STAMPING


// Name:         DWC_EQOS_ATI_STS_WIDTH
// Default:      82 ((DWC_EQOS_TIME_STAMPING==1) ? 64+18 : 18)
// Values:       -2147483648, ..., 2147483647
// 
// Specifies the width of ati_txstatus_o signal.
`define DWC_EQOS_ATI_STS_WIDTH 82


// Name:         DWC_EQOS_SYSTIME_SOURCE
// Default:      Internal
// Values:       Internal (0), External (1), Both Options (2)
// Enabled:      DWC_EQOS_TIME_STAMPING==1
// 
// Specifies the source of 64-bit reference System Time to take the timestamps that are provided with the status.
`define DWC_EQOS_SYSTIME_SOURCE 2


// Name:         DWC_EQOS_SYSTIME_SOURCE_BOTH
// Default:      1 (DWC_EQOS_SYSTIME_SOURCE==2)
// Values:       0, 1
// 
// Specifies Internal or External source of 64-bit reference System Time to take the timestamps that are provided with the 
// status.
`define DWC_EQOS_SYSTIME_SOURCE_BOTH


// Name:         DWC_EQOS_SYSTIME_SOURCE_EXT
// Default:      0 (DWC_EQOS_SYSTIME_SOURCE==1)
// Values:       0, 1
// 
// Specifies Internal or External source of 64-bit reference System Time to take the timestamps that are provided with the 
// status.
// `define DWC_EQOS_SYSTIME_SOURCE_EXT


// Name:         DWC_EQOS_COARSE_FINE_CORRECTION
// Default:      Both Options
// Values:       Coarse (0), Fine (1), Both Options (2)
// Enabled:      DWC_EQOS_TIME_STAMPING==1&&DWC_EQOS_SYSTIME_SOURCE!=1
// 
// Specifies the Coarse, Fine, or both options for System Time update.
`define DWC_EQOS_COARSE_FINE_CORRECTION 2


// Name:         DWC_EQOS_ADV_TIME_HIGH_WORD
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_TIME_STAMPING&&DWC_EQOS_SYSTIME_SOURCE!=1
// 
// Adds a register to store the most significant 16 bits of the 48-bit seconds time register for IEEE 1588-2008 
// implementation.
`define DWC_EQOS_ADV_TIME_HIGH_WORD


// Name:         DWC_EQOS_ADV_SUBNSEC_SUPPORT
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_OST_EN&&DWC_EQOS_SYSTIME_SOURCE!=1
// 
// Adds sub nanoseconds resolution to the system timestamp and timestamp correction
// `define DWC_EQOS_ADV_SUBNSEC_SUPPORT


// Name:         DWC_EQOS_ADV_TIME_AUX_SNAP
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_TIME_STAMPING==1
// 
// Adds the capability of storing the timestamp snapshots, taken with an external trigger, into a 4-deep FIFO.
`define DWC_EQOS_ADV_TIME_AUX_SNAP


// Name:         DWC_EQOS_AUX_SNAP_IN_NUM
// Default:      1 ((DWC_EQOS_ADV_TIME_AUX_SNAP==1) ? 1:0)
// Values:       0 1 2 3 4
// Enabled:      DWC_EQOS_ADV_TIME_AUX_SNAP==1
// 
// Specifies the number of external trigger inputs for capturing the timestamps.
`define DWC_EQOS_AUX_SNAP_IN_NUM 1


// Name:         DWC_EQOS_AUX_SNAP_1_EN
// Default:      0 (DWC_EQOS_AUX_SNAP_IN_NUM>1)
// Values:       0, 1
// 
// Enables two external trigger inputs for Auxillary snapshot.
// `define DWC_EQOS_AUX_SNAP_1_EN


// Name:         DWC_EQOS_AUX_SNAP_2_EN
// Default:      0 (DWC_EQOS_AUX_SNAP_IN_NUM>2)
// Values:       0, 1
// 
// Enables three external trigger inputs for Auxillary snapshot.
// `define DWC_EQOS_AUX_SNAP_2_EN


// Name:         DWC_EQOS_AUX_SNAP_3_EN
// Default:      0 (DWC_EQOS_AUX_SNAP_IN_NUM==4)
// Values:       0, 1
// 
// Enables four external trigger inputs for Auxillary snapshot.
// `define DWC_EQOS_AUX_SNAP_3_EN


// Name:         DWC_EQOS_AUX_FIFO_DEPTH
// Default:      4
// Values:       4 8 16
// Enabled:      DWC_EQOS_ADV_TIME_AUX_SNAP==1
// 
// Specifies the depth of FIFO to store the IEEE 1588 Auxiliary snapshots.
`define DWC_EQOS_AUX_FIFO_DEPTH 4


// Name:         DWC_EQOS_FLEXI_PPS_OUT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_TIME_STAMPING==1&&DWC_EQOS_SYSTIME_SOURCE!=1
// 
// Enables the feature to program the start or stop time, width, and interval of the pulse generated on the ptp_pps_o 
// output.
`define DWC_EQOS_FLEXI_PPS_OUT_EN


// Name:         DWC_EQOS_PPS_OUT_NUM
// Default:      1 ((DWC_EQOS_FLEXI_PPS_OUT_EN==0) ? 0 : 1)
// Values:       0 1 2 3 4
// Enabled:      DWC_EQOS_FLEXI_PPS_OUT_EN
// 
// Specifies the number of Pulse-Per-Second (PPS) Outputs.
`define DWC_EQOS_PPS_OUT_NUM 1


// Name:         DWC_EQOS_PPS_OUT_1_EN
// Default:      0 
//               (DWC_EQOS_PPS_OUT_NUM==2||DWC_EQOS_PPS_OUT_NUM==3||DWC_EQOS_PPS_OUT_NUM==4)
// Values:       0, 1
// 
// Enables one additional PPS Output.
// `define DWC_EQOS_PPS_OUT_1_EN


// Name:         DWC_EQOS_PPS_OUT_2_EN
// Default:      0 (DWC_EQOS_PPS_OUT_NUM==3||DWC_EQOS_PPS_OUT_NUM==4)
// Values:       0, 1
// 
// Enables second additional PPS Output.
// `define DWC_EQOS_PPS_OUT_2_EN


// Name:         DWC_EQOS_PPS_OUT_3_EN
// Default:      0 (DWC_EQOS_PPS_OUT_NUM==4)
// Values:       0, 1
// 
// Enables third additional PPS Output.
// `define DWC_EQOS_PPS_OUT_3_EN


// Name:         DWC_EQOS_OST_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_TIME_STAMPING==1
// 
// Enables One-Step Timestamp in the transmit path.
`define DWC_EQOS_OST_EN


// Name:         DWC_EQOS_TOFF_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables Timestamp Offload in the transmit path.
// `define DWC_EQOS_TOFF_EN


// Name:         DWC_EQOS_DOUBLE_VLAN_EN
// Default:      0
// Values:       0, 1
// 
// Enables Double VLAN Processing
// `define DWC_EQOS_DOUBLE_VLAN_EN

// RFC Fifo Depth


// Name:         DWC_EQOS_RFC_FDEPTH
// Default:      4 ((DWC_EQOS_NUM_RXQ>1&&DWC_EQOS_DOUBLE_VLAN_EN) ? 5 : 4)
// Values:       4, 5
// 
// Specifies the FIFO Depth in the RFC block.
`define DWC_EQOS_RFC_FDEPTH 4


// Name:         DWC_EQOS_RFC_FPTRWIDTH
// Default:      2 (((DWC_EQOS_NUM_RXQ>1&&DWC_EQOS_DOUBLE_VLAN_EN) ? 5 : 4>4) ? 3 : 
//               2)
// Values:       2, 3
// 
// Specifies the FIFO pointer width in the RFC block.
`define DWC_EQOS_RFC_FPTRWIDTH 2


// Name:         DWC_EQOS_SA_VLAN_INS_CTRL_EN
// Default:      0
// Values:       0, 1
// 
// Enables Source Address Insert/Replace and VLAN Insert/Replace/Delete logic
// `define DWC_EQOS_SA_VLAN_INS_CTRL_EN


// Name:         DWC_EQOS_RX_COE
// Default:      1 
//               (DWC_EQOS_TIME_STAMPING||DWC_EQOS_L3_L4_FILTER_EN||DWC_EQOS_SPLIT_HDR_EN)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TIME_STAMPING&&!DWC_EQOS_L3_L4_FILTER_EN&&!DWC_EQOS_SPLIT_HDR_EN
// 
// Enables the Checksum Offload engine in the receive path. In this mode, the Checksum Offload engine checks and detects 
// the IPv4 header checksum errors and TCP, UDP, or ICMP checksum errors encapsulated in IPv4 or IPv6 datagrams payload of the 
// received frames.
`define DWC_EQOS_RX_COE


// Name:         DWC_EQOS_TX_COE
// Default:      0 (DWC_EQOS_TSO_EN)
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS!=0&&!DWC_EQOS_TSO_EN
// 
// Enables the Checksum Offload Engine in the transmit path. In this mode, the DWC_eqos can calculate and insert the 
// checksums of TCP, UDP, or ICMP segments encapsulated in IPv4 or IPv6 datagrams. The DWC_eqos can also insert IPv4 header 
// checksums in the transmitted frames.
`define DWC_EQOS_TX_COE


// Name:         DWC_EQOS_TX_Q0_TX_COE
// Default:      1 (DWC_EQOS_TX_COE)
// Values:       0, 1
// Enabled:      DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>1&&!DWC_EQOS_TSO_EN
// 
// Enables Tx COE in TX Queue 0
`define DWC_EQOS_TX_Q0_TX_COE


// Name:         DWC_EQOS_TX_Q0_TX_COE_EN
// Default:      1 (DWC_EQOS_TX_Q0_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 0
`define DWC_EQOS_TX_Q0_TX_COE_EN 1


// Name:         DWC_EQOS_TX_Q1_TX_COE
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>1)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>1&&!(DWC_EQOS_TSO_EN&&DWC_EQOS_NUM_DMA_TSO_CH>1))
// 
// Enables Tx COE in TX Queue 1
`define DWC_EQOS_TX_Q1_TX_COE


// Name:         DWC_EQOS_TX_Q1_TX_COE_EN
// Default:      1 (DWC_EQOS_TX_Q1_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 1
`define DWC_EQOS_TX_Q1_TX_COE_EN 1


// Name:         DWC_EQOS_TX_Q2_TX_COE
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>2)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>2&&!(DWC_EQOS_TSO_EN&&DWC_EQOS_NUM_DMA_TSO_CH>2))
// 
// Enables Tx COE in TX Queue 2
// `define DWC_EQOS_TX_Q2_TX_COE


// Name:         DWC_EQOS_TX_Q2_TX_COE_EN
// Default:      0 (DWC_EQOS_TX_Q2_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 2
`define DWC_EQOS_TX_Q2_TX_COE_EN 0


// Name:         DWC_EQOS_TX_Q3_TX_COE
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>3)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>3&&!(DWC_EQOS_TSO_EN&&DWC_EQOS_NUM_DMA_TSO_CH>3))
// 
// Enables Tx COE in TX Queue 3
// `define DWC_EQOS_TX_Q3_TX_COE


// Name:         DWC_EQOS_TX_Q3_TX_COE_EN
// Default:      0 (DWC_EQOS_TX_Q3_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 3
`define DWC_EQOS_TX_Q3_TX_COE_EN 0


// Name:         DWC_EQOS_TX_Q4_TX_COE
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>4)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>4&&!(DWC_EQOS_TSO_EN&&DWC_EQOS_NUM_DMA_TSO_CH>4))
// 
// Enables Tx COE in TX Queue 4
// `define DWC_EQOS_TX_Q4_TX_COE


// Name:         DWC_EQOS_TX_Q4_TX_COE_EN
// Default:      0 (DWC_EQOS_TX_Q4_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 4
`define DWC_EQOS_TX_Q4_TX_COE_EN 0


// Name:         DWC_EQOS_TX_Q5_TX_COE
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>5)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>5&&!(DWC_EQOS_TSO_EN&&DWC_EQOS_NUM_DMA_TSO_CH>5))
// 
// Enables Tx COE in TX Queue 5
// `define DWC_EQOS_TX_Q5_TX_COE


// Name:         DWC_EQOS_TX_Q5_TX_COE_EN
// Default:      0 (DWC_EQOS_TX_Q5_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 5
`define DWC_EQOS_TX_Q5_TX_COE_EN 0


// Name:         DWC_EQOS_TX_Q6_TX_COE
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>6)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>6&&!(DWC_EQOS_TSO_EN&&DWC_EQOS_NUM_DMA_TSO_CH>6))
// 
// Enables Tx COE in TX Queue 6
// `define DWC_EQOS_TX_Q6_TX_COE


// Name:         DWC_EQOS_TX_Q6_TX_COE_EN
// Default:      0 (DWC_EQOS_TX_Q6_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 6
`define DWC_EQOS_TX_Q6_TX_COE_EN 0


// Name:         DWC_EQOS_TX_Q7_TX_COE
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>7)
// Values:       0, 1
// Enabled:       
//               DWC_EQOS_TX_COE&&DWC_EQOS_NUM_TXQ>7&&!(DWC_EQOS_TSO_EN&&DWC_EQOS_NUM_DMA_TSO_CH>7))
// 
// Enables Tx COE in TX Queue 7
// `define DWC_EQOS_TX_Q7_TX_COE


// Name:         DWC_EQOS_TX_Q7_TX_COE_EN
// Default:      0 (DWC_EQOS_TX_Q7_TX_COE)
// Values:       -2147483648, ..., 2147483647
// 
// Enables Tx COE in TX Queue 7
`define DWC_EQOS_TX_Q7_TX_COE_EN 0


// Name:         DWC_EQOS_CHKSUM_FIFO_WIDTH
// Default:      32
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_TX_COE==1 && DWC_EQOS_SYS!=0
// 
// Specifies the width of Transmit Checksum FIFO.
`define DWC_EQOS_CHKSUM_FIFO_WIDTH 32


// Name:         DWC_EQOS_SBD_FC_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS!=0
// 
// Adds the sideband sbd_flowctrl_i as input port for triggering flow control (backpressure or Pause packets).
// `define DWC_EQOS_SBD_FC_EN


// Name:         DWC_EQOS_ADD_TXRX_DIS_IO
// Default:      0
// Values:       0, 1
// Enabled:      (DWC_EQOS_SYS==1)||(DWC_EQOS_SYS==0)
// 
// Adds the sideband signals sbd_dis_transmit_i and sbd_dis_receive_i as input ports for Disable control of MAC transmitter 
// and receiver.
// `define DWC_EQOS_ADD_TXRX_DIS_IO


// Name:         DWC_EQOS_TX_STS_DROP
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS!=0
// 
// Enables Transmit Status Dropping in the MTL. The Transmit Status FIFO is removed from the configuration.
// `define DWC_EQOS_TX_STS_DROP


// Name:         DWC_EQOS_GPIO_EN
// Default:      0
// Values:       0, 1
// Enabled:      Always
// 
// Adds the sideband general purpose IO signals.
// `define DWC_EQOS_GPIO_EN


// Name:         DWC_EQOS_GIW
// Default:      0 (DWC_EQOS_GPIO_EN ? 4 : 0)
// Values:       0 4 8 12 16
// Enabled:      DWC_EQOS_GPIO_EN
// 
// Sets the width of the general purpose input bus.
`define DWC_EQOS_GIW 0


// Name:         DWC_EQOS_GOW
// Default:      0 (DWC_EQOS_GPIO_EN ? 4 : 0)
// Values:       0 4 8 12 16
// Enabled:      DWC_EQOS_GPIO_EN
// 
// Sets the width of the general purpose output bus.
`define DWC_EQOS_GOW 0


// Name:         DWC_EQOS_MDC_CONTEXT_EN
// Default:      1 
//               (!DWC_EQOS_CORE&&!DWC_EQOS_MTL_SUBSYS)&&(DWC_EQOS_OST_EN||DWC_EQOS_TSO_EN||DWC_EQOS_SA_VLAN_INS_CTRL_EN)
// Values:       0, 1
// 
// Enables Context Descriptor format for DMA configurations.
`define DWC_EQOS_MDC_CONTEXT_EN


// Name:         DWC_EQOS_MMC_EN
// Default:      0
// Values:       0, 1
// 
// Enables the MAC Management (RMON) counters.
`define DWC_EQOS_MMC_EN


// Name:         DWC_EQOS_MMC_EN_TX_ALL
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN
// 
// Enables all Tx packet counters.
`define DWC_EQOS_MMC_EN_TX_ALL


// Name:         DWC_EQOS_MMC_TXADDR_RNG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables the octet counters for all transmitted packets of different sizes ( =64, 65-127, 128-255, 256-511, 512-1023, 
// 1024-maxsize).
`define DWC_EQOS_MMC_TXADDR_RNG_CNT_EN


// Name:         DWC_EQOS_MMC_TXADDR_RNG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXADDR_RNG_CNT_EN
// 
// Enables the 16-bit octet counters for all transmitted packets of different sizes ( =64, 65-127, 128-255, 256-511, 
// 512-1023, 1024-maxsize).
`define DWC_EQOS_MMC_TXADDR_RNG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXOCTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables Octet counter for all good and bad transmitted packets.
`define DWC_EQOS_MMC_TXOCTGB_CNT_EN


// Name:         DWC_EQOS_MMC_TXOCTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit support for Octet counter for all good and bad transmitted packets.
// `define DWC_EQOS_MMC_TXOCTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXPKTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables Packet counter for all good and bad transmitted packets.
`define DWC_EQOS_MMC_TXPKTGB_CNT_EN


// Name:         DWC_EQOS_MMC_TXPKTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXPKTGB_CNT_EN
// 
// Enables 16-bit support for Frame counter for all good and bad transmitted packets.
`define DWC_EQOS_MMC_TXPKTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXBCASTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables counter for transmitted good broadcast packets.
`define DWC_EQOS_MMC_TXBCASTG_CNT_EN


// Name:         DWC_EQOS_MMC_TXBCASTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXBCASTG_CNT_EN
// 
// Enables 16-bit counter support for transmitted good broadcast packets.
`define DWC_EQOS_MMC_TXBCASTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXMCASTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables counter for transmitted good multicast packets.
`define DWC_EQOS_MMC_TXMCASTG_CNT_EN


// Name:         DWC_EQOS_MMC_TXMCASTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXMCASTG_CNT_EN
// 
// Enables 16-bit counter support for transmitted good multicast packets.
`define DWC_EQOS_MMC_TXMCASTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXUCASTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables counter for transmitted good or bad unicast packets.
`define DWC_EQOS_MMC_TXUCASTGB_CNT_EN


// Name:         DWC_EQOS_MMC_TXUCASTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXUCASTGB_CNT_EN
// 
// Enables 16-bit counter support for transmitted good or bad unicast packets.
`define DWC_EQOS_MMC_TXUCASTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXMCASTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables counter for transmitted good or bad multicast packets.
`define DWC_EQOS_MMC_TXMCASTGB_CNT_EN


// Name:         DWC_EQOS_MMC_TXMCASTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXMCASTGB_CNT_EN
// 
// Enables 16-bit counter support for transmitted good or bad multicast packets.
`define DWC_EQOS_MMC_TXMCASTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXBCASTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables counter for transmitted good or bad broadcast packets.
`define DWC_EQOS_MMC_TXBCASTGB_CNT_EN


// Name:         DWC_EQOS_MMC_TXBCASTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXBCASTGB_CNT_EN
// 
// Enables 16-bit counter support for transmitted good or bad broadcast packets.
`define DWC_EQOS_MMC_TXBCASTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXUNDRFLW_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables counter for packets transmitted with underflow error bit set.
`define DWC_EQOS_MMC_TXUNDRFLW_CNT_EN


// Name:         DWC_EQOS_MMC_TXUNDRFLW_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXUNDRFLW_CNT_EN
// 
// Enables 16-bit counter support for packets transmitted with underflow error bit set.
`define DWC_EQOS_MMC_TXUNDRFLW_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXSNGLCOLG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY
// 
// Enables counter for packets transmitted with single collision in the half-duplex mode .
`define DWC_EQOS_MMC_TXSNGLCOLG_CNT_EN


// Name:         DWC_EQOS_MMC_TXSNGLCOLG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXSNGLCOLG_CNT_EN
// 
// Enables 16-bit counter support for packets transmitted with single collision in the half-duplex mode.
`define DWC_EQOS_MMC_TXSNGLCOLG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXMULTCOLG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY
// 
// Enables counter for packets transmitted with multiple collision in the half-duplex mode.
`define DWC_EQOS_MMC_TXMULTCOLG_CNT_EN


// Name:         DWC_EQOS_MMC_TXMULTCOLG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXMULTCOLG_CNT_EN
// 
// Enables 16-bit counter support for packets transmitted with multiple collision in the half-duplex mode.
`define DWC_EQOS_MMC_TXMULTCOLG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXDEFRD_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY
// 
// Enables counter for packets deferred before transmission in the half-duplex mode.
`define DWC_EQOS_MMC_TXDEFRD_CNT_EN


// Name:         DWC_EQOS_MMC_TXDEFRD_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXDEFRD_CNT_EN
// 
// Enables 16-bit counter support for packets deferred before transmission in the half-duplex mode.
`define DWC_EQOS_MMC_TXDEFRD_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXLATECOL_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY
// 
// Enables counter for packets aborted because of late collision in the half-duplex mode.
`define DWC_EQOS_MMC_TXLATECOL_CNT_EN


// Name:         DWC_EQOS_MMC_TXLATECOL_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXLATECOL_CNT_EN
// 
// Enables 16-bit counter support for packets aborted because of late collision in the half-duplex mode.
`define DWC_EQOS_MMC_TXLATECOL_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXEXSCOL_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY
// 
// Enables counter for packets aborted because of excessive collision in the half-duplex mode.
`define DWC_EQOS_MMC_TXEXSCOL_CNT_EN


// Name:         DWC_EQOS_MMC_TXEXSCOL_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXEXSCOL_CNT_EN
// 
// Enables 16-bit counter support for packets aborted because of excessive collision in the half-duplex mode.
`define DWC_EQOS_MMC_TXEXSCOL_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXCARR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY
// 
// Enables counter for packets aborted because of carrier errors in the half-duplex mode.
`define DWC_EQOS_MMC_TXCARR_CNT_EN


// Name:         DWC_EQOS_MMC_TXCARR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXCARR_CNT_EN
// 
// Enables 16-bit counter support for packets aborted because of carrier errors in the half-duplex mode.
`define DWC_EQOS_MMC_TXCARR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXOCTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables Octet counter for only good transmitted packets.
`define DWC_EQOS_MMC_TXOCTG_CNT_EN


// Name:         DWC_EQOS_MMC_TXOCTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit Octet counter support for only good transmitted packets.
// `define DWC_EQOS_MMC_TXOCTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXPKTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables Frame counter for only good transmitted packets.
`define DWC_EQOS_MMC_TXPKTG_CNT_EN


// Name:         DWC_EQOS_MMC_TXPKTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXPKTG_CNT_EN
// 
// Enables 16-bit Frame counter support for only good transmitted packets.
`define DWC_EQOS_MMC_TXPKTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXEXSDEF_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL&&!DWC_EQOS_FDUPLX_ONLY
// 
// Enables counter for packets aborted because of excessive deferral in the half-duplex mode.
`define DWC_EQOS_MMC_TXEXSDEF_CNT_EN


// Name:         DWC_EQOS_MMC_TXEXSDEF_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXEXSDEF_CNT_EN
// 
// Enables 16-bit counter support for packets aborted because of excessive deferral in the half-duplex mode.
`define DWC_EQOS_MMC_TXEXSDEF_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXPAUSE_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables packet counter for transmitted PAUSE packets.
`define DWC_EQOS_MMC_TXPAUSE_CNT_EN


// Name:         DWC_EQOS_MMC_TXPAUSE_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXPAUSE_CNT_EN
// 
// Enables 16-bit packet counter support for transmitted PAUSE packets.
`define DWC_EQOS_MMC_TXPAUSE_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXVLAN_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables packet counter for transmitted VLAN-tagged packets.
`define DWC_EQOS_MMC_TXVLAN_CNT_EN


// Name:         DWC_EQOS_MMC_TXVLAN_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXVLAN_CNT_EN
// 
// Enables 16-bit packet counter support for transmitted VLAN-tagged packets.
`define DWC_EQOS_MMC_TXVLAN_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TXOVERSZG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_TX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_TX_ALL
// 
// Enables the counter for transmitted Oversize (size > 1518/1522/2000 bytes) packets.
`define DWC_EQOS_MMC_TXOVERSZG_CNT_EN


// Name:         DWC_EQOS_MMC_TXOVERSZG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_TXOVERSZG_CNT_EN
// 
// Enables the 16-bit counter support for transmitted Oversize (size > 1518/1522/2000 bytes) packets.
`define DWC_EQOS_MMC_TXOVERSZG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_TX_PKTS_ATLEAST_ONE
// Default:      1 
//               
//               
//               
//               
//               
//               
//               
//               (DWC_EQOS_MMC_TXADDR_RNG_CNT_EN||DWC_EQOS_MMC_TXPKTGB_CNT_EN||DWC_EQOS_MMC_TXBCASTG_CNT_EN||DWC_EQOS_MMC_TXMCASTG_CNT_EN||DWC_EQOS_MMC_TXUCASTGB_CNT_EN||DWC_EQOS_MMC_TXMCASTGB_CNT_EN||DWC_EQOS_MMC_TXBCASTGB_CNT_EN||DWC_EQOS_MMC_TXUNDRFLW_CNT_EN||DWC_EQOS_MMC_TXSNGLCOLG_CNT_EN||DWC_EQOS_MMC_TXMULTCOLG_CNT_EN||DWC_EQOS_MMC_TXDEFRD_CNT_EN||DWC_EQOS_MMC_TXLATECOL_CNT_EN||DWC_EQOS_MMC_TXEXSCOL_CNT_EN||DWC_EQOS_MMC_TXCARR_CNT_EN||DWC_EQOS_MMC_TXPKTG_CNT_EN||DWC_EQOS_MMC_TXEXSDEF_CNT_EN||DWC_EQOS_MMC_TXPAUSE_CNT_EN||DWC_EQOS_MMC_TXVLAN_CNT_EN||DWC_EQOS_MMC_TXOVERSZG_CNT_EN)
// Values:       0, 1
// 
// This is defined when at least one MMC Transmit Packet Counter is enabled.
`define DWC_EQOS_MMC_TX_PKTS_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_TX_BCNT_ATLEAST_ONE
// Default:      1 (DWC_EQOS_MMC_TXOCTGB_CNT_EN||DWC_EQOS_MMC_TXOCTG_CNT_EN)
// Values:       0, 1
// 
// This is defined when at least one MMC Transmit Octet Counter is enabled.
`define DWC_EQOS_MMC_TX_BCNT_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_TX_EN_ATLEAST_ONE
// Default:      1 
//               (DWC_EQOS_MMC_TX_PKTS_ATLEAST_ONE||DWC_EQOS_MMC_TX_BCNT_ATLEAST_ONE)
// Values:       0, 1
// 
// This is defined when at least one MMC Transmit Counter is enabled.
`define DWC_EQOS_MMC_TX_EN_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_EN_RX_ALL
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN
// 
// Enables all receive packet counters.
`define DWC_EQOS_MMC_EN_RX_ALL


// Name:         DWC_EQOS_MMC_RXPKTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables Packet counter for received good and bad packets.
`define DWC_EQOS_MMC_RXPKTGB_CNT_EN


// Name:         DWC_EQOS_MMC_RXPKTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXPKTGB_CNT_EN
// 
// Enables 16-bit Packet counter support for received good and bad packets.
`define DWC_EQOS_MMC_RXPKTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXOCTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables Octet counter for received good packets.
`define DWC_EQOS_MMC_RXOCTG_CNT_EN


// Name:         DWC_EQOS_MMC_RXOCTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit Octet counter support for received good packets.
// `define DWC_EQOS_MMC_RXOCTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXOCTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables Octet counter for all received packets.
`define DWC_EQOS_MMC_RXOCTGB_CNT_EN


// Name:         DWC_EQOS_MMC_RXOCTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit Octet counter support for all received packets.
// `define DWC_EQOS_MMC_RXOCTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXBCASTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for received good broadcast packets.
`define DWC_EQOS_MMC_RXBCASTG_CNT_EN


// Name:         DWC_EQOS_MMC_RXBCASTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXBCASTG_CNT_EN
// 
// Enables 16-bit counter support for received good broadcast packets.
`define DWC_EQOS_MMC_RXBCASTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXMCASTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for received good multicast packets.
`define DWC_EQOS_MMC_RXMCASTG_CNT_EN


// Name:         DWC_EQOS_MMC_RXMCASTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXMCASTG_CNT_EN
// 
// Enables 16-bit counter support for received good multicast packets.
`define DWC_EQOS_MMC_RXMCASTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXCRCERR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for packets received with CRC error.
`define DWC_EQOS_MMC_RXCRCERR_CNT_EN


// Name:         DWC_EQOS_MMC_RXCRCERR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXCRCERR_CNT_EN
// 
// Enables 16-bit counter support for packets received with CRC error.
`define DWC_EQOS_MMC_RXCRCERR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXALGNERR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL&&!DWC_EQOS_M1000_ONLY)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL&&!DWC_EQOS_M1000_ONLY
// 
// Enables counter for packets received with Alignment Error (dribble) in the 100 Mbps mode.
`define DWC_EQOS_MMC_RXALGNERR_CNT_EN


// Name:         DWC_EQOS_MMC_RXALGNERR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXALGNERR_CNT_EN
// 
// Enables 16-bit counter support for packets received with Alignment Error (dribble) in the 100 Mbps mode.
`define DWC_EQOS_MMC_RXALGNERR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXRUNTERR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for received runt (size less than 64 bytes and CRC error) packets.
`define DWC_EQOS_MMC_RXRUNTERR_CNT_EN


// Name:         DWC_EQOS_MMC_RXRUNTERR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXRUNTERR_CNT_EN
// 
// Enables 16-bit counter support for received runt (size less than 64 bytes and CRC error) packets.
`define DWC_EQOS_MMC_RXRUNTERR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXJABERR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for packets received with Jabber error.
`define DWC_EQOS_MMC_RXJABERR_CNT_EN


// Name:         DWC_EQOS_MMC_RXJABERR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXJABERR_CNT_EN
// 
// Enables 16-bit counter support for packets received with Jabber error.
`define DWC_EQOS_MMC_RXJABERR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXUNDERSZG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for received undersize (size less than 64 bytes and no errors) packets.
`define DWC_EQOS_MMC_RXUNDERSZG_CNT_EN


// Name:         DWC_EQOS_MMC_RXUNDERSZG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXUNDERSZG_CNT_EN
// 
// Enables 16-bit counter support for received undersize (size less than 64 bytes and no errors) packets.
`define DWC_EQOS_MMC_RXUNDERSZG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXOVERSZG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables the Rx packet counter for oversized packets received without errors. Oversized packets have length greater than 
// maxsize (1,518 or 1,522 bytes for VLAN tagged packets; 2000 bytes if enabled in bit 27 of Register 0 (MAC Configuration 
// Register)).
`define DWC_EQOS_MMC_RXOVERSZG_CNT_EN


// Name:         DWC_EQOS_MMC_RXOVERSZG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXOVERSZG_CNT_EN
// 
// Enables the 16-bit counter support for received Oversize (size > 1518/1522/2000 bytes) packets.
`define DWC_EQOS_MMC_RXOVERSZG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXADDR_RNG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables the octet counters for all received packets of different sizes (64, 65-127, 128-255, 256-511, 512-1023, 
// 1024-maxsize).
`define DWC_EQOS_MMC_RXADDR_RNG_CNT_EN


// Name:         DWC_EQOS_MMC_RXADDR_RNG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXADDR_RNG_CNT_EN
// 
// Enables the 16-bit octet counters for all received packets of different sizes (64, 65-127, 128-255, 256-511, 512-1023, 
// 1024-maxsize).
`define DWC_EQOS_MMC_RXADDR_RNG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXUCASTG_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for received good Unicast packets.
`define DWC_EQOS_MMC_RXUCASTG_CNT_EN


// Name:         DWC_EQOS_MMC_RXUCASTG_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXUCASTG_CNT_EN
// 
// Enables 16-bit counter support for received good Unicast packets.
`define DWC_EQOS_MMC_RXUCASTG_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXLENERR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for packets received with Length error.
`define DWC_EQOS_MMC_RXLENERR_CNT_EN


// Name:         DWC_EQOS_MMC_RXLENERR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXLENERR_CNT_EN
// 
// Enables 16-bit counter support for packets received with Length error.
`define DWC_EQOS_MMC_RXLENERR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXOUTOFRNG_TYP_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables Out of Range (LengthField between 1500 & 1536 decimal) packet counter.
`define DWC_EQOS_MMC_RXOUTOFRNG_TYP_CNT_EN


// Name:         DWC_EQOS_MMC_RXOUTOFRNG_TYP_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXOUTOFRNG_TYP_CNT_EN
// 
// Enables 16-bit Out of Range (LengthField between 1500 & 1536 decimal) packet counter.
`define DWC_EQOS_MMC_RXOUTOFRNG_TYP_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXPAUSEPKT_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for received Pause packets.
`define DWC_EQOS_MMC_RXPAUSEPKT_CNT_EN


// Name:         DWC_EQOS_MMC_RXPAUSEPKT_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXPAUSEPKT_CNT_EN
// 
// Enables 16-bit counter support for received Pause packets.
`define DWC_EQOS_MMC_RXPAUSEPKT_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXFIFOOVFL_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL&&!DWC_EQOS_CORE)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL&&!DWC_EQOS_CORE
// 
// Enables counter to count the number of times Rx MTL FIFO overflowed.
`define DWC_EQOS_MMC_RXFIFOOVFL_CNT_EN


// Name:         DWC_EQOS_MMC_RXFIFOOVFL_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXFIFOOVFL_CNT_EN
// 
// Enables 16-bit counter support to count the number of times Rx MTL FIFO overflowed.
`define DWC_EQOS_MMC_RXFIFOOVFL_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXVLANPKTGB_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for received good or bad VLAN packets.
`define DWC_EQOS_MMC_RXVLANPKTGB_CNT_EN


// Name:         DWC_EQOS_MMC_RXVLANPKTGB_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXVLANPKTGB_CNT_EN
// 
// Enables 16-bit counter support for received good or bad VLAN packets.
`define DWC_EQOS_MMC_RXVLANPKTGB_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXWDGERR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for packets with Watchdog timeout error.
`define DWC_EQOS_MMC_RXWDGERR_CNT_EN


// Name:         DWC_EQOS_MMC_RXWDGERR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXWDGERR_CNT_EN
// 
// Enables 16-bit counter support for packets with Watchdog timeout error.
`define DWC_EQOS_MMC_RXWDGERR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXRCVERR_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for packets with Receive error.
`define DWC_EQOS_MMC_RXRCVERR_CNT_EN


// Name:         DWC_EQOS_MMC_RXRCVERR_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXRCVERR_CNT_EN
// 
// Enables 16-bit counter support for packets with Receive error.
`define DWC_EQOS_MMC_RXRCVERR_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RXCTRLPKT_CNT_EN
// Default:      1 (DWC_EQOS_MMC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&!DWC_EQOS_MMC_EN_RX_ALL
// 
// Enables counter for all types of good control packets.
`define DWC_EQOS_MMC_RXCTRLPKT_CNT_EN


// Name:         DWC_EQOS_MMC_RXCTRLPKT_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RXCTRLPKT_CNT_EN
// 
// Enables 16-bit counter support for types of good control packets.
`define DWC_EQOS_MMC_RXCTRLPKT_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_PKTS_ATLEAST_ONE
// Default:      1 
//               
//               
//               
//               
//               
//               (DWC_EQOS_MMC_RXPKTGB_CNT_EN||DWC_EQOS_MMC_RXBCASTG_CNT_EN||DWC_EQOS_MMC_RXMCASTG_CNT_EN||DWC_EQOS_MMC_RXCRCERR_CNT_EN||DWC_EQOS_MMC_RXALGNERR_CNT_EN||DWC_EQOS_MMC_RXRUNTERR_CNT_EN||DWC_EQOS_MMC_RXJABERR_CNT_EN||DWC_EQOS_MMC_RXUNDERSZG_CNT_EN||DWC_EQOS_MMC_RXOVERSZG_CNT_EN||DWC_EQOS_MMC_RXADDR_RNG_CNT_EN||DWC_EQOS_MMC_RXUCASTG_CNT_EN||DWC_EQOS_MMC_RXLENERR_CNT_EN||DWC_EQOS_MMC_RXOUTOFRNG_TYP_CNT_EN||DWC_EQOS_MMC_RXPAUSEPKT_CNT_EN 
//               
//               ||DWC_EQOS_MMC_RXFIFOOVFL_CNT_EN||DWC_EQOS_MMC_RXVLANPKTGB_CNT_EN||DWC_EQOS_MMC_RXWDGERR_CNT_EN||DWC_EQOS_MMC_RXRCVERR_CNT_EN||DWC_EQOS_MMC_RXCTRLPKT_CNT_EN)
// Values:       0, 1
// 
// This is defined when at least one MMC Receive Packet Counter is enabled.
`define DWC_EQOS_MMC_RX_PKTS_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_RX_BCNT_ATLEAST_ONE
// Default:      1 (DWC_EQOS_MMC_RXOCTG_CNT_EN||DWC_EQOS_MMC_RXOCTGB_CNT_EN)
// Values:       0, 1
// 
// This is defined when at least one MMC Receive Octet Counter is enabled.
`define DWC_EQOS_MMC_RX_BCNT_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_RX_EN_ATLEAST_ONE
// Default:      1 
//               (DWC_EQOS_MMC_RX_PKTS_ATLEAST_ONE||DWC_EQOS_MMC_RX_BCNT_ATLEAST_ONE)
// Values:       0, 1
// 
// This is defined when at least one MMC Receive Counter is enabled.
`define DWC_EQOS_MMC_RX_EN_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_IPC_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_EN&&DWC_EQOS_RX_COE
// 
// Enables the MAC Management (RMON) counters for the Checksum Offload module.
`define DWC_EQOS_MMC_IPC_EN


// Name:         DWC_EQOS_MMC_IPC_EN_RX_ALL
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN
// 
// Enables all Rx IPC counters.
`define DWC_EQOS_MMC_IPC_EN_RX_ALL


// Name:         DWC_EQOS_MMC_RX_IPV4_GD_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for IPv4 packets with no checksum errors.
`define DWC_EQOS_MMC_RX_IPV4_GD_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_GD_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV4_GD_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv4 packets with no checksum errors.
`define DWC_EQOS_MMC_RX_IPV4_GD_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_HDRERR_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for IPv4 packets with checksum errors.
`define DWC_EQOS_MMC_RX_IPV4_HDRERR_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_HDRERR_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV4_HDRERR_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv4 packets with checksum errors.
`define DWC_EQOS_MMC_RX_IPV4_HDRERR_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_NOPAY_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for IPv4 packets which do not have TCP, UDP, or ICMP.
`define DWC_EQOS_MMC_RX_IPV4_NOPAY_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_NOPAY_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV4_NOPAY_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv4 packets which do not have TCP, UDP, or ICMP.
`define DWC_EQOS_MMC_RX_IPV4_NOPAY_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_FRAG_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables Rx frame counter for all IPv4 packets received with fragments.
`define DWC_EQOS_MMC_RX_IPV4_FRAG_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_FRAG_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV4_FRAG_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv4 packets received with fragments.
`define DWC_EQOS_MMC_RX_IPV4_FRAG_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_UDSBL_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for IPv4 UDP packets with checksum disabled.
`define DWC_EQOS_MMC_RX_IPV4_UDSBL_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_UDSBL_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV4_UDSBL_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv4 UDP packets with checksum disabled.
`define DWC_EQOS_MMC_RX_IPV4_UDSBL_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_GD_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for IPv6 packets that do not have checksum-related errors.
`define DWC_EQOS_MMC_RX_IPV6_GD_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_GD_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV6_GD_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv6 packets that do not have checksum-related errors.
`define DWC_EQOS_MMC_RX_IPV6_GD_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_HDRERR_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for IPv6 packets received with header error.
`define DWC_EQOS_MMC_RX_IPV6_HDRERR_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_HDRERR_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV6_HDRERR_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv6 packets received with header error.
`define DWC_EQOS_MMC_RX_IPV6_HDRERR_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_NOPAY_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for IPv6 packets not having TCP, UDP, or ICMP.
`define DWC_EQOS_MMC_RX_IPV6_NOPAY_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_NOPAY_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_IPV6_NOPAY_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for IPv6 packets not having TCP, UDP, or ICMP.
`define DWC_EQOS_MMC_RX_IPV6_NOPAY_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_GD_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for packets containing UDP with no errors.
`define DWC_EQOS_MMC_RX_UDP_GD_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_GD_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_UDP_GD_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for packets containing UDP with no errors.
`define DWC_EQOS_MMC_RX_UDP_GD_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_ERR_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for packets containing UDP with errors.
`define DWC_EQOS_MMC_RX_UDP_ERR_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_ERR_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_UDP_ERR_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for packets containing UDP with errors.
`define DWC_EQOS_MMC_RX_UDP_ERR_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_GD_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for packets containing TCP with no errors.
`define DWC_EQOS_MMC_RX_TCP_GD_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_GD_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_TCP_GD_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for packets containing TCP with no errors.
`define DWC_EQOS_MMC_RX_TCP_GD_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_ERR_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for packets containing TCP with errors.
`define DWC_EQOS_MMC_RX_TCP_ERR_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_ERR_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_TCP_ERR_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for packets containing TCP with errors.
`define DWC_EQOS_MMC_RX_TCP_ERR_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_GD_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for packets containing ICMP with no errors.
`define DWC_EQOS_MMC_RX_ICMP_GD_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_GD_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_ICMP_GD_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for packets containing ICMP with no errors.
`define DWC_EQOS_MMC_RX_ICMP_GD_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_ERR_PKTS_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter for packets containing ICMP with errors.
`define DWC_EQOS_MMC_RX_ICMP_ERR_PKTS_CNT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_ERR_PKTS_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_RX_ICMP_ERR_PKTS_CNT_EN
// 
// Enables 16-bit MMC Counter for packets containing ICMP with errors.
`define DWC_EQOS_MMC_RX_ICMP_ERR_PKTS_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_GD_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting IPv4 datagrams bytes when there are no checksum errors.
`define DWC_EQOS_MMC_RX_IPV4_GD_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_GD_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting IPv4 datagrams bytes when there are no checksum errors.
// `define DWC_EQOS_MMC_RX_IPV4_GD_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_HDRERR_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables an Rx octet counter for all IPv4 datagrams received with a header error.
`define DWC_EQOS_MMC_RX_IPV4_HDRERR_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_HDRERR_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter for for all IPv4 datagrams received with a header error.
// `define DWC_EQOS_MMC_RX_IPV4_HDRERR_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_NOPAY_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes of IPv4 datagrams with no UDP, TCP, or ICMP.
`define DWC_EQOS_MMC_RX_IPV4_NOPAY_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_NOPAY_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes of IPv4 datagrams with no UDP, TCP, or ICMP.
// `define DWC_EQOS_MMC_RX_IPV4_NOPAY_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_FRAG_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables an Rx octet counter for all IPv4 datagrams received with fragments.
`define DWC_EQOS_MMC_RX_IPV4_FRAG_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_FRAG_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter for all IPv4 datagrams received with fragments.
// `define DWC_EQOS_MMC_RX_IPV4_FRAG_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_UDSBL_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in IPv4 UDP datagram which has checksum disabled. This includes only UDP bytes and 
// not the IPv4 header.
`define DWC_EQOS_MMC_RX_IPV4_UDSBL_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV4_UDSBL_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in IPv4 UDP datagram which has checksum disabled. This includes only UDP bytes 
// and not the IPv4 header.
// `define DWC_EQOS_MMC_RX_IPV4_UDSBL_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_GD_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in IPv6 datagram having no checksum errors.
`define DWC_EQOS_MMC_RX_IPV6_GD_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_GD_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in IPv6 datagram having no checksum errors.
// `define DWC_EQOS_MMC_RX_IPV6_GD_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_HDRERR_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in IPv6 datagram having header errors.
`define DWC_EQOS_MMC_RX_IPV6_HDRERR_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_HDRERR_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in IPv6 datagram having header errors.
// `define DWC_EQOS_MMC_RX_IPV6_HDRERR_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_NOPAY_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in IPv6 datagram not having TCP, UDP, or ICMP.
`define DWC_EQOS_MMC_RX_IPV6_NOPAY_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_IPV6_NOPAY_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in IPv6 datagram not having TCP, UDP, or ICMP.
// `define DWC_EQOS_MMC_RX_IPV6_NOPAY_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_GD_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in UDP which do not have checksum errors.
`define DWC_EQOS_MMC_RX_UDP_GD_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_GD_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in UDP which do not have checksum errors.
// `define DWC_EQOS_MMC_RX_UDP_GD_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_ERR_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in UDP which have checksum errors.
`define DWC_EQOS_MMC_RX_UDP_ERR_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_UDP_ERR_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in UDP which have checksum errors.
// `define DWC_EQOS_MMC_RX_UDP_ERR_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_GD_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in TCP which do not have checksum errors.
`define DWC_EQOS_MMC_RX_TCP_GD_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_GD_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in TCP which do not have checksum errors.
// `define DWC_EQOS_MMC_RX_TCP_GD_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_ERR_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in TCP which have checksum errors.
`define DWC_EQOS_MMC_RX_TCP_ERR_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_TCP_ERR_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in TCP which have checksum errors.
// `define DWC_EQOS_MMC_RX_TCP_ERR_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_GD_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in ICMP which do not have checksum errors.
`define DWC_EQOS_MMC_RX_ICMP_GD_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_GD_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in ICMP which do not have checksum errors.
// `define DWC_EQOS_MMC_RX_ICMP_GD_OCTET_CNT_16BIT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_ERR_OCTET_CNT_EN
// Default:      1 (DWC_EQOS_MMC_IPC_EN_RX_ALL)
// Values:       0, 1
// Enabled:      DWC_EQOS_MMC_IPC_EN&&!DWC_EQOS_MMC_IPC_EN_RX_ALL
// 
// Enables MMC Counter counting bytes in ICMP which have checksum errors.
`define DWC_EQOS_MMC_RX_ICMP_ERR_OCTET_CNT_EN


// Name:         DWC_EQOS_MMC_RX_ICMP_ERR_OCTET_CNT_16BIT_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables 16-bit MMC Counter counting bytes in ICMP which have checksum errors.
// `define DWC_EQOS_MMC_RX_ICMP_ERR_OCTET_CNT_16BIT_EN



// Name:         DWC_EQOS_MMC_IPC_RX_DGRAM_BCNT_ATLEAST_ONE
// Default:      1 
//               
//               
//               
//               (DWC_EQOS_MMC_RX_IPV4_GD_OCTET_CNT_EN||DWC_EQOS_MMC_RX_IPV4_HDRERR_OCTET_CNT_EN||DWC_EQOS_MMC_RX_IPV4_NOPAY_OCTET_CNT_EN||DWC_EQOS_MMC_RX_IPV4_FRAG_OCTET_CNT_EN||DWC_EQOS_MMC_RX_IPV6_GD_OCTET_CNT_EN||DWC_EQOS_MMC_RX_IPV6_HDRERR_OCTET_CNT_EN||DWC_EQOS_MMC_RX_IPV6_NOPAY_OCTET_CNT_EN)
// Values:       0, 1
// 
// This is defined when at least one MMC IPC receive datagram counter is selected.
`define DWC_EQOS_MMC_IPC_RX_DGRAM_BCNT_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_IPC_RX_PAYLD_BCNT_ATLEAST_ONE
// Default:      1 
//               
//               
//               (DWC_EQOS_MMC_RX_UDP_GD_OCTET_CNT_EN||DWC_EQOS_MMC_RX_IPV4_UDSBL_OCTET_CNT_EN||DWC_EQOS_MMC_RX_UDP_ERR_OCTET_CNT_EN||DWC_EQOS_MMC_RX_TCP_GD_OCTET_CNT_EN||DWC_EQOS_MMC_RX_TCP_ERR_OCTET_CNT_EN||DWC_EQOS_MMC_RX_ICMP_GD_OCTET_CNT_EN||DWC_EQOS_MMC_RX_ICMP_ERR_OCTET_CNT_EN)
// Values:       0, 1
// 
// This is defined when at least one MMC IPC receive payload counter is selected.
`define DWC_EQOS_MMC_IPC_RX_PAYLD_BCNT_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_IPC_RX_PKTS_ATLEAST_ONE
// Default:      1 
//               
//               
//               
//               
//               
//               
//               (DWC_EQOS_MMC_RX_IPV4_GD_PKTS_CNT_EN||DWC_EQOS_MMC_RX_IPV4_HDRERR_PKTS_CNT_EN||DWC_EQOS_MMC_RX_IPV4_NOPAY_PKTS_CNT_EN||DWC_EQOS_MMC_RX_IPV4_FRAG_PKTS_CNT_EN||DWC_EQOS_MMC_RX_IPV4_UDSBL_PKTS_CNT_EN||DWC_EQOS_MMC_RX_IPV6_GD_PKTS_CNT_EN||DWC_EQOS_MMC_RX_IPV6_HDRERR_PKTS_CNT_EN||DWC_EQOS_MMC_RX_IPV6_NOPAY_PKTS_CNT_EN||DWC_EQOS_MMC_RX_UDP_GD_PKTS_CNT_EN||DWC_EQOS_MMC_RX_UDP_ERR_PKTS_CNT_EN||DWC_EQOS_MMC_RX_TCP_GD_PKTS_CNT_EN||DWC_EQOS_MMC_RX_TCP_ERR_PKTS_CNT_EN||DWC_EQOS_MMC_RX_ICMP_GD_PKTS_CNT_EN||DWC_EQOS_MMC_RX_ICMP_ERR_PKTS_CNT_EN)
// Values:       0, 1
// 
// This is defined when at least one MMC IPC receive packet counter is selected.
`define DWC_EQOS_MMC_IPC_RX_PKTS_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_IPC_RX_EN_ATLEAST_ONE
// Default:      1 
//               (DWC_EQOS_MMC_IPC_RX_PKTS_ATLEAST_ONE||DWC_EQOS_MMC_IPC_RX_DGRAM_BCNT_ATLEAST_ONE||DWC_EQOS_MMC_IPC_RX_PAYLD_BCNT_ATLEAST_ONE)
// Values:       0, 1
// 
// This is defined when at least one MMC IPC receive counter is selected.
`define DWC_EQOS_MMC_IPC_RX_EN_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_PKTS_ATLEAST_ONE
// Default:      1 
//               (DWC_EQOS_MMC_TX_PKTS_ATLEAST_ONE||DWC_EQOS_MMC_RX_PKTS_ATLEAST_ONE||DWC_EQOS_MMC_IPC_RX_PKTS_ATLEAST_ONE)
// Values:       0, 1
// 
// This is defined when at least one MMC Packet counter is selected.
`define DWC_EQOS_MMC_PKTS_ATLEAST_ONE


// Name:         DWC_EQOS_MMC_BCNT_ATLEAST_ONE
// Default:      1 
//               
//               (DWC_EQOS_MMC_TX_BCNT_ATLEAST_ONE||DWC_EQOS_MMC_RX_BCNT_ATLEAST_ONE||DWC_EQOS_MMC_IPC_RX_DGRAM_BCNT_ATLEAST_ONE||DWC_EQOS_MMC_IPC_RX_PAYLD_BCNT_ATLEAST_ONE)
// Values:       0, 1
// 
// This is defined when at least one MMC Octet counter is selected.
`define DWC_EQOS_MMC_BCNT_ATLEAST_ONE


// Name:         DWC_EQOS_PMT_EN
// Default:      0
// Values:       0, 1
// 
// Enables the Power Management (PMT) block in the DWC_eqos core.
`define DWC_EQOS_PMT_EN


// Name:         DWC_EQOS_LP_MODE_EN
// Default:      1 (DWC_EQOS_PMT_EN)
// Values:       0, 1
// 
// Changes the architecture of DWC_eqos and adds Unified Power Format (UPF) constraints for the low-power mode support.
`define DWC_EQOS_LP_MODE_EN


// Name:         DWC_EQOS_PMT_MGK_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_PMT_EN
// 
// Enables the detection of a magic packet.
`define DWC_EQOS_PMT_MGK_EN


// Name:         DWC_EQOS_PMT_RWK_EN
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_PMT_EN
// 
// Enables the detection of a remote wake-up packet.
`define DWC_EQOS_PMT_RWK_EN


// Name:         DWC_EQOS_NUM_PMT_RWK_FILT
// Default:      4 (DWC_EQOS_PMT_RWK_EN ? 4 : 0)
// Values:       0 4 8 16
// Enabled:      DWC_EQOS_PMT_RWK_EN
// 
// Selects the number of remote wake-up packet filters.
`define DWC_EQOS_NUM_PMT_RWK_FILT 4


// Name:         DWC_EQOS_SYNC_PMT_RWK_FILT
// Default:      1 (DWC_EQOS_PMT_RWK_EN==1)
// Values:       0, 1
// Enabled:      DWC_EQOS_PMT_RWK_EN==1
// 
// Enables the synchronization of the PMT Remote Wake-Up Packet Filter Registers to the receive clock domain. Default is 
// direct usage.
`define DWC_EQOS_SYNC_PMT_RWK_FILT


// Name:         DWC_EQOS_PMT_RWK_CW
// Default:      3 (!DWC_EQOS_PMT_RWK_EN ? 1 : [<functionof> 
//               (log(DWC_EQOS_NUM_PMT_RWK_FILT*2)/log(2))])
// Values:       -2147483648, ..., 2147483647
// Enabled:      DWC_EQOS_PMT_RWK_EN
// 
// Selects the width of remote wake-up packet filters counter.
`define DWC_EQOS_PMT_RWK_CW 3


// Name:         DWC_EQOS_EEE_EN
// Default:      0
// Values:       0, 1
// Enabled:       
//               
//               DWC_EQOS_RTBI_INTF_ONLY&&!DWC_EQOS_TBI_INTF_ONLY&&!DWC_EQOS_SGMII_INTF_ONLY&&!DWC_EQOS_SMII_INTF_ONLY&&!DWC_EQOS_RMII_INTF_ONLY&&!DWC_EQOS_REVMII_INTF_ONLY
// 
// Adds Logic for supporting the Energy Efficient Ethernet (EEE).
`define DWC_EQOS_EEE_EN


// Name:         DWC_EQOS_ARP_EN
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables the IPv4 ARP Offload feature. In this mode, the DWC_eqos can process the ARP request packet in the receive path 
// and generate corresponding ARP response packet in the transmit path.
// `define DWC_EQOS_ARP_EN


// Name:         DWC_EQOS_SYNC_ARP_PROT_ADDR
// Default:      0
// Values:       0, 1
// Enabled:      0
// 
// Enables the synchronization of the ARP Protocol Address Register to the receive and transmit clock domain. Default is 
// direct usage.
// `define DWC_EQOS_SYNC_ARP_PROT_ADDR


`define DWC_EQOS_TXD_WIDTH 8


`define DWC_EQOS_RXD_WIDTH 8

// AXI Specific parameters


// Name:         DWC_EQOS_AXI_BL
// Default:      16
// Values:       16 32 64 128 256
// Enabled:      DWC_EQOS_SYS==4
// 
// Sets the maximum burst length allowed on the AXI bus.
`define DWC_EQOS_AXI_BL 16


// Name:         DWC_EQOS_BLW
// Default:      4 ([<functionof> (log(DWC_EQOS_AXI_BL)/log(2))])
// Values:       4, ..., 8
// Enabled:      DWC_EQOS_SYS==4
// 
// Supports Extended burst length on AXI.
`define DWC_EQOS_BLW 4


// Name:         DWC_EQOS_BL32
// Default:      0 (DWC_EQOS_AXI_BL > 16)
// Values:       0, 1
// 
// Indicates that maximum burst length selected on AXI is 32.
// `define DWC_EQOS_BL32


// Name:         DWC_EQOS_BL64
// Default:      0 (DWC_EQOS_AXI_BL > 32)
// Values:       0, 1
// 
// Indicates that maximum burst length selected on AXI is 64.
// `define DWC_EQOS_BL64


// Name:         DWC_EQOS_BL128
// Default:      0 (DWC_EQOS_AXI_BL > 64)
// Values:       0, 1
// 
// Indicates that maximum burst length selected on AXI is 128.
// `define DWC_EQOS_BL128


// Name:         DWC_EQOS_BL256
// Default:      0 (DWC_EQOS_AXI_BL > 128)
// Values:       0, 1
// 
// Indicates that maximum burst length selected on AXI is 256.
// `define DWC_EQOS_BL256


// Name:         DWC_EQOS_AXI_GM_AXI_ID_WIDTH
// Default:      4 (([<functionof> (DWC_EQOS_NUM_DMA_TX_CH > DWC_EQOS_NUM_DMA_RX_CH 
//               ? DWC_EQOS_NUM_DMA_TX_CH : DWC_EQOS_NUM_DMA_RX_CH)])>8 ? 5 : 4)
// Values:       1 2 3 4 5 6 7 8 9 10 11 12
// Enabled:      DWC_EQOS_SYS== 4
// 
// Sets the AXI Master bus ID width.
`define DWC_EQOS_AXI_GM_AXI_ID_WIDTH 8


// Name:         DWC_EQOS_GS_ID
// Default:      8
// Values:       2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
// Enabled:      DWC_EQOS_CSR_PORT == 3
// 
// Sets the AXI Slave bus ID width.
`define DWC_EQOS_GS_ID 8


// Name:         DWC_EQOS_AXI_GM_GM_ID_WIDTH
// Default:      2 ([<functionof> (DWC_EQOS_NUM_DMA_CSR_CH>4 ? 4 : 
//               ((DWC_EQOS_NUM_DMA_CSR_CH>2) ? 3 : ((DWC_EQOS_NUM_DMA_CSR_CH>1) ? 2 : 1)) )])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates the ID width on GM interface.
`define DWC_EQOS_AXI_GM_GM_ID_WIDTH 2


// Name:         DWC_EQOS_AXI_GM_STORE_AND_FORWARD
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==4
// 
// Indicates the selected burst length.
// `define DWC_EQOS_AXI_GM_STORE_AND_FORWARD


// Name:         DWC_EQOS_AXI_GM_WRITE_INTERLEAVING
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==4
// 
// Enables AXI Write Channel Data Enable Interleaving.
// `define DWC_EQOS_AXI_GM_WRITE_INTERLEAVING


// Name:         DWC_EQOS_AXI_GM_WRITE_REORDERING
// Default:      0
// Values:       0, 1
// Enabled:      DWC_EQOS_SYS==4
// 
// Enables reordering of AXI Write Channel requests.
// `define DWC_EQOS_AXI_GM_WRITE_REORDERING


// Name:         DWC_EQOS_AXI_GM_MAX_RD_REQUESTS
// Default:      4 (DWC_EQOS_NUM_DMA_CSR_CH<=2 ? 4 : DWC_EQOS_NUM_DMA_CSR_CH<=4 ? 8 
//               : DWC_EQOS_NUM_DMA_CSR_CH<=8 ? 16 : 32)
// Values:       4 8 16 32
// Enabled:      DWC_EQOS_SYS==4
// 
// Indicates maximun Outstanding Read requests on the AXI interface.
`define DWC_EQOS_AXI_GM_MAX_RD_REQUESTS 4


// Name:         DWC_EQOS_AXI_GM_MAX_WR_REQUESTS
// Default:      4 (DWC_EQOS_NUM_DMA_CSR_CH<=2 ? 4 : DWC_EQOS_NUM_DMA_CSR_CH<=4 ? 8 
//               : DWC_EQOS_NUM_DMA_CSR_CH<=8 ? 16 : 32)
// Values:       4 8 16 32
// Enabled:      DWC_EQOS_SYS==4
// 
// Indicates maximum Outstanding Write Requests on AXI interface.
`define DWC_EQOS_AXI_GM_MAX_WR_REQUESTS 4


// Name:         DWC_EQOS_ROSRLW
// Default:      2 ([<functionof> (log(DWC_EQOS_AXI_GM_MAX_RD_REQUESTS)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates width of Outstanding read request counter.
`define DWC_EQOS_ROSRLW 2


// Name:         DWC_EQOS_WOSRLW
// Default:      2 ([<functionof> (log(DWC_EQOS_AXI_GM_MAX_WR_REQUESTS)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates width of Outstanding write request counter.
`define DWC_EQOS_WOSRLW 2


// Name:         DWC_EQOS_BSA
// Default:      4 ([<functionof> (log(DWC_EQOS_DATAWIDTH/8)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates the selected burst length.
`define DWC_EQOS_BSA 4


// Name:         DWC_EQOS_CSR_BSA
// Default:      2 ([<functionof> (log(DWC_EQOS_CSR_DATAWIDTH/8)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates the selected burst length width of Slave.
`define DWC_EQOS_CSR_BSA 2


// Name:         DWC_EQOS_DMA_TX_CH0_EN
// Default:      1 (!DWC_EQOS_CORE&&!DWC_EQOS_MTL_SUBSYS)
// Values:       0, 1
// 
// DMA Transmit Channel 0 is Enabled
`define DWC_EQOS_DMA_TX_CH0_EN


// Name:         DWC_EQOS_DMA_TX_CH1_EN
// Default:      1 (DWC_EQOS_NUM_DMA_TX_CH>1)
// Values:       0, 1
// 
// DMA Transmit Channel 1 is enabled.
`define DWC_EQOS_DMA_TX_CH1_EN


// Name:         DWC_EQOS_DMA_TX_CH2_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TX_CH>2)
// Values:       0, 1
// 
// DMA Transmit Channel 2 is enabled.
// `define DWC_EQOS_DMA_TX_CH2_EN


// Name:         DWC_EQOS_DMA_TX_CH3_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TX_CH>3)
// Values:       0, 1
// 
// DMA Transmit Channel 3 is enabled.
// `define DWC_EQOS_DMA_TX_CH3_EN


// Name:         DWC_EQOS_DMA_TX_CH4_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TX_CH>4)
// Values:       0, 1
// 
// DMA Transmit Channel 4 is enabled.
// `define DWC_EQOS_DMA_TX_CH4_EN


// Name:         DWC_EQOS_DMA_TX_CH5_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TX_CH>5)
// Values:       0, 1
// 
// DMA Transmit Channel 5 is enabled.
// `define DWC_EQOS_DMA_TX_CH5_EN


// Name:         DWC_EQOS_DMA_TX_CH6_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TX_CH>6)
// Values:       0, 1
// 
// DMA Transmit Channel 6 is enabled.
// `define DWC_EQOS_DMA_TX_CH6_EN


// Name:         DWC_EQOS_DMA_TX_CH7_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TX_CH>7)
// Values:       0, 1
// 
// DMA Transmit Channel 7 is enabled.
// `define DWC_EQOS_DMA_TX_CH7_EN


// Name:         DWC_EQOS_DMA_RX_CH0_EN
// Default:      1 (!DWC_EQOS_CORE&&!DWC_EQOS_MTL_SUBSYS)
// Values:       0, 1
// 
// DMA Receive Channel 0 is Enabled
`define DWC_EQOS_DMA_RX_CH0_EN


// Name:         DWC_EQOS_DMA_RX_CH1_EN
// Default:      0 (DWC_EQOS_NUM_DMA_RX_CH>1)
// Values:       0, 1
// 
// DMA Receive Channel 1 is enabled.
// `define DWC_EQOS_DMA_RX_CH1_EN


// Name:         DWC_EQOS_DMA_RX_CH2_EN
// Default:      0 (DWC_EQOS_NUM_DMA_RX_CH>2)
// Values:       0, 1
// 
// DMA Receive Channel 2 is enabled.
// `define DWC_EQOS_DMA_RX_CH2_EN


// Name:         DWC_EQOS_DMA_RX_CH3_EN
// Default:      0 (DWC_EQOS_NUM_DMA_RX_CH>3)
// Values:       0, 1
// 
// DMA Receive Channel 3 is enabled.
// `define DWC_EQOS_DMA_RX_CH3_EN


// Name:         DWC_EQOS_DMA_RX_CH4_EN
// Default:      0 (DWC_EQOS_NUM_DMA_RX_CH>4)
// Values:       0, 1
// 
// DMA Receive Channel 4 is enabled.
// `define DWC_EQOS_DMA_RX_CH4_EN


// Name:         DWC_EQOS_DMA_RX_CH5_EN
// Default:      0 (DWC_EQOS_NUM_DMA_RX_CH>5)
// Values:       0, 1
// 
// DMA Receive Channel 5 is enabled.
// `define DWC_EQOS_DMA_RX_CH5_EN


// Name:         DWC_EQOS_DMA_RX_CH6_EN
// Default:      0 (DWC_EQOS_NUM_DMA_RX_CH>6)
// Values:       0, 1
// 
// DMA Receive Channel 6 is enabled.
// `define DWC_EQOS_DMA_RX_CH6_EN


// Name:         DWC_EQOS_DMA_RX_CH7_EN
// Default:      0 (DWC_EQOS_NUM_DMA_RX_CH>7)
// Values:       0, 1
// 
// DMA Receive Channel 7 is enabled.
// `define DWC_EQOS_DMA_RX_CH7_EN


// Name:         DWC_EQOS_DMA_TSO_CH0_EN
// Default:      0 (DWC_EQOS_TSO_EN)
// Values:       0, 1
// 
// DMA Transmit Channel 0 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH0_EN


// Name:         DWC_EQOS_DMA_TSO_CH1_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>1)
// Values:       0, 1
// 
// DMA Transmit Channel 1 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH1_EN


// Name:         DWC_EQOS_DMA_TSO_CH2_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>2)
// Values:       0, 1
// 
// DMA Transmit Channel 2 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH2_EN


// Name:         DWC_EQOS_DMA_TSO_CH3_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>3)
// Values:       0, 1
// 
// DMA Transmit Channel 3 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH3_EN


// Name:         DWC_EQOS_DMA_TSO_CH4_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>4)
// Values:       0, 1
// 
// DMA Transmit Channel 4 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH4_EN


// Name:         DWC_EQOS_DMA_TSO_CH5_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>5)
// Values:       0, 1
// 
// DMA Transmit Channel 5 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH5_EN


// Name:         DWC_EQOS_DMA_TSO_CH6_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>6)
// Values:       0, 1
// 
// DMA Transmit Channel 6 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH6_EN


// Name:         DWC_EQOS_DMA_TSO_CH7_EN
// Default:      0 (DWC_EQOS_NUM_DMA_TSO_CH>7)
// Values:       0, 1
// 
// DMA Transmit Channel 7 is enabled for TSO feature.
// `define DWC_EQOS_DMA_TSO_CH7_EN

// Existence parameter definitions for BCM modules


`define RM_BCM01 0


`define RM_BCM02 0


`define RM_BCM03 0


`define RM_BCM05 0


`define RM_BCM06 0


`define RM_BCM07 0


`define RM_BCM08 0


`define RM_BCM09 0


`define RM_BCM10 0


`define RM_BCM11 0


`define RM_BCM12 0


`define RM_BCM15 0


`define RM_BCM16 0


`define RM_BCM21 0


`define RM_BCM21_A 0


`define RM_BCM22 0


`define RM_BCM23 0


`define RM_BCM24 0


`define RM_BCM25 0


`define RM_BCM26 0


`define RM_BCM27 0


`define RM_BCM28 0


`define RM_BCM29 0


`define RM_BCM30 0


`define RM_BCM31 0


`define RM_BCM32 0


`define RM_BCM35 0


`define RM_BCM36 0


`define RM_BCM37 0


`define RM_BCM38 0


`define RM_BCM39 0


`define RM_BCM43 0


`define RM_BCM44 0


`define RM_BCM46_A 0


`define RM_BCM46_B 0


`define RM_BCM46_C 0


`define RM_BCM46_D 0


`define RM_BCM46_E 0


`define RM_BCM47 0


`define RM_BCM48 0


`define RM_BCM51 0


`define RM_BCM52 0


`define RM_BCM53 0


`define RM_BCM54 0


`define RM_BCM55 0


`define RM_BCM57 0


`define RM_BCM58 0


`define RM_BCM59 0


`define RM_BCM60 0


`define RM_BCM62 0


`define RM_BCM64 0


`define RM_BCM65 0


`define RM_BCM66 0


`define RM_BCM71 0


`define RM_BCM72 0


`define RM_BCM73 0


`define RM_BCM74 0


`define RM_BCM76 0


`define DWC_EQOS_MAX_QUEUE 8

// AXI Slave Specific parameters taken from DW_axi_gs module
// Made visisble false


// Name:         DWC_EQOS_GS_AXI_EX_ACCESS
// Default:      0
// Values:       0, ..., 16
// 
// Indicates maximum number of exclusive accesses supported in parallel. 
//  A value of 0 means exclusive accesses are not supported.
`define DWC_EQOS_GS_AXI_EX_ACCESS 0


// Name:         DWC_EQOS_GS_GIF_LITE
// Default:      0
// Values:       -2147483648, ..., 2147483647
// 
// Lite version of GIF. Supports devices with one-cycle data 
//  response and no flow control.
`define DWC_EQOS_GS_GIF_LITE 0


// Name:         DWC_EQOS_GS_BID_BUFFER
// Default:      1
// Values:       1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
// 
// Depth of BID buffer for outstanding GIF write requests. 
//  If set to 1, equivalent to blocking GIF write; current GIF write 
//  requests must complete (write response received from GIF Response 
//  Channel) before next AXI write request is accepted by DW_axi_gs. 
//  If greater than 1, AXI write IDs are allowed to be queued in BID 
//  buffer, while write request is transferred to GIF Request Channel 
//  before previous GIF writes responses are completed (up to the 
//  configured limit).
`define DWC_EQOS_GS_BID_BUFFER 1


// Name:         DWC_EQOS_GS_RID_BUFFER
// Default:      1
// Values:       1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
// 
// Depth of RID buffer for outstanding RID requests. 
//  If set to 1, equivalent to blocking GIF read; current GIF read request 
//  must complete (read response received form GIF response channel) before 
//  next AXI read request is accepted by DW_axi_gs. 
//  If greater than 1, AXI read IDs are allowed to be queued in RID buffer, 
//  while read request if transferred to GIF Request Channel before previous 
//  GIF reads responsese are completed (up to the configured limit).
`define DWC_EQOS_GS_RID_BUFFER 1


// Name:         DWC_EQOS_GS_DIRECT_GIF_READY
// Default:      true
// Values:       false (0), true (1)
// 
// If true, GIF saccept input is combinationally connected to AXI 
//  awready, wready, and arready outputs. 
//  If false, GIF saccept input is registered, inserting one cycle 
//  of latency.
`define DWC_EQOS_GS_DIRECT_GIF_READY 1


// Name:         DWC_EQOS_GS_REQ_BUFFER
// Default:      1
// Values:       1 2 3 4
// 
// Depth of combined read and write AXI request buffer. Higher values 
//  allow AXI requests to be bufffered, rather than stalled, if GIF 
//  request channel stalls DW_axi_gs transactions.
`define DWC_EQOS_GS_REQ_BUFFER 1


// Name:         DWC_EQOS_GS_WDATA_BUFFER
// Default:      1
// Values:       1 2 3 4
// 
// Depth of AXI write data buffer. Higher values allow AXI write data 
//  to be buffered, rather than stalled, if GIF request channel stalls 
//  DW_axi_gs transactions data.
`define DWC_EQOS_GS_WDATA_BUFFER 1

// See databook for side effect of DIRECT_AXI_READY
// and GIF_LITE both enabled with a slow GCLK.


// Name:         DWC_EQOS_GS_DIRECT_AXI_READY
// Default:      true
// Values:       false (0), true (1)
// 
// If true, AXI rready and bready inputs are combinationally connected to 
//  GIF mready outputs. 
//  If false, AXI rready and bready inputs are registered, inserting one 
//  cycle of latency.
`define DWC_EQOS_GS_DIRECT_AXI_READY 1


// Name:         DWC_EQOS_GS_RESP_BUFFER
// Default:      1
// Values:       1 2 3 4
// 
// Depth of GIF response buffer. Higher values allow GIF responses to be 
//  buffered, rather than stalled, if AXI read data or write response 
//  channel stall DW_axi_gs responses.
`define DWC_EQOS_GS_RESP_BUFFER 1

// AXI Interface specific Internal parameters (Not visible)


// Name:         DWC_EQOS_AXI_GM_REQUEST_PRIORITY
// Default:      1
// Values:       0, 1
// 
// Enables the handling of Priority Requests on GM.
`define DWC_EQOS_AXI_GM_REQUEST_PRIORITY


// Name:         DWC_EQOS_AXI_GM_ADDR_WIDTH
// Default:      32
// Values:       -2147483648, ..., 2147483647
// 
// Indicates the AXI bus Address width.
`define DWC_EQOS_AXI_GM_ADDR_WIDTH 32


// Name:         DWC_EQOS_AXI_GM_DATA_WIDTH
// Default:      128 (DWC_EQOS_DATAWIDTH)
// Values:       -2147483648, ..., 2147483647
// 
// Indicates the AXI bus Data width.
`define DWC_EQOS_AXI_GM_DATA_WIDTH 128


// Name:         DWC_EQOS_AXI_GM_DATA_WIDTH_64
// Default:      0 (DWC_EQOS_DATAWIDTH == 64)
// Values:       0, 1
// 
// Enables 64-bit data width for system interface.
// `define DWC_EQOS_AXI_GM_DATA_WIDTH_64


// Name:         DWC_EQOS_AXI_GM_DATA_WIDTH_128
// Default:      1 (DWC_EQOS_DATAWIDTH == 128)
// Values:       0, 1
// 
// Enables 128-bit data width for system interface.
`define DWC_EQOS_AXI_GM_DATA_WIDTH_128


// Name:         DWC_EQOS_AXI_GM_PER_ID_MAX_WR_REQUESTS
// Default:      2 ((DWC_EQOS_AXI_SUBSYS) ? ((DWC_EQOS_AXI_GM_MAX_WR_REQUESTS==4) ? 
//               2 : 
//               
//               ((DWC_EQOS_AXI_GM_MAX_WR_REQUESTS==8&&DWC_EQOS_AXI_GM_GM_ID_WIDTH>2)||(DWC_EQOS_AXI_GM_MAX_WR_REQUESTS==16&&DWC_EQOS_AXI_GM_GM_ID_WIDTH>3)) ? 2 : [<functionof> 
//               ((DWC_EQOS_AXI_GM_MAX_WR_REQUESTS)/pow(2,DWC_EQOS_AXI_GM_GM_ID_WIDTH))]) : 2)
// Values:       -2147483648, ..., 2147483647
// 
// Indicates maximun per ID Write Requests on AXI.
`define DWC_EQOS_AXI_GM_PER_ID_MAX_WR_REQUESTS 2


// Name:         DWC_EQOS_AXI_GM_WR_REQ_BUFFER
// Default:      2 ((DWC_EQOS_AXI_GM_REQUEST_PRIORITY) ? 2 : 1)
// Values:       (DWC_EQOS_AXI_GM_REQUEST_PRIORITY) ? 2 : 1, ..., 16
// 
// Indicates GM Commmand buffer depth.
`define DWC_EQOS_AXI_GM_WR_REQ_BUFFER 2


// Name:         DWC_EQOS_WR_REQUEST_BUFFER_PRESENT
// Default:      0 ((DWC_EQOS_AXI_GM_REQUEST_PRIORITY && 
//               DWC_EQOS_AXI_GM_WR_REQ_BUFFER > 2) ? 1 : (!DWC_EQOS_AXI_GM_REQUEST_PRIORITY && 
//               DWC_EQOS_AXI_GM_WR_REQ_BUFFER > 1) ? 1 : 0)
// Values:       0, 1
// 
// Indicates whether Command buffer is present or not.
// `define DWC_EQOS_WR_REQUEST_BUFFER_PRESENT


// Name:         DWC_EQOS_AXI_GM_WDATA_BUFFER
// Default:      2
// Values:       1, ..., 256
// 
// Indicates Data buffer depth.
`define DWC_EQOS_AXI_GM_WDATA_BUFFER 2


// Name:         DWC_EQOS_AXI_GM_WRESP_BUFFER
// Default:      2
// Values:       1, ..., 256
// 
// Indicates Response buffer depth.
`define DWC_EQOS_AXI_GM_WRESP_BUFFER 2

// Design Specific parameters on Read Interface


// Name:         DWC_EQOS_AXI_GM_PER_ID_MAX_RD_REQUESTS
// Default:      2 ((DWC_EQOS_AXI_SUBSYS) ? ((DWC_EQOS_AXI_GM_MAX_RD_REQUESTS==4) ? 
//               2 : 
//               
//               ((DWC_EQOS_AXI_GM_MAX_RD_REQUESTS==8&&DWC_EQOS_AXI_GM_GM_ID_WIDTH>2)||(DWC_EQOS_AXI_GM_MAX_RD_REQUESTS==16&&DWC_EQOS_AXI_GM_GM_ID_WIDTH>3)) ? 2 : [<functionof> 
//               ((DWC_EQOS_AXI_GM_MAX_RD_REQUESTS)/pow(2,DWC_EQOS_AXI_GM_GM_ID_WIDTH))]) : 2)
// Values:       -2147483648, ..., 2147483647
// 
// Indicates maximum per ID Read Requests on AXI.
`define DWC_EQOS_AXI_GM_PER_ID_MAX_RD_REQUESTS 2


// Name:         DWC_EQOS_AXI_GM_RD_REQ_BUFFER
// Default:      2 ((DWC_EQOS_AXI_GM_REQUEST_PRIORITY) ? 2 : 1)
// Values:       (DWC_EQOS_AXI_GM_REQUEST_PRIORITY) ? 2 : 1, ..., 16
// 
// Indicates GM Commmand buffer depth.
`define DWC_EQOS_AXI_GM_RD_REQ_BUFFER 2


// Name:         DWC_EQOS_RD_REQUEST_BUFFER_PRESENT
// Default:      0 ((DWC_EQOS_AXI_GM_REQUEST_PRIORITY && 
//               DWC_EQOS_AXI_GM_RD_REQ_BUFFER > 2) ? 1 : (!DWC_EQOS_AXI_GM_REQUEST_PRIORITY && 
//               DWC_EQOS_AXI_GM_RD_REQ_BUFFER > 1) ? 1 : 0)
// Values:       0, 1
// 
// Indicates whether Command buffer is present or not.
// `define DWC_EQOS_RD_REQUEST_BUFFER_PRESENT


`define DWC_EQOS_PAD_ZEROS 1

// Derived Parameters


`define DWC_EQOS_TOT_IDS 4


// Name:         DWC_EQOS_STRW
// Default:      16 ([<functionof> (pow(2,DWC_EQOS_BSA))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates Write Strobes width.
`define DWC_EQOS_STRW 16


// Name:         DWC_EQOS_CSR_STRW
// Default:      4 ([<functionof> (pow(2,DWC_EQOS_CSR_BSA))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates Write Strobes width of Slave.
`define DWC_EQOS_CSR_STRW 4


// Name:         DWC_EQOS_WTOT_CMDS
// Default:      8 ([<functionof> 
//               (DWC_EQOS_AXI_GM_PER_ID_MAX_WR_REQUESTS*DWC_EQOS_TOT_IDS)])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates Total Write commands.
`define DWC_EQOS_WTOT_CMDS 8


// Name:         DWC_EQOS_WLBCW
// Default:      2 ([<functionof> (log(DWC_EQOS_AXI_GM_WDATA_BUFFER)/log(2))+1])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates width of the L bit counter of Data buffer.
`define DWC_EQOS_WLBCW 2


// Name:         DWC_EQOS_WOSRCW
// Default:      3 ([<functionof> (log(DWC_EQOS_AXI_GM_MAX_WR_REQUESTS)/log(2))+1])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates width of Outstanding write request counter.
`define DWC_EQOS_WOSRCW 3


// Name:         DWC_EQOS_WCMN_CPTRW
// Default:      3 ([<functionof> (log(DWC_EQOS_WTOT_CMDS)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates width of Command command pointer (write).
`define DWC_EQOS_WCMN_CPTRW 3


// Name:         DWC_EQOS_WPID_CPTRW
// Default:      1 ( (DWC_EQOS_AXI_GM_PER_ID_MAX_WR_REQUESTS ==1) ? 1 : 
//               [<functionof> (log(DWC_EQOS_AXI_GM_PER_ID_MAX_WR_REQUESTS)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates width of per ID command pointer (Write).
`define DWC_EQOS_WPID_CPTRW 1


// Name:         DWC_EQOS_RTOT_CMDS
// Default:      8 ([<functionof> 
//               (DWC_EQOS_AXI_GM_PER_ID_MAX_RD_REQUESTS*DWC_EQOS_TOT_IDS)])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates total commands (Read).
`define DWC_EQOS_RTOT_CMDS 8


// Name:         DWC_EQOS_ROSRCW
// Default:      3 ([<functionof> (log(DWC_EQOS_AXI_GM_MAX_RD_REQUESTS)/log(2))+1])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates width of the Outstanding request count.
`define DWC_EQOS_ROSRCW 3


// Name:         DWC_EQOS_RCMN_CPTRW
// Default:      3 ([<functionof> (log(DWC_EQOS_RTOT_CMDS)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates Common Command pointer Width (Read).
`define DWC_EQOS_RCMN_CPTRW 3


// Name:         DWC_EQOS_RPID_CPTRW
// Default:      1 ( (DWC_EQOS_AXI_GM_PER_ID_MAX_RD_REQUESTS==1) ? 1 : [<functionof> 
//               (log(DWC_EQOS_AXI_GM_PER_ID_MAX_RD_REQUESTS)/log(2))])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates the per ID Command pointer width (read).
`define DWC_EQOS_RPID_CPTRW 1


// Name:         DWC_EQOS_IO_DRQW
// Default:      17 ((DWC_EQOS_AXI_GM_WRITE_INTERLEAVING) ? [<functionof> 
//               (DWC_EQOS_BSA+DWC_EQOS_BSA+DWC_EQOS_BLW+DWC_EQOS_AXI_GM_GM_ID_WIDTH+4)] :  
//               [<functionof> 
//               (DWC_EQOS_BSA+DWC_EQOS_BSA+DWC_EQOS_BLW+DWC_EQOS_AXI_GM_GM_ID_WIDTH+3)])
// Values:       -2147483648, ..., 2147483647
// 
// Indicates In-Order FIFO Depth.
`define DWC_EQOS_IO_DRQW 17


// Name:         DWC_EQOS_NUM_RX_CH_EFF
// Default:      1 ((DWC_EQOS_MTL_SUBSYS) ? DWC_EQOS_NUM_RXQ : 
//               DWC_EQOS_NUM_DMA_RX_CH)
// Values:       -2147483648, ..., 2147483647
// 
// Consolidated Number of Channels
`define DWC_EQOS_NUM_RX_CH_EFF 1


// Name:         DWC_EQOS_ATI_CTL_WIDTH
// Default:      1 
//               ((DWC_EQOS_DATAWIDTH==32&&DWC_EQOS_SA_VLAN_INS_CTRL_EN&&(DWC_EQOS_OST_EN)) ? 2 : (DWC_EQOS_DATAWIDTH==32&&DWC_EQOS_OST_EN) ? 2 : 
//               (DWC_EQOS_DATAWIDTH==32&&DWC_EQOS_SA_VLAN_INS_CTRL_EN) ? 1 : 
//               (DWC_EQOS_DATAWIDTH==64&&(DWC_EQOS_OST_EN)) ? 1 : 1)
// Values:       -2147483648, ..., 2147483647
// 
// Specifies the width of ati_ctrl_i signal.
`define DWC_EQOS_ATI_CTL_WIDTH 1


// Name:         DWC_EQOS_ATI_CTL_TYPE_PRESENT
// Default:      0 
//               
//               (((DWC_EQOS_DATAWIDTH==32&&(DWC_EQOS_SA_VLAN_INS_CTRL_EN||DWC_EQOS_OST_EN))||(DWC_EQOS_DATAWIDTH==64&&(DWC_EQOS_OST_EN)))&&DWC_EQOS_MTL_SUBSYS)
// Values:       0, 1
// 
// Specifies the width of ati_ctrl_i signal.
// `define DWC_EQOS_ATI_CTL_TYPE_PRESENT


// Name:         DWC_EQOS_AHM_BUSY_EN
// Default:      0 (DWC_EQOS_AHB_SUBSYS&&DWC_EQOS_TX_COE)
// Values:       0, 1
// 
// Enable BUSY feature support in AHB Master
// `define DWC_EQOS_AHM_BUSY_EN


// Name:         DWC_EQOS_RCVTHRW
// Default:      6 
//               ((!DWC_EQOS_MTL_SUBSYS&&(DWC_EQOS_SPLIT_HDR_EN||DWC_EQOS_NUM_DMA_RX_CH>1)) ? 7 : 6)
// Values:       -2147483648, ..., 2147483647
// 
// Specifies the width of rcv_thrshld signal.
`define DWC_EQOS_RCVTHRW 6
