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

//---------------------------------------------------------------------------//
// $Id: //dwh/ethernet_iip/dev/ETHER_QOS_4_00A/src/top/DWC_ether_qos.v#146 $
// Release version :  4.00a
// Date             :        $Date: 2013/10/08 $
// File Version     :        $Revision: #146 $
//--                                                                        
//--------------------------------------------------------------------------
// MODULE:                                                                   //
// ETHER QOS TOP LEVEL MODULE (DWC_ether_qos.v)                              //
//                                                                           //
// DESCRIPTION:                                                              //
// ETHER QOS subsystem enables the host to transmit and receive data over    //
// Ethernet in compliance with the IEEE 802.3-2002 standard. The ETHER QOS   //
// subsystem can be configured to include the following system interfaces.   //
// 1.ETHER QOS Subsystem with AXI Interface.                                 //
//   Constituent Blocks- AXI Bus Interface Unit,                             //
//                       DMA Unit,                                           // 
//                       MAC Transaction Layer,                              // 
//                       MAC Controller.                                     //
//                                                                           //
//---------------------------------------------------------------------------//

module DWC_ether_qos (

  // Input clocks and reset
        clk_tx_i,
                      clk_rx_i,
                      clk_csr_i,
                      clk_tx_125_i,
                      clk_rmii_i,
                      clk_rx_125_i,
                      clk_tx_180_i,
                      clk_rx_180_i,
                      clk_ptp_ref_i,
                      rst_clk_tx_n_o,
                      rst_clk_rx_n_o,
                      rst_clk_app_n_o,
                      mac_speed_o,
                      sgmii_link_speed_o,
                      // Test Mode Enable Port
                      test_mode, 
                      lpi_intr_o,
                      sbd_tx_clk_gating_ctrl_o,
                      pwr_isolate_i,
                      pwr_clamp_ctrl_i,
                      pwr_down_ctrl_i,
                      phy_intf_sel_i,
                      // MII Management Interface
                      gmii_mdc_o,
                      gmii_mdi_i,
                      gmii_mdo_o,
                      gmii_mdo_o_e,
                      phy_intr_i,
                      // GMAC AXI subsystem
                      // AXI Master Write Control Channel
                      aclk_i,
                      aresetn_i,
                      awaddr_m_o,
                      awlen_m_o,
                      awid_m_o,
                      awburst_m_o,
                      awvalid_m_o,
                      awready_m_i,
                      awsize_m_o,
                      awlock_m_o,
                      awcache_m_o,
                      awprot_m_o,
                      // AXI Master Write Data Channel
                      wid_m_o,
                      wdata_m_o,
                      wstrb_m_o,
                      wlast_m_o,
                      wvalid_m_o,
                      wready_m_i,
                      // AXI Master Write Response Channel
                      bid_m_i,
                      bresp_m_i,
                      bvalid_m_i,
                      bready_m_o,
                      // AXI Master Read Control Channel
                      araddr_m_o,
                      arlen_m_o,
                      arid_m_o,
                      arburst_m_o,
                      arvalid_m_o,
                      arready_m_i,
                      arsize_m_o,
                      arlock_m_o,
                      arcache_m_o,
                      arprot_m_o,
                      // AXI Master Read Response Channel
                      rid_m_i,
                      rresp_m_i,
                      rdata_m_i,
                      rlast_m_i,
                      rvalid_m_i,
                      rready_m_o,
                      csysreq_i,
                      csysack_o,
                      cactive_o,
                      // Inputs from the APB.
                      psel_i,
                      paddr_i,
                      pwrite_i,
                      pwdata_i,
                      penable_i,
                      // Outputs to the APB bus.
                      prdata_o,
                      pready_o,
                      sbd_intr_o,
                      twc_wr_addr_o,
                      twc_wr_csn_o,
                      twc_wr_data_o,
                      twc_wr_en_o,
                      trc_rd_addr_o,
                      trc_rd_csn_o,
                      trc_rd_data_i,
                      trc_rd_en_o,
                      rwc_wr_addr_o,
                      rwc_wr_csn_o,
                      rwc_wr_data_o,
                      rwc_wr_en_o,
                      rrc_rd_addr_o,
                      rrc_rd_data_i,
                      rrc_rd_csn_o,
                      rrc_rd_en_o,
                      ptp_timestamp_i,
                      ptp_timestamp_o,
                      ptp_pps_o,
                      ptp_aux_ts_trig_i,
                      sbd_pwr_down_ack_o, 
                      pmt_intr_o,
                      pcs_acquired_sync_o,
                      pcs_ewrap_o,
                      pcs_en_cdet_o,
                      pcs_lck_ref_o,
                      phy_txen_o,
                      phy_txer_o,
                      phy_txd_o,
                      phy_crs_i,
                      phy_col_i,
                      phy_rxdv_i,
                      phy_rxer_i,
                      phy_rxd_i
                      );

  localparam  MAX_RX_FRM = `DWC_EQOS_RXFIFO_SIZE/16;
  localparam  RFCW       = MAX_RX_FRM <= 2? 1     : MAX_RX_FRM <= 4? 2      : MAX_RX_FRM <= 8? 3       : MAX_RX_FRM <= 16? 4     :
                           MAX_RX_FRM <= 32? 5    : MAX_RX_FRM <= 64? 6     : MAX_RX_FRM <= 128? 7     : MAX_RX_FRM <= 256? 8    :
                           MAX_RX_FRM <= 512? 9   : MAX_RX_FRM <= 1024? 10  : MAX_RX_FRM <= 2048? 11   : MAX_RX_FRM <= 4096? 12  :
                           MAX_RX_FRM <= 8192? 13 : MAX_RX_FRM <= 16384? 14 : 15;
  localparam  QNUMW      = `DWC_EQOS_NUM_RXQ <= 2 ? 1 : `DWC_EQOS_NUM_RXQ <= 4 ? 2 : 3;
  
  // Input clocks and reset
  input                      clk_tx_i;                // GMII/MII transmit reference clock (2.5/25/125)Mhz.
  input                      clk_rx_i;                // GMII/MII receive clock from PHY (2.5/25/125)mhz.
  input                      clk_csr_i;               // CSR clock input. 
  input                      clk_tx_125_i;            // PCS transmit reference clock (125)MHz.
  input                      clk_rmii_i;              // RMII reference clock(50Mhz).
  input                      clk_rx_125_i;            // PCS receive reference clock 125 Mhz.
  input                      clk_tx_180_i;            // 180 phase shifted clk_tx_i.
  input                      clk_rx_180_i;            // 180 phase shifter clk_rx_i.
  input                      clk_ptp_ref_i;           // PTP reference clock


  output                     rst_clk_tx_n_o;          // Active low reset synchronous to TX clock
  output                     rst_clk_rx_n_o;          // Active low reset synchronous to RX clock
  output                     rst_clk_app_n_o;         // Active low reset synchronous to APP clock

  output [1:0]               mac_speed_o;             // Speed select output for MAC
  output [1:0]               sgmii_link_speed_o;      // 00 - 10 Mbps, 01 - 100Mbps, 10 - 1000Mbps.
  input                      test_mode;               // Controlling reset signal during TEST 
  output                     lpi_intr_o;     // LPI Rx exit interrupt output
  output                     sbd_tx_clk_gating_ctrl_o; // TX Clock gating control
//leda NTL_CON13C off
//LMD: non driving port 
//LJ: the signal is being used in the UPF flow ; need not be used internally
//LJ: hence the rule is turned off 
//leda NTL_CON37 off
//LMD: signal/net must read from the input in module 
//LJ: the signal is being used in UPF flow, need not be used internally
//LJ: hence turned the rule off 
  input                      pwr_isolate_i;      // Control input for clamping of isolation cells
//leda NTL_CON37 on  
//leda NTL_CON13C on  
//leda NTL_CON13C off
//LMD: non driving port 
//LJ: the signal is being connected to the control inputs of the UPF cells,
//LJ: during the UPF flow synthesis and need not be driving in the module
//LJ: hence the rule is turned off 
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module
//LJ: the signal is being connected to the control inputs of the UPF cells,
//LJ: during the UPF flow synthesis and need not be read in the module 
//LJ: hence turned the rule off 
  input                      pwr_clamp_ctrl_i;        // Control input for clamping of reset signals 
//leda NTL_CON37 on  
//leda NTL_CON13C on  
//leda NTL_CON13C off
//LMD: non driving port 
//LJ: the signal is being used in the UPF flow ; need not be used internally
//LJ: hence the rule is turned off 
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module
//LJ: the signal is being used in UPF flow, need not be used internally
//LJ: hence turned the rule off 
  input                      pwr_down_ctrl_i; // Control the VDD power down
//leda NTL_CON37 on  
//leda NTL_CON13C on  

  input  [2:0]               phy_intf_sel_i;          // signal used to select one among various 
                                                      // PHY Interface available 
                                                      // for GMAC. This is sampled only when 
                                                      // rst_clk_tx_n is active low
                                                      // 000-GMII/MII,001-RGMII,010-SGMII,
                                                      // 011-TBI, 100-RMII, 101-RTBI, 110-SMII.


  output                     gmii_mdc_o;              // GMII/MII management clock.
  input                      gmii_mdi_i;              // GMII/MII mgmt data input. 
  output                     gmii_mdo_o;              // GMII/MII mgmt data output.
  output                     gmii_mdo_o_e;            // GMII/MII mgmt data o/p enable.
  input                      phy_intr_i;              // PHY Interrupt

// MAC Control Interface(MCI)
                                                      // data of CSR access.
//leda NTL_CON13C off
//LMD: non driving port 
//LJ: bits of the signal are read based on the configuration
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module
//LJ: bits of the signal are read based on the configuration
//leda NTL_CON37 on
//leda NTL_CON13C on

  // DMA Interface 

                                               // 1 - use fixed-bursts (INCR4/8/16); 0 = use INCR
  output                    sbd_intr_o; //Interrupt signal to host system
  



  output [`DWC_EQOS_TX_FIFO_PTR_WIDTH-1:0]twc_wr_addr_o; // Transmit memory write address 
  output                                  twc_wr_csn_o;  // Transmit memory write chip select
  output [`DWC_EQOS_MEMW-1:0]             twc_wr_data_o; // Transmit memory write data
  output                                  twc_wr_en_o;   // Transmit memory write enable

  output [`DWC_EQOS_TX_FIFO_PTR_WIDTH-1:0]trc_rd_addr_o; // Transmit memory read address 
  output                                  trc_rd_csn_o;  // Transmit memory read chip select
  input [`DWC_EQOS_MEMW-1:0]              trc_rd_data_i; // Transmit memory read data
  output                                  trc_rd_en_o;   // Transmit memory read enable

  output [`DWC_EQOS_RX_FIFO_PTR_WIDTH-1:0]rwc_wr_addr_o; // Receive memory write address    
  output                                  rwc_wr_csn_o;  // Receive memory write chip select 
  output [`DWC_EQOS_MEMW-1:0]             rwc_wr_data_o; // Receive memory write data       
  output                                  rwc_wr_en_o;   // Receive memory write enable

  output [`DWC_EQOS_RX_FIFO_PTR_WIDTH-1:0]rrc_rd_addr_o; // Receive memory read address     
  output                                  rrc_rd_csn_o;  // Receive memory read chip select
  input  [`DWC_EQOS_MEMW-1:0]             rrc_rd_data_i; // Receive memory read data
  output                                  rrc_rd_en_o;   // Receive memory read enable


  
                                                // frame or activate backpressure.
  
//leda NTL_CON13C off
//LMD: non driving port 
//LJ: the time stamp feature requires 64 bit data width as per the standard
//LJ: hence turning of the rule;even if all the bits are not driving 
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module
//LJ: time stamp feature by standard requires 64 bit data width;
//LJ: hence following the standard;leaving the width at 64 bits; 
//LJ: hence turning of the rule;even if all the bits are not read 
//leda NTL_CON37 on
//leda NTL_CON13C on  


  input  [`DWC_EQOS_AUX_SNAP_IN_NUM-1:0] ptp_aux_ts_trig_i; // External Trigger for auxiliary snapshot
  input  [63:0]              ptp_timestamp_i;  // External timestamp input sync to clk_ptp_ref_i 
  output [63:0]              ptp_timestamp_o;  // External timestamp output sync to clk_ptp_ref_i
  output [`DWC_EQOS_PPSOW-1:0] ptp_pps_o;         // PPS Output

  output                     sbd_pwr_down_ack_o;      // Ack to indicate start of power down sequence
  output                     pmt_intr_o;              // Interrupt from PMT



  output                     pcs_acquired_sync_o;   // Signal asserted when synchronization is acquired
  output                     pcs_ewrap_o;           // Enable Loopback of serialised data in PMA
  output                     pcs_en_cdet_o;         // Enable Comma Detect
  output                     pcs_lck_ref_o;         // Signal requesting clock recovery unit
                                                    // to lock to PMA received clock

  output                     phy_txen_o;             // Transmit data Enable - GMII/RGMII/RMII, 
                                                     // 9th bit of trasnmit code group - TBI/SGMII.
                                                     // SYNC (TXSYNC in Source Sync Mode) signal - SMII.
  output                     phy_txer_o;             // Transmit Error - GMII.
                                                     // 10th bit of transmit code group - TBI/SGMII
                                         
  output [`DWC_EQOS_TXD_IOW-1:0] phy_txd_o;          // Transmit Data[7:0] - GMII/TBI/SGMII
                                                     // Transmit Data[3:0] - RGMII/RTBI/MII.
                                                     // Transmit Data[1:0] - RMII.
                                                     // Transmit Data[0]   - SMII.
  
  input                      phy_rxdv_i;             // Receive data valid signal - GMII/MII.
                                                     // 9th bit of receive code group - TBI/SGMII.
                                                     // rctl     - RGMII
                                                     // crs_dv   - RMII
                                                     // Source Sync Mode RXSYNC signal - SMII.
  input                      phy_rxer_i;             // Receive error-GMII/MII.
                                                     // 10th bit of receive code group - TBI/SGMII.
  
  input  [`DWC_EQOS_RXD_IOW-1:0]  phy_rxd_i;         // Receive Data [7:0] in GMII/TBI/SGMII.
                                                     // Receive Data [3:0] in RGMII/RTBI/MII.
                                                     // Receive Data [1:0] in RMII.
                                                     // Receive Data [0] in SMII.
  input                      phy_crs_i;              // Carrier Sense in GMII/MII
  input                      phy_col_i;              // Collision Detect in GMII/MII.
  
// AXI Clock and Reset
  input             aclk_i;           // AXI Clock
  input             aresetn_i;        // AXI Reset Active Low

// AXI Master Write Control Channel
  output [`DWC_EQOS_AW-1:0] awaddr_m_o; // AXI Master wirte control channel's address
  output [`DWC_EQOS_BLW-1:0] awlen_m_o; // AXI Master wirte control channel's burst length 
  output [`DWC_EQOS_AXI_IDW-1:0] awid_m_o; // AXI Master write control channle's ID
  output [1:0]      awburst_m_o;       // AXI Master write control channel's burst type
                                       // 00-FIXED 01-INCR 10-WRAP 11-Reserved
  output            awvalid_m_o;       // AXI Master write control channel's valid
  input             awready_m_i;       // AXI Master write control channel's ready
  output [2:0]      awsize_m_o;        // AXI Master write control channel's transfer size
  output [1:0]      awlock_m_o;        // AXI Master write control channel's locked access indicator H/W to zero
  output [3:0]      awcache_m_o;       // AXI Master write control channel's cache type H/W to zero
  output [2:0]      awprot_m_o;        // AXI Master write control channel's protection control H/W to zero

// AXI Master Write Data Channel
  output [`DWC_EQOS_AXI_IDW-1:0] wid_m_o;// AXI Master write data channel's channel ID
  output [`DWC_EQOS_DATW-1:0] wdata_m_o;// AXI Master write data channel's write data bus
  output [`DWC_EQOS_STRW-1:0] wstrb_m_o;// AXI Master write data channel's write strobe
  output             wlast_m_o;        // AXI Master write data channel's Last data of the burst
  output             wvalid_m_o;       // AXI Master write data channel's data Valid
  input              wready_m_i;       // AXI Master write data channel's slave Ready
  
// AXI Master Write Response Channel
  input [`DWC_EQOS_AXI_IDW-1:0]   bid_m_i;        // AXI Master Write Response ID
  input [1:0]        bresp_m_i;        // AXI Master Response channle's Resposne
                                       // 00-OK 01-EXOK 10-SLVERR 11-DECERR
  input              bvalid_m_i;       // AXI Master Responce Valid
  output             bready_m_o;       // AXI Master Responce accept handshake to Slave

// AXI Master Read Control channel
  output [`DWC_EQOS_AW-1:0] araddr_m_o; // AXI Master read control channel's address
  output [`DWC_EQOS_BLW-1:0] arlen_m_o; // AXI Master read control channel's burst length
  output [`DWC_EQOS_AXI_IDW-1:0] arid_m_o; // AXI Master read control channel's ID
  output [1:0]       arburst_m_o;      // AXI Master read control channel's burst type
                                       // 00-FIXED 01-INCR 10-WRAP 11-Reserved
  output             arvalid_m_o;      // AXI Master read control channel's valid
  input              arready_m_i;      // AXI Master read control channel's ready
  output [2:0]       arsize_m_o;       // AXI Master read control channel's transfer size
  output [1:0]       arlock_m_o;       // AXI Master read control channel's locked access indicator H/W to zero
  output [3:0]       arcache_m_o;      // AXI Master read control channel's cache type H/W to zero
  output [2:0]       arprot_m_o;       // AXI Master read control channel's protection control H/W to zero
  
// AXI Master Read Response/Data channel
  input [`DWC_EQOS_AXI_IDW-1:0] rid_m_i;
  input [1:0]        rresp_m_i;       // AXI Master Read Data/Response Channel's Response
                                      // 00-OK 01-EXOK 10-SLVERR 11-DECERR
  input [`DWC_EQOS_DATW-1:0]  rdata_m_i;// AXI Master Read Data/Response Channel's read data
  input              rvalid_m_i;      // AXI Master Read Data/Response Channel's data valid
  input              rlast_m_i;       // AXI Master Read Data/Response Channel's last burst data
  output             rready_m_o;      // AXI Master Read Data/Response Channel's Ready handshake
  
// Low Power Interface
  input               csysreq_i;   // System Low Power Request
  output              csysack_o;   // Peripheral low power request acknowledgement
  output              cactive_o;   // Peripheral Clock active

//these two inputs are not being used ;hence the rule checking is removed
//leda NTL_CON13C off
//LMD: non driving port
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module 
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON37 on
//leda NTL_CON13C on
        

//this input is not being used at all; hence the rules indicating it are being removed 
//leda NTL_CON13C off
//LMD: non driving port
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module 
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON37 on
//leda NTL_CON13C on
//this input is not being used at all; hence the rules indicating it are being removed 
//leda NTL_CON13C off
//LMD: non driving port
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module 
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON37 on
//leda NTL_CON13C on
      
        
//these two ports are not being used at all;hence the rule is being turned off 
//leda NTL_CON37 off  
//LMD: signal/net must read from the input port in module 
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON13C off  
//LMD: non driving port
//LJ: input is not being used. reserved for further expansion
//leda NTL_CON13C on  
//leda NTL_CON37 on  
      




    
                                  
//this signal is just an input and is not being used in this module, so leda check has been turned off
//leda NTL_CON32 off
//LMD: change on net has no effect on any of the outputs
//LJ: port is not used, could be used in expansion
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in module 
//LJ: port is not used, could be used in expansion. 
//leda NTL_CON13C off
//LMD: non driving port
//LJ: port is not used, could be used in expansion. 
//leda NTL_CON13C on
//leda NTL_CON37 on
//leda NTL_CON32 on

       
 // Outputs to the AHB bus.

  input                  psel_i;       // APB SELECT
  input  [13:0]          paddr_i;      // APB PORT ADDRESS
  input                  pwrite_i;     // APB WRITE
  input  [31:0]          pwdata_i;     // APB WRITE DATA
//leda NTL_CON13C off
//LMD: non driving port
//LJ: the input port is not driving when the APB3 slave is enabled
//LJ: the input is not being used; but needs to be defined as per the protocol
//LJ: hence turned the rule off
//leda NTL_CON37 off
//LMD: signal/net must read from the input port in the module
//LJ: the input is not being read when APB3 slave is enabled
//LJ: but the port needs to be defined as per the protocol 
//LJ: hence turned the rule off
  input                  penable_i;    // APB ENABLE - NOT USED in APB3 IF
//leda NTL_CON13C on
//leda NTL_CON37 on
  output [31:0]          prdata_o;     // APB Read data 
  output                 pready_o;     // APB Ready/acknowledge 
  wire [`DWC_EQOS_PPSOW-1:0] ptp_pps_o;// PPS Output

  wire   [`DWC_EQOS_MAC_CFG_REGW-1:0] cr_reg0; // Configuration register signals.
  wire                   cr_reg193_wr; // MAC Address0 Low reg 
                                       // byte0 write pulse - Big endian
                                       // byte3 write pulse - Little endian
  wire   [`DWC_EQOS_MARW-9:0] cr_macaddr0; // 1st MAC address of GMAC.

 wire                    sc2rpa_lpi_reg_read;   // Indicates read operation to LPI reg.
 wire                    rrpe_lpi_rcvd_sw;      // indicates SW domain RPE FSM is in the LPI state
 wire                    rrpe_lpi_rcvd;         // indicates RPE FSM is in the LPI state
 wire                    rrpe_lpi_intr_sw;      // SW domain LPI interrupt output
 wire                    lpi_intr_o;            // LPI interrupt output
 wire                       pmt_intr_status;         // PMT interrupt status from PMT block
   
 wire                       gmii_txen;                // GMII TXEN
 wire                       gmii_txer;                // GMII TXER
 wire   [`DWC_EQOS_TXD_WIDTH-1:0] gmii_txd;           // GMII TXD

 wire                       sc2td_link_up;           // 0 -> Link Down, 1 -> Link Up
 wire                       sc2tdu_speed;            // 0 -> 10BASE, 1 -> 100BASE
 wire                       sc2tdu_duplexmode;       // 0 -> Half Duplex, 1 -> Full Duplex

 wire                       sc2td_tx_config;        // 1 -> transmit status in between TX frames
                                                     // 0 -> Do not transmit status in between TX frames
 wire                       sc2tdu_portselect;       // mac_portselect signal sync'd to clk_tx_i.

 wire                       gmii_mdo_o;              // GMII/MII mgmt data output.
 wire                       gmii_mdo_o_e;            // GMII/MII mgmt data o/p enable.
 wire   [1:0]               mac_speed_o;             // Speed select output for MAC
 wire                       sma_mdo_o;               // Serial MDIO Data Output from SMA        
 wire                       sma_mdo_en_o;            // Serial MDIO Output Data Enable from SMA

 wire   [2:0]               phy_select;              // Muxed output of phy_intf_sel_i 
 wire                       sc2rd_ipchksum_en;       // IP checksum enable sync'd to Rx clock.
 wire                       sc2rd_jumboframe_en;     // max upto 9000(9018) byte frames
 wire                       sc2rd_receive_en;        // Enabling the receive FSM.
 wire                       sc2rd_disreceiveown;     // Disable reception of frames  
                                                     // when gmii_txen_o is asserted.
 wire                       sc2rd_duplexmode;        // Duplexmode bit.
 wire                       sc2rd_autocrcpadstrip;   // strip pad & FCS for frame  
                                                     // received <= 1500 bytes
 wire                       sc2rd_loopback_mode;     // Enabling loopback of transmit 
                                                     // data(half duplex).
 wire                       sc2rd_portselect;        // Portselect sync'd to EQOS Rx clock.
 wire                       sc2rd_watchdog_en;       // cuts off, above 2048 bytes
 wire   [`DWC_EQOS_CR_REG62_BYTE0_C2T_WDW-1:0] cr_reg62; // SGMII/RGMII/SMII Control and Status Register
 wire                       cr_reg62_byte0_wr;       // SGMII/RGMII/SMII Control and Status Register Byte 0 write pulse
 wire                       cr_ao_an_cmplt_intr_sts; // auto-negotiation complete status  
 wire                       cr_ao_link_sts_changed;  // registered link status change event
 wire                       sc2rd_dis_crc_chk;       // Disable CRC Checking 
 wire   [31:0]              csr_ao_rdata;            // Read data from CSR_ON to the application.
 wire                       non_resrv_csr_sel;       // Select line for non reserved CSR address space
 wire                       rrpe_fsm_sts;            // When low, RRPE FSM is in IDLE state
 wire   [`DWC_EQOS_MARW-9:0]sc2rdu_macaddr0;         // MAC Address0 sync'd to clk_rx_i.
 
 wire                       cr_reg0_byte0_wr;        // MAC Config reg byte0 write pulse.
 wire                       cr_reg0_byte1_wr;        // MAC Config reg byte1 write pulse.
 wire                       cr_reg0_byte3_wr;        // MAC Config reg byte3 write pulse.
 wire   [1:0]               sgmii_link_speed_o;      // 00 - 10 Mbps, 01 - 100Mbps, 10 - 1000Mbps.

 wire   [`DWC_EQOS_RXD_WIDTH-1:0] gmii_rxd;          // Receive data to GMII Block.  
 wire                       gmii_rxdv;               // receive data valid to GMII Block .
 wire                       gmii_rxer;               // receive error to GMII Block. 
 wire                       gmii_crs;                // carrier sense to GMII Block. 
 wire                       gmii_col;                // collision detect to GMII Block. 

//leda NTL_CON13A off
//LMD: non driving internal net 
//LJ: all the bits are not driving any signal;
//LJ: but the signal driving it requires all the bits to be connected 
 wire   [5:0]               phy_intf_sts;
//leda NTL_CON13A on
  wire                      cr_timestamp_enable;

  wire                      mti_data_txon_o;
  wire [`DWC_EQOS_RXQW-1:0] mri_q_sel_o;        // Indicates the receive queue selected for received packet 
  wire [`DWC_EQOS_NUM_RXQ-1:0] mri_q_en_o;         // Indicates the receive queue is enabled


  wire                     mti_ena_timestamp_i; // Enable timestamp for curr. frame
//leda NTL_CON13A off
//LMD: non driving internal net
//LJ: this signal is used to connect within modules/ as a dummy to complete
//LJ: module instantiation.
  wire [63:0]              mti_timestamp_o;     // Timestamp snapshot output for Tx
//leda NTL_CON13A on  
  wire                     mti_ost_en_i;        // Indicates one step timestamp enabled for TX PTP packet
  wire [63:0]              mti_ost_i;           // One step timestamp to be inserted in TX PTP packet


wire                     mti_val_i;          // Data valid signal.
wire [`DWC_EQOS_DW-1:0]  mti_data_i;         // 32/64/128-bit application data.
wire                     mti_sop_i;          // Start of packet signal.
wire                     mti_eop_i;          // End of packet signal.
wire [`DWC_EQOS_DW/64+1:0] mti_be_i;         // Byte enables for application data.
wire [1:0]               mti_crc_pad_ctrl_i; // FCS-padding addition control
wire [`DWC_EQOS_TXFCBW-1:0] mti_flowctrl_i; // H/W request to transmit control 
wire                     mti_rdy_o;           // Ready signal for application.
wire                     mti_err_i;           // Indicates error in packet, terminate packet forcing CRC error
wire [31:0]              mti_txstatus_o;      // Transmit Frame Status from GMAC.
wire                     mti_txstatus_val_o;  // Status valid from GMAC.
//
wire                     mri_val_o;         // Data valid signal.
wire [`DWC_EQOS_DW-1:0]    mri_data_o;      // Frame data to application.
wire [`DWC_EQOS_DW/64+1:0] mri_be_o;        // Encoded Byte enable.
wire                     mri_sop_o;         // Start of Packet signal.
wire                     mri_eop_o;         // End of Packet signal.
wire [`DWC_EQOS_CORE_STSW-1:0] mri_rxstatus_o;// status of received frame.
  wire                     mri_timestamp_val_o; // Time-stamp valid 
  wire                     tpe_col_window_ovr;  // Collision window has been completed. used to update pointer in MTL

   wire [`DWC_EQOS_MDC_CSRW-1:0]     dcr_rdata;// Data read from the DMA's CSR 

  wire [`DWC_EQOS_NTXCH-1:0]         ati_ts_avail;       // Timestamp Available Status
  //wire [(64/`DWC_EQOS_DW)-1:0]       ati_ctrl_type_i;    //Indicates which control word is being driven on the ati_data bus.
  wire                               ati_ctrl_val_i;     //Indicates that the data on ati_data_i is a control word
  wire [`DWC_EQOS_BEW-1:0]           ati_be_i;           //Byte enables for data on ati_data bus
  wire [`DWC_EQOS_DW-1:0]            ati_data_i;         //Transmit Data bus
  wire                               ati_err_i;          //This signal indicates that there was an
                                                         //error during data read from the system side 
 // wire [`DWC_EQOS_NUM_DMA_TX_CH-1:0] ati_xmit_done_o;    //
  wire [(`DWC_EQOS_NTXQ*`DWC_EQOS_ATI_PBL_WIDTH)-1:0]      ati_pbl_i;          //Burst Length for the next transfer to each MTL TxFIFO queue. 
  wire                               ati_rdy_o;          //Asserted when MTL is ready to accept transmit frame data.
  wire                               ati_sop_i;          //Start of packet indication. Valid only when ati_val is high
  wire                               ati_eop_i;          //End of transmit packet indication. Valid only when ati_val is high
  wire [`DWC_EQOS_NUM_DMA_TX_CH-1:0] ati_txwatermark_o;  //When asserted indicates that MTL can
                                                         //accomodate number of beats indicated by ati_pbl.
 // wire [`DWC_EQOS_NTXCH-1:0]         ati_underflow_o;    //Underflow occured at MTL
  wire                               ati_txstatus_ack_i; //This signal acknowledges that DMA has accepted the
                                                         //transmit status from the MTL.
  wire [`DWC_EQOS_NTXCH-1:0]         ati_txstatus_val_o; //Indicates that transmit status is available 
                                                         //for the corresponding channel.
  wire [`DWC_EQOS_NTXCH-1:0]         ati_frm_abort;      // Packet Abort status
  wire                               ati_val_i;          //Validates ati_data bus from DU to MTL
  wire [(`DWC_EQOS_NUM_RX_CH_EFF*`DWC_EQOS_ARI_PBL_WIDTH)-1:0] ari_pbl_i; // ARI Programmable burst length
  wire [`DWC_EQOS_NUM_RX_CH_EFF-1:0]       ari_ready_i;        // Indicates DMA is ready to accept a PBL burst
  wire [`DWC_EQOS_NUM_DMA_RX_CHW-1:0]ari_chnum_o;        // DMA channel selected by MTL, vld when ari_vld_o=1
  wire                               ari_val_o;          // Vld indicator for data, dma ch num
  wire                               ari_sop_o;          // Start of packet indicator for selected DMA ch
  wire                               ari_eop_o;          // End of packet indicator
  wire [`DWC_EQOS_DATAWIDTH-1:0]     ari_data_o;         // Data for selected DMA ch. Status when rxstatus_val_o=1
  wire [`DWC_EQOS_BEW-1:0]           ari_be_o;           // During EOF, indicates the Valid no. of bytes
  wire                               ari_ack_i;          // Ack from application
  wire                               ari_rxstatus_val_o; // When set indicates ari_data contains status
  wire                               ari_timestamp_val_o;// When set indicates ari_data contains timestamp
  wire [`DWC_EQOS_NUM_RX_CH_EFF-1:0] ari_rxwatermark_o;  // Indicates RX FIFO has data of prog. burst size
//   wire [`DWC_EQOS_NUM_RX_CH_EFF-1:0] ari_rxpkt_avail_o;  // Indicates RX FIFO has data of prog. burst size
  wire [`DWC_EQOS_NUM_RX_CH_EFF-1:0] ari_pkt_flush_i;    // Flush the current selected packet
   wire [`DWC_EQOS_TX_STSW-1:0]       ati_txstatus_o;     //Transmit status word from MTL
  wire [`DWC_EQOS_TXQW-1:0]          ati_txsqnum_i;      //This signal carries a request for the status of
                                                         //a transmit queue by driving the queue number on this
                                                         //port.
  wire [`DWC_EQOS_TXQW-1:0]          ati_qnum_i;         //MTL FIFO queue number to which data
                                                         //should be written by MTL.

//leda NTL_CON13A off
//LMD: non driving internal net
//LJ: the signal's bit 0 is only being used; as per the functionality 
  wire [`DWC_EQOS_NUM_TXQ-1:0]       sc2al_csr_txq_drop_txsts; // Drop Transmit status signal
//leda NTL_CON13A on  

  wire                               c2al_csr_txq_drop_txsts; //Tx Drop Status Enable

  wire [`DWC_EQOS_RSN_WIDTH-1:0] sp2td_ptp_ref_slnum; // rsg_ptp_ref_slnum synced to clk_tx_i
  wire                           sp2tp_ptp_refp_125us; // rsg_ptp_refp_125us synced to clk_tx_i
  wire [`DWC_EQOS_RSN_WIDTH-1:0] sp2ad_ptp_ref_slnum; // rsg_ptp_ref_slnum synced to clk_app_i
  wire [`DWC_EQOS_RSN_WIDTH-1:0] sp2cd_ptp_ref_slnum; // rsg_ptp_ref_slnum synced to clk_csr_i


// Write Sideband signals
// GM Write Command IF
wire               gm_disable_sf;
wire               gmw_mbigendian;
wire               gmr_mbigendian;
//wire               dcr_enburst_undef;
//wire               dcr_enburst4;
//wire               dcr_enburst8;
//wire               dcr_enburst16;
//wire               dcr_onerequestonly;
//wire [`DWC_EQOS_ROSRLW-1:0] dcr_read_osrc_lmt;
//wire [`DWC_EQOS_WOSRLW-1:0] dcr_write_osrc_lmt;
//wire               dcr_axi_1k_en; 

wire               gmw_idle;
wire  [`DWC_EQOS_IDW-1:0]   xarb_gmw_mid;
wire  [`DWC_EQOS_AW-1:0]    xarb_gmw_maddr;
//leda NTL_CON13A off 
//LMD: non driving internal net 
//LJ: this error indicates that bit 2 of this signal is a non driving internal net  
//LJ: the wire is connected to a port; of which bit 2 is reserved and not used 
wire  [2:0]        xarb_gmw_mcmd;
//leda NTL_CON13A on
wire  [15:0]       xarb_gmw_mcount;
//leda NTL_CON13A off 
//LMD: non driving internal net 
//LJ: this error indicates that bit 2 of this signal is a non driving internal net  
//LJ: the wire is connected to a port; of which bit 2 is reserved and not used 
wire  [2:0]        xarb_gmw_mburst;
//leda NTL_CON13A on
//leda NTL_CON13A off 
//LMD: non driving internal net 
//LJ: this error indicates that bit 0 of this signal is a non driving internal net  
//LJ: the wire is connected to a port; of which bit 0 is reserved and not used 
wire  [1:0]        xarb_gmw_mpriority;
//leda NTL_CON13A on
wire               gmw_mcmdaccept;

// GM Write abort IF
wire               xarb_gmw_mabort;
wire  [`DWC_EQOS_IDW-1:0]   xarb_gmw_mabortid;

// GM Write Data IF
wire               gmw_mdatarequest;
wire  [`DWC_EQOS_IDW-1:0]   gmw_mdatarequestid;
wire               gmw_mdatalast;
wire  [`DWC_EQOS_DATW-1:0]  xarb_gmw_mdata;
wire               xarb_gmw_mdataaccept;

// GM Write Response IF
wire  [`DWC_EQOS_IDW-1:0]   gmw_sid;
wire               gmw_srespvalid;
//leda NTL_CON13A off
//LMD: non driving internal net 
//LJ: bit 2 of this wire is a non driving internal net 
//LJ: this wire is connected to an input port of which bit 2 is included but reserved 
wire  [2:0]        gmw_sresp;
//leda NTL_CON13A on
wire               xarb_gmw_srespaccept;

// Read Sideband signals
//wire               sb_gmr_idle;              // GMR is in Idle state
// GM Read Command IF
wire                         gmr_idle;
wire  [`DWC_EQOS_IDW-1:0]    xarb_gmr_mid;
wire  [`DWC_EQOS_AW-1:0]     xarb_gmr_maddr;
//leda NTL_CON13A off
//LMD: non driving internal net 
//LJ: bit 1 of this signal is a non driving internal net 
//LJ: this wire drives a port - gmr_mcmd of which only bit 0 is used ; 
//LJ: bit 1 is reserved for expansion
wire  [1:0]                  xarb_gmr_mcmd;
//leda NTL_CON13A on
wire  [`DWC_EQOS_CNTW-1:0]   xarb_gmr_mcount;
//leda NTL_CON13A off
//LMD: non driving internal net 
//LJ: bit 2 of this signal is a non driving internal net 
//LJ: this wire drives a port - gmr_mburst of which only bits 1,0 are used ; 
//LJ: bit 2 is reserved for expansion
wire  [2:0]                  xarb_gmr_mburst;
//leda NTL_CON13A on
//leda NTL_CON13A off 
//LMD: non driving internal net 
//LJ: this error indicates that bit 0 of this signal is a non driving internal net  
//LJ: the wire is connected to a port; of which bit 0 is reserved and not used 
wire  [1:0]                  xarb_gmr_mpriority;
//leda NTL_CON13A on
wire                         gmr_mcmdaccept;
// GM Read Abort IF
wire                         xarb_gmr_mabort;
wire  [`DWC_EQOS_IDW-1:0]    xarb_gmr_mabortid;
// GM Read Response IF
wire  [`DWC_EQOS_IDW-1:0]   gmr_sid;
wire  [`DWC_EQOS_DATW-1:0]  gmr_sdata;
wire               gmr_sdatalast;
wire               gmr_srespvalid;
//leda NTL_CON13A off
//LMD: non driving internal net 
//LJ: bit 2 of this wire is a non driving internal net 
//LJ: this wire is connected to an input port of which bit 2 is included but reserved 
wire   [2:0]       gmr_sresp;
//leda NTL_CON13A on
wire               xarb_gmr_srespaccept;
wire               gs_bigendian;
wire               dcr_mdc_idle;
wire               dcr_allow_lpi;
wire [5:0]         sca_mac_dbg_sts;
//wire               rpe_fsm_sts;
wire  [`DWC_EQOS_WOSRLW-1:0] sc2adu_dcr_write_osrc_lmt;
wire  [`DWC_EQOS_ROSRLW-1:0] sc2adu_dcr_read_osrc_lmt;
wire               sa2cbu_dtx_ch_idle;

//leda NTL_CON13A off
//LMD: non driving internal net 
//LJ: this signal is used only when axi and pmt are enabled; but is generated when !core and !mtl exists 
//LJ: in such a case it results in a dummy wire to complete the module instantiation 
wire               dcr_unlck_on_mgk_wkp_pkt;
//leda NTL_CON13A on



  wire             mac_sbd_intr; // Interrupt from MAC
  wire             mtl_sbd_intr; // Interrupt from MTL


  wire                           mci_val_i;
  wire                           mci_ack_o;
//leda NTL_CON13A off
//LMD: non driving internal net 
//LJ: bits 1:0 are non driving in some configurations; 
  wire  [13:0]                   mci_addr_i;
//leda NTL_CON13A on  
  wire                           mci_rdwrn_i;
  wire  [31:0]                   mci_wdata_i;
  wire  [3:0]                    mci_be_i;
  wire  [31:0]                   mci_rdata_o;
  wire                           mci_ack_intr_clr; // mci_ack used for clear on read interrupts

  wire                           clk_csr;
  wire                           rst_clk_csr;               


  wire                           sa2cl_st2cl_mtl_tx_active; // MTL Tx is active

  wire                           sa2cl_sr2cl_mtl_rx_active; // MTL Rx is active

  wire [31:0]                    mtl_csr_data;   // 32-bit MTL CSR read data.
//  wire                           mtl_csr_sel;    // Select line for MTL CSR address space.

  wire                            clk_app;
  wire                           rst_clk_rx_125_n;            
  wire                           rst_clk_tx_180_n;            
  wire                           rst_clk_rx_180_n;            
  wire                           rst_clk_rmii_n;            
  wire                           rst_clk_app_n;               
  wire                           rst_clk_tx_n;                
  wire                           rst_clk_rx_n;
  wire                           rst_clk_csr_n;               
  wire                           rst_clk_ptp_ref_n;
  wire                           rst_clk_csr_long_n;
//leda G_568_1 off 
//LMD: avoid glue logic at top level
//LJ: the logic is necessary as per functionality.
  wire                           sr2cl_fifooverflow;
//leda G_568_1 on  
  wire [`DWC_EQOS_NUM_RXQ-1:0]   sr2cp_rwc_rxq_overflow; //PerQ Rx Queue Overflow synced to clk_csr_i
  wire                           pwron_rstn;
/*
*/
  wire                           dcr_soft_reset_o;
  wire                           sw_rst_in_prgs_i;
  
  wire [`DWC_EQOS_NUM_TXQ-1:0]   mti_disable_txq_o;
//leda G_568_1 off
//LMD: avoid glue logic at top level
//LJ: the logic is necessary as per functionality.
//leda W563 off 
//LMD: Reduction of a single bit expression is redundant
//LJ: the signal's width is configurable and its a vector in some cases; 
//LJ: hence the warning can be ignored; 
  assign sr2cl_fifooverflow = (|sr2cp_rwc_rxq_overflow);
//leda W563 on
//leda G_568_1 on 

  
  assign pwron_rstn = aresetn_i;
/*
*/
  assign rst_clk_tx_n_o  = rst_clk_tx_n;
  assign rst_clk_rx_n_o  = rst_clk_rx_n;
  assign rst_clk_app_n_o = rst_clk_app_n;

  assign clk_csr = clk_csr_i;

  assign rst_clk_csr = rst_clk_csr_n;

  
  assign clk_app = aclk_i;

  assign gs_bigendian = `DWC_EQOS_L;

  assign gmw_mbigendian = `DWC_EQOS_L;
  assign gmr_mbigendian = `DWC_EQOS_L;
  assign gm_disable_sf = `DWC_EQOS_L;

  assign mci_val_i   = psel_i;
  assign mci_addr_i  = paddr_i;
//leda NTL_STR07 off  
//LMD: avoid glue logic at the top level
//LJ: this is required functionally; hence turned the warning off 
//leda G_568_1 off
//LMD: avoid glue logic at top level
//LJ: the logic is necessary as per functionality.
  assign mci_rdwrn_i = !pwrite_i;
//leda G_568_1 on  
//leda NTL_STR07 on  
  assign mci_wdata_i = pwdata_i;
  assign mci_be_i    = 4'b1111;
  assign prdata_o    = mci_rdata_o;
  assign pready_o    = mci_val_i ? mci_ack_o : 1'b1;

   localparam TIMESTAMP = 1;


  wire [`DWC_EQOS_NUM_TXQ-1:0]   ati_txqueueflush_i;     // ATI TX FIFO Flush Request
  assign ati_txqueueflush_i = {`DWC_EQOS_NUM_TXQ{`L}};
/*
  wire                 sbd_desc_endianness;// When high endianness is opposite to that of data.
 assign sbd_desc_endianness = `L; 
*/
  wire [(`DWC_EQOS_NUM_RXQ*2)-1:0] cr_reg40; // Receive Queue Control Register 0
  wire                             cr_reg40_wr; // Receive Queue Control Register write

  DWC_eqos_mac
   DWC_eqos_mac_inst (
        .clk_tx_i(clk_tx_i),
                                  .clk_rx_i(clk_rx_i),
                                  .clk_csr_i(clk_csr),
                                  .clk_app_i(clk_app),
                                  .rst_clk_tx_n(rst_clk_tx_n),
                                  .rst_clk_rx_n(rst_clk_rx_n),
                                  .rst_clk_csr_n(rst_clk_csr),
                                  .rst_clk_csr_long_n(rst_clk_csr_long_n),
                                  .rst_clk_app_n(rst_clk_app_n),
                                  .clk_ptp_ref_i(clk_ptp_ref_i),
                                  .rst_clk_ptp_ref_n(rst_clk_ptp_ref_n),
                                  .sc2td_link_up(sc2td_link_up),
                                  .sc2tdu_speed(sc2tdu_speed),
                                  .sc2tdu_duplexmode(sc2tdu_duplexmode),
                                  .sc2td_tx_config(sc2td_tx_config),
                                  .phy_intf_sts(phy_intf_sts[3]),
                                  .sc2rd_ipchksum_en(sc2rd_ipchksum_en),
                                  .sc2rd_jumboframe_en(sc2rd_jumboframe_en),
                                  .sc2rd_receive_en(sc2rd_receive_en),
                                  .sc2rd_disreceiveown(sc2rd_disreceiveown),
                                  .sc2rd_duplexmode(sc2rd_duplexmode),
                                  .sc2rd_autocrcpadstrip(sc2rd_autocrcpadstrip),
                                  .sc2rd_loopback_mode(sc2rd_loopback_mode),
                                  .sc2rd_portselect(sc2rd_portselect),
                                  .sc2rd_watchdog_en(sc2rd_watchdog_en),
                                  .cr_reg62(cr_reg62),
                                  .cr_reg62_byte0_wr(cr_reg62_byte0_wr),
                                  .cr_ao_an_cmplt_intr_sts(cr_ao_an_cmplt_intr_sts),
                                  .cr_ao_link_sts_changed(cr_ao_link_sts_changed),
                                  .csr_ao_rdata(csr_ao_rdata),
                                  .non_resrv_csr_sel(non_resrv_csr_sel),
                                  .cr_reg0_byte0_wr(cr_reg0_byte0_wr),
                                  .cr_reg0_byte1_wr(cr_reg0_byte1_wr),
                                  .cr_reg0_byte3_wr(cr_reg0_byte3_wr),
                                  .sc2rd_dis_crc_chk(sc2rd_dis_crc_chk),
                                  .sc2rdu_macaddr0(sc2rdu_macaddr0),
                                  .rrpe_fsm_sts(rrpe_fsm_sts),
                                  .cr_reg40(cr_reg40),
                                  .cr_reg40_wr(cr_reg40_wr),
                                  .gmii_rxd(gmii_rxd),
                                  .gmii_rxdv(gmii_rxdv),
                                  .gmii_rxer(gmii_rxer),
                                  .gmii_crs(gmii_crs),
                                  .gmii_col(gmii_col),
                                  .pmt_intr_status(pmt_intr_status),
                                  .cr_timestamp_enable(cr_timestamp_enable),
                                  .ptp_timestamp_i(ptp_timestamp_i),
                                  .ptp_timestamp_o(ptp_timestamp_o),
                                  .ptp_pps_o(ptp_pps_o),
                                  .ptp_aux_ts_trig_i(ptp_aux_ts_trig_i),
                                  .sca_mac_dbg_sts(sca_mac_dbg_sts),
                                  .mti_val_i(mti_val_i),
                                  .mti_data_i(mti_data_i),
                                  .mti_sof_i(mti_sop_i),
                                  .mti_eof_i(mti_eop_i),
                                  .mti_be_i(mti_be_i),
                                  .mti_crc_pad_ctrl_i(mti_crc_pad_ctrl_i),
                                  .mti_txfifoflush_i(mti_txfifoflush_i),
                                  .tpe_col_window_ovr(tpe_col_window_ovr),
                                  .mti_flowctrl_i(mti_flowctrl_i),
                                  .mti_rdy_o(mti_rdy_o),
                                  .mti_err_i(mti_err_i),
                                  .mti_txstatus_o(mti_txstatus_o),
                                  .mti_txstatus_val_o(mti_txstatus_val_o),
                                  .mti_timestamp_o(mti_timestamp_o),        
                                  .mti_ena_timestamp_i(mti_ena_timestamp_i),        
                                  .mti_data_txon(mti_data_txon_o),
                                  .mti_ost_en_i(mti_ost_en_i),
                                  .mti_ost_i(mti_ost_i),
                                  .mti_disable_txq_o(mti_disable_txq_o),
                                  .mri_val_o(mri_val_o),
                                  .mri_data_o(mri_data_o),
                                  .mri_be_o(mri_be_o),
                                  .mri_sof_o(mri_sop_o),
                                  .mri_eof_o(mri_eop_o),
                                  .mri_rxstatus_o(mri_rxstatus_o),
                                  .mri_timestamp_val_o(mri_timestamp_val_o),
                                  .mri_q_sel_o(mri_q_sel_o),
                                  .mri_q_en_o(mri_q_en_o),
                                  .mci_val_i(mci_val_i),
                                  .mci_addr_i(mci_addr_i[13:2]),
                                  .mci_rdwrn_i(mci_rdwrn_i),
                                  .mci_wdata_i(mci_wdata_i),
                                  .mci_be_i(mci_be_i),
                                  .mci_ack_o(mci_ack_o),
                                  .mci_ack_intr_clr(mci_ack_intr_clr),
                                  .mci_rdata_o(mci_rdata_o),
                                  .mci_intr_o(mac_sbd_intr),
                                  .mtl_csr_data(mtl_csr_data),
                                  .cr_reg0(cr_reg0),
                                  .cr_reg193_wr(cr_reg193_wr),
                                  .cr_macaddr0(cr_macaddr0),
                                  .rrpe_lpi_rcvd_sw(rrpe_lpi_rcvd_sw),
                                  .rrpe_lpi_intr_sw(rrpe_lpi_intr_sw),
                                  .rrpe_lpi_rcvd(rrpe_lpi_rcvd),
                                  .sbd_tx_clk_gating_ctrl_o(sbd_tx_clk_gating_ctrl_o),
                                  .sc2rpa_lpi_reg_read(sc2rpa_lpi_reg_read),
                                  .sw_rst_in_prgs_i(sw_rst_in_prgs_i),
                                  .dcr_data(dcr_rdata),
                                  .sr2cl_fifooverflow(sr2cl_fifooverflow),
                                  .c2al_csr_txq_drop_txsts(c2al_csr_txq_drop_txsts),
                                  .sp2td_ptp_ref_slnum(sp2td_ptp_ref_slnum),
                                  .sp2ad_ptp_ref_slnum(sp2ad_ptp_ref_slnum),
                                  .sp2cd_ptp_ref_slnum(sp2cd_ptp_ref_slnum),
                                  .sp2tp_ptp_refp_125us(sp2tp_ptp_refp_125us),
                                  .gmii_mdc_o(gmii_mdc_o),
                                  .gmii_mdi_i(gmii_mdi_i),
                                  .sma_mdo_o(sma_mdo_o),
                                  .sma_mdo_en_o(sma_mdo_en_o),
                                  .phy_intr_i(phy_intr_i),
                                  .sc2tdu_portselect(sc2tdu_portselect),
                                  .sa2cl_st2cl_mtl_tx_active(sa2cl_st2cl_mtl_tx_active),
                                  .sa2cbu_dtx_ch_idle(sa2cbu_dtx_ch_idle),
                                  .phy_select(phy_select),
                                  .gmii_txen_o(gmii_txen),
                                  .gmii_txer_o(gmii_txer),
                                  .gmii_txd_o(gmii_txd)
                                  );

  DWC_eqos_mac_ao
   DWC_eqos_mac_ao_inst(
                                       .clk_tx_i(clk_tx_i),
                                       .clk_rx_i(clk_rx_i),
                                       .clk_csr_i(clk_csr),
                                       .clk_tx_125_i(clk_tx_125_i),
                                       .clk_rmii_i(clk_rmii_i),
                                       .clk_rx_125_i(clk_rx_125_i),
                                       .clk_tx_180_i(clk_tx_180_i),
                                       .clk_rx_180_i(clk_rx_180_i),
                                       .pwr_on_rst_n(pwron_rstn),
                                       .rst_clk_tx_n(rst_clk_tx_n),
                                       .rst_clk_rx_n(rst_clk_rx_n),
                                       .rst_clk_csr_n(rst_clk_csr),
                                       .rst_clk_csr_long_n(rst_clk_csr_long_n),
                                       .rst_clk_tx_125_n(rst_clk_tx_125_n),
                                       .rst_clk_rmii_n(rst_clk_rmii_n),
                                       .rst_clk_rx_125_n(rst_clk_rx_125_n),
                                       .rst_clk_tx_180_n(rst_clk_tx_180_n),
                                       .rst_clk_rx_180_n(rst_clk_rx_180_n),
                                       .mac_speed_o(mac_speed_o),
                                       .test_mode(test_mode), 
                                       .pwr_clamp_ctrl_i(pwr_clamp_ctrl_i),
                                       .cr_reg0(cr_reg0),
                                       .cr_macaddr0(cr_macaddr0),
                                       .cr_reg193_wr(cr_reg193_wr),
                                       .phy_intf_sel_i(phy_intf_sel_i),
                                       .sc2rpa_lpi_reg_read(sc2rpa_lpi_reg_read),
                                       .sc2rd_ipchksum_en(sc2rd_ipchksum_en),
                                       .sc2rd_jumboframe_en(sc2rd_jumboframe_en),
                                       .sc2rd_receive_en(sc2rd_receive_en),
                                       .sc2rd_disreceiveown(sc2rd_disreceiveown),
                                       .sc2rd_duplexmode(sc2rd_duplexmode),
                                       .sc2rd_autocrcpadstrip(sc2rd_autocrcpadstrip),
                                       .sc2rd_loopback_mode(sc2rd_loopback_mode),
                                       .sc2rd_portselect(sc2rd_portselect),
                                       .sc2rd_watchdog_en(sc2rd_watchdog_en),
                                       .mte_txen(gmii_txen),
                                       .mte_txer(gmii_txer),
                                       .mte_txd(gmii_txd),
                                       .sc2td_link_up(sc2td_link_up),
                                       .sc2tdu_speed(sc2tdu_speed),
                                       .sc2td_duplexmode(sc2tdu_duplexmode),
                                       .sc2tdu_portselect(sc2tdu_portselect),
                                       .sc2tdl_tx_config(sc2td_tx_config),
                                       .cr_reg62(cr_reg62),
                                       .cr_reg62_byte0_wr(cr_reg62_byte0_wr),
                                       .cr_ao_an_cmplt_intr_sts(cr_ao_an_cmplt_intr_sts),
                                       .cr_ao_link_sts_changed(cr_ao_link_sts_changed),
                                       .srh2c_link_speed_selected(sgmii_link_speed_o),
                                       .phy_select(phy_select),
                                       .mci_val_i(mci_val_i),
                                       .mci_addr_i(mci_addr_i[13:2]),
                                       .mci_rdwrn_i(mci_rdwrn_i),
                                       .mci_wdata_i(mci_wdata_i),
                                       .mci_be_i(mci_be_i),
                                       .mci_ack_o(mci_ack_o),
                                       .mci_ack_intr_clr(mci_ack_intr_clr),
                                       .csr_ao_rdata(csr_ao_rdata),
                                       .non_resrv_csr_sel(non_resrv_csr_sel),
                                       .sma_mdo_o(sma_mdo_o),
                                       .sma_mdo_en_o(sma_mdo_en_o),
                                       .gmii_mdo_o(gmii_mdo_o),
                                       .gmii_mdo_o_e(gmii_mdo_o_e),
                                       .cr_reg0_byte0_wr(cr_reg0_byte0_wr),
                                       .cr_reg0_byte1_wr(cr_reg0_byte1_wr),
                                       .cr_reg0_byte3_wr(cr_reg0_byte3_wr),
                                       .pcs_aquired_sync_o(pcs_acquired_sync_o),
                                       .pcs_ewrap_o(pcs_ewrap_o),
                                       .pcs_en_cdet_o(pcs_en_cdet_o),
                                       .pcs_lck_ref_o(pcs_lck_ref_o),
                                       .pmt_intr_o(pmt_intr_o),
                                       .pmt_intr_status(pmt_intr_status),
                                       .sbd_pwr_down_ack_o(sbd_pwr_down_ack_o), 
                                       .phy_txen_o(phy_txen_o),
                                       .phy_txer_o(phy_txer_o),
                                       .phy_txd_o(phy_txd_o),
                                       .phy_intf_sts(phy_intf_sts),
                                       .sc2rd_dis_crc_chk(sc2rd_dis_crc_chk),
                                       .sc2rdu_macaddr0(sc2rdu_macaddr0),
                                       .rrpe_lpi_rcvd_sw(rrpe_lpi_rcvd_sw),
                                       .rrpe_lpi_intr_sw(rrpe_lpi_intr_sw),
                                       .rrpe_lpi_rcvd(rrpe_lpi_rcvd),
                                       .rrpe_lpi_intr_o(lpi_intr_o),    
                                       .gmii_rxd(gmii_rxd),
                                       .gmii_rxdv(gmii_rxdv),
                                       .gmii_rxer(gmii_rxer),
                                       .gmii_crs(gmii_crs),
                                       .gmii_col(gmii_col),
                                       .phy_crs_i(phy_crs_i),
                                       .phy_col_i(phy_col_i),
                                       .phy_rxdv_i(phy_rxdv_i),
                                       .phy_rxer_i(phy_rxer_i),
                                       .phy_rxd_i(phy_rxd_i)
                                       );

   DWC_eqos_mtl
    #(
                  .DW         (`DWC_EQOS_DATAWIDTH),
                  .TMSIZE     (`DWC_EQOS_TXFIFO_SIZE),
                  .RMSIZE     (`DWC_EQOS_RXFIFO_SIZE),
                  .TXQ        (`DWC_EQOS_NUM_TXQ),
                  .RXQ        (`DWC_EQOS_NUM_RXQ),
                  .TXSFD      (`DWC_EQOS_MAX_FRAME_IN_TXFIFO),
                  .TIMESTAMP  (TIMESTAMP),
                  .TPBLW      (`DWC_EQOS_ATI_PBL_WIDTH),
                  .RPBLW      (`DWC_EQOS_ARI_PBL_WIDTH),
                  .NUMCH      (`DWC_EQOS_NUM_RX_CH_EFF)
                 ) DWC_eqos_mtl_inst (

        .clk_app_i(clk_app),
                                      .rst_clk_app_n(rst_clk_app_n),
                                      .clk_tx_i(clk_tx_i),
                                      .rst_clk_tx_n(rst_clk_tx_n),
                                      .clk_rx_i(clk_rx_i),
                                      .rst_clk_rx_n(rst_clk_rx_n),
                                      .clk_csr_i(clk_csr),
                                      .rst_clk_csr_n(rst_clk_csr),
                                      .rst_clk_csr_long_n(rst_clk_csr_long_n),
                                      .ati_qnum_i(ati_qnum_i),
                                      .ati_ctrl_val_i(ati_ctrl_val_i),
                                      .ati_val_i(ati_val_i),
                                      .ati_data_i(ati_data_i),
                                      .ati_be_i(ati_be_i),
                                      .ati_sof_i(ati_sop_i),
                                      .ati_eof_i(ati_eop_i),
                                      .ati_error_i(ati_err_i),
                                      .ati_rdy_o(ati_rdy_o),
                                      .ati_txqueueflush_i(ati_txqueueflush_i),
                                      .ati_pbl_i(ati_pbl_i),
                                      .ati_txwatermark_o(ati_txwatermark_o),
                                      .ati_txstatus_val_o(ati_txstatus_val_o),
                                      .ati_txstatus_o(ati_txstatus_o),
                                      .ati_txstatus_ack_i(ati_txstatus_ack_i),
                                      .ati_txsqnum_i(ati_txsqnum_i),
                                      .ati_ts_avail(ati_ts_avail),
                                      .ati_frm_abort(ati_frm_abort),
                                      .ari_pbl_i(ari_pbl_i),
                                      .ari_ready_i(ari_ready_i),
                                      .ari_chnum_o(ari_chnum_o),
                                      .ari_val_o(ari_val_o),
                                      .ari_sof_o(ari_sop_o),
                                      .ari_eof_o(ari_eop_o),
                                      .ari_data_o(ari_data_o),
                                      .ari_be_o(ari_be_o),
                                      .ari_ack_i(ari_ack_i),
                                      .ari_rx_status_val_o(ari_rxstatus_val_o),
                                      .ari_timestamp_val_o(ari_timestamp_val_o),
                                      .ari_rxwatermark_o(ari_rxwatermark_o),
                                      .ari_frame_flush_i(ari_pkt_flush_i),
                                      .mti_val_o(mti_val_i),
                                      .mti_sof_o(mti_sop_i),
                                      .mti_eof_o(mti_eop_i),
                                      .mti_be_o(mti_be_i),
                                      .mti_data_o(mti_data_i),
                                      .mti_error_o(mti_err_i),
                                      .mti_rdy_i(mti_rdy_o),
                                      .mti_txflush_o(mti_txfifoflush_i),
                                      .mti_ena_timestamp_o(mti_ena_timestamp_i),
                                      .mti_crc_repl_ctrl_o(mti_crc_pad_ctrl_i),
                                      .mti_onestep_tcorr_en_o(mti_ost_en_i),
                                      .mti_onestep_tcorr_o(mti_ost_i),
                                      .mti_datatxon_i(mti_data_txon_o),
                                      .mti_txstatus_val_i(mti_txstatus_val_o),
                                      .mti_txstatus_i(mti_txstatus_o),
                                      .mti_timestamp_i(mti_timestamp_o),
                                      .mti_disable_txq_i(mti_disable_txq_o),
                                      .mti_flowctrl_o(mti_flowctrl_i),
                                      .tpe_col_window_ovr(tpe_col_window_ovr),
                                      .mri_qno_i(mri_q_sel_o),
                                      .mri_q_en_i(mri_q_en_o),
                                      .mri_val_i(mri_val_o),
                                      .mri_sof_i(mri_sop_o),
                                      .mri_eof_i(mri_eop_o),
                                      .mri_data_i(mri_data_o),
                                      .mri_be_i(mri_be_o),
                                      .mri_rxstatus_i(mri_rxstatus_o),
                                      .mri_timestamp_val_i(mri_timestamp_val_o),
                                      .mci_val_i(mci_val_i),
                                      .mci_addr_i(mci_addr_i),
                                      .mci_rd_wrn_i(mci_rdwrn_i),
                                      .mci_wdata_i(mci_wdata_i),
                                      .mci_be_i(mci_be_i),
                                      .mci_rdata_o(mtl_csr_data),
                                      .mci_ack_o(mci_ack_o),
                                      .cr_reg40(cr_reg40),
                                      .cr_reg40_wr(cr_reg40_wr),
                                      .sp2td_ptp_ref_slnum(sp2td_ptp_ref_slnum),
                                      .sp2tp_ptp_refp_125us(sp2tp_ptp_refp_125us),
                                      .sc2t_duplexmode_i(sc2tdu_duplexmode),
                                      .sc2t_port_select_i(sc2tdu_portselect),
                                      .mtl_sbd_intr(mtl_sbd_intr),
                                      .sr2cp_rwc_rxq_overflow(sr2cp_rwc_rxq_overflow),
                                      .sc2al_csr_txq_drop_txsts(sc2al_csr_txq_drop_txsts),
                                      .c2al_csr_txq_drop_txsts(c2al_csr_txq_drop_txsts),
                                      .sa2cl_st2cl_mtl_tx_active(sa2cl_st2cl_mtl_tx_active),
                                      .sa2cl_sr2cl_mtl_rx_active(sa2cl_sr2cl_mtl_rx_active),
                                      .twc_wr_addr_o(twc_wr_addr_o),
                                      .twc_wr_csn_o(twc_wr_csn_o),
                                      .twc_wr_data_o(twc_wr_data_o),
                                      .twc_wr_en_o(twc_wr_en_o),
                                      .trc_rd_addr_o(trc_rd_addr_o),
                                      .trc_rd_csn_o(trc_rd_csn_o),
                                      .trc_rd_data_i(trc_rd_data_i),
                                      .trc_rd_en_o(trc_rd_en_o),
                                      .rwc_wr_addr_o(rwc_wr_addr_o),
                                      .rwc_wr_csn_o(rwc_wr_csn_o),
                                      .rwc_wr_data_o(rwc_wr_data_o),
                                      .rwc_wr_en_o(rwc_wr_en_o),
                                      .rrc_rd_addr_o(rrc_rd_addr_o),
                                      .rrc_rd_data_i(rrc_rd_data_i),
                                      .rrc_rd_csn_o(rrc_rd_csn_o),
                                      .rrc_rd_en_o(rrc_rd_en_o)
                                      );


  DWC_eqos_mdc
   DWC_eqos_mdc_inst (
        //Inputs
        .clk_app_i(clk_app),
                                  .clk_csr_i(clk_csr),
                                  .rst_clk_app_n(rst_clk_app_n),
                                  .rst_clk_csr_n(rst_clk_csr),
                                  .rst_clk_csr_long_n(rst_clk_csr_long_n),
                                  .ari_be(ari_be_o),
                                  .ari_chnum(ari_chnum_o),
                                  .ari_data(ari_data_o),
                                  .ari_eof(ari_eop_o),
                                  //.ari_pkt_avail                     (ari_rxpkt_avail_o                 ),
                                  .ari_rx_watermark(ari_rxwatermark_o),
                                  .ari_rxstatus_val(ari_rxstatus_val_o),
                                  .ari_sof(ari_sop_o),
                                  .ari_timestamp_val(ari_timestamp_val_o),
                                  .ari_val(ari_val_o),
                                  //   .ati_fr_xmit_done                  (ati_xmit_done_o                   ),
                                  .ati_rdy(ati_rdy_o),
                                  .ati_tx_watermark(ati_txwatermark_o),
                                  //  .ati_underflow                     (ati_underflow_o                   ),
                                  .ati_txstatus(ati_txstatus_o),
                                  .ati_txstatus_avail(ati_txstatus_val_o),
                                  .ati_ts_avail(ati_ts_avail),
                                  .ati_frm_abort(ati_frm_abort),
                                  .csr_ack(mci_ack_o),
                                  .cr_timestamp_enable(cr_timestamp_enable),
                                  .mac_intr(mac_sbd_intr),
                                  .mci_addr(mci_addr_i),
                                  .mci_be(mci_be_i),
                                  .mci_rd_wrn(mci_rdwrn_i),
                                  .mci_val(mci_val_i),
                                  .mci_wdata(mci_wdata_i),
                                  .mtl_intr(mtl_sbd_intr),
                                  .sc2al_csr_txq_drop_txsts(sc2al_csr_txq_drop_txsts[0]),
                                  .sp2ad_ptp_ref_slnum(sp2ad_ptp_ref_slnum),
                                  .sp2cd_ptp_ref_slnum(sp2cd_ptp_ref_slnum),
                                  //  .sbd_desc_endianness_i             (sbd_desc_endianness               ),
                                  .sw_rst_in_prgs_i(sw_rst_in_prgs_i),
                                  .gmw_mcmdaccept(gmw_mcmdaccept),
                                  .gmw_mdatarequest(gmw_mdatarequest),
                                  .gmw_mdatarequestid(gmw_mdatarequestid[`DWC_EQOS_IDW-1:0]),
                                  .gmw_mdatalast(gmw_mdatalast),
                                  .gmw_sid(gmw_sid),
                                  .gmw_srespvalid(gmw_srespvalid),
                                  .gmw_sresp(gmw_sresp),
                                  .gmr_mcmdaccept(gmr_mcmdaccept),
                                  .gmr_sid(gmr_sid[`DWC_EQOS_IDW-1:0]),
                                  .gmr_sdata(gmr_sdata),
                                  .gmr_srespvalid(gmr_srespvalid),
                                  .gmr_sresp(gmr_sresp),
                                  .gmr_sdatalast(gmr_sdatalast),
                                  .gmw_idle(gmw_idle),
                                  .gmr_idle(gmr_idle),
                                  //Outputs
                                  .ari_ack(ari_ack_i),
                                  .ari_frameflush(ari_pkt_flush_i),
                                  .ari_pbl(ari_pbl_i),
                                  .ari_rdy(ari_ready_i),
                                  .ati_be(ati_be_i),
                                  .ati_ctrl_val(ati_ctrl_val_i),
                                  .ati_data(ati_data_i),
                                  .ati_eof(ati_eop_i),
                                  .ati_err(ati_err_i),
                                  .ati_pbl(ati_pbl_i),
                                  .ati_qnum(ati_qnum_i),
                                  .ati_sof(ati_sop_i),
                                  .ati_txsqnum(ati_txsqnum_i),
                                  .ati_txstatus_ack(ati_txstatus_ack_i),
                                  .ati_val(ati_val_i),
                                  .dcr_rdata(dcr_rdata),
                                  .dcr_soft_reset_o(dcr_soft_reset_o),
                                  .xarb_gmw_mid(xarb_gmw_mid[`DWC_EQOS_IDW-1:0]),
                                  .xarb_gmw_maddr(xarb_gmw_maddr),
                                  .xarb_gmw_mcmd(xarb_gmw_mcmd),
                                  .xarb_gmw_mcount(xarb_gmw_mcount),
                                  .xarb_gmw_mburst(xarb_gmw_mburst),
                                  .xarb_gmw_mpriority(xarb_gmw_mpriority),
                                  .xarb_gmw_mabort(xarb_gmw_mabort),
                                  .xarb_gmw_mabortid(xarb_gmw_mabortid[`DWC_EQOS_IDW-1:0]),
                                  .xarb_gmw_mdata(xarb_gmw_mdata),
                                  .xarb_gmw_mdataaccept(xarb_gmw_mdataaccept),
                                  .xarb_gmw_srespaccept(xarb_gmw_srespaccept),
                                  .xarb_gmr_mid(xarb_gmr_mid[`DWC_EQOS_IDW-1:0]),
                                  .xarb_gmr_maddr(xarb_gmr_maddr),
                                  .xarb_gmr_mcmd(xarb_gmr_mcmd),
                                  .xarb_gmr_mcount(xarb_gmr_mcount),
                                  .xarb_gmr_mburst(xarb_gmr_mburst),
                                  .xarb_gmr_mpriority(xarb_gmr_mpriority),
                                  .xarb_gmr_mabort(xarb_gmr_mabort),
                                  .xarb_gmr_mabortid(xarb_gmr_mabortid[`DWC_EQOS_IDW-1:0]),
                                  .xarb_gmr_srespaccept(xarb_gmr_srespaccept),
                                  .dcr_mdc_idle(dcr_mdc_idle),
                                  .dcr_unlck_on_mgk_wkp_pkt(dcr_unlck_on_mgk_wkp_pkt),
                                  .dcr_allow_lpi(dcr_allow_lpi),
                                  .sa2cbu_dtx_ch_idle(sa2cbu_dtx_ch_idle),
                                  .sc2adu_dcr_read_osrc_lmt(sc2adu_dcr_read_osrc_lmt),
                                  .sc2adu_dcr_write_osrc_lmt(sc2adu_dcr_write_osrc_lmt),
                                  .sc2adu_dcr_axi_1k_en(sc2adu_dcr_axi_1k_en),
                                  .sc2adu_dcr_enburst_undef(sc2adu_dcr_enburst_undef),
                                  .sc2adu_dcr_enburst4(sc2adu_dcr_enburst4),
                                  .sc2adu_dcr_enburst8(sc2adu_dcr_enburst8),
                                  .sc2adu_dcr_enburst16(sc2adu_dcr_enburst16),
                                  .sc2adu_dcr_onerequestonly(sc2adu_dcr_onerequestonly),
                                  .sbd_intr_o(sbd_intr_o)
                                  );


 DWC_eqos_axi
   DWC_eqos_axi_inst
  (
                   .gm_clk(aclk_i)
   ,.gm_clk_en(`H)
   ,.gm_reset_n(aresetn_i)
   ,.gs_clk(clk_csr)
   ,.gs_clk_en(`H)
   ,.gs_reset_n(rst_clk_csr_n)
   ,.gm_enburst_undef(sc2adu_dcr_enburst_undef)
   ,.gm_read_osrc_lmt(sc2adu_dcr_read_osrc_lmt)
   ,.gm_write_osrc_lmt(sc2adu_dcr_write_osrc_lmt)
   ,.gm_axi_1k_en(sc2adu_dcr_axi_1k_en)
   ,.gm_enburst4(sc2adu_dcr_enburst4)
   ,.gm_enburst8(sc2adu_dcr_enburst8)
   ,.gm_enburst16(sc2adu_dcr_enburst16)
   ,.gm_onerequestonly(sc2adu_dcr_onerequestonly)
   ,.sb_gmw_idle(gmw_idle)
   ,.gmw_mbigendian(gmw_mbigendian)
   ,.gmw_mid(xarb_gmw_mid)
   ,.gmw_maddr(xarb_gmw_maddr)
   ,.gmw_mcmd(xarb_gmw_mcmd)
   ,.gmw_mcount(xarb_gmw_mcount)
   ,.gmw_mburst(xarb_gmw_mburst)
   ,.gmw_mpriority(xarb_gmw_mpriority)
   ,.gmw_mcmdaccept(gmw_mcmdaccept)
   ,.gmw_mabort(xarb_gmw_mabort)
   ,.gmw_mabortid(xarb_gmw_mabortid)
   ,.gmw_mdatarequest(gmw_mdatarequest)
   ,.gmw_mdatarequestid(gmw_mdatarequestid)
   ,.gmw_mdatalast(gmw_mdatalast)
   ,.gmw_mdata(xarb_gmw_mdata)
   ,.gmw_mdataaccept(xarb_gmw_mdataaccept)
   ,.gmw_sid(gmw_sid)
   ,.gmw_srespvalid(gmw_srespvalid)
   ,.gmw_sresp(gmw_sresp)
   ,.gmw_srespaccept(xarb_gmw_srespaccept)
   ,.xm_awaddr(awaddr_m_o)
   ,.xm_awlen(awlen_m_o)
   ,.xm_awid(awid_m_o)
   ,.xm_awburst(awburst_m_o)
   ,.xm_awvalid(awvalid_m_o)
   ,.xm_awready(awready_m_i)
   ,.xm_awsize(awsize_m_o)
   ,.xm_awlock(awlock_m_o)
   ,.xm_awcache(awcache_m_o)
   ,.xm_awprot(awprot_m_o)
   ,.xm_wid(wid_m_o)
   ,.xm_wdata(wdata_m_o)
   ,.xm_wstrb(wstrb_m_o)
   ,.xm_wlast(wlast_m_o)
   ,.xm_wvalid(wvalid_m_o)
   ,.xm_wready(wready_m_i)
   ,.xm_bid(bid_m_i)
   ,.xm_bresp(bresp_m_i)
   ,.xm_bvalid(bvalid_m_i)
   ,.xm_bready(bready_m_o)
   ,.sb_gmr_idle(gmr_idle)
   ,.gmr_mbigendian(gmr_mbigendian)
   ,.gmr_mid(xarb_gmr_mid)
   ,.gmr_maddr(xarb_gmr_maddr)
   ,.gmr_mcmd(xarb_gmr_mcmd)
   ,.gmr_mcount(xarb_gmr_mcount)
   ,.gmr_mburst(xarb_gmr_mburst[1:0])
   ,.gmr_mpriority(xarb_gmr_mpriority)
   ,.gmr_mcmdaccept(gmr_mcmdaccept)
   ,.gmr_mabort(xarb_gmr_mabort)
   ,.gmr_mabortid(xarb_gmr_mabortid)
   ,.gmr_sid(gmr_sid)
   ,.gmr_sdata(gmr_sdata)
   ,.gmr_sdatalast(gmr_sdatalast)
   ,.gmr_srespvalid(gmr_srespvalid)
   ,.gmr_sresp(gmr_sresp)
   ,.gmr_srespaccept(xarb_gmr_srespaccept)
   ,.xm_araddr(araddr_m_o)
   ,.xm_arlen(arlen_m_o)
   ,.xm_arid(arid_m_o)
   ,.xm_arburst(arburst_m_o)
   ,.xm_arvalid(arvalid_m_o)
   ,.xm_arready(arready_m_i)
   ,.xm_arsize(arsize_m_o)
   ,.xm_arlock(arlock_m_o)
   ,.xm_arcache(arcache_m_o)
   ,.xm_arprot(arprot_m_o)
   ,.xm_rid(rid_m_i)
   ,.xm_rresp(rresp_m_i)
   ,.xm_rdata(rdata_m_i)
   ,.xm_rlast(rlast_m_i)
   ,.xm_rvalid(rvalid_m_i)
   ,.xm_rready(rready_m_o)
   );


 DWC_eqos_lpi
   DWC_eqos_lpi_inst
    (
          .clk_csr_i(clk_csr),
     .rst_clk_csr_n(rst_clk_csr),
     .clk_rx_i(clk_rx_i),
     .rst_clk_rx_n(rst_clk_rx_n),
     .gm_clk(aclk_i),
     .gm_reset_n(aresetn_i),
     .psel_i(psel_i),
     .rrpe_fsm_sts(rrpe_fsm_sts),
     .sca_mac_dbg_sts(sca_mac_dbg_sts),
     .sa2cl_st2cl_mtl_tx_active(sa2cl_st2cl_mtl_tx_active),
     .sa2cl_sr2cl_mtl_rx_active(sa2cl_sr2cl_mtl_rx_active),
     .dcr_mdc_idle(dcr_mdc_idle),
     .xm_gmr_idle(gmr_idle),
     .xm_gmw_idle(gmw_idle),
     .csr_allow_lpi(dcr_allow_lpi),
     .csr_unlck_on_mgk_wkp_pkt(dcr_unlck_on_mgk_wkp_pkt),
     .pmt_intr(pmt_intr_o),
     .csysreq_i(csysreq_i),
     .cactive_o(cactive_o),
     .csysack_o(csysack_o)
     );







//leda W389 off
//LMD: multiple clocks in the module
//LJ: this is reset block requires multiple clocks. 
DWC_eqos_reset_blk
 DWC_eqos_reset_blk_inst (
          .clk_app_i(clk_app),
                                            .clk_csr_i(clk_csr),
                                            .clk_tx_i(clk_tx_i),
                                            .clk_rx_i(clk_rx_i),
                                            .clk_tx_125_i(clk_tx_125_i),
                                            .clk_rx_125_i(clk_rx_125_i),
                                            .clk_ptp_ref_i(clk_ptp_ref_i),
                                            .rst_clk_tx_125_n(rst_clk_tx_125_n),
                                            .rst_clk_rx_125_n(rst_clk_rx_125_n),
                                            .rst_clk_ptp_ref_n(rst_clk_ptp_ref_n),
                                            .clk_tx_180_i(clk_tx_180_i),
                                            .rst_clk_tx_180_n(rst_clk_tx_180_n),
                                            .clk_rx_180_i(clk_rx_180_i),
                                            .rst_clk_rx_180_n(rst_clk_rx_180_n),
                                            .pwr_on_rst_n(pwron_rstn),
                                            .test_mode(test_mode),
                                            .dcr_soft_reset_i(dcr_soft_reset_o),
                                            .clk_rmii_i(clk_rmii_i),
                                            .rst_clk_rmii_n(rst_clk_rmii_n),
                                            .phy_select(phy_select),
                                            .rst_clk_csr_n(rst_clk_csr_n),
                                            .rst_clk_csr_long_n(rst_clk_csr_long_n),
                                            .rst_clk_app_n(rst_clk_app_n),
                                            .rst_clk_tx_n(rst_clk_tx_n),
                                            .rst_clk_rx_n(rst_clk_rx_n),
                                            .sw_rst_in_prgs_o(sw_rst_in_prgs_i)
                                            );

//leda W389 on

endmodule
