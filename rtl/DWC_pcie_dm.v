//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2002 - 2016 SYNOPSYS, INC.
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

// -------------------------------------------------------------------------
// ---  RCS information: ARCT generated file. Do not manually edit. (generator -> process_rtl.sh)
// ---    $DateTime: 2016/07/14 04:08:50 $
// ---    $Revision: #56 $
// ---    $Id: //dwh/pcie_iip/main/DWC_pcie/DWC_pcie_common/src/DWC_pcie_common.v#56 $
// -------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// --- Module description:  This is for top-level dual mode/end device/root complex/switch application.
// --- Top level modules:
// --- * radm_dm        : Rcvd ADM for dual-mode application
// --- * radm_ep        : Rcvd ADM for end-point application
// --- * radm_rc        : Rcvd ADM for root application
// --- * radm_sw        : Rcvd ADM for switch application
// --- * xadm           : Txmt ADM
// --- * cx_pl          : Basic PCI Express Functionality: Layer1, Layer2 and Layer3
// --- * cdm            : Type 0 CDM
// --- * lbc            : Local bus controller
// --- * pm_ctrl        : Power management running at Aux clock
// --- * msg_gen        : Message TLP Generation
// -----------------------------------------------------------------------------
//
//
module DWC_pcie_dm (

    // Master interfaces of AXI
    mstr_awid,
    mstr_awvalid,
    mstr_awaddr,
    mstr_awlen,
    mstr_awsize,
    mstr_awburst,
    mstr_awlock,
    mstr_awcache,
    mstr_awprot,
    mstr_awready,
    mstr_awmisc_info,
    mstr_awmisc_info_last_dcmp_tlp,
    mstr_awmisc_info_hdr_34dw,
    mstr_awmisc_info_dma,
    mstr_awmisc_info_func_num,
    mstr_awmisc_info_ido,

    mstr_wready,
    mstr_wdata,
    mstr_wstrb,
    mstr_wlast,
    mstr_wvalid,
    mstr_wid,

    mstr_bready,
    mstr_bid,
    mstr_bvalid,
    mstr_bresp,


    mstr_bmisc_info_cpl_stat,

    mstr_arid,
    mstr_arvalid,
    mstr_araddr,
    mstr_arlen,
    mstr_arsize,
    mstr_arburst,
    mstr_arlock,
    mstr_arcache,
    mstr_arprot,
    mstr_rready,
    mstr_armisc_info,
    mstr_armisc_info_last_dcmp_tlp,
    mstr_armisc_info_dma,
    mstr_armisc_info_func_num,
    mstr_armisc_info_ido,
    mstr_arready,
    mstr_rid,
    mstr_rvalid,
    mstr_rlast,
    mstr_rdata,
    mstr_rresp,
    mstr_rmisc_info,

    mstr_rmisc_info_cpl_stat,

    mstr_csysack,
    mstr_cactive,
    mstr_csysreq,
    mstr_aclk,
    mstr_aclk_ug,
    mstr_aclk_active,
    mstr_aresetn,

    slv_awid,
    slv_awaddr,
    slv_awlen,
    slv_awsize,
    slv_awburst,
    slv_awlock,
    slv_awcache,
    slv_awprot,
    slv_awvalid,
    slv_awready,
    slv_awmisc_info,
    slv_awmisc_info_hdr_34dw,
    slv_awmisc_info_p_tag,
    slv_awmisc_info_atu_bypass,
    slv_awmisc_info_func_num,
    slv_awmisc_info_ido,

    slv_wready,
    slv_wid,
    slv_wdata,
    slv_wstrb,
    slv_wlast,
    slv_wvalid,

    slv_bid,
    slv_bresp,
    slv_bvalid,
    slv_bready,
    slv_bmisc_info,


    slv_arid,
    slv_araddr,
    slv_arlen,
    slv_arsize,
    slv_arburst,
    slv_arlock,
    slv_arcache,
    slv_arprot,
    slv_arvalid,
    slv_armisc_info,
    slv_armisc_info_atu_bypass,
    slv_armisc_info_func_num,
    slv_armisc_info_ido,
    slv_rready,

    slv_rid,
    slv_rdata,
    slv_rresp,
    slv_rlast,
    slv_rvalid,
    slv_rmisc_info,
    slv_rmisc_info_ido,
    slv_arready,

    slv_csysreq,
    slv_csysack,
    slv_cactive,

    slv_aclk,
    slv_aclk_ug,
    slv_aclk_active,
    slv_aresetn,

    radm_cpl_timeout,
    radm_timeout_func_num,
    radm_timeout_cpl_tc,
    radm_timeout_cpl_attr,
    radm_timeout_cpl_len,
    radm_timeout_cpl_tag,



    // Gated Slave DBI clock
    dbi_aclk,
    // Ungated Slave DBI clock
    dbi_aclk_ug,
    // Slave DBI clock gating control
    dbi_aclk_active,
    dbi_aresetn,
    // Slave DBI interfaces of AXI
    dbi_awid,
    dbi_awaddr,
    dbi_awlen,
    dbi_awsize,
    dbi_awburst,
    dbi_awlock,
    dbi_awcache,
    dbi_awprot,
    dbi_awvalid,
    dbi_awready,
    dbi_wready,
    dbi_wid,
    dbi_wdata,
    dbi_wstrb,
    dbi_wlast,
    dbi_wvalid,

    dbi_bid,
    dbi_bresp,
    dbi_bvalid,
    dbi_bready,


    dbi_arid,
    dbi_araddr,
    dbi_arlen,
    dbi_arsize,
    dbi_arburst,
    dbi_arlock,
    dbi_arcache,
    dbi_arprot,
    dbi_arvalid,
    dbi_rready,

    dbi_rid,
    dbi_rdata,
    dbi_rresp,
    dbi_rlast,
    dbi_rvalid,
    dbi_arready,

    dbi_csysreq,
    dbi_csysack,
    dbi_cactive,


    // ELBI interface
    ext_lbc_ack,
    ext_lbc_din,
    lbc_ext_addr,
    lbc_ext_dout,
    lbc_ext_cs,
    lbc_ext_wr,
    lbc_ext_rom_access,
    lbc_ext_io_access,
    lbc_ext_bar_num,
    // MSI interface
    ven_msi_req,
    ven_msi_func_num,
    ven_msi_tc,
    ven_msi_vector,
    ven_msi_grant,
    cfg_msi_en,

    // MSI-X interface

    // VPD interface
    cfg_vpd_int,

    // FLR interface
    cfg_flr_pf_active,
    app_flr_pf_done,



    // Power Budgeting Capabilities interface
    cfg_pwr_budget_data_reg,
    cfg_pwr_budget_func_num,
    cfg_pwr_budget_data_sel_reg,
    cfg_pwr_budget_sel,
    // VMI interface
    ven_msg_fmt,
    ven_msg_type,
    ven_msg_tc,
    ven_msg_td,
    ven_msg_ep,
    ven_msg_attr,
    ven_msg_len,
    ven_msg_func_num,
    ven_msg_tag,
    ven_msg_code,
    ven_msg_data,
    ven_msg_req,
    ven_msg_grant,

    // SII interface
    rx_lane_flip_en,
    tx_lane_flip_en,

    sys_int,
    outband_pwrup_cmd,
    apps_pm_xmt_pme,
    sys_aux_pwr_det,
    sys_atten_button_pressed,
    sys_pre_det_state,
    sys_mrl_sensor_state,
    sys_pwr_fault_det,
    sys_mrl_sensor_chged,
    sys_pre_det_chged,
    sys_cmd_cpled_int,
    sys_eml_interlock_engaged,
    cfg_pwr_ind,
    cfg_atten_ind,
    cfg_pwr_ctrler_ctrl,
    apps_pm_xmt_turnoff,
    app_unlock_msg,
    pm_xtlh_block_tlp,
    cfg_bar0_start,
    cfg_bar1_start,
    cfg_bar0_limit,
    cfg_bar1_limit,
    cfg_bar2_start,
    cfg_bar2_limit,
    cfg_bar3_start,
    cfg_bar3_limit,
    cfg_bar4_start,
    cfg_bar4_limit,
    cfg_bar5_start,
    cfg_bar5_limit,
    cfg_exp_rom_start,
    cfg_exp_rom_limit,
    cfg_bus_master_en,
    cfg_mem_space_en,
    cfg_max_rd_req_size,
    cfg_max_payload_size,
    cfg_rcb,
    cfg_pm_no_soft_rst,
    cfg_aer_rc_err_int,
    cfg_aer_rc_err_msi,
    cfg_aer_int_msg_num,
    cfg_sys_err_rc,
    cfg_pme_int,
    cfg_pme_msi,
    cfg_pcie_cap_int_msg_num,
    rdlh_link_up,
    pm_curnt_state,
    smlh_ltssm_state,
    smlh_link_up,
    smlh_req_rst_not,
    link_req_rst_not,
    brdg_slv_xfer_pending,
    brdg_dbi_xfer_pending,
    edma_xfer_pending,
    radm_xfer_pending,
    radm_vendor_msg,
    radm_msg_payload,
    radm_msg_unlock,
    radm_msg_req_id,
    radm_inta_asserted,
    radm_intb_asserted,
    radm_intc_asserted,
    radm_intd_asserted,
    radm_inta_deasserted,
    radm_intb_deasserted,
    radm_intc_deasserted,
    radm_intd_deasserted,
    radm_correctable_err,
    radm_nonfatal_err,
    radm_fatal_err,
    radm_pm_pme,
    radm_pm_to_ack,
    radm_pm_turnoff,
    rtlh_rfc_upd,
    rtlh_rfc_data,
    wake,
    clk_req_n,
    cfg_eml_control,
    hp_pme,
    hp_int,
    hp_msi,
    app_ltssm_enable,
    cfg_pbus_num,
    cfg_pbus_dev_num,
    pm_dstate,
    pm_pme_en,
    pm_linkst_in_l0s,
    pm_linkst_in_l1,
    pm_linkst_in_l2,
    pm_linkst_l2_exit,
    pm_status,
    aux_pm_en,
    cfg_link_auto_bw_int,
    cfg_bw_mgt_int,
    msi_ctrl_io,
    msi_ctrl_int,
    msi_ctrl_int_vec,
    radm_q_not_empty,
    radm_qoverflow,

    trgt_cpl_timeout,
    trgt_timeout_cpl_func_num,
    trgt_timeout_cpl_tc,
    trgt_timeout_cpl_attr,
    trgt_timeout_cpl_len,
    trgt_timeout_lookup_id,
    trgt_lookup_id,
    trgt_lookup_empty,


    // PIPE interface
    mac_phy_powerdown,
    phy_mac_rxelecidle,
    phy_mac_phystatus,
    pipe_clk,
    phy_mac_rxdata,
    phy_mac_rxdatak,
    phy_mac_rxvalid,
    phy_mac_rxstatus,
    phy_mac_rxstandbystatus,
    phy_cfg_status,
    mac_phy_txdata,
    mac_phy_txdatak,
    mac_phy_elasticbuffermode,
    mac_phy_txdatavalid,

    mac_phy_txdetectrx_loopback,
    mac_phy_txelecidle,
    mac_phy_txcompliance,
    mac_phy_rxpolarity,
    mac_phy_width,
    mac_phy_pclk_rate,
    mac_phy_rxstandby,

    mac_phy_rate,
    mac_phy_txdeemph,
    mac_phy_txmargin,
    mac_phy_txswing,
    cfg_hw_auto_sp_dis,

    phy_mac_rxdatavalid,
    cfg_phy_control,
    // clk_and_reset interface
    core_clk,
    core_clk_ug,
    aux_clk,
    aux_clk_g,
    en_aux_clk_g,
    radm_clk_g,
    en_radm_clk_g,
    radm_idle,
    pwr_rst_n,
    sticky_rst_n,
    non_sticky_rst_n,
    core_rst_n,
    perst_n,
    app_clk_req_n,
    phy_clk_req_n,
    pm_req_sticky_rst,
    pm_req_core_rst,
    pm_req_non_sticky_rst,
    pm_sel_aux_clk,
    pm_req_phy_rst,
    pipe_rst_n,
    app_req_entr_l1,
    app_ready_entr_l23,
    //<ct:CX_IS_SW><br><i>Note:</i> The controller ignores this input in a downstream port.</ct>
    app_req_exit_l1,
    app_xfer_pending,
    app_init_rst,
    device_type,
    app_req_retry_en,

    training_rst_n,

   // RAM moved out of the TOP
    // Retry buffer external RAM interface
    xdlh_retryram_addr,
    xdlh_retryram_data,
    xdlh_retryram_we,
    xdlh_retryram_en,
    xdlh_retryram_par_chk_val,
    retryram_xdlh_parerr_in,
    retryram_xdlh_data,

    // Retry SOT buffer
    xdlh_retrysotram_waddr,
    xdlh_retrysotram_raddr,
    xdlh_retrysotram_data,
    xdlh_retrysotram_we,
    xdlh_retrysotram_en,
    xdlh_retrysotram_par_chk_val,
    retrysotram_xdlh_data,
    retrysotram_xdlh_parerr_in,

    // For the effort of bring RAM outside of the hiarch.
    // Beneath are grouped outputs and input  s just for RAM
    p_hdrq_dataout,
    p_hdrq_par_chk_val,
    p_hdrq_parerr_in,
    p_hdrq_addra,
    p_hdrq_addrb,
    p_hdrq_datain,
    p_hdrq_ena,
    p_hdrq_enb,
    p_hdrq_wea,
    p_dataq_dataout,
    p_dataq_par_chk_val,
    p_dataq_parerr_in,
    p_dataq_addra,
    p_dataq_addrb,
    p_dataq_datain,
    p_dataq_ena,
    p_dataq_enb,
    p_dataq_wea,





  // eDMA RAM interface signals
    ram2edma_din,
    edma2ram_addra,
    edma2ram_addrb,
    edma2ram_dout,
    edma2ram_re,
    edma2ram_we,
    //eDMA Read buffer RAM interface
    ram2edmarbuff_din,
    edmarbuff2ram_addra,
    edmarbuff2ram_addrb,
    edmarbuff2ram_dout,
    edmarbuff2ram_re,
    edmarbuff2ram_we,



    ib_rreq_ordr_ram_addra,
    ib_rreq_ordr_ram_addrb,
    ib_rreq_ordr_ram_wea,
    ib_rreq_ordr_ram_enb,
    ib_rreq_ordr_ram_dina,
    ib_rreq_ordr_ram_doutb,
    ib_rreq_c2a_cdc_ram_addra,
    ib_rreq_c2a_cdc_ram_addrb,
    ib_rreq_c2a_cdc_ram_wea,
    ib_rreq_c2a_cdc_ram_enb,
    ib_rreq_c2a_cdc_ram_dina,
    ib_rreq_c2a_cdc_ram_doutb,
    ib_wreq_c2a_cdc_ram_addra,
    ib_wreq_c2a_cdc_ram_addrb,
    ib_wreq_c2a_cdc_ram_wea,
    ib_wreq_c2a_cdc_ram_enb,
    ib_wreq_c2a_cdc_ram_dina,
    ib_wreq_c2a_cdc_ram_doutb,
    ib_mcpl_sb_ram_addra,
    ib_mcpl_sb_ram_addrb,
    ib_mcpl_sb_ram_dina,
    ib_mcpl_sb_ram_doutb,
    ib_mcpl_sb_ram_enb,
    ib_mcpl_sb_ram_wea,
    ib_mcpl_a2c_cdc_ram_addra,
    ib_mcpl_a2c_cdc_ram_addrb,
    ib_mcpl_a2c_cdc_ram_wea,
    ib_mcpl_a2c_cdc_ram_enb,
    ib_mcpl_a2c_cdc_ram_doutb,
    ib_mcpl_a2c_cdc_ram_dina,
    slv_npw_sab_ram_addra,
    slv_npw_sab_ram_wea,
    slv_npw_sab_ram_dina,
    slv_npw_sab_ram_addrb,
    slv_npw_sab_ram_enb,
    slv_npw_sab_ram_doutb,
    ob_npdcmp_ram_addra,
    ob_npdcmp_ram_wea,
    ob_npdcmp_ram_dina,
    ob_npdcmp_ram_addrb,
    ob_npdcmp_ram_enb,
    ob_npdcmp_ram_doutb,
    ob_pdcmp_hdr_ram_addra,
    ob_pdcmp_hdr_ram_wea,
    ob_pdcmp_hdr_ram_dina,
    ob_pdcmp_hdr_ram_addrb,
    ob_pdcmp_hdr_ram_enb,
    ob_pdcmp_hdr_ram_doutb,
    ob_pdcmp_data_ram_addra,
    ob_pdcmp_data_ram_wea,
    ob_pdcmp_data_ram_dina,
    ob_pdcmp_data_ram_addrb,
    ob_pdcmp_data_ram_enb,
    ob_pdcmp_data_ram_doutb,
    ob_ccmp_data_ram_addra,
    ob_ccmp_data_ram_wea,
    ob_ccmp_data_ram_dina,
    ob_ccmp_data_ram_addrb,
    ob_ccmp_data_ram_enb,
    ob_ccmp_data_ram_doutb,
    ob_cpl_c2a_cdc_ram_addra,
    ob_cpl_c2a_cdc_ram_wea,
    ob_cpl_c2a_cdc_ram_dina,
    ob_cpl_c2a_cdc_ram_addrb,
    ob_cpl_c2a_cdc_ram_enb,
    ob_cpl_c2a_cdc_ram_doutb,
    cxpl_debug_info,
    cxpl_debug_info_ei
    ,edma_int
   ,
    cfg_2ndbus_num,
    cfg_subbus_num,
    cfg_2nd_reset
    ,
    clkreq_in_n,
    pm_linkst_in_l1sub,
    cfg_l1sub_en,
    mac_phy_pclkreq_n
    ,
    app_clk_pm_en
   ,aux_clk_active

    ,cfg_ido_req_en
    ,cfg_ido_cpl_en

    ,cfg_send_cor_err
    ,cfg_send_nf_err
    ,cfg_send_f_err


    ,cfg_int_disable
    ,cfg_no_snoop_en
    ,cfg_relax_order_en





);



parameter INST = 0;
parameter NL = 4;
localparam L2NL    = NL==1 ? 1 : `CX_LOGBASE2(NL);  // log2 number of NL
parameter TXNL = 4;
parameter RXNL = 4;
parameter NB = 4;
parameter PHY_NB = 1;
parameter CM_PHY_NB = 1;
parameter NW = 4;
parameter NF = 2;
parameter PF_WD = 1;
parameter NVC = 1;
parameter NHQ = 1;
parameter NDQ = 1;
parameter DATA_PAR_WD = 0;
parameter TRGT_DATA_WD = 128;

parameter ADDR_PAR_WD = 0;
parameter DW_W_PAR = 128;
parameter DW_WO_PAR = 128;
parameter RAS_PCIE_HDR_PROT_WD = 0;
parameter TX_HW_W_PAR = 128;
parameter RADM_P_HWD = 133;
parameter DW = 128;
parameter DATA_WIDTH = 128;
parameter ADDR_WIDTH = 64;
// parameter ADDR_WIDTH        = (`CC_DEVICE_TYPE==`CC_EP) ? ( `RADM_PARBITS_OUT_VALUE ? `FLT_Q_ADDR_WIDTH + ADDR_PAR_WD : `FLT_Q_ADDR_WIDTH ) : `FLT_Q_ADDR_WIDTH;
parameter RX_NDLLP = 2;
parameter L2N_INTFC = 1;
parameter ALL_FUNC_NUM = 24'hfac688;
parameter TRGT_HDR_WD = 133;
parameter TRGT_HDR_PROT_WD = 0;
parameter CLIENT_HDR_PROT_WD = 0;
parameter ST_HDR = 157;
parameter HDR_PROT_WD = 0;
parameter RBUF_DEPTH = 136;
parameter RBUF_PW = 8;
parameter SOTBUF_DP = 128;
parameter SOTBUF_PW = 7;
parameter SOTBUF_WD = 8;
parameter DATAQ_WD = 137;
parameter RADM_Q_DATABITS = 129;
parameter RADM_Q_DATABITS_O = 129;
parameter LBC_EXT_AW = 32;

parameter RADM_PQ_HWD = 139;
parameter RADM_NPQ_HWD = 139;
parameter RADM_CPLQ_HWD = 103;
parameter RADM_PQ_HPW = 6;
parameter RADM_NPQ_HPW = 6;
parameter RADM_CPLQ_HPW = 2;
parameter RADM_PQ_DPW = 7;
parameter RADM_NPQ_DPW = 4;
parameter RADM_CPLQ_DPW = 2;

parameter RADM_Q_H_CTRLBITS = 1;
parameter RADM_Q_D_CTRLBITS = 1;
parameter RADM_PQ_H_DATABITS = 134;
parameter RADM_PQ_H_DATABITS_O = 134;
parameter RADM_NPQ_H_DATABITS = 139;
parameter RADM_NPQ_H_DATABITS_O = 139;
parameter RADM_CPLQ_H_DATABITS = 103;
parameter RADM_CPLQ_H_DATABITS_O = 103;

parameter RADM_PQ_H_ADDRBITS = 7;
parameter RADM_NPQ_H_ADDRBITS = 7;
parameter RADM_CPLQ_H_ADDRBITS = 7;
parameter RADM_PQ_D_ADDRBITS = 7;
parameter RADM_NPQ_D_ADDRBITS = 7;
parameter RADM_CPLQ_D_ADDRBITS = 7;

parameter RADM_PQ_HDP = 54;
parameter RADM_NPQ_HDP = 54;
parameter RADM_CPLQ_HDP = 3;
parameter RADM_PQ_DDP = 97;
parameter RADM_NPQ_DDP = 12;
parameter RADM_CPLQ_DDP = 3;
parameter DCA_WD = 1;
parameter BUSNUM_WD = 8;
parameter DEVNUM_WD = 5;
parameter N_FLT_MASK = 5'h18;

parameter CPL_LUT_DEPTH = 32;


////reuse-pragma attr Visible false
//parameter SLV_DATA_WD        = `CC_SLV_DBUS_WD;
////reuse-pragma attr Visible false
//parameter SLV_ADDR_WD        = `CC_SLV_ADDR_WD;
////reuse-pragma attr Visible false
//parameter SLV_WSTRB_WD       = `CC_SLV_WSTRB_WD;
////reuse-pragma attr Visible false
//parameter SLV_ID_WD          = `CC_SLV_ID_WD;
parameter SLV_DATA_WD = 128;
parameter SLV_DATAP_WD = 1;
parameter SLV_ADDR_WD = 32;
parameter SLV_ADDRP_WD = 1;
parameter SLV_LOCK_WD = 2;
parameter SLV_WSTRB_WD = 16;
parameter SLV_ID_WD = 12;
parameter DBI_SLV_DATA_WD = 32;
parameter DBI_SLV_WSTRB_WD = 4;
parameter DBI_SLV_ADDR_WD = 33;
parameter DBI_SLV_LOCK_WD = 2;
parameter DBI_SLV_ID_WD = 4;
parameter DATA_PAR_CALC_WIDTH = 0;
parameter ADDR_PAR_CALC_WIDTH = 0;
////reuse-pragma attr Visible false
//parameter MSTR_DATA_WD       = `CC_MSTR_DBUS_WD;
////reuse-pragma attr Visible false
////reuse-pragma attr Visible false
////reuse-pragma attr Visible false
//parameter MSTR_ID_WD         = `CC_MSTR_ID_WD;

parameter MSTR_DATA_WD = 128;
parameter MSTR_DATAP_WD = 1;
parameter MSTR_ADDR_WD = 32;
parameter MSTR_ADDRP_WD = 1;
parameter MSTR_LOCK_WD = 2;
parameter MSTR_WSTRB_WD = 16;
parameter MSTR_ID_WD = 5;

// -------------------------------------------------------------------------------------
// Slave Non-Posted Write Set-Aside FIFO RAM // To do : update parameter names
 parameter SLV_NPW_SAB_RAM_DATA_WD = 100;
 parameter SLV_NPW_SAB_RAM_ADDR_WD = 5;
 parameter SLV_NPW_SAB_RAM_ADDRP_WD = 1;


// -------------------------------------------------------------------------------------
// Outbound Non-Posted Decomposer Header/Data FIFO RAM
 parameter OB_NPDCMP_RAM_DATA_WD = 126;
 parameter OB_NPDCMP_RAM_ADDR_WD = 4;
 parameter OB_NPDCMP_RAM_ADDRP_WD = 1;

// -------------------------------------------------------------------------------------
// Outbound Posted Decomposer Header FIFO RAM
 parameter OB_PDCMP_HDR_RAM_DATA_WD = 87;
 parameter OB_PDCMP_HDR_RAM_ADDR_WD = 4;
 parameter OB_PDCMP_HDR_RAM_ADDRP_WD = 1;

// -------------------------------------------------------------------------------------
// Outbound Posted Decomposer Data FIFO RAM
 parameter OB_PDCMP_DATA_RAM_DATA_WD = 128;
 parameter OB_PDCMP_DATA_RAM_ADDR_WD = 6;
 parameter OB_PDCMP_DATA_RAM_ADDRP_WD = 1;

// -------------------------------------------------------------------------------------
// Outbound Completion Composer Segmented Buffer RAM
 parameter OB_CCMP_DATA_RAM_DATA_WD = 133;
 parameter OB_CCMP_DATA_RAM_ADDR_WD = 9;
 parameter OB_CCMP_DATA_RAM_ADDRP_WD = 1;

// -------------------------------------------------------------------------------------
// Outbound Completion Async CDC FIFO RAM
 parameter OB_CPL_C2A_CDC_RAM_DATA_WD = 169;
 parameter OB_CPL_C2A_CDC_RAM_ADDR_WD = 4;
 parameter OB_CPL_C2A_CDC_RAM_ADDRP_WD = 1;

// -------------------------------------------------------------------------------------
// Inbound Read Request Order RAM
  parameter CC_IB_RD_REQ_ORDR_RAM_ADDR_WD = 5;
  parameter CC_IB_RD_REQ_ORDR_RAM_ADDRP_WD = 1;
  parameter CC_IB_RD_REQ_ORDR_RAM_DATA_WD = 161;

// -------------------------------------------------------------------------------------
// Inbound Read Request CDC FIFO RAM
  parameter CC_IB_RD_REQ_CDC_RAM_ADDR_WD = 4;
  parameter CC_IB_RD_REQ_CDC_RAM_ADDRP_WD = 1;
  parameter CC_IB_WR_REQ_CDC_RAM_ADDR_WD = 4;
  parameter CC_IB_WR_REQ_CDC_RAM_ADDRP_WD = 1;

// -------------------------------------------------------------------------------------
// Inbound Write Request CDC FIFO RAM
  parameter CC_IB_WR_REQ_CDC_RAM_DATA_WD = 311;
  parameter CC_IB_RD_REQ_CDC_RAM_DATA_WD = 183;

// -------------------------------------------------------------------------------------
// Inbound Master Completion CDC FIFO RAM
  parameter CC_IB_MCPL_CDC_RAM_ADDR_WD = 4;
  parameter CC_IB_MCPL_CDC_RAM_ADDRP_WD = 1;
  parameter CC_IB_MCPL_CDC_RAM_DATA_WD = 191;

// -------------------------------------------------------------------------------------
// Inbound Completion Data Segment Buffer RAM
  parameter CC_IB_MCPL_SEG_BUF_RAM_DATA_WD = 133;
  parameter CC_IB_MCPL_SEG_BUF_RAM_ADDR_WD = 10;
  parameter CC_IB_MCPL_SEG_BUF_RAM_ADDRP_WD = 1;


parameter MSTR_MISC_INFO_PW = 48;
parameter SLV_MISC_INFO_PW = 25;
parameter MSTR_RESP_MISC_INFO_PW = 13;
parameter SLV_RESP_MISC_INFO_PW = 14;
parameter MSTR_BURST_LEN_PW = 4;
parameter SLV_BURST_LEN_PW = 4;
parameter DBISLV_BURST_LEN_PW = 4;


parameter MAX_MSTR_TAGS = 32;
parameter MAX_MSTR_TAG_PW = 5;

parameter MAX_WIRE_TAG = 16;

parameter MAX_WIRE_TAG_PW = 4;

parameter CORE_ADDR_BUS_WD = 64;
parameter CORE_ADDR_PAR_WD = 0;

parameter DMA_CTX_RAM_ADDR_WIDTH = 2;


parameter DMA_CTX_RAM_DATA_WIDTH = 256;

parameter DMA_SEG_BUF_NW_ADDR_WIDTH = 9;


parameter DMA_SEG_BUF_DATA_WIDTH = 128;



localparam TX_COEF_WD = 18; // Width of concatenated bus for Equalization Coefficients: {C(+1); C(0), C(-1)}

localparam TX_DATA_WD = NL * PHY_NB * 8;
localparam TX_DATAK_WD = NL * PHY_NB;
parameter PDWN_WIDTH = 4;
parameter RATE_WIDTH = 1;
parameter TX_DEEMPH_WD = 2;

parameter ATU_OUT_REGIONS = 2;
parameter ATU_IN_REGIONS = 2;
// Size of upper base and target registers
parameter ATU_BASE_WD = 32;
// Size of lower base, limit and target registers
parameter ATU_REG_WD = 16;
parameter ATU_UPR_LMT_WD = 0;
localparam ATU_REG_LWR_WD = 32-ATU_REG_WD;     // width of lower address register which are not hardwired.
// Be nice to lint tools when 0 REGIONS are set(IN|OUT not both)
localparam ATU_OUT_MIN1 = ATU_OUT_REGIONS > 0 ? ATU_OUT_REGIONS : 1;
localparam ATU_IN_MIN1 = ATU_IN_REGIONS > 0 ? ATU_IN_REGIONS : 1;
localparam ERR_BUS_WD = 13;     // When TLP Prefixes are enabled, application error bus width is 12.
localparam RX_TLP = (NW==16) ? 4 : (NW==8) ? 2 : 1; // Number of TLPs that can be received in a single cycle
localparam FX_TLP               = (NW==16) ? 1 : RX_TLP;          // Number of TLPs that can be processed in a single cycle after the formation block
localparam RX_TLP_CXPL = (NW==16) ? 4 : (NW==8) ? 2 : 1; // Number of TLPs received in a single cycle after the u_cxpl block
localparam TX_NDLLP    =  1;

localparam TAG_SIZE    = `CX_TAG_SIZE;
localparam LOOKUPID_WD = `CX_REMOTE_LOOKUPID_WD;


localparam ATTR_WD = `FLT_Q_ATTR_WIDTH;


    `define AMBA_OR_NO_DMA
`define AMBA_TOP DWC_pcie_edma_amba_bridge
      `define AMBA_INST u_DWC_pcie_edma_axi_bridge
      `define AMBA_TOP_AMBADMA_WRAPPER


parameter LBC_INT_WD = 32;


parameter GEN2_DYNAMIC_FREQ_VALUE = 1;



parameter RADM_RAM_RD_LATENCY = 1;
parameter RETRY_RAM_RD_LATENCY = 1;
parameter RETRY_SOT_RAM_RD_LATENCY = 1;

localparam HCRD_WD   = `SCALED_FC_SUPPORTED ? 12 : 8;
localparam DCRD_WD   = `SCALED_FC_SUPPORTED ? 16 : 12;
// ------------------------------------------------------------------------------------------
// genvar declarations
// ------------------------------------------------------------------------------------------
genvar lane;  // used to instantiate per-lane logic
genvar func;  // used to instantiate per-function logic
genvar rx_tlp; // used to instantiate per-TLP logic

// ------------------------------------------------------------------------------------------
// Interface Signal Descriptions
// ------------------------------------------------------------------------------------------
input               app_clk_req_n;                  // Application request removal of reference clock
input               phy_clk_req_n;                  // PHY ready for removal of reference clock
input               perst_n; // main power ready indication
output              pm_req_sticky_rst;
output              pm_req_core_rst;
output              pm_req_non_sticky_rst;
output              pm_sel_aux_clk;
output              pm_req_phy_rst;
wire                pm_req_sticky_rst;
wire                pm_req_core_rst;
wire                pm_req_non_sticky_rst;
wire                pm_sel_aux_clk;
wire                pm_req_phy_rst;
wire  [4:0]         pm_master_state;
wire  [3:0]         pm_slave_state;






// AXI master write request
output  [MSTR_ID_WD -1:0]        mstr_awid;
output                           mstr_awvalid;
output  [MSTR_ADDR_WD -1:0]      mstr_awaddr;
output  [MSTR_BURST_LEN_PW -1:0] mstr_awlen;
output  [2:0]                    mstr_awsize;
output  [1:0]                    mstr_awburst;
output  [MSTR_LOCK_WD-1:0]       mstr_awlock;
output  [3:0]                    mstr_awcache;
output  [2:0]                    mstr_awprot;
output  [MSTR_MISC_INFO_PW -1:0] mstr_awmisc_info;
output                           mstr_awmisc_info_last_dcmp_tlp;
output  [63:0]                   mstr_awmisc_info_hdr_34dw;

output [5:0]                     mstr_awmisc_info_dma;
output  [PF_WD-1:0]              mstr_awmisc_info_func_num;
output                           mstr_awmisc_info_ido;
input                            mstr_awready;

// AXI master write data
output  [MSTR_ID_WD -1:0]        mstr_wid;
output                           mstr_wvalid;
output                           mstr_wlast;
output  [MSTR_DATA_WD -1:0]      mstr_wdata;
output  [MSTR_WSTRB_WD -1:0]     mstr_wstrb;
input                            mstr_wready;

// AXI master write response
input   [MSTR_ID_WD -1:0]        mstr_bid;
input                            mstr_bvalid;
input   [1:0]                    mstr_bresp;
input   [1:0]                    mstr_bmisc_info_cpl_stat;
output                           mstr_bready;

// AXI master read request
output  [MSTR_ID_WD -1:0]        mstr_arid;
output                           mstr_arvalid;
output  [MSTR_ADDR_WD -1:0]      mstr_araddr;
output  [MSTR_BURST_LEN_PW -1:0] mstr_arlen;
output  [2:0]                    mstr_arsize;
output  [1:0]                    mstr_arburst;
output  [MSTR_LOCK_WD-1:0]       mstr_arlock;
output  [3:0]                    mstr_arcache;
output  [2:0]                    mstr_arprot;
output  [MSTR_MISC_INFO_PW -1:0] mstr_armisc_info;
output               mstr_armisc_info_last_dcmp_tlp;
output  [5:0]                    mstr_armisc_info_dma;
output  [PF_WD-1:0]              mstr_armisc_info_func_num;
output                           mstr_armisc_info_ido;
input                            mstr_arready;

// AXI master read response & read data
input   [MSTR_ID_WD -1:0]        mstr_rid;
input                            mstr_rvalid;
input                            mstr_rlast;
input   [MSTR_DATA_WD -1:0]      mstr_rdata;
input   [1:0]                    mstr_rresp;
input   [MSTR_RESP_MISC_INFO_PW -1:0] mstr_rmisc_info;
input   [1:0]                    mstr_rmisc_info_cpl_stat;
output                           mstr_rready;

// AXI master low power
input                            mstr_csysreq;
output                           mstr_csysack;
output                           mstr_cactive;
input                            mstr_aclk;
input                            mstr_aresetn;
input                            mstr_aclk_ug;
output                           mstr_aclk_active;

// AXI slave interface
// AXI slave Write address channel
input   [SLV_ID_WD -1:0] slv_awid;
input   [SLV_ADDR_WD -1:0] slv_awaddr;
input   [SLV_BURST_LEN_PW -1:0]  slv_awlen;
input   [2:0]                    slv_awsize;
input   [1:0]                    slv_awburst;
input   [SLV_LOCK_WD-1:0]        slv_awlock;
input   [3:0]                    slv_awcache;
input   [2:0]                    slv_awprot;
input                            slv_awvalid;
input   [SLV_MISC_INFO_PW -1:0]  slv_awmisc_info;
input   [63:0]                   slv_awmisc_info_hdr_34dw;
input   [TAG_SIZE-1:0]           slv_awmisc_info_p_tag;
input                            slv_awmisc_info_atu_bypass;
input   [PF_WD-1:0]              slv_awmisc_info_func_num;
input                            slv_awmisc_info_ido;
output                           slv_awready;

// AXI slave Write data channel
input   [SLV_ID_WD -1:0]         slv_wid;
input   [SLV_DATA_WD -1:0]       slv_wdata;
input   [SLV_WSTRB_WD -1:0]      slv_wstrb;
input                            slv_wlast;
input                            slv_wvalid;
output                           slv_wready;

// AXI slave Write response channel
output  [SLV_ID_WD -1:0]         slv_bid;
output  [1:0]                    slv_bresp;
output                           slv_bvalid;
output  [SLV_RESP_MISC_INFO_PW -1:0]  slv_bmisc_info;
input                            slv_bready;
// AXI slave Read address channel
input   [SLV_ID_WD -1:0]         slv_arid;
input   [SLV_ADDR_WD -1:0]       slv_araddr;
input   [SLV_BURST_LEN_PW -1:0]  slv_arlen;
input   [2:0]                    slv_arsize;
input   [1:0]                    slv_arburst;
input   [SLV_LOCK_WD-1:0]        slv_arlock;
input   [3:0]                    slv_arcache;
input   [2:0]                    slv_arprot;
input                            slv_arvalid;
input   [SLV_MISC_INFO_PW -1:0]  slv_armisc_info;
input                            slv_armisc_info_atu_bypass;
input   [PF_WD-1:0]              slv_armisc_info_func_num;
input                            slv_armisc_info_ido;
output                           slv_arready;
// AXI slave Read data channel
output  [SLV_ID_WD -1:0]         slv_rid;
output  [SLV_DATA_WD -1:0]       slv_rdata;
output  [1:0]                    slv_rresp;
output                           slv_rlast;
output                           slv_rvalid;
output  [SLV_RESP_MISC_INFO_PW -1:0]  slv_rmisc_info;
output                           slv_rmisc_info_ido;
input                            slv_rready;
// AXI slave Low-power Channel
input                            slv_csysreq;
output                           slv_csysack;
output                           slv_cactive;

// clk_and_reset Signal Descriptions for axi side.
input                            slv_aclk;
input                            slv_aresetn;
input                            slv_aclk_ug;
output                           slv_aclk_active;




   output [CC_IB_RD_REQ_ORDR_RAM_ADDR_WD-1:0]     ib_rreq_ordr_ram_addra;
   output                                         ib_rreq_ordr_ram_wea;
   output [CC_IB_RD_REQ_ORDR_RAM_DATA_WD-1:0]     ib_rreq_ordr_ram_dina;
   output [CC_IB_RD_REQ_ORDR_RAM_ADDR_WD-1:0]     ib_rreq_ordr_ram_addrb;
   output                                         ib_rreq_ordr_ram_enb;
   input  [CC_IB_RD_REQ_ORDR_RAM_DATA_WD-1:0]     ib_rreq_ordr_ram_doutb;
   output [CC_IB_RD_REQ_CDC_RAM_ADDR_WD-1:0]      ib_rreq_c2a_cdc_ram_addra;
   output                                         ib_rreq_c2a_cdc_ram_wea;
   output [CC_IB_RD_REQ_CDC_RAM_DATA_WD-1:0]      ib_rreq_c2a_cdc_ram_dina;
   output [CC_IB_RD_REQ_CDC_RAM_ADDR_WD-1:0]      ib_rreq_c2a_cdc_ram_addrb;
   output                                         ib_rreq_c2a_cdc_ram_enb;
   input [CC_IB_RD_REQ_CDC_RAM_DATA_WD-1:0]       ib_rreq_c2a_cdc_ram_doutb;
   output [CC_IB_WR_REQ_CDC_RAM_ADDR_WD-1:0]      ib_wreq_c2a_cdc_ram_addra;
   output                                         ib_wreq_c2a_cdc_ram_wea;
   output [CC_IB_WR_REQ_CDC_RAM_DATA_WD-1:0]      ib_wreq_c2a_cdc_ram_dina;
   output [CC_IB_WR_REQ_CDC_RAM_ADDR_WD-1:0]      ib_wreq_c2a_cdc_ram_addrb;
   output                                         ib_wreq_c2a_cdc_ram_enb;
   input [CC_IB_WR_REQ_CDC_RAM_DATA_WD-1:0]       ib_wreq_c2a_cdc_ram_doutb;
// Master completion buffer segment buffer RAM outputs
output [CC_IB_MCPL_SEG_BUF_RAM_ADDR_WD-1:0]   ib_mcpl_sb_ram_addra;
output                                        ib_mcpl_sb_ram_wea;
output [CC_IB_MCPL_SEG_BUF_RAM_DATA_WD-1:0]   ib_mcpl_sb_ram_dina;
output [CC_IB_MCPL_SEG_BUF_RAM_ADDR_WD-1:0]   ib_mcpl_sb_ram_addrb;
output                                        ib_mcpl_sb_ram_enb;
input  [CC_IB_MCPL_SEG_BUF_RAM_DATA_WD-1:0]   ib_mcpl_sb_ram_doutb;
  // Master completion buffer AMBA to PCIe core clock domain crossing FIFO RAM outputs
output [CC_IB_MCPL_CDC_RAM_ADDR_WD-1:0]     ib_mcpl_a2c_cdc_ram_addra;
output                                      ib_mcpl_a2c_cdc_ram_wea;
output                                      ib_mcpl_a2c_cdc_ram_enb;
output [CC_IB_MCPL_CDC_RAM_DATA_WD-1:0]     ib_mcpl_a2c_cdc_ram_dina;
output [CC_IB_MCPL_CDC_RAM_ADDR_WD-1:0]     ib_mcpl_a2c_cdc_ram_addrb;
input  [CC_IB_MCPL_CDC_RAM_DATA_WD-1:0]     ib_mcpl_a2c_cdc_ram_doutb;
  output [SLV_NPW_SAB_RAM_ADDR_WD-1:0]      slv_npw_sab_ram_addra;
  output                                    slv_npw_sab_ram_wea;
  output [SLV_NPW_SAB_RAM_DATA_WD-1:0]      slv_npw_sab_ram_dina;
  output [SLV_NPW_SAB_RAM_ADDR_WD-1:0]      slv_npw_sab_ram_addrb;
  output                                    slv_npw_sab_ram_enb;
  input  [SLV_NPW_SAB_RAM_DATA_WD-1:0]      slv_npw_sab_ram_doutb;
  output [OB_NPDCMP_RAM_ADDR_WD-1:0]        ob_npdcmp_ram_addra;
  output                                    ob_npdcmp_ram_wea;
  output [OB_NPDCMP_RAM_DATA_WD-1:0]        ob_npdcmp_ram_dina;
  output [OB_NPDCMP_RAM_ADDR_WD-1:0]        ob_npdcmp_ram_addrb;
  output                                    ob_npdcmp_ram_enb;
  input  [OB_NPDCMP_RAM_DATA_WD-1:0]        ob_npdcmp_ram_doutb;

  output [OB_PDCMP_HDR_RAM_ADDR_WD-1:0]     ob_pdcmp_hdr_ram_addra;
  output                                    ob_pdcmp_hdr_ram_wea;
  output [OB_PDCMP_HDR_RAM_DATA_WD-1:0]     ob_pdcmp_hdr_ram_dina;
  output [OB_PDCMP_HDR_RAM_ADDR_WD-1:0]     ob_pdcmp_hdr_ram_addrb;
  output                                    ob_pdcmp_hdr_ram_enb;
  input  [OB_PDCMP_HDR_RAM_DATA_WD-1:0]     ob_pdcmp_hdr_ram_doutb;

  output [OB_PDCMP_DATA_RAM_ADDR_WD-1:0]    ob_pdcmp_data_ram_addra;
  output                                    ob_pdcmp_data_ram_wea;
  output [OB_PDCMP_DATA_RAM_DATA_WD-1:0]    ob_pdcmp_data_ram_dina;
  output [OB_PDCMP_DATA_RAM_ADDR_WD-1:0]    ob_pdcmp_data_ram_addrb;
  output                                    ob_pdcmp_data_ram_enb;
  input  [OB_PDCMP_DATA_RAM_DATA_WD-1:0]    ob_pdcmp_data_ram_doutb;

  output [OB_CCMP_DATA_RAM_ADDR_WD-1:0]     ob_ccmp_data_ram_addra;
  output                                    ob_ccmp_data_ram_wea;
  output [OB_CCMP_DATA_RAM_DATA_WD-1:0]     ob_ccmp_data_ram_dina;
  output [OB_CCMP_DATA_RAM_ADDR_WD-1:0]     ob_ccmp_data_ram_addrb;
  output                                    ob_ccmp_data_ram_enb;
  input  [OB_CCMP_DATA_RAM_DATA_WD-1:0]     ob_ccmp_data_ram_doutb;
  output [OB_CPL_C2A_CDC_RAM_ADDR_WD-1:0]   ob_cpl_c2a_cdc_ram_addra;
  output                                    ob_cpl_c2a_cdc_ram_wea;
  output                                    ob_cpl_c2a_cdc_ram_enb;
  output [OB_CPL_C2A_CDC_RAM_DATA_WD-1:0]   ob_cpl_c2a_cdc_ram_dina;
  output [OB_CPL_C2A_CDC_RAM_ADDR_WD-1:0]   ob_cpl_c2a_cdc_ram_addrb;
  input  [OB_CPL_C2A_CDC_RAM_DATA_WD-1:0]   ob_cpl_c2a_cdc_ram_doutb;



wire                             radm_trgt1_dv;
wire                             radm_trgt1_hv;
wire                             radm_trgt1_eot;
wire                             radm_trgt1_tlp_abort;
wire                             radm_trgt1_dllp_abort;
wire                             radm_trgt1_ecrc_err;
wire [TRGT_DATA_WD-1:0]          radm_trgt1_data;
// LMD: Undriven net Range
// LJ: The function add_data_par is assigned to a signal radm_grant_tlp_type where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [DW_W_PAR -1:0]             radm_trgt1_data_w_par;
// leda NTL_CON12 on
wire [NW -1:0]                   radm_trgt1_dwen;
wire [1:0]                       radm_trgt1_fmt;
wire [4:0]                       radm_trgt1_type;
wire [2:0]                       radm_trgt1_tc;
wire [ATTR_WD-1:0]               radm_trgt1_attr;
wire [15:0]                      radm_trgt1_reqid;
wire [TAG_SIZE-1:0]              radm_trgt1_tag;
wire [PF_WD-1:0]                 radm_trgt1_func_num;
wire                             radm_trgt1_td;
wire                             radm_trgt1_poisoned;
wire [9:0]                       radm_trgt1_dw_len;
wire [3:0]                       radm_trgt1_first_be;
wire [3:0]                       radm_trgt1_last_be;
wire [ADDR_WIDTH -1:0]           radm_trgt1_addr;
wire [ADDR_WIDTH -1:0]           radm_trgt1_hdr_uppr_bytes;
wire [CORE_ADDR_BUS_WD -1:0]     radm_trgt1_addr_w_par;
wire                             radm_trgt1_rom_in_range;
wire [2:0]                       radm_trgt1_in_membar_range;
wire                             radm_trgt1_io_req_in_range;
wire [2:0]                       radm_trgt1_cpl_status;
wire [(NVC*3)-1:0]               trgt1_radm_pkt_halt;

wire                             radm_trgt1_bcm;
wire                             radm_trgt1_cpl_last;
wire [11:0]                      radm_trgt1_byte_cnt;
wire [15:0]                      radm_trgt1_cmpltr_id;



// START_IO:DBI Signal Descriptions.
wire    [31:0]                      slv_dbi_addr;                   // address in DBI interface
wire    [31:0]                      slv_dbi_din;                    // wire  data in DBI interface
wire                                slv_dbi_cs;                     // Chip select to program configuration space registers
wire                                slv_dbi_cs2;                    // Chip select2 wire  for DBI bus.  Used for changing
                                                                    // BAR mask/size in CDM.
wire    [3:0]                       slv_dbi_wr;                     // Byte write enable
                                                                    // 4'b0000: read
                                                                    // 4'b0001: write byte 0
                                                                    // 4'b0010: write byte 1
                                                                    // 4'b0100: write byte 2
                                                                    // 4'b1000: write byte 3
                                                                    // 4'b1111: write the entire DW
wire    [PF_WD-1:0]           slv_dbi_func_num;               // Function number of the DBI access
wire                                slv_lbc_dbi_ack;                // When asserted, indicates that the read/write operation
                                                                    // is completed.
wire    [31:0]                      slv_lbc_dbi_dout;               // Register read back data bus

// END_IO:DBI Signal Descriptions.


// AXI DBI slave interface
// AXI DBI slave Write address channel
input   [DBI_SLV_ID_WD -1:0]        dbi_awid;
input   [DBI_SLV_ADDR_WD -1:0]      dbi_awaddr;
input   [DBISLV_BURST_LEN_PW -1:0]  dbi_awlen;
input   [2:0]                       dbi_awsize;
input   [1:0]                       dbi_awburst;
input   [DBI_SLV_LOCK_WD-1:0]       dbi_awlock;
input   [3:0]                       dbi_awcache;
input   [2:0]                       dbi_awprot;
input                               dbi_awvalid;
output                              dbi_awready;

// AXI DBI slave Write data channel
input   [DBI_SLV_ID_WD -1:0]        dbi_wid;
input   [DBI_SLV_DATA_WD -1:0]      dbi_wdata;
input   [DBI_SLV_DATA_WD/8 -1:0]    dbi_wstrb;
input                               dbi_wlast;
input                               dbi_wvalid;
output                              dbi_wready;

// AXI DBI slave Write response channel
output  [DBI_SLV_ID_WD -1:0]        dbi_bid;
output  [1:0]                       dbi_bresp;
output                              dbi_bvalid;
input                               dbi_bready;

// AXI DBI slave Read address channel
input   [DBI_SLV_ID_WD -1:0]         dbi_arid;
input   [DBI_SLV_ADDR_WD -1:0]       dbi_araddr;
input   [DBISLV_BURST_LEN_PW -1:0]   dbi_arlen;
input   [2:0]                        dbi_arsize;
input   [1:0]                        dbi_arburst;
input   [DBI_SLV_LOCK_WD-1:0]        dbi_arlock;
input   [3:0]                        dbi_arcache;
input   [2:0]                        dbi_arprot;
input                                dbi_arvalid;
output                               dbi_arready;

// AXI DBI slave Read data channel
output  [DBI_SLV_ID_WD -1:0]         dbi_rid;
output  [DBI_SLV_DATA_WD -1:0]       dbi_rdata;
output  [1:0]                        dbi_rresp;
output                               dbi_rlast;
output                               dbi_rvalid;
input                                dbi_rready;

// AXI slave Low-power Channel
input                                dbi_csysreq;
output                               dbi_csysack;
output                               dbi_cactive;
// DBI Clock & Reset
input                                dbi_aclk;
input                                dbi_aresetn;
input                                dbi_aclk_ug;
output                               dbi_aclk_active;




// START_IO:ELBI Signal Descriptions. EP Mode Only
input   [NF-1:0]                    ext_lbc_ack;                    // When asserted, indicates that a read or write operation
                                                                    // to external register block is completed. There is no
                                                                    // minimum ACK response cycle required. A time-out timer
                                                                    // may be implemented to avoid lockup if application register
                                                                    // block never asserts the lbc_ect_ack signal.
input   [(`CX_LBC_NW*32*NF)-1:0]    ext_lbc_din;                    // Memory mapped end-point register read data Bus.
output  [LBC_EXT_AW-1:0]            lbc_ext_addr;                   // Memory mapped end-point register address. It will be
                                                                    // decoded by register blocks
output  [`CX_LBC_NW*32-1:0]         lbc_ext_dout;                   // Memory mapped end-point register write data Bus
output  [NF-1:0]                    lbc_ext_cs;                     // This signal is asserted when received TLP is a memory read
                                                                    // or write request and its address is in the supported range
                                                                    // by end-point device (as determined by BAR in configuration
                                                                    // space) and it is de-asserted when ext_lbc_ack is asserted.
output  [(4*`CX_LBC_NW)-1:0]        lbc_ext_wr;                     // Byte write enable
                                                                    // 4'b0000: read
                                                                    // 4'b0001: write byte 0
                                                                    // 4'b0010: write byte 1
                                                                    // 4'b0100: write byte 2
                                                                    // 4'b1000: write byte 3
                                                                    // 4'b1111: write the entire DW
output                              lbc_ext_rom_access;             // indicate the this access is for rom expansion
output                              lbc_ext_io_access;              // indicate the this access is for io
output  [2:0]                       lbc_ext_bar_num;                // indicate the this access is for which bar
// END_IO:ELBI Signal Descriptions.

// START_IO:CII Signal Descriptions. EP Mode Only
// END_IO:CII Signal Descriptions.


// START_IO:MSI Signal Descriptions. EP Mode Only
input                               ven_msi_req;                    // When asserted, application is requesting to send MSI/MSI-X.
                                                                    // It stays asserted until ven_msi_grant is asserted.
input   [PF_WD-1:0]                 ven_msi_func_num;               // MSI/MSI-X function number, set to 0 for function 0;
                                                                    // set to 1 for function 1 etc
input   [2:0]                       ven_msi_tc;                     // MSI/MSI-X Traffic Class, default to 0.
                                                                    // It is valid when ven_msi_req is asserted
input   [4:0]                       ven_msi_vector;                 // MSI vector driven by application logic, which is used to
                                                                    // modulate the lowest 5 bits in the ven_msi_data register,
                                                                    // it is valid when ven_msi_req is asserted and only valid
                                                                    // when multiple MSI messages is granted to this device
output                              ven_msi_grant;                  // When asserted, MSI requested was sent. One cycle pulse.
output  [NF-1:0]                    cfg_msi_en;                     // When set, MSI is enabled, INTx msg will not be sent.
// END_IO:MSI Signal Descriptions.

// START_IO:MSI-X Signal Descriptions. EP Mode Only
// END_IO:MSI-X Signal Descriptions.
// START_IO:VPD Signal Descriptions.
output  [NF-1:0]                    cfg_vpd_int;                    // VPD Interrupt to application.  One cycle pulse.
                                                                    // When asserted, application should read the VPD registers.
// END_IO:VPD Signal Descriptions.

// START_IO:FLR Signal Descriptions.
output  [NF-1:0]                    cfg_flr_pf_active;              // Set when software initiates an FLR on a physical function.
                                                                    // One bit per Physical Function
input   [NF-1:0]                    app_flr_pf_done;                // Asserted by the application that it has finished all FLR activities.
                                                                    // Should be held high until cfg_flr_pf_active is deasserted
                                                                    // One bit per Physical Function
// END_IO:FLR Signal Descriptions.




// START_IO: Power Budgeting Signal Descriptions.
input   [31:0]                      cfg_pwr_budget_data_reg;        // Power Budgeting: Data Register from application
input   [PF_WD-1:0]                 cfg_pwr_budget_func_num;        // Power Budgeting: Function # of data register above
output  [7:0]                       cfg_pwr_budget_data_sel_reg;    // Power Budgeting: Data Select register
output  [NF-1:0]                    cfg_pwr_budget_sel;             // Power Budgeting: One cycle pulse signal indicates new data_sel_reg
// END_IO: Power Budgeting Signal Descriptions.



// START_IO:VMI Signal Descriptions.
input   [1:0]                       ven_msg_fmt;                    // Vendor MSG header: Vendor message FMT field, it is
                                                                    // valid when ven_msg_req is asserted
input   [4:0]                       ven_msg_type;                   // Vendor MSG header: Vendor message Type field, it is
                                                                    // valid when ven_msg_req is asserted
input   [2:0]                       ven_msg_tc;                     // Vendor MSG header: Vendor message TC field, it is valid
                                                                    // when ven_msg_req is asserted
input                               ven_msg_td;                     // Vendor MSG header: Vendor message TD field, it is valid
                                                                    // when ven_msg_req is asserted
input                               ven_msg_ep;                     // Vendor MSG header: Vendor message EP field, it is valid
                                                                    // when ven_msg_req is asserted
input   [ATTR_WD-1:0]               ven_msg_attr;                   // Vendor MSG header: Vendor message attribute field, it is
                                                                    // valid when ven_msg_req is asserted
input   [9:0]                       ven_msg_len;                    // Vendor MSG header: Vendor message length field, it is
                                                                    // valid when ven_msg_req is asserted
input   [PF_WD-1:0]                 ven_msg_func_num;               // Vendor MSG header: Vendor message function number, it is valid
                                                                    // when ven_msg_req is asserted
input   [TAG_SIZE-1:0]              ven_msg_tag;                    // Vendor MSG header: Vendor msg tag, it is valid when
                                                                    // ven_msg_req is asserted
input   [7:0]                       ven_msg_code;                   // Vendor MSG header: Vendor msg code, it is valid when
                                                                    // ven_msg_req is asserted
input   [63:0]                      ven_msg_data;                   // Vendor msg payload data, it is valid when ven_msg_req
                                                                    // is asserted
input                               ven_msg_req;                    // It requests CXEP core to generate and send Vendor MSG when
                                                                    // it is asserted. It is de-asserted when CXEP core asserts
                                                                    // ven_msg_grant
output                              ven_msg_grant;                  // When asserted, Vendor MSG is granted the cycles
// END_IO:VMI Signal Descriptions.

// START_IO:SII Signal Descriptions.
input                               rx_lane_flip_en;                // Enable the physical RX lane flip so that a physical layout problem of
                                                                    // lane reversed can be fixes. This bit 0 indicates that core currently
                                                                    // requires the LSB lane (i.e lane0) to be physically presented.
                                                                    // When this bit is asserted 1 enables the flip of the MSB lane to lane0.
input                               tx_lane_flip_en;                // Enable the physical TX lane flip so that a physical layout problem of
                                                                    // lane reversed can be fixes. This bit 0 indicates that core currently
                                                                    // requires the LSB lane (i.e lane0) to be physically presented.
                                                                    // When this bit is asserted 1 enables the flip of the MSB lane to lane0
input   [NF-1:0]                    sys_int;                        // Interrupt pin Per function to
                                                                    // support legacy devices that do not support MSI mechanism.
input   [NF-1:0]                    outband_pwrup_cmd;              // EP Mode Only: It is used to wake up the PMC state machine
                                                                    // from D2 state. For example, it may be asserted by
                                                                    // application WOL logic.
input                               app_unlock_msg;                 // RC Mode Only: Generate unlock message. Used for logging into CDM registers
input                               apps_pm_xmt_turnoff;            // RC Mode Only: Generate PM turnoff message for power management
input   [NF-1:0]                    apps_pm_xmt_pme;                // EP Mode Only: Indicates that application wishes to wake up PF (one clock pulse).
input                               sys_aux_pwr_det;                // When asserted, aux power is detected
input                               app_ltssm_enable;               // application signal to enable the LTSSM, if deasserted, it indicates that application is not ready
input   [NF-1:0]                    sys_atten_button_pressed;       // Attention button was pressed
input   [NF-1:0]                    sys_pre_det_state;              // Presence detect state. Used for logging into CDM registers.
input   [NF-1:0]                    sys_mrl_sensor_state;           // MRL sensor state. Used for logging into CDM registers.
input   [NF-1:0]                    sys_pwr_fault_det;              // Power fault detect. Used for logging into CDM registers.
input   [NF-1:0]                    sys_mrl_sensor_chged;           // MRL sensor changed. Used for logging into CDM registers.
input   [NF-1:0]                    sys_pre_det_chged;              // Presence detect changed. Used for logging into CDM registers.
input   [NF-1:0]                    sys_cmd_cpled_int;              // command cpLED interrupt. Used for logging into CDM registers.
input   [NF-1:0]                    sys_eml_interlock_engaged;      // Electromechanical Interlock engaged
output  [(2*NF)-1:0]                cfg_pwr_ind;                    // Power indicator control - 01: On, 10: Blink, 11: Off, 00: Reserved
output  [(2*NF)-1:0]                cfg_atten_ind;                  // Attention indicator control - 01: On, 10: Blink, 11: Off, 00: Reserved
output  [NF-1:0]                    cfg_pwr_ctrler_ctrl;            // Power controller control

output  [NVC-1:0]                   radm_q_not_empty;               // RADM queues contain data
output  [NVC-1:0]                   radm_qoverflow;                 // RADM queue overflow pulse

    // ELBI interface
output                              pm_xtlh_block_tlp;              // Power management control to block schedule of new TLP requests.
                                                                    // Used for logging into CDM registers.
output  [(64*NF)-1:0]               cfg_bar0_start;                 // Memory or IO BAR start address, support both 32-bit and 64-bit
output  [(32*NF)-1:0]               cfg_bar1_start;                 // Memory or IO BAR start address, support both 32-bit
output  [(64*NF)-1:0]               cfg_bar0_limit;                 // Memory or IO BAR end address, support both 32-bit and 64-bit
output  [(32*NF)-1:0]               cfg_bar1_limit;                 // Memory or IO BAR end address, support 32-bit
output  [(64*NF)-1:0]               cfg_bar2_start;                 // Memory or IO BAR Start address, support both 32-bit and 64-bit
output  [(64*NF)-1:0]               cfg_bar2_limit;                 // Memory or IO BAR end address, support both 32-bit and 64-bit
output  [(32*NF)-1:0]               cfg_bar3_start;                 // Memory or IO BAR Start address, support 32-bit
output  [(32*NF)-1:0]               cfg_bar3_limit;                 // Memory or IO BAR end address, support 32-bit
output  [(64*NF)-1:0]               cfg_bar4_start;                 // Memory or IO BAR Start address, support both 32-bit and 64-bit
output  [(64*NF)-1:0]               cfg_bar4_limit;                 // Memory or IO BAR end address, support both 32-bit and 64-bit
output  [(32*NF)-1:0]               cfg_bar5_start;                 // Memory or IO BAR Start address, support 32-bit
output  [(32*NF)-1:0]               cfg_bar5_limit;                 // Memory or IO BAR end address, support 32-bit
output  [(32*NF)-1:0]               cfg_exp_rom_start;              // Expansion ROM base Address
output  [(32*NF)-1:0]               cfg_exp_rom_limit;              // Expansion ROM Limit
output  [NF-1:0]                    cfg_bus_master_en;              // Bus master enabled
output  [NF-1:0]                    cfg_mem_space_en;               // Memory space is enabled
output  [(3*NF)-1:0]                cfg_max_rd_req_size;            // Maximum read request size
output  [(3*NF)-1:0]                cfg_max_payload_size;           // Maximum MTU size
output  [NF-1:0]                    cfg_rcb;                        // 128byte RCB boundary
output  [NF -1 :0]                  cfg_pm_no_soft_rst;             // Indicates that not soft reset needed
output                              rdlh_link_up;                   // output for reset module to assert reset base on link down
output  [2:0]                       pm_curnt_state;                 // current power down state that is used for reset or
                                                                    // clock module to bring the proper power down actions
output  [NF-1:0]                    cfg_aer_rc_err_int;             // RC Only: Error interrupt
output  [NF-1:0]                    cfg_aer_rc_err_msi;             // RC Only: Error MSI/MSI-X
output  [(NF*5)-1:0]                cfg_aer_int_msg_num;            // RC Only: Advanced Error Interrupt Message Number
output  [NF-1:0]                    cfg_sys_err_rc;                 // RC Only: System error
output  [NF-1:0]                    cfg_pme_int;                    // RC Only: Interrupt caused by PME
output  [NF-1:0]                    cfg_pme_msi;                    // RC Only: MSI caused by PME
output  [(NF*5)-1:0]                cfg_pcie_cap_int_msg_num;       // RC & SW Only: Interrupt Message Number
output  [5:0]                       smlh_ltssm_state;               // Current LTSSM state. Intended to be used as debug information
output                              smlh_link_up;                   // Report LTSSM is in L0 state
output                              smlh_req_rst_not;               // Link reset request.
output                              link_req_rst_not;               // This signal is designed to guide application reset module to reset link. It is supposed to be used
                                                                    // by detecting its falling edge. When this signal deasserted from high to low, it report that LTSSM is in Detect.Quiet and it is okay to reset the core
output                              brdg_slv_xfer_pending;
output                              brdg_dbi_xfer_pending;
output                              edma_xfer_pending;
output                              radm_xfer_pending;

output  [63:0]                      cxpl_debug_info;                // Debug bus provides internal status information
                                                                    // See cx_pl.v for bit field descriptions
output  [`CX_INFO_EI_WD-1:0]        cxpl_debug_info_ei;             // Debug bus, provides internal status information related to electrical idle
                                                                    // See smlh_ltssm.v for bit field descriptions
output                              radm_msg_unlock;                // received unlock message
output  [FX_TLP-1:0]                radm_vendor_msg;                // received vendor message
output  [(FX_TLP*64)-1:0]           radm_msg_payload;               // vendor message 1dword info
output                              wake;                           // WAKE# signal from power management unit
output                              clk_req_n;                      // indicates to PHY the states that required clock. When it inidcates not required clock, it is imporatant to make sure that PHY is specially designed for this.
output  [(FX_TLP*16)-1:0]           radm_msg_req_id;                // RC Mode Only: received message request id
output                              radm_inta_asserted;             // RC Mode Only:
output                              radm_intb_asserted;             // RC Mode Only:
output                              radm_intc_asserted;             // RC Mode Only:
output                              radm_intd_asserted;             // RC Mode Only:
output                              radm_inta_deasserted;           // RC Mode Only:
output                              radm_intb_deasserted;           // RC Mode Only:
output                              radm_intc_deasserted;           // RC Mode Only:
output                              radm_intd_deasserted;           // RC Mode Only:
output                              radm_correctable_err;           // RC Mode Only:
output                              radm_nonfatal_err;              // RC Mode Only:
output                              radm_fatal_err;                 // RC Mode Only:
output                              radm_pm_pme;                    // RC Mode Only: Power Management event Msg received.
output                              radm_pm_to_ack;                 // RC Mode Only: Received PME_TO_Ack
output  [RX_NDLLP-1:0]              rtlh_rfc_upd;                   // RC Mode Only: FC pkt rcvd from RTLH
output  [(32*RX_NDLLP)-1:0]         rtlh_rfc_data;                  // RC Mode Only: 32bits FC data from RTLH
output  [NF-1:0]                    cfg_eml_control;                // Electromechanical Interlock Control
output  [NF-1:0]                    hp_pme;                         // Hot plug PME software notification
output  [NF-1:0]                    hp_int;                         // Hot plug interrupt software notification
output  [NF-1:0]                    hp_msi;                         // Hot plug MSI/MSI-X software notification
output                              radm_pm_turnoff;                // EP Mode Only: Received PMC_Turn_Off
// END_IO:SII Signal Descriptions.
output                              trgt_cpl_timeout;               // Transmit CPL is timeout, it indicates the timeout when no CPL is
                                                                    // received in the expected time window
output  [PF_WD-1:0]                 trgt_timeout_cpl_func_num;      // Transmit Timeout CPL function number, it indicates the function number
                                                                    // of the timeout completion
output  [2:0]                       trgt_timeout_cpl_tc;            // Transmit Timeout CPL TC, it indicates the TC of the timeout CPL
output  [1:0]                       trgt_timeout_cpl_attr;          // Transmit Timeout CPL attributes, it indicates the attribute of the
                                                                    // Transmit timeout CPL
output  [11:0]                      trgt_timeout_cpl_len;           // Transmit Timeout CPL length, it indicates the length in bytes of the
                                                                    // Transmit timeout CPL
output  [LOOKUPID_WD-1:0]           trgt_timeout_lookup_id;         // Transmit Timeout CPL lookup Id
output  [LOOKUPID_WD-1:0]           trgt_lookup_id;                 // Target completion lookup ID. It is used for application to return completion with a specific assigned ID.
output                              trgt_lookup_empty;              // Target completion lookup exhausting condition indication  . When asserted, we should halt the RADM target1 interface. This is output because appliction needs to OR its target1_halt with this signal to stop taking a new request since we have no more lookup ID at this moment.
// END_IO:RCPL Signal Descriptions. master interface: all TLPs (CPL cycles) decoded


// completion timeout interface
output                              radm_cpl_timeout;               // CPL is timeout, it indicates the timeout when no CPL is
                                                                    // received in the expected time window
output  [PF_WD-1:0]                 radm_timeout_func_num;          // Timeout CPL function number, it indicates the function number
                                                                    // of the timeout completion
output  [2:0]                       radm_timeout_cpl_tc;            // Timeout CPL TC, it indicates the TC of the timeout CPL
output  [1:0]                       radm_timeout_cpl_attr;          // Timeout CPL attributes, it indicates the attribute of the
                                                                    // timeout CPL
output  [11:0]                      radm_timeout_cpl_len;           // Timeout CPL length, it indicates the length in bytes of the
                                                                    // timeout CPL
output  [TAG_SIZE-1:0]              radm_timeout_cpl_tag;           // Timeout CPL tag, it indicates the tag of the timeout CPL
wire                                radm_cpl_timeout;               // CPL is timeout, it indicates the timeout when no CPL is
                                                                    // received in the expected time window
wire  [2:0]                         radm_timeout_cpl_tc;            // Timeout CPL TC, it indicates the TC of the timeout CPL
wire  [1:0]                         radm_timeout_cpl_attr;          // Timeout CPL attributes, it indicates the attribute of the
wire  [11:0]                        radm_timeout_cpl_len;           // Timeout CPL length, it indicates the length in bytes of the
                                                                    // timeout CPL
wire  [TAG_SIZE-1:0]                radm_timeout_cpl_tag;           // Timeout CPL tag, it indicates the tag of the timeout CPL
wire    [PF_WD-1:0]                 radm_timeout_func_num;          // timeout CPL function number

output  [(PDWN_WIDTH - 1) : 0]                       mac_phy_powerdown;              // Place PHY into following power states.
                                                                    // 0000 - P0, normal operation
                                                                    // 0001 - P0s, low recovery time latency
                                                                    // 0010 - P1, longer recovery time latency
                                                                    // 0011 - P2, lowest power state
                                                                    // CX_PIPE43_P1CPM_ENCODING: P1.CPM (L1 Substates L1.0)
                                                                    // CX_PIPE43_P1_1_ENCODING: P1.1 (L1 Substates L1.1)
                                                                    // CX_PIPE43_P1_2_ENCODING: P1.2 (L1 Substates L1.2)
                                                                    // Sourced from Power Management Controller
                                                                    // synchronous to this clock. For PxPipe, this is the receive clock.

input   [NL-1:0]                    phy_mac_rxelecidle;             // Indicates receiver detection of an electrical idle. This
                                                                    // is an asynchronous signals
input   [NL-1:0]                    phy_mac_phystatus;              // Used to communicate completion of several PHY functions
                                                                    // including power management state transitions,
                                                                    // and receiver detection
input                               pipe_clk;

// START_IO:PIPE Signal Descriptions.
input   [(TX_DATA_WD - 1):0]         phy_mac_rxdata;                 // The received data. 8/16 bits per lane SDM performs 8B10B
                                                                    // decode and error checking functions.
input   [(NL*PHY_NB)-1:0]           phy_mac_rxdatak;                // K character indication 1 or 2 bits per lane.  Signals SDM
                                                                    // detected comma. SDM may perform comma detect alignment as well.
input   [NL-1:0]                    phy_mac_rxvalid;                // Receive data is valid.
input   [(NL*3)-1:0]                phy_mac_rxstatus;               // Encoders receiver status and error codes for the received
                                                                    // data stream and receiver detection
input   [NL-1:0]                    phy_mac_rxstandbystatus;
input   [31:0]                      phy_cfg_status;                 // Generic PHY sideband status bus mapped to Port Logic register
                                                                    // for PHY configuration.  See SDM documentation for details.
                                                                    // (optional, determined by end-user)
output                              mac_phy_elasticbuffermode;
output  [NL-1:0]                    mac_phy_txdatavalid;
input   [NL-1:0]                    phy_mac_rxdatavalid;


output  [(TX_DATA_WD - 1):0]         mac_phy_txdata;                 // Parallel transmit data. 1 or 2 bytes per lane.
output  [(NL*PHY_NB)-1:0]           mac_phy_txdatak;                // K character indication 1 or 2 bits per lane.
                                                                    // Signals control character encoding to SDM.
output  [NL-1:0]                    mac_phy_txdetectrx_loopback;    // Enable receiver detection sequence.  SerDes transmits
                                                                    // receiver detection sequence or to begin loopback
output  [NL-1:0]                    mac_phy_txelecidle;             // Place transmitter (SerDes) into electrical idle.
output  [NL-1:0]                    mac_phy_txcompliance;           // Indicate to SDM to transmit a compliance sequence.
                                                                    // (Sets negative disparity).
output  [NL-1:0]                    mac_phy_rxpolarity;             // Invert the received data when asserted
output  [1:0]                       mac_phy_width;                  // Data Width: 0-8bit, 1-16bit, 2-32bit
output  [2:0]                       mac_phy_pclk_rate;              // Pclk rate: 0-62.5, 1-125, 2-250, 3-500, 4-1000MHz
output  [NL-1:0]                    mac_phy_rxstandby;              //

output  [RATE_WIDTH-1:0]            mac_phy_rate;                   // 1=change speed to gen2, 2-gen3, 0-gen1
output  [TX_DEEMPH_WD-1:0]          mac_phy_txdeemph;               // tx coef for gen3 rate, tx deemphasis for gen1/2 rate
output  [2:0]                       mac_phy_txmargin;               // selects transmitter voltage levels in the PHY
output                              mac_phy_txswing;                // selects transmitter voltage swing level in the PHY
output                              cfg_hw_auto_sp_dis;             // HW autonomous speed disable


output  [31:0]                      cfg_phy_control;                // Generic PHY sideband control bus mapped to Port Logic
                                                                    // register for PHY configuration.  See SDM documentation
                                                                    // for details. (Optional, determined by user)
// END_IO:PIPE Signal Descriptions.

// START_IO:clk_and_reset Signal Descriptions.
input   [3:0]                       device_type;                    // pin to select the core operation mode either EP or RC

input                               core_clk;                       // The primary clock input to the CXEP core. It is assumed
                                                                    // that all input signals other than resets are synchronous
                                                                    // to this clock. Depending on the configuration, this clock is
                                                                    // typically 125MHz or 250MHz.
input                               core_clk_ug;                    // An ungated version of core_clk used to track phystatus during powerdown states
input                               aux_clk;                        // aux_clk is the auxiliary Clock to PMC domain
                                                                    // The CXEP core provides a partitioning of some functions
                                                                    // which may be enabled to operate on an auxiliary clock in
                                                                    // certain power management states. The aux_clk input is provided
                                                                    // for this purpose.  The PMC is split off to run on aux_clk in L2
                                                                    // states if supported by the application.
                                                                    // In normal operation, the aux_clk and core_clk inputs are assumed
                                                                    // to be equivalent and the physical design implementation must
                                                                    // assume they are the same in terms of clock tree matching / skew.
                                                                    // For power management enabled solutions, it is the responsibility
                                                                    // of the end-user to manage any clock switching required to gate
                                                                    // core_clk and switch aux_clk from the normal operating frequency
                                                                    // to the slower clock rate used in the low power states.

input                               aux_clk_g;                      // Auxiliary gated clock to CDM and LBC. Disable when gated Power Managment
output                              en_aux_clk_g;                   // Enable signal from pm_ctrl module to clk_rst module. Disable aux_clk_g when gated Power Managment
input                               radm_clk_g;                     // Auxiliary gated clock to RADM. Disable when RADM module is in idle state
output                              en_radm_clk_g;                  // Enable signal from RADM module. Disable radm_clk_g when RADM module is in idle state
output                              radm_idle;                      // Status of RADM module. Output of radm_state module.
input                               pwr_rst_n;                      // When asserted, this resets the PMC module.
                                                                    // The pwr_rst_n input signal is used as the "cold reset"
                                                                    // applied to the CXEP core upon power up.  It must occur
                                                                    // following the application of Aux power.  Under normal
                                                                    // implementation, this reset impacts the registers including
                                                                    // sticky bits running under Aux Clock domain.
                                                                    // NOTE: the pwr_rst_n shall be asserted following the
                                                                    // application of the main power if Aux power is not
                                                                    // available to the device.
input                               sticky_rst_n;                   // When asserted, reset all sticky registers in
                                                                    // configuration register space.
input                               non_sticky_rst_n;               // When asserted, reset all non-sticky registers in
                                                                    // configuration register space.

input                               core_rst_n;                     // When asserted, resets the CXEP core, except for PMC module.
                                                                    // In some applications, end-user may choose to wire
                                                                    // core_rst_n as an "OR" function of main power on reset and
                                                                    // training reset. When first time power on the device,
                                                                    // core_rst_n is asserted to reset the non-aux domain logic;
                                                                    // subsequently core_rst_n will function as hot reset.
input                               pipe_rst_n;                     // When asserted, resets core logic clocked on pipe_clk.
                                                                    // Reset logic should assert pipe_rst_n at same time as
                                                                    // core_rst_n and deassert Synchronous to pipe_clk.
input                               app_init_rst;                   // N/A for end-point, used by downstream port of a switch.
input                               app_req_entr_l1;                // Provide a capability for applications to request PM state to enter L1.
                                                                    // This is only effective when ASPM of L1 is enabled.
input                               app_ready_entr_l23;             // Provide a capability for applications to notify PM module that it is ready
                                                                    // to enter L23 when Device is placed in D3 hot/cold
input                               app_req_exit_l1;                // Provide a capability for applications to request PM state to exit L1.
                                                                    // This is only effective when ASPM of L1 is enabled.
input                               app_req_retry_en;               // Allow application to enable LBC to return request retry status
                                                                    // to all configuration accesses
input                               app_xfer_pending;               // Allow application to indicate transfer pending to avoid going to L1
                                                   // When used for Readiness Notification, DRS messaging is blocked when app_req_retry_en is asserted.










output                              training_rst_n;                 // Hot reset from upstream component, shall be routed to
                                                                    // core_rst_n via reset tree. This signal is fully synchronous
                                                                    // to core_clk.  It is defined in the 1.0a spec. 4.2.5.11.
                                                                    // This reset is asserted by LTSSM when it receives two
                                                                    // consecutive TS1 ordered set with the hot_reset bit
                                                                    // asserted. (4.2.6.10). NOTE:  An end-device can't hot reset
                                                                    // the upstream component, can only be hot reset
                                                                    // by upstream component.
output  [BUSNUM_WD-1:0]             cfg_pbus_num;                   // configured primary bus number, it will be reserved during power down if PMC module is populated
output  [DEVNUM_WD-1:0]             cfg_pbus_dev_num;               // configured primary device number, it will be reserved during power down if PMC module is populated
output  [(3*NF)-1:0]                pm_dstate;                      // PF Power Management D-state
output  [NF-1:0]                    pm_status;
output  [NF-1:0]                    pm_pme_en;
output                              pm_linkst_in_l0s;
output                              pm_linkst_in_l1;
output                              pm_linkst_in_l2;
output                              pm_linkst_l2_exit;
output  [NF-1:0]                    aux_pm_en;
// END_IO:clk_and_reset Signal Descriptions.


//eDMA Local Interrupt
output [(`CC_NUM_DMA_RD_CHAN+`CC_NUM_DMA_WR_CHAN-1):0] edma_int;
output  [(8*NF)-1:0]                cfg_2ndbus_num;                 // configured primary bus number, it will be reserved during power down if PMC module is populated
output  [(8*NF)-1:0]                cfg_subbus_num;                 // configured primary bus number, it will be reserved during power down if PMC module is populated
output                              cfg_2nd_reset;     // application requests this downstream port to start link hot reset
output  [NF-1:0]        cfg_no_snoop_en;            // No Snoop enable
output  [NF-1:0]        cfg_relax_order_en;           // relaxed ordering enable


output                              cfg_link_auto_bw_int;           // Interrupt indicating that Link Bandwidth Management Status bit has been set
output                              cfg_bw_mgt_int;                 // Interrupt indicating that Link Autonomous Bandwidth Status bit has been set

output  [31:0]                      msi_ctrl_io;                    // MSI Interrupt Controller GPIO
output                              msi_ctrl_int;                   // MSI Interrupt Detected
output  [7:0]                       msi_ctrl_int_vec;               // MSI Interrupt Vector


// START_IO:rams
// Retry buffer external RAM interface
output  [RBUF_PW -1:0]              xdlh_retryram_addr;             // Adrress to retry buffer RAM
output  [`RBUF_WIDTH-1:0]           xdlh_retryram_data;             // Write data to retry buffer RAM
output                              xdlh_retryram_we;               // Write enable to retry buffer RAM
output                              xdlh_retryram_en;               // Read enable to retry buffer RAM
output                              xdlh_retryram_par_chk_val;      // Parity Check Valid
input                               retryram_xdlh_parerr_in;           // RAM parity error detected
input   [`RBUF_WIDTH-1:0]           retryram_xdlh_data;             // Data coming back from Retry buffer RAM

// Retry SOT buffer
output  [SOTBUF_PW -1:0]            xdlh_retrysotram_waddr;          // Write Adrress to retry buffer RAM
output  [SOTBUF_PW -1:0]            xdlh_retrysotram_raddr;          // Read Adrress to retry buffer RAM
output  [SOTBUF_WD -1:0]            xdlh_retrysotram_data;          // Write data to retry buffer RAM
output                              xdlh_retrysotram_we;            // Write enable to retry buffer RAM
output                              xdlh_retrysotram_en;            // Read enable to retry buffer RAM
output                              xdlh_retrysotram_par_chk_val;   // Parity Check Valid
input   [SOTBUF_WD -1:0]            retrysotram_xdlh_data;          // Data coming back from Retry buffer RAM
input                               retrysotram_xdlh_parerr_in;        // SOT RAM parity error

// Beneath are grouped inputs and outputs just for RAM
input   [RADM_PQ_H_DATABITS_O-1:0]  p_hdrq_dataout;
input   [RADM_Q_H_CTRLBITS-1:0]     p_hdrq_parerr_in;
output  [RADM_Q_H_CTRLBITS-1:0]     p_hdrq_par_chk_val;
output  [RADM_PQ_H_ADDRBITS-1:0]    p_hdrq_addra;
output  [RADM_PQ_H_ADDRBITS-1:0]    p_hdrq_addrb;
output  [RADM_PQ_H_DATABITS-1:0]    p_hdrq_datain;
output  [RADM_Q_H_CTRLBITS-1:0]     p_hdrq_ena;
output  [RADM_Q_H_CTRLBITS-1:0]     p_hdrq_enb;
output  [RADM_Q_H_CTRLBITS-1:0]     p_hdrq_wea;
input   [RADM_Q_DATABITS_O-1:0]     p_dataq_dataout;
input   [RADM_Q_D_CTRLBITS-1:0]     p_dataq_parerr_in;
output  [RADM_Q_D_CTRLBITS-1:0]     p_dataq_par_chk_val;
output  [RADM_PQ_D_ADDRBITS-1:0]    p_dataq_addra;
output  [RADM_PQ_D_ADDRBITS-1:0]    p_dataq_addrb;
output  [RADM_Q_DATABITS-1:0]       p_dataq_datain;
output  [RADM_Q_D_CTRLBITS-1:0]     p_dataq_ena;
output  [RADM_Q_D_CTRLBITS-1:0]     p_dataq_enb;
output  [RADM_Q_D_CTRLBITS-1:0]     p_dataq_wea;







// eDMA RAM Interface signals
input  [DMA_CTX_RAM_DATA_WIDTH-1:0]     ram2edma_din;

output [DMA_CTX_RAM_ADDR_WIDTH-1:0]     edma2ram_addra;
output [DMA_CTX_RAM_ADDR_WIDTH-1:0]     edma2ram_addrb;
output [DMA_CTX_RAM_DATA_WIDTH-1:0]     edma2ram_dout;
output                                  edma2ram_re;
output                                  edma2ram_we;
//eDMA Read buffer RAM interface signals

input  [DMA_SEG_BUF_DATA_WIDTH-1:0]    ram2edmarbuff_din;

output [DMA_SEG_BUF_NW_ADDR_WIDTH-1:0] edmarbuff2ram_addra;
output [DMA_SEG_BUF_NW_ADDR_WIDTH-1:0] edmarbuff2ram_addrb;
output [DMA_SEG_BUF_DATA_WIDTH-1:0]    edmarbuff2ram_dout;
output                                 edmarbuff2ram_re;
output                                 edmarbuff2ram_we;

// END_IO:rams


input                   aux_clk_active; // muxed aux clk has switched to low frequency clock, used when entering L1 to stall progression into L1 substates
input                   app_clk_pm_en;          // Clock PM feature enabled by application
input                   clkreq_in_n; // the state of the CLKREQ# pin, used for remotely initiated exit from L1 substates
output                  pm_linkst_in_l1sub; // link state has entered L1 PM substates - used in clk_rst to keep AUX clock switched to free running clock
output                  cfg_l1sub_en; // L1 Substates are enabled, used by app to determine when CLKREQ# can be driven
output [1:0]            mac_phy_pclkreq_n;     // Request PCLK removal:
                                               // 2'b00: do not request PCLK removal
                                               // 2'b01: request PCLK removal for executing L1 with Clock PM
                                               // 2'b10: request PCLK removal for executing L1 substates
                                               // 2'b11: request PCLK removal for executing L1 substates with Clock PM
wire    [`CX_L1SUB_CONTROL_WD-1:0]  cfg_l1sub_control; // L1 Substates control signal bus
wire    [`CX_PL_L1SUB_CONTROL_WD-1:0] cfg_pl_l1sub_control; // Port Logic L1 Substates control signal bus
wire                    cfg_pl_l1_exit_mode; // L1 exit mode
wire                    pm_smlh_l1_2_latched; // 1: L1_SUB entered L1_2 substate
wire                    pm_smlh_l1_n_latched; // 1: L1_SUB entered L1_n substate
wire    [7:0]           cfg_l1sub_t_common_mode = cfg_l1sub_control[`CX_L1SUB_CONTROL_T_COMM_MODE_RANGE]; // common mode time in us
wire                    pm_rcvd_as_req_l1; // downstream port has received request to enter ASPM L1
wire                    pm_rcvd_pm_enter_l1; // downstream port has received request to enter PCI-PM L1
wire                    pm_cpl_timer_decr; // decrement the timer
wire [`CX_PM_CPL_TIMER_WD-1:0] pm_cpl_timeout_value; // the number of 16us intervals to reach completion timeout
wire [`CX_PM_CPL_TIMER_WD-1:0] pm_cpl_timer; // how much time was spent in L1 substate, in 16us units
wire                    cfg_pl_l1_nowait_p1;
wire                    cfg_pl_l1_clk_sel;
wire    [`CX_PL_AUX_CLK_FREQ_WD-1:0]  cfg_pl_aux_clk_freq;   // programmable auxiliary clock frequency




wire  [63:0]                        xtranslated_addr_in_d;
wire  [4:0]                         xtranslated_type_in_d;
wire  [7:0]                         xtranslated_func_in_d;
wire                                xtranslate_enable;
wire   [63:0]                       x_addr_out;
wire   [1:0]                        x_fmt_out;
wire   [15:0]                       x_rid_out;
wire                                x_dma_out;
wire   [TAG_SIZE-1:0]               x_tag_out;
wire                                x_atu_bypass_out;
wire                                radm_trgt1_hdr_uppr_bytes_valid;
wire                                radm_trgt1_hdr_uppr_bytes_valid_atu;
wire                                radm_trgt1_hdr_uppr_bytes_valid_i;
wire [63:0]                         atu_trgt1_addr;
wire   [RADM_P_HWD-1:0]             radm_outq_pkt_hdr;          // TLP header fields before RADM outq manager pipeline.
wire                                radm_outq_halt_in;          // header halt signal
wire [1:0]                          radm_xlate_fmt;             // Fmt field which can be translated outside RADM

reg                                 translated_tlp_hdr_fmt0;
wire   [1:0]                        translated_tlp_hdr_fmt;

wire  [FX_TLP*64-1:0]               rtranslated_addr_in_d;
wire  [FX_TLP*2-1:0]                rtranslated_err_in_d;        // 00 -- Normal, 01 -- UR, 10 -- CA. 11-- Undifined (not allow)
wire   [FX_TLP*64-1:0]              r_addr_out;
wire   [FX_TLP*8-1:0]               r_func_out;
wire   [FX_TLP*5-1:0]               r_type_out;
wire   [FX_TLP*3-1:0]               r_bar_out;
wire   [FX_TLP-1:0]                 r_rombar_out;
wire                                xtranslated_inhibit_pyld_in;
wire                                xtranslated_inhibit_pyld_in_d;
wire      [2:0]                     xtranslated_tc_in_d;
wire                                xtranslated_td_in_d;
wire      [ATTR_WD-1:0]             xtranslated_attr_in_d;
wire      [TAG_SIZE-1:0]            xtranslated_tag_in_d;
wire      [7:0]                     xtranslated_msg_code_in_d;

wire   [FX_TLP*3-1:0]               r_tc_out;
wire   [FX_TLP-1:0]                 r_td_out;
wire   [FX_TLP*ATTR_WD-1:0]         r_attr_out;
wire   [FX_TLP*8-1:0]               r_msgcode_out;
wire      [(64*NF)-1:0]             cfg_bar0_mask;
wire      [(32*NF)-1:0]             cfg_bar1_mask;
wire      [(64*NF)-1:0]             cfg_bar2_mask;
wire      [(32*NF)-1:0]             cfg_bar3_mask;
wire      [(64*NF)-1:0]             cfg_bar4_mask;
wire      [(32*NF)-1:0]             cfg_bar5_mask;
wire      [(32*NF)-1:0]             cfg_rom_mask;

wire                                pipe_clk;

// PIPE Loopback connections
wire [8*PHY_NB*NL-1:0]    lpbk_rxdata;
wire [PHY_NB*NL-1:0]      lpbk_rxdatak;
wire [NL-1:0]             lpbk_rxvalid;
wire [NL-1:0]             lpbk_rxelecidle;
wire [NL-1:0]             lpbk_rxdatavalid;
wire [NL*3-1:0]           lpbk_rxstatus;
wire [NL-1:0]             lpbk_phystatus;

wire     retryram_xdlh_parerr;
wire     retrysotram_xdlh_parerr;



wire [RADM_Q_H_CTRLBITS-1:0]        p_hdrq_parerr;
wire [RADM_Q_D_CTRLBITS-1:0]        p_dataq_parerr;
wire [RADM_Q_H_CTRLBITS-1:0]        np_hdrq_parerr;
wire [RADM_Q_D_CTRLBITS-1:0]        np_dataq_parerr;
wire [RADM_Q_H_CTRLBITS-1:0]        cpl_hdrq_parerr;
wire [RADM_Q_D_CTRLBITS-1:0]        cpl_dataq_parerr;
wire [RADM_Q_H_CTRLBITS-1:0]        p_hdrq_parerr_out_int;
wire [RADM_Q_D_CTRLBITS-1:0]        p_dataq_parerr_out_int;
wire [RADM_Q_H_CTRLBITS-1:0]        np_hdrq_parerr_out_int;
wire [RADM_Q_D_CTRLBITS-1:0]        np_dataq_parerr_out_int;
wire [RADM_Q_H_CTRLBITS-1:0]        cpl_hdrq_parerr_out_int;
wire [RADM_Q_D_CTRLBITS-1:0]        cpl_dataq_parerr_out_int;

wire    [NL-1:0]                    sqlchd_rxelecidle;
wire                                pm_aux_clk;
wire                                pm_app_xfer_pending;
wire                                pm_sys_aux_pwr_det;


wire                                pm_aux_clk_active;
wire                                pm_slv_awvalid;
wire                                pm_slv_arvalid;
wire                                pm_slv_wvalid;
wire                                pm_dbi_arvalid;
wire                                pm_dbi_awvalid;
wire                                pm_dbi_wvalid;

    assign retryram_xdlh_parerr         =  retryram_xdlh_parerr_in;
    assign retrysotram_xdlh_parerr      =  retrysotram_xdlh_parerr_in;
    assign p_hdrq_parerr                =  p_hdrq_parerr_in;
    assign p_dataq_parerr               =  p_dataq_parerr_in;


wire                             client0_addr_align_en;
wire [7:0]                       client0_tlp_byte_en;
wire [15:0]                      client0_remote_req_id;
wire [11:0]                      client0_cpl_byte_cnt;
wire [2:0]                       client0_tlp_tc;
wire [ATTR_WD-1:0]               client0_tlp_attr;
wire [2:0]                       client0_cpl_status;
wire                             client0_cpl_bcm;
wire                             client0_tlp_dv;
wire                             client0_tlp_eot;
wire                             client0_tlp_bad_eot;
wire                             client0_tlp_hv;
wire [1:0]                       client0_tlp_fmt;
wire [4:0]                       client0_tlp_type;
wire                             client0_tlp_td;
wire                             client0_tlp_ep;
wire [12:0]                      client0_tlp_byte_len;
// LMD: Undriven net Range
// LJ: The function swap_addr_par is assigned to a signal client0_tlp_addr where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [63:0]                      client0_tlp_addr;
// leda NTL_CON12 on
wire [TAG_SIZE-1:0]              client0_tlp_tid;
// LMD: Undriven net Range
// LJ: The function swap_data_par is assigned to a signal client0_tlp_data where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [DW_W_PAR -1:0]             client0_tlp_data;
// leda NTL_CON12 on
wire [PF_WD-1:0]                 client0_tlp_func_num;
wire  [2:0]                      client0_tlp_dma;
wire  [2:0]                      client0_tlp_dma_channel;
wire [LOOKUPID_WD-1:0]           client0_cpl_lookup_id;
wire                             xadm_client0_halt;

// XALI1 interface
wire                             client1_addr_align_en;
wire [7:0]                       client1_tlp_byte_en;
wire [15:0]                      client1_remote_req_id;
wire [2:0]                       client1_cpl_status;
wire                             client1_cpl_bcm;
wire [11:0]                      client1_cpl_byte_cnt;
wire                             client1_tlp_dv;
wire                             client1_tlp_eot;
wire                             client1_tlp_bad_eot;
wire                             client1_tlp_hv;
wire [1:0]                       client1_tlp_fmt;
wire [4:0]                       client1_tlp_type;
wire [2:0]                       client1_tlp_tc;
wire                             client1_tlp_td;
wire                             client1_tlp_ep;
wire [ATTR_WD-1:0]               client1_tlp_attr;


wire [12:0]                      client1_tlp_byte_len;
wire [TAG_SIZE-1:0]              client1_tlp_tid;
// LMD: Undriven net Range
// LJ: The function swap_addr_par is assigned to a signal client1_tlp_addr where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [63:0]                      client1_tlp_addr;
// leda NTL_CON12 on
// LMD: Undriven net Range
// LJ: The function swap_data_par is assigned to a signal client1_tlp_data where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [DW_W_PAR -1:0]             client1_tlp_data;
// leda NTL_CON12 on
wire [PF_WD-1:0]                 client1_tlp_func_num;
wire  [2:0]                      client1_tlp_dma;
wire  [2:0]                      client1_tlp_dma_channel;
wire [LOOKUPID_WD-1:0]           client1_cpl_lookup_id;
wire                             xadm_client1_halt;
// XALI2 interface
wire [LOOKUPID_WD-1:0]           client2_cpl_lookup_id;
wire                             client2_addr_align_en;
wire [7:0]                       client2_tlp_byte_en;
wire [15:0]                      client2_remote_req_id;
wire [2:0]                       client2_cpl_status;
wire                             client2_cpl_bcm;
wire [11:0]                      client2_cpl_byte_cnt;
wire                             client2_tlp_dv;
wire                             client2_tlp_eot;
wire                             client2_tlp_bad_eot;
wire                             client2_tlp_hv;
wire [1:0]                       client2_tlp_fmt;
wire [4:0]                       client2_tlp_type;
wire [2:0]                       client2_tlp_tc;
wire                             client2_tlp_td;
wire                             client2_tlp_ep;
wire [ATTR_WD-1:0]               client2_tlp_attr;
wire [12:0]                      client2_tlp_byte_len;
wire [TAG_SIZE-1:0]              client2_tlp_tid;
// LMD: Undriven net Range
// LJ: The function swap_addr_par is assigned to a signal client2_tlp_addr where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [63:0]                      client2_tlp_addr;
// leda NTL_CON12 on
// LMD: Undriven net Range
// LJ: The function swap_data_par is assigned to a signal client2_tlp_data where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [DW_W_PAR -1:0]             client2_tlp_data;
// leda NTL_CON12 on
wire [PF_WD-1:0]                 client2_tlp_func_num;
wire                             client2_tlp_atu_bypass;
wire                             xadm_client2_halt;
wire [DW_W_PAR-1:0]              radm_bypass_data;

// LMD: Undriven net Range
// LJ: The function add_data_par is assigned to a signal radm_bypass_data_w_par where the result come through two "for" statement intercalated
// leda NTL_CON12 off
wire [DW_W_PAR -1:0]             radm_bypass_data_w_par;
// leda NTL_CON12 on
wire [NW-1:0]                    radm_bypass_dwen;
wire [NHQ-1:0]                   radm_bypass_dv;
wire [NHQ-1:0]                   radm_bypass_hv;
wire [NHQ-1:0]                   radm_bypass_eot;
wire [NHQ-1:0]                   radm_bypass_dllp_abort;
wire [NHQ-1:0]                   radm_bypass_tlp_abort;
wire [NHQ-1:0]                   radm_bypass_ecrc_err;
wire [NHQ*2-1:0]                 radm_bypass_fmt;
wire [NHQ*5-1:0]                 radm_bypass_type;
wire [NHQ*3-1:0]                 radm_bypass_tc;
wire [NHQ*ATTR_WD-1:0]           radm_bypass_attr;
wire [NHQ*16-1:0]                radm_bypass_reqid;
wire [NHQ*TAG_SIZE-1:0]          radm_bypass_tag;
wire [NHQ*PF_WD-1:0]             radm_bypass_func_num;
wire [NHQ-1:0]                   radm_bypass_td;
wire [NHQ-1:0]                   radm_bypass_poisoned;
wire [NHQ*10-1:0]                radm_bypass_dw_len;
wire [NHQ*4-1:0]                 radm_bypass_first_be;
wire [NHQ*4-1:0]                 radm_bypass_last_be;
wire [NHQ*`FLT_Q_ADDR_WIDTH -1:0]radm_bypass_addr;
wire [NHQ*CORE_ADDR_BUS_WD -1:0] radm_bypass_addr_w_par;
wire [NHQ-1:0]                   radm_bypass_rom_in_range;
wire [NHQ-1:0]                   radm_bypass_io_req_in_range;
wire [NHQ*3-1:0]                 radm_bypass_in_membar_range;
wire [NHQ-1:0]                   radm_bypass_bcm;
wire [NHQ-1:0]                   radm_bypass_cpl_last;
wire [NHQ*3-1:0]                 radm_bypass_cpl_status;
wire [NHQ*12-1:0]                radm_bypass_byte_cnt;
wire [NHQ*16-1:0]                radm_bypass_cmpltr_id;

wire [(NVC*3)-1:0]               radm_grant_tlp_type;


// ------------------------------------------------------------------------------------------
// Internal Signal declaration
// ------------------------------------------------------------------------------------------
wire  [7:0]                      radm_trgt1_msgcode;

 wire   [15:0]                      client0_req_id;                 // bus and dev number are set based on per function
 wire   [15:0]                      client1_req_id;                 // bus and dev number are set based on per function
  wire  [15:0]                      client2_req_id;                 // bus and dev number are set based on per function

wire                               trgt_lookup_empty;
wire                               trgt_cpl_lut_empty;

wire  [CPL_LUT_DEPTH-1:0]           radm_cpl_lut_valid;         // completion lookup table valid indication
wire                              xdlh_retry_req;                           // Puls : Retry Event





wire   [DW_W_PAR -1:0]             client0_tlp_data_i                 ;
wire   [PF_WD-1:0]                 client0_tlp_func_num_i             ;
wire                               client0_addr_align_en_i            ;
wire   [7:0]                       client0_tlp_byte_en_i              ;
wire   [2:0]                       client0_cpl_status_i               ;
wire                               client0_cpl_bcm_i                  ;
wire   [15:0]                      client0_remote_req_id_i            ;
wire   [11:0]                      client0_cpl_byte_cnt_i             ;
wire   [2:0]                       client0_tlp_tc_i                   ;
wire   [ATTR_WD-1:0]               client0_tlp_attr_i                 ;
wire                               client0_tlp_dv_i                   ;
wire                               client0_tlp_eot_i                  ;
wire                               client0_tlp_bad_eot_i              ;
wire                               client0_tlp_hv_i                   ;
wire   [1:0]                       client0_tlp_fmt_i                  ;
wire   [4:0]                       client0_tlp_type_i                 ;
wire                               client0_tlp_td_i                   ;
wire                               client0_tlp_ep_i                   ;
wire   [12:0]                      client0_tlp_byte_len_i             ;
wire   [TAG_SIZE-1:0]              client0_tlp_tid_i                  ;
wire   [63:0]                      client0_tlp_addr_i                 ;
wire   [15:0]                      client0_req_id_i                   ;

wire                               client1_addr_align_en_i            ;
wire   [7:0]                       client1_tlp_byte_en_i              ;
wire   [2:0]                       client1_cpl_status_i               ;
wire                               client1_cpl_bcm_i                  ;
wire   [15:0]                      client1_remote_req_id_i            ;
wire   [11:0]                      client1_cpl_byte_cnt_i             ;
wire   [2:0]                       client1_tlp_tc_i                   ;
wire   [ATTR_WD-1:0]               client1_tlp_attr_i                 ;
wire                               client1_tlp_dv_i                   ;
wire                               client1_tlp_eot_i                  ;
wire                               client1_tlp_bad_eot_i              ;
wire                               client1_tlp_hv_i                   ;
wire   [1:0]                       client1_tlp_fmt_i                  ;
wire   [4:0]                       client1_tlp_type_i                 ;
wire                               client1_tlp_td_i                   ;
wire                               client1_tlp_ep_i                   ;
wire   [12:0]                      client1_tlp_byte_len_i             ;
wire   [TAG_SIZE-1:0]              client1_tlp_tid_i                  ;
wire   [63:0]                      client1_tlp_addr_i                 ;
wire   [15:0]                      client1_req_id_i                   ;
wire   [DW_W_PAR -1:0]             client1_tlp_data_i                 ;
wire   [PF_WD-1:0]                 client1_tlp_func_num_i             ;
// Client2 XADM interconnect signals
wire                               client2_addr_align_en_i            ;
wire   [7:0]                       client2_tlp_byte_en_i              ;
wire   [2:0]                       client2_cpl_status_i               ;
wire                               client2_cpl_bcm_i                  ;
wire   [15:0]                      client2_remote_req_id_i            ;
wire   [11:0]                      client2_cpl_byte_cnt_i             ;
wire   [2:0]                       client2_tlp_tc_i                   ;
wire   [ATTR_WD-1:0]               client2_tlp_attr_i                 ;
wire                               client2_tlp_dv_i                   ;
wire                               client2_tlp_eot_i                  ;
wire                               client2_tlp_bad_eot_i              ;
wire                               client2_tlp_hv_i                   ;
wire   [1:0]                       client2_tlp_fmt_i                  ;
wire   [4:0]                       client2_tlp_type_i                 ;
wire                               client2_tlp_td_i                   ;
wire                               client2_tlp_ep_i                   ;
wire   [12:0]                      client2_tlp_byte_len_i             ;
wire   [TAG_SIZE-1:0]              client2_tlp_tid_i                  ;
wire   [63:0]                      client2_tlp_addr_i                 ;
wire   [15:0]                      client2_req_id_i                   ;
wire   [DW_W_PAR -1:0]             client2_tlp_data_i                 ;
wire   [PF_WD-1:0]                 client2_tlp_func_num_i             ;



// START_IO:XALI0 Descriptions




wire                               xadm_client0_halt_i                ;
wire [7:0]                         unconn_client0_non_dma_cpl_rmpd_lkup_id   ;
wire [LOOKUPID_WD-1:0]             client0_cpl_lookup_id_i            ;
wire [LOOKUPID_WD-1:0]             trgt_lookup_id_i                   ;

wire  [2:0]                        client0_tlp_dma_i;
wire  [2:0]                        client0_tlp_dma_channel_i;
wire                               client0_tlp_atu_bypass             ;
wire                               client0_tlp_atu_bypass_i           ;
// END_IO:XALI0 Descriptions

// START_IO:XALI1 Descriptions



wire                               xadm_client1_halt_i                ;
wire [LOOKUPID_WD-1:0]             client1_cpl_lookup_id_i            ;

wire  [2:0]                        client1_tlp_dma_i;
wire  [2:0]                        client1_tlp_dma_channel_i;
wire                               client1_tlp_atu_bypass             ;
wire                               client1_tlp_atu_bypass_i           ;
// END_IO:XALI1 Descriptions

// Client2 XADM interconnect signals
wire [LOOKUPID_WD-1:0]             client2_cpl_lookup_id_i            ;
wire  [2:0]                        client2_tlp_dma_i;
wire  [2:0]                        client2_tlp_dma_channel_i;
wire                               client2_tlp_atu_bypass_i           ;
wire                               xadm_client2_halt_i                ;

//--------------------------------
//     TRGT1 Interface
//--------------------------------
wire [TRGT_HDR_WD-1:0]            radm_trgt1_hdr_i                      ;
wire                              trgt1_radm_halt_i                     ;
wire                              radm_trgt1_hv_i                       ;
wire                              radm_trgt1_dv_i                       ;
wire                              radm_trgt1_eot_i                      ;
wire                              radm_trgt1_tlp_abort_i                ;
wire                              radm_trgt1_dllp_abort_i               ;
wire                              radm_trgt1_ecrc_err_i                 ;
wire  [TRGT_DATA_WD-1:0]          radm_trgt1_data_i                     ;
wire  [NW-1:0]                    radm_trgt1_dwen_i                     ;
wire  [1:0]                       radm_trgt1_fmt_i                      ;
wire  [4:0]                       radm_trgt1_type_i                     ;
wire  [2:0]                       radm_trgt1_tc_i                       ;
wire  [ATTR_WD-1:0]               radm_trgt1_attr_i                     ;
wire  [15:0]                      radm_trgt1_reqid_i                    ;
wire  [TAG_SIZE-1:0]              radm_trgt1_tag_i                      ;
wire  [PF_WD-1:0]                 radm_trgt1_func_num_i                 ;
wire                              radm_trgt1_td_i                       ;
wire                              radm_trgt1_poisoned_i                 ;
wire  [9:0]                       radm_trgt1_dw_len_i                   ;
wire  [3:0]                       radm_trgt1_first_be_i                 ;
wire  [3:0]                       radm_trgt1_last_be_i                  ;
wire  [ADDR_WIDTH -1:0]           radm_trgt1_addr_i                     ;
wire [ADDR_WIDTH -1:0]           radm_trgt1_hdr_uppr_bytes_i;
wire [63:0]                      radm_trgt1_hdr_uppr_bytes_tmp;
wire  [ADDR_WIDTH -1:0]           radm_trgt1_addr_out_i                 ;
wire                              radm_trgt1_io_req_in_range_i          ;
wire                              radm_trgt1_rom_in_range_i             ;
wire  [2:0]                       radm_trgt1_in_membar_range_i          ;
wire  [2:0]                       radm_trgt1_cpl_status_i               ;
wire                              radm_trgt1_bcm_i                      ;
wire                              radm_trgt1_cpl_last_i                 ;
wire [11:0]                       radm_trgt1_byte_cnt_i                 ;
wire [15:0]                       radm_trgt1_cmpltr_id_i                ;
wire [2:0]                        radm_trgt1_vc_num_i                   ;
wire                              brdg_trgt1_p_xfer_done                ;
wire  [CPL_LUT_DEPTH-1:0]         radm_cpl_lut_valid_i                  ;


wire                                radm_cpl_timeout_i                  ;
wire                                radm_cpl_timeout_cdm_i              ;
wire    [PF_WD-1:0]                 radm_timeout_func_num_i             ;
wire    [2:0]                       radm_timeout_cpl_tc_i               ;
wire    [1:0]                       radm_timeout_cpl_attr_i             ;
wire    [11:0]                      radm_timeout_cpl_len_i              ;
wire    [TAG_SIZE-1:0]              radm_timeout_cpl_tag_i              ;

//--------------------------------
//     RADM Bypass interface
//--------------------------------
wire    [DW_W_PAR-1:0]              radm_bypass_data_i               ;
wire    [NW-1:0]                    radm_bypass_dwen_i               ;
wire    [NHQ-1:0]                   radm_bypass_dv_i                 ;
wire    [NHQ-1:0]                   radm_bypass_hv_i                 ;
wire    [NHQ-1:0]                   radm_bypass_eot_i                ;
wire    [NHQ-1:0]                   radm_bypass_dllp_abort_i         ;
wire    [NHQ-1:0]                   radm_bypass_tlp_abort_i          ;
wire    [NHQ-1:0]                   radm_bypass_ecrc_err_i           ;
wire    [NHQ-1:0]                   radm_bypass_bcm_i                ;
wire    [NHQ-1:0]                   radm_bypass_cpl_last_i           ;
wire    [NHQ*3-1:0]                 radm_bypass_cpl_status_i         ;

wire    [NHQ*12-1:0]                radm_bypass_byte_cnt_i           ;
wire    [NHQ*16-1:0]                radm_bypass_cmpltr_id_i          ;
wire    [NHQ*2-1:0]                 radm_bypass_fmt_i                ;
wire    [NHQ*5-1:0]                 radm_bypass_type_i               ;
wire    [NHQ*3-1:0]                 radm_bypass_tc_i                 ;
wire    [NHQ*ATTR_WD-1:0]           radm_bypass_attr_i               ;
wire    [NHQ*16-1:0]                radm_bypass_reqid_i              ;
wire    [NHQ*TAG_SIZE-1:0]          radm_bypass_tag_i                ;
wire    [NHQ*PF_WD-1:0]             radm_bypass_func_num_i           ;
wire    [NHQ-1:0]                   radm_bypass_td_i                 ;
wire    [NHQ-1:0]                   radm_bypass_poisoned_i           ;
wire    [NHQ*10-1:0]                radm_bypass_dw_len_i             ;
wire    [NHQ*4-1:0]                 radm_bypass_first_be_i           ;
wire    [NHQ*4-1:0]                 radm_bypass_last_be_i            ;
wire    [NHQ*`FLT_Q_ADDR_WIDTH-1:0] radm_bypass_addr_i               ;
wire    [NHQ-1:0]                   radm_bypass_rom_in_range_i       ;
wire    [NHQ-1:0]                   radm_bypass_io_req_in_range_i    ;
wire    [NHQ*3-1:0]                 radm_bypass_in_membar_range_i    ;
wire    [(NVC*3)-1:0]               radm_grant_tlp_type_i            ;
wire                              brdg_dbi_xfer_pending              ;
wire                              brdg_slv_xfer_pending              ;
wire                              brdg_slv_flush_ack                 ;
wire                              radm_xfer_pending                  ;
wire                              radm_q_pending                     ;
wire                              edma_xfer_pending                  ;
wire                              rstctl_ltssm_enable                ;
wire                              rstctl_core_flush_req              ;
wire                              rstctl_slv_flush_req               ;
wire                              rstctl_mstr_flush_req              ;

output [NF-1:0]                  cfg_ido_req_en;
output [NF-1:0]                  cfg_ido_cpl_en;
wire   [NF-1:0]                  cfg_ido_req_en;
wire   [NF-1:0]                  cfg_ido_cpl_en;

// -------------------------------------------------------------------------------------
// XADM/RADM interconnect signals.

// The following signals are not used in DMA.


/* //reuse-pragma process_ifdef standard
*/

// Assignments valid for Core only, Core+AMBA, Core+AMBA+DMA configurations

assign client0_tlp_dv_i           =   client0_tlp_dv                  ;
assign client0_tlp_eot_i          =   client0_tlp_eot                 ;
assign client0_tlp_bad_eot_i      =   client0_tlp_bad_eot             ;
assign client0_tlp_data_i         =   client0_tlp_data                ;
// assign client0_tlp_func_num_i     =   client0_tlp_func_num            ;

// `ifdef CX_SRIOV_ENABLE
//assign client0_tlp_vfunc_num_i    =   client0_tlp_vfunc_num           ;
//assign client0_tlp_vfunc_active_i =   client0_tlp_vfunc_active        ;
// `endif // CX_SRIOV_ENABLE
// `ifdef CX_TPH_ENABLE
//  `ifdef AMBA_POPULATED
//    `ifdef CC_DMA_ENABLE
// assign client0_tlp_th_i             = client0_tlp_th                  ;
// assign client0_tlp_ph_i             = client0_tlp_ph                  ;
// assign client0_tlp_st_i             = client0_tlp_st                  ;
//    `endif // CC_DMA_ENABLE
//  `else // !AMBA_POPULATED
// assign client0_tlp_th_i             = client0_tlp_th                  ;
// assign client0_tlp_ph_i             = client0_tlp_ph                  ;
// assign client0_tlp_st_i             = client0_tlp_st                  ;
//  `endif // AMBA_POPULATED
// `endif // CX_TPH_ENABLE
assign client0_tlp_atu_bypass_i   =   client0_tlp_atu_bypass          ;
assign client0_cpl_lookup_id_i    =   client0_cpl_lookup_id           ;
assign trgt_lookup_id             =   trgt_lookup_id_i                ;
assign xadm_client0_halt          =   xadm_client0_halt_i             ;

assign client1_tlp_dv_i           =   client1_tlp_dv                  ;
assign client1_tlp_eot_i          =   client1_tlp_eot                 ;
assign client1_tlp_bad_eot_i      =   client1_tlp_bad_eot             ;
assign client1_tlp_data_i         =   client1_tlp_data                ;

assign client1_tlp_atu_bypass_i   =   client1_tlp_atu_bypass           ;
assign client1_cpl_lookup_id_i    =   client1_cpl_lookup_id           ;
assign  xadm_client1_halt         =   xadm_client1_halt_i             ;
assign radm_trgt1_hv                =  radm_trgt1_hv_i                       ;
assign radm_trgt1_dv                =  radm_trgt1_dv_i                       ;
assign radm_trgt1_eot               =  radm_trgt1_eot_i                      ;
assign radm_trgt1_tlp_abort         =  radm_trgt1_tlp_abort_i                ;
assign radm_trgt1_dllp_abort        =  radm_trgt1_dllp_abort_i               ;
assign radm_trgt1_ecrc_err          =  radm_trgt1_ecrc_err_i                 ;
assign radm_trgt1_data              =  radm_trgt1_data_i                     ;
assign radm_trgt1_dwen              =  radm_trgt1_dwen_i                     ;
assign radm_trgt1_fmt               =  radm_trgt1_fmt_i                      ;
assign radm_trgt1_type              =  radm_trgt1_type_i                     ;
assign radm_trgt1_tc                =  radm_trgt1_tc_i                       ;
assign radm_trgt1_attr              =  radm_trgt1_attr_i                     ;
assign radm_trgt1_reqid             =  radm_trgt1_reqid_i                    ;
assign radm_trgt1_tag               =  radm_trgt1_tag_i                      ;
assign radm_trgt1_func_num          =  radm_trgt1_func_num_i                 ;
assign radm_trgt1_td                =  radm_trgt1_td_i                       ;
assign radm_trgt1_poisoned          =  radm_trgt1_poisoned_i                 ;
assign radm_trgt1_dw_len            =  radm_trgt1_dw_len_i                   ;
assign radm_trgt1_first_be          =  radm_trgt1_first_be_i                 ;
assign radm_trgt1_last_be           =  radm_trgt1_last_be_i                  ;
assign radm_trgt1_addr              =  radm_trgt1_addr_i                     ;
assign radm_trgt1_io_req_in_range   =  radm_trgt1_io_req_in_range_i          ;
assign radm_trgt1_rom_in_range      =  radm_trgt1_rom_in_range_i             ;
assign radm_trgt1_in_membar_range   =  radm_trgt1_in_membar_range_i          ;
assign radm_trgt1_cpl_status        =  radm_trgt1_cpl_status_i               ;
assign radm_trgt1_hdr_uppr_bytes    =  radm_trgt1_hdr_uppr_bytes_i           ;
assign radm_trgt1_hdr_uppr_bytes_valid =  radm_trgt1_hdr_uppr_bytes_valid_i  ;
assign radm_trgt1_bcm               =  radm_trgt1_bcm_i                      ;
assign radm_trgt1_cpl_last          =  radm_trgt1_cpl_last_i                 ;
assign radm_trgt1_byte_cnt          =  radm_trgt1_byte_cnt_i                 ;
assign radm_trgt1_cmpltr_id         =  radm_trgt1_cmpltr_id_i                ;

assign radm_cpl_timeout          =  radm_cpl_timeout_i                      ;
assign radm_timeout_cpl_tc       =  radm_timeout_cpl_tc_i                   ;
assign radm_timeout_cpl_attr     =  radm_timeout_cpl_attr_i                 ;
assign radm_timeout_cpl_len      =  radm_timeout_cpl_len_i                  ;
assign radm_timeout_cpl_tag      =  radm_timeout_cpl_tag_i                  ;
assign radm_timeout_func_num     =  radm_timeout_func_num_i                 ;


assign radm_bypass_data              =   radm_bypass_data_i               ;
assign radm_bypass_dwen              =   radm_bypass_dwen_i               ;
assign radm_bypass_dv                =   radm_bypass_dv_i                 ;
assign radm_bypass_hv                =   radm_bypass_hv_i                 ;
assign radm_bypass_eot               =   radm_bypass_eot_i                ;
assign radm_bypass_dllp_abort        =   radm_bypass_dllp_abort_i         ;
assign radm_bypass_tlp_abort         =   radm_bypass_tlp_abort_i          ;
assign radm_bypass_ecrc_err          =   radm_bypass_ecrc_err_i           ;
assign radm_bypass_bcm               =   radm_bypass_bcm_i                ;
assign radm_bypass_cpl_last          =   radm_bypass_cpl_last_i           ;
assign radm_bypass_cpl_status        =   radm_bypass_cpl_status_i         ;
assign radm_bypass_byte_cnt          =   radm_bypass_byte_cnt_i           ;
assign radm_bypass_cmpltr_id         =   radm_bypass_cmpltr_id_i          ;
assign radm_bypass_fmt               =   radm_bypass_fmt_i                ;
assign radm_bypass_type              =   radm_bypass_type_i               ;
assign radm_bypass_tc                =   radm_bypass_tc_i                 ;
assign radm_bypass_attr              =   radm_bypass_attr_i               ;
assign radm_bypass_reqid             =   radm_bypass_reqid_i              ;
assign radm_bypass_tag               =   radm_bypass_tag_i                ;
assign radm_bypass_func_num          =   radm_bypass_func_num_i           ;
assign radm_bypass_td                =   radm_bypass_td_i                 ;
assign radm_bypass_poisoned          =   radm_bypass_poisoned_i           ;
assign radm_bypass_dw_len            =   radm_bypass_dw_len_i             ;
assign radm_bypass_first_be          =   radm_bypass_first_be_i           ;
assign radm_bypass_last_be           =   radm_bypass_last_be_i            ;
assign radm_bypass_addr              =   radm_bypass_addr_i               ;
assign radm_bypass_rom_in_range      =   radm_bypass_rom_in_range_i       ;
assign radm_bypass_io_req_in_range   =   radm_bypass_io_req_in_range_i    ;
assign radm_bypass_in_membar_range   =   radm_bypass_in_membar_range_i    ;


assign client0_tlp_dma_i             =   client0_tlp_dma                  ;
assign client0_tlp_dma_channel_i     =   client0_tlp_dma_channel          ;
assign client1_tlp_dma_i             =   client1_tlp_dma                  ;
assign client1_tlp_dma_channel_i     =   client1_tlp_dma_channel          ;
assign client2_tlp_dma_i             =   0                                ;
assign client2_tlp_dma_channel_i     =   0                                ;

assign client2_tlp_dv_i           =   client2_tlp_dv                  ;
assign client2_tlp_eot_i          =   client2_tlp_eot                 ;
assign client2_tlp_bad_eot_i      =   client2_tlp_bad_eot             ;
assign client2_tlp_data_i         =   client2_tlp_data                ;

assign client2_tlp_atu_bypass_i   =   client2_tlp_atu_bypass          ;
assign client2_cpl_lookup_id_i    =   client2_cpl_lookup_id           ;
assign  xadm_client2_halt         =    xadm_client2_halt_i            ;

assign radm_cpl_lut_valid         =   radm_cpl_lut_valid_i            ;
assign radm_grant_tlp_type        =   radm_grant_tlp_type_i           ;

wire                               edma_client0_tlp_hv_i;
wire                               edma_client1_tlp_hv_i;
assign client0_tlp_hv_i           = client0_tlp_hv;
assign client1_tlp_hv_i           = client1_tlp_hv;
assign client2_tlp_hv_i           = client2_tlp_hv;


wire [1:0] tmp_ltssm_powerdown, tmp_xmlh_powerdown;
wire [1:0] int_ltssm_powerdown, int_xmlh_powerdown;
wire [1:0] tmp_int_mac_phy_rate;

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


assign client0_tlp_func_num_i     =   client0_tlp_func_num            ;
assign client0_addr_align_en_i    =   client0_addr_align_en           ;
assign client0_tlp_byte_en_i      =   client0_tlp_byte_en             ;
assign client0_cpl_status_i       =   client0_cpl_status              ;
assign client0_cpl_bcm_i          =   client0_cpl_bcm                 ;
assign client0_remote_req_id_i    =   client0_remote_req_id           ;
assign client0_cpl_byte_cnt_i     =   client0_cpl_byte_cnt            ;
assign client0_tlp_tc_i           =   client0_tlp_tc                  ;
assign client0_tlp_attr_i         =   client0_tlp_attr                ;
assign client0_tlp_fmt_i          =   client0_tlp_fmt                 ;
assign client0_tlp_type_i         =   client0_tlp_type                ;
assign client0_tlp_td_i           =   client0_tlp_td                  ;
assign client0_tlp_ep_i           =   client0_tlp_ep                  ;
assign client0_tlp_byte_len_i     =   client0_tlp_byte_len            ;
assign client0_tlp_tid_i          =   client0_tlp_tid                 ;
assign client0_tlp_addr_i         =   client0_tlp_addr                ;
assign client0_req_id_i           =   client0_req_id                  ;


assign client1_addr_align_en_i    =   client1_addr_align_en           ;
assign client1_tlp_byte_en_i      =   client1_tlp_byte_en             ;
assign client1_cpl_status_i       =   client1_cpl_status              ;
assign client1_cpl_bcm_i          =   client1_cpl_bcm                 ;
assign client1_remote_req_id_i    =   client1_remote_req_id           ;
assign client1_cpl_byte_cnt_i     =   client1_cpl_byte_cnt            ;
assign client1_tlp_tc_i           =   client1_tlp_tc                  ;
assign client1_tlp_attr_i         =   client1_tlp_attr                ;
assign client1_tlp_fmt_i          =   client1_tlp_fmt                 ;
assign client1_tlp_type_i         =   client1_tlp_type                ;
assign client1_tlp_td_i           =   client1_tlp_td                  ;
assign client1_tlp_ep_i           =   client1_tlp_ep                  ;
assign client1_tlp_byte_len_i     =   client1_tlp_byte_len            ;
assign client1_tlp_tid_i          =   client1_tlp_tid                 ;
assign client1_tlp_addr_i         =   client1_tlp_addr                ;
assign client1_req_id_i           =   client1_req_id                  ;
assign client1_tlp_func_num_i     =   client1_tlp_func_num            ;


assign client2_addr_align_en_i    =   client2_addr_align_en           ;
assign client2_tlp_byte_en_i      =   client2_tlp_byte_en             ;
assign client2_cpl_status_i       =   client2_cpl_status              ;
assign client2_cpl_bcm_i          =   client2_cpl_bcm                 ;
assign client2_remote_req_id_i    =   client2_remote_req_id           ;
assign client2_cpl_byte_cnt_i     =   client2_cpl_byte_cnt            ;
assign client2_tlp_tc_i           =   client2_tlp_tc                  ;
assign client2_tlp_attr_i         =   client2_tlp_attr                ;
assign client2_tlp_fmt_i          =   client2_tlp_fmt                 ;
assign client2_tlp_type_i         =   client2_tlp_type                ;
assign client2_tlp_td_i           =   client2_tlp_td                  ;
assign client2_tlp_ep_i           =   client2_tlp_ep                  ;
assign client2_tlp_byte_len_i     =   client2_tlp_byte_len            ;
assign client2_tlp_tid_i          =   client2_tlp_tid                 ;
assign client2_tlp_addr_i         =   client2_tlp_addr                ;
assign client2_req_id_i           =   client2_req_id                  ;
assign client2_tlp_func_num_i     =   client2_tlp_func_num            ;



//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


wire    [NVC-1:0]                   radm_pend_cpl_so                 ;
wire    [NVC-1:0]                   radm_q_cpl_not_empty             ;

wire                                phy_type;
assign phy_type = `CX_PHY_TYPE;

wire    [BUSNUM_WD -1:0]            pm_bus_num;
wire    [DEVNUM_WD -1:0]            pm_dev_num;
wire    [1:0]                       rdlh_dlcntrl_state;
wire                                xadm_msg_halt;
wire    [(TX_DATA_WD - 1):0]         phy_mac_rxdata;
wire    [NL*PHY_NB-1 :0]            phy_mac_rxdatak;
wire    [NL-1:0]                    phy_mac_rxvalid;
wire    [NL-1:0]                    phy_mac_rxelecidle;
wire    [NL-1:0]                    phy_mac_phystatus;
wire    [(NL*3)-1:0]                phy_mac_rxstatus;               // Encoders receiver status and error codes for the received
wire    [NL-1:0]                    phy_mac_rxstandbystatus;
wire    [31:0]                      phy_cfg_status;
wire    [31:0]                      cfg_phy_control;
wire                                cfg_elastic_buffer_mode;
wire    [RATE_WIDTH-1:0]            mac_phy_rate;                   // 1=change speed to gen2, 2-gen3, 0-gen1
wire    [RATE_WIDTH-1:0]            pre_mac_phy_rate;
wire    [NL*2-1:0]                  tmp_mac_phy_rate_bus;           // 1=change speed to gen2, 2-gen3, 0-gen1, internal use
wire    [1:0]                       tmp_mac_phy_rate;               // 1=change speed to gen2, 2-gen3, 0-gen1, internal use
wire    [(TX_DATA_WD - 1):0]         mac_phy_txdata;
wire    [(NL*PHY_NB)-1:0]           mac_phy_txdatak;
wire    [(TX_DATA_WD - 1):0]         pre_mac_phy_txdata;
wire    [(NL*PHY_NB)-1:0]           pre_mac_phy_txdatak;
wire    [NL-1:0]                    pre_mac_phy_txdatavalid;
wire    [NL-1:0]                    mac_phy_txdatavalid;            // Instruct the PHY to ignore bytes on the data interface
wire    [NL-1:0]                    mac_phy_txelecidle;
wire    [NL-1:0]                    int_phy_txelecidle;
wire    [NL-1:0]                    mac_phy_txcompliance;
wire    [NL-1:0]                    mac_phy_rxpolarity;
wire    [1:0]                       mac_phy_width;
wire    [2:0]                       mac_phy_pclk_rate;
wire    [NL-1:0]                    mac_phy_rxstandby;
wire    [NL-1:0]                    pre_mac_phy_txcompliance;
wire    [NL-1:0]                    pre_mac_phy_rxpolarity;
wire    [1:0]                       pre_mac_phy_width;
wire    [2:0]                       pre_mac_phy_pclk_rate;
wire    [NL-1:0]                    pre_mac_phy_rxstandby;
wire    [1:0]                       adapted_pipe_mac_phy_width;
wire    [2:0]                       adapted_pipe_mac_phy_pclk_rate;
wire    [(PDWN_WIDTH - 1) : 0]      mac_phy_powerdown;              // Power up or down the tranceiver to 1 of 16 power states
wire    [(PDWN_WIDTH - 1) :0]       pre_mac_phy_powerdown;
wire    [NL-1:0]                    mac_phy_txdetectrx_loopback;    // Enable receiver detection sequence.  SerDes transmits
wire    [NL-1:0]                    pre_mac_phy_txdetectrx_loopback;
wire    [(NL*NB*8)-1:0]             int_phy_mac_rxdata;
wire    [NL*NB-1 :0]                int_phy_mac_rxdatak;
wire    [NL-1:0]                    int_phy_mac_rxvalid;
wire    [NL-1:0]                    int_phy_mac_rxelecidle;
wire    [(NL*3)-1:0]                int_phy_mac_rxstatus;           // Encoders receiver status and error codes for the received
wire    [NL-1:0]                    int_phy_mac_phystatus;          // Used to communicate completion of several PHY functions
wire    [NL-1:0]                    int_phy_mac_rxstandbystatus;
wire    [(NL*NB*8)-1:0]             tmp_phy_mac_rxdata;
wire    [NL*NB-1 :0]                tmp_phy_mac_rxdatak;
wire    [NL-1:0]                    tmp_phy_mac_rxvalid;
wire    [NL-1:0]                    tmp_phy_mac_rxelecidle;
wire    [(NL*3)-1:0]                tmp_phy_mac_rxstatus;
wire    [NL-1:0]                    tmp_phy_mac_phystatus;
wire    [NL-1:0]                    tmp_phy_mac_rxstandbystatus;
wire    [(NL*NB*8)-1:0]             in_cxpl_phy_mac_rxdata;
wire    [NL*NB-1 :0]                in_cxpl_phy_mac_rxdatak;
wire    [NL-1:0]                    in_cxpl_phy_mac_rxvalid;
wire    [NL-1:0]                    in_cxpl_phy_mac_rxelecidle;
wire    [(NL*3)-1:0]                in_cxpl_phy_mac_rxstatus;
wire    [NL-1:0]                    in_cxpl_phy_mac_phystatus;
wire                                xadm_xtlh_hv;                   // hdr valid on bus when asserted
wire    [1:0]                       xadm_xtlh_soh;                  // Indicates start of header loacation for 32/64-bit
wire    [TX_HW_W_PAR-1:0]           xadm_xtlh_hdr;                  // hdr bus from XadM
wire                                xadm_xtlh_dv;                   // data valid on bus when asserted
wire    [DW_W_PAR-1:0]              xadm_xtlh_data;                 // data bus from XadM
wire    [NW-1:0]                    xadm_xtlh_dwen;                 // data bus dword enable
wire    [8:0]                       cfg_lane_en;                    // pre-determined number of lanes
wire                                cfg_gen1_ei_inference_mode;     // EI inference mode for Gen1. default 0 - using rxelecidle==1; 1 - using rxvalid==0
wire    [6:0]                       cfg_rxstandby_control;          // Rxstandby Control
wire                                smlh_bw_mgt_status;             // Indicate that link retraining (via retrain bit) or HW autonomous link speed change has occurred
                                                                    // without the port transitioning through DL_Down status
wire                                smlh_link_auto_bw_status;       // Indicate that hardware has autonomously changed link speed or width, without the port transitioning through
                                                                    // DL_Down status, for reasons other than to attempt to correct unreliable link operation.
wire    [3:0]                       cfg_pcie_max_link_speed;        // Max link speed
wire    [3:0]                       cfg_target_link_speed;          // Target link speed
wire                                cfg_sel_de_emphasis;
wire    [2:0]                       cfg_transmit_margin;
wire                                cfg_enter_mod_compliance;
wire                                cfg_compliance_sos;
wire    [3:0]                       cfg_compliance_de_emphasis;
wire                                cfg_gen2_support;               // core is enabled to run at gen 2 speeds
wire    [7:0]                       cfg_gen2_n_fts;                 // number of fts's to send in gen 2 speeds
wire                                cfg_enter_compliance;           // config bit to enter the compliance state
wire                                cfg_hw_auto_sp_dis;             // HW autonomous speed disable
wire                                cfg_directed_speed_change;      // config bit to start speed change
wire                                cfg_phy_txswing;                // controls mac_phy_txswing signal to the phy
wire                                cfg_tx_compliance_rcv;          // Sets the compliance received bit in the TS1
assign cfg_gen2_support = (cfg_pcie_max_link_speed != `GEN1_LINK_SP);  // Gen2 Supported if Max Link Speed is greater than Gen1

wire                                smlh_clr_enter_compliance;      // Signal the cdm that the "Enter Compliance" bit in the "Link Control" register should be cleared
wire                                smlh_tx_margin_rst;             // Signal the cdm to reset the transmit margin
wire                                smlh_core_rst_n_release_pulse;  // assign DEFAULT_GEN2_SPEED_CHANGE to cfg_directed_speed_change
wire                                smlh_dir_spd_chg_rising_edge;   // clear cfg_directed_speed_change

wire    [1:0]                       int_mac_phy_txdeemph;           // selects transmitter de-emphasis in the PHY
wire    [2:0]                       int_mac_phy_txmargin;           // selects transmitter voltage levels in the PHY
wire                                int_mac_phy_txswing;            // selects transmitter voltage swing level in the PHY
wire    [NL*2-1:0]                  mac_phy_txdeemph_bus;           // selects transmitter de-emphasis in the PHY
wire    [NL*3-1:0]                  mac_phy_txmargin_bus;           // selects transmitter voltage levels in the PHY
wire    [NL-1:0]                    mac_phy_txswing_bus;            // selects transmitter voltage swing level in the PHY
wire    [TX_DEEMPH_WD-1:0]          mac_phy_txdeemph;               // coefficients for Gen3, txdeemphasis[1:0] for Gen1/2 including No-Deemphasis
wire    [TX_DEEMPH_WD-1:0]          pre_mac_phy_txdeemph;
wire    [2:0]                       mac_phy_txmargin;               // selects transmitter voltage levels in the PHY
wire                                mac_phy_txswing;                // selects transmitter voltage swing level in the PHY
wire    [2:0]                       pre_mac_phy_txmargin;
wire                                pre_mac_phy_txswing;
wire                                smlh_dir_linkw_chg_rising_edge;    // clear cfg_directed_link_width_change
wire                                smlh_ltssm_in_hotrst_dis_entry;
wire    [1:0]                       current_data_rate;              // 0=running at gen1 speeds, 1=running at gen2 speeds
wire    [1:0]                       pm_current_data_rate;              // current_data_rate shadowed in pm_ctrl

wire                                training_rst_n;                 // Hot reset from upstream component, shall be routed to
wire                                xadm_xtlh_eot;                  // end of transaction
wire                                xadm_xtlh_bad_eot;              // poison the data
wire                                xadm_xtlh_add_ecrc;
wire    [2:0]                       xadm_xtlh_vc;
wire    [NL-1:0]                    tmp_ltssm_txelecidle;
wire    [NL-1:0]                    int_ltssm_txelecidle;
wire    [1:0]                       xmlh_powerdown;
wire    [(NL*NB*8)-1:0]             int_mac_phy_txdata;
wire    [(NL*NB)-1:0]               int_mac_phy_txdatak;
wire    [NL-1:0]                    int_mac_phy_txelecidle;
wire    [NL-1:0]                    int_mac_phy_txcompliance;
wire    [NL-1:0]                    int_mac_phy_rxpolarity;
wire    [NL-1:0]                    int_mac_phy_rxstandby;
wire    [1:0]                       int_mac_phy_rate;               // 1=change speed to gen2, 2-gen3
wire    [NL-1:0]                    int_mac_phy_txdetectrx_loopback;// Enable receiver detection sequence.  SerDes transmits
wire    [(PDWN_WIDTH - 1) : 0]      pm_int_phy_powerdown;
wire    [(NL*NB*8)-1:0]             tmp_mac_phy_txdata;
wire    [(NL*NB)-1:0]               tmp_mac_phy_txdatak;
wire    [NL-1:0]                    int_phy_mac_rxdatavalid;
wire    [NL-1:0]                    tmp_phy_mac_rxdatavalid;

wire [1:0]             core_int_mac_phy_txdeemph;
wire [NL-1:0]          lpbk_rxdatavalid_i;

wire [(PDWN_WIDTH - 1) : 0] adapted_pipe_mac_phy_powerdown;

wire    [NL-1:0]                    tmp_mac_phy_txcompliance;
wire    [NL-1:0]                    tmp_mac_phy_rxpolarity;
wire    [NL-1:0]                    tmp_mac_phy_rxstandby;
wire    [NL-1:0]                    smlh_rcvd_eidle_rxstandby;
wire    [NL-1:0]                    laneflip_lanes_active;
wire    [NL-1:0]                    laneflip_rcvd_eidle_rxstandby;
wire    [NL-1:0]                    tmp_mac_phy_txdetectrx_loopback;// Enable receiver detection sequence.  SerDes transmits
wire    [2:0]                       pm_curnt_state;

wire                                rdlh_link_down;
wire    [DW_W_PAR-1:0]              rtlh_radm_data;                 // Packet data
wire    [RX_TLP_CXPL*(128+RAS_PCIE_HDR_PROT_WD)-1:0] rtlh_radm_hdr;        // hdr data
wire    [NW-1:0]                    rtlh_radm_dwen;                 // Packet data dword enable
wire    [RX_TLP_CXPL-1:0]           rtlh_radm_dv;                   // data is valid this cycle
wire    [RX_TLP_CXPL-1:0]           rtlh_radm_hv;                   // hdr is valid this cycle
wire    [RX_TLP_CXPL-1:0]           rtlh_radm_eot;                  // EOT indication
wire    [RX_NDLLP-1:0]              rtlh_rfc_upd;                   // FC pkt rcvd
wire    [32*RX_NDLLP-1:0]           rtlh_rfc_data;                  // FC data from RTLH
wire                                xtlh_xadm_restore_enable;
wire    [1:0]                       xtlh_xadm_restore_ctrl;
wire                                xtlh_xadm_restore_capture;
wire    [2:0]                       xtlh_xadm_restore_tc;
wire    [6:0]                       xtlh_xadm_restore_type;
wire    [9:0]                       xtlh_xadm_restore_word_len;


// cfg newly added signals

wire    [63:0]                      cxpl_debug_info;
wire    [`CX_INFO_EI_WD-1:0]        cxpl_debug_info_ei;
wire                                radm_pm_pme;
wire                                radm_pm_to_ack;
wire                                int_radm_pm_to_ack;
wire                                radm_pm_asnak;
wire                                radm_pm_turnoff;
wire                                pm_xtlh_block_tlp;
wire                                pm_block_all_tlp;
wire                                pm_l1_aspm_entr;
wire    [7:0]                       rtfcgen_ph_diff;
wire    [NF-1:0]                    pm_radm_block_tlp;
wire                                pm_xdlh_enter_l1;
wire                                pm_xdlh_req_ack;
wire                                pm_xdlh_enter_l23;
wire                                pm_xdlh_actst_req_l1;
wire                                smlh_in_l0;
wire                                smlh_in_l1;
wire                                smlh_in_l1_p1;
wire                                smlh_in_l23;
wire                                smlh_l123_eidle_timeout;
wire                                latched_rcvd_eidle_set;
wire                                pm_freeze_fc_timer;
wire                                pm_smlh_entry_to_l0s;
wire                                pm_smlh_entry_to_l1;
wire                                pm_smlh_entry_to_l2;
wire                                pm_smlh_prepare4_l123;
wire                                pm_smlh_l0s_exit;
wire                                pm_smlh_l1_exit;
wire                                pm_smlh_l23_exit;
wire                                pm_smlh_link_retrain;

wire                                rdlh_rcvd_as_req_l1;
wire                                rdlh_rcvd_pm_enter_l1;
wire                                rdlh_rcvd_pm_enter_l23;
wire                                rdlh_rcvd_pm_req_ack;

wire                                lbc_cpl_hv;
wire                                lbc_cpl_dv;
wire                                lbc_cpl_eot;
wire    [DW_W_PAR-1:0]              lbc_cpl_data;
wire    [ST_HDR-1:0]                lbc_cpl_hdr;
//DE:Deadlock Fix
wire                                lbc_deadlock_det;

wire                                msg_gen_dv;
wire                                msg_gen_hv;
wire                                msg_gen_eot;
wire    [DW_W_PAR-1:0]              msg_gen_data;
wire    [ST_HDR-1:0]                msg_gen_hdr;
wire    [TRGT_DATA_WD-1:0]          radm_trgt0_data;
wire    [NW-1:0]                    radm_trgt0_dwen;
wire    [TRGT_HDR_WD-1:0]           radm_trgt0_hdr;
wire                                radm_trgt0_eot;
wire                                radm_trgt0_dv;
wire                                radm_trgt0_hv;
wire                                radm_trgt0_abort;
wire                                xtlh_xmt_tlp_done;
wire    [15 :0]                     xtlh_xmt_tlp_req_id;
wire    [TAG_SIZE-1:0]              xtlh_xmt_tlp_tag;
wire    [1:0]                       xtlh_xmt_tlp_attr;
wire    [2:0]                       xtlh_xmt_tlp_tc;
wire    [11:0]                      xtlh_xmt_tlp_len_inbytes;
wire    [3:0]                       xtlh_xmt_tlp_first_be;
wire                                xtlh_xmt_cfg_req;
wire                                xtlh_xmt_memrd_req;

// Local bus controller interface
wire    [31:0]                      lbc_cdm_addr;
wire    [31:0]                      lbc_cdm_data;
wire    [3:0]                       lbc_cdm_wr;


wire    [NVC-1:0]                   int_rtlh_ph_ca;                 // Credit allocated (posted header)
wire    [NVC-1:0]                   int_rtlh_pd_ca;                 // Credit allocated (posted data)
wire    [NVC-1:0]                   int_rtlh_nph_ca;                // Credit allocated (non-posted header)
wire    [NVC-1:0]                   int_rtlh_npd_ca;                // Credit allocated (non-posted data)
wire    [NVC-1:0]                   int_rtlh_cplh_ca;               // Credit allocated (completion header)
wire    [NVC-1:0]                   int_rtlh_cpld_ca;               // Credit allocated (completion data)



// From  RADM queue
wire    [NVC-1:0]                   radm_rtlh_ph_ca;                // Credit allocated (posted header)
wire    [NVC-1:0]                   radm_rtlh_pd_ca;                // Credit allocated (posted data)
wire    [NVC-1:0]                   radm_rtlh_nph_ca;               // Credit allocated (non-posted header)
wire    [NVC-1:0]                   radm_rtlh_npd_ca;               // Credit allocated (non-posted data)
wire    [NVC-1:0]                   radm_rtlh_cplh_ca;              // Credit allocated (completion header)
wire    [NVC-1:0]                   radm_rtlh_cpld_ca;              // Credit allocated (completion data)

wire    [5:0]                       smlh_autoneg_link_width;
wire    [3:0]                       smlh_autoneg_link_sp;
wire                                smlh_link_training_in_prog;
wire    [NF-1:0]                    radm_cpl_pending;
wire    [31:0]                      radm_slot_pwr_payload;

wire    [(FX_TLP*64)-1:0]           radm_msg_payload;
wire    [(FX_TLP*16)-1:0]           radm_msg_req_id;
wire    [NVC*HCRD_WD-1:0]           xadm_ph_cdts;                   // header for P credits
wire    [NVC*DCRD_WD-1:0]           xadm_pd_cdts;                   // data for P credits
wire    [NVC*HCRD_WD-1:0]           xadm_nph_cdts;                  // header for NPR credits
wire    [NVC*DCRD_WD-1:0]           xadm_npd_cdts;                  // data for NPR credits
wire    [NVC*HCRD_WD-1:0]           xadm_cplh_cdts;                 // header for cPL credits
wire    [NVC*DCRD_WD-1:0]           xadm_cpld_cdts;                 // data for cPL credits
wire    [NL-1:0]                    smlh_lanes_active;              // active lanes


// declaration for multi-func purpose
//  input signals of cdm
// -----------------------------------------------------------------------------
wire    [NF-1:0]                    xtlh_xmt_cpl_ca;
wire    [NF-1:0]                    xtlh_xmt_cpl_ur;
wire    [NF-1:0]                    xtlh_xmt_wreq_poisoned;
wire    [NF-1:0]                    xtlh_xmt_cpl_poisoned;
wire    [(FX_TLP*NF)-1:0]           radm_rcvd_wreq_poisoned;

wire    [(FX_TLP*NF)-1:0]           radm_mlf_tlp_err;
wire    [(FX_TLP*NF)-1:0]           radm_rcvd_cpl_poisoned;
wire    [(FX_TLP*NF)-1:0]           radm_ecrc_err;
wire    [(FX_TLP*NF)-1:0]           radm_hdr_log_valid;
wire    [(FX_TLP*128)-1:0]          radm_hdr_log;
wire    [NVC-1:0]                   radm_qoverflow;
wire    [NF-1:0]                    rtlh_overfl_err_nf;
wire    [(FX_TLP*NF)-1:0]           radm_rcvd_cpl_ur;

wire    [(FX_TLP*NF)-1:0]           radm_rcvd_cpl_ca;
wire    [(FX_TLP*NF)-1:0]           radm_rcvd_req_ur;
wire    [(FX_TLP*NF)-1:0]           radm_rcvd_req_ca;
wire    [(FX_TLP*NF)-1:0]           radm_unexp_cpl_err;
wire    [FX_TLP-1:0]                cdm_err_advisory;

wire    [(3*NF)-1:0]                pm_dstate;
wire    [NF-1:0]                    pm_status;
wire    [NF-1:0]                    pm_pme_en;
wire    [NF-1:0]                    pm_pme_en_split;
wire    [NF-1:0]                    pm_aux_pm_en_split;
wire                                pm_linkst_in_l0s;
wire                                pm_linkst_in_l1;
wire                                pm_linkst_in_l2;
wire                                pm_linkst_l2_exit;
wire                                pm_phy_type;
wire                                pm_ltssm_enable;
wire                                smlh_link_in_training;                    // Level: Ltssm is in Config or Reovery
wire    [NF-1:0]                    aux_pm_en;
wire    [L2NL - 1 : 0]              pm_rx_lane_flip_en;
wire    [L2NL - 1 : 0]              pm_tx_lane_flip_en;
wire    [L2NL - 1 : 0]              pm_rx_pol_lane_flip_ctrl;

// declaration for multi-func purpose
//  output signals of cdm
// ----------------------------------------------------------------------------

wire    [(32*NF)-1:0]               cdm_lbc_data;
wire    [NF-1:0]                    cdm_lbc_ack;
wire    [NF-1:0]                    lbc_cdm_cs;

wire                                cfg_upd_aspm_ctrl;
wire    [(NF - 1) : 0]              cfg_upd_aslk_pmctrl;
wire    [NF-1:0]                    cfg_upd_pme_cap;
wire    [BUSNUM_WD-1:0]             cfg_pbus_num;
wire    [DEVNUM_WD-1:0]             cfg_pbus_dev_num;
wire    [(2*NF)-1:0]                cfg_aslk_pmctrl;
wire                                cfg_clk_pm_en;
wire    [NF-1:0]                    cfg_aux_pm_en;
wire    [NF-1:0]                    cfg_ext_tag_en;
wire    [NF-1:0]                    cfg_rcb;
wire                                cfg_comm_clk_config;
wire                                cfg_hw_autowidth_dis;
wire    [2:0]                       cfg_highest_max_payload;
wire    [(3*NF)-1:0]                cfg_max_payload_size;
wire    [7:0]                       cfg_ack_freq;
wire    [15:0]                      cfg_ack_latency_timer;
wire    [16:0]                      cfg_replay_timer_value;
wire    [12:0]                      cfg_fc_latency_value;
wire    [31:0]                      cfg_other_msg_payload;
wire                                cfg_other_msg_request;
wire    [31:0]                      cfg_corrupt_crc_pattern;
wire                                cfg_scramble_dis;
wire    [7:0]                       cfg_n_fts;
wire    [7:0]                       cfg_link_num;
wire                                cfg_link_dis;
wire                                cfg_link_retrain;
wire                                cfg_lpbk_en;
wire                                cfg_pipe_loopback;
wire    [5:0]                       cfg_rxstatus_lane;          // Lane to inject rxstatus value(bit6 = all lanes)
wire    [2:0]                       cfg_rxstatus_value;         // rxstatus value to inject
wire    [NL-1:0]                    cfg_lpbk_rxvalid;           // rxvalid value to use during loopback
wire                                cfg_reset_assert;
wire                                cfg_plreg_reset;
wire                                cfg_force_en;
wire    [5:0]                       cfg_forced_link_state;
wire    [3:0]                       cfg_forced_ltssm_cmd;

wire    [23:0]                      cfg_lane_skew;
wire                                cfg_flow_control_disable;       // disable the automatic flowcontrol built in this core
wire                                cfg_acknack_disable;
wire                                cfg_deskew_disable;
wire    [3:0]                       cfg_imp_num_lanes;
wire                                cfg_fast_link_mode;
wire    [1:0]                       cfg_fast_link_scaling_factor;
wire                                cfg_l0s_supported;
wire                                diag_fast_link_mode;
wire                                int_cfg_fast_link_mode;
assign                              cfg_fast_link_mode = int_cfg_fast_link_mode;
wire    [NF-1:0]                    cfg_ecrc_chk_en;
wire    [10:0]                      cfg_skip_interval;              // skip interval
wire    [5:0]                       cfg_link_capable;
wire                                cfg_dll_lnk_en;
wire    [NF-1:0]                    cfg_ecrc_gen_en;
wire    [(64*NF)-1:0]               cfg_bar0_start;                 // BAR0 base, can be used for memory or IO (32bit only)
wire    [(32*NF)-1:0]               cfg_bar1_start;                 // BAR1 base
wire    [(64*NF)-1:0]               cfg_bar0_limit;                 // BAR0 Limit
wire    [(32*NF)-1:0]               cfg_bar1_limit;                 // BAR1 Limit
wire    [(64*NF)-1:0]               cfg_bar2_start;                 // BAR2 base address
wire    [(64*NF)-1:0]               cfg_bar2_limit;                 // BAR2 limit
wire    [(32*NF)-1:0]               cfg_bar3_start;                 // BAR3 base address
wire    [(32*NF)-1:0]               cfg_bar3_limit;                 // BAR3 limit
wire    [(64*NF)-1:0]               cfg_bar4_start;                 // BAR4 base address
wire    [(64*NF)-1:0]               cfg_bar4_limit;                 // BAR4 limit
wire    [(32*NF)-1:0]               cfg_bar5_start;                 // BAR5 base address
wire    [(32*NF)-1:0]               cfg_bar5_limit;                 // BAR5 limit
wire    [(32*NF)-1:0]               cfg_exp_rom_start;
wire    [(32*NF)-1:0]               cfg_exp_rom_limit;
wire    [(16*NF)-1:0]               cfg_io_limit_upper16;
wire    [(16*NF)-1:0]               cfg_io_base_upper16;
wire    [(8*NF)-1:0]                cfg_io_limit;
wire    [(8*NF)-1:0]                cfg_io_base;
wire                                cfg_ext_synch;
wire    [NF-1:0]                    cfg_io_space_en;
wire    [NF-1:0]                    cfg_mem_space_en;
wire                                upstream_port;
wire                                end_device;
wire                                rc_device;
wire                                bridge_device;
wire    [(3*NF)-1:0]                cfg_pmstate;
wire    [NF-1:0]                    cfg_pme_en;
wire    [(5*NF)-1:0]                cfg_pme_cap;
wire    [2:0]                       cfg_l0s_entr_latency_timer;
wire    [2:0]                       cfg_l1_entr_latency_timer;
wire                                cfg_l1_entr_wo_rl0s;
wire    [(4*NF)-1:0]                cfg_cpl_timeout_range;
wire    [NF-1:0]                    cfg_cpl_timeout_disable;
wire    [NF-1:0]                    cfg_adv_cor_err_int;
wire    [NF-1:0]                    cfg_adv_nf_err_int;
wire    [NF-1:0]                    cfg_adv_f_err_int;
wire    [NF-1:0]                    cfg_bus_master_en;
wire                                cfg_ob_rd_split_burst_en;
wire    [2:0]                       int_cfg_remote_rd_req_bridge_size;
assign int_cfg_remote_rd_req_bridge_size = `DC_MAX_PYLD_SIZE_4096_BYTES_ENC;

wire    [`CX_REMOTE_LUT_PTR_WIDTH-1:0] int_cfg_remote_max_bridge_tag;
assign int_cfg_remote_max_bridge_tag = `CX_REMOTE_MAX_TAG;
wire                                cfg_msi_ctrl_en;
wire    [63:0]                      cfg_msi_ctrl_addr;
wire                                msi_int_rcvd;
wire    [15:0]                      msi_int_data;

wire     [15:0]                     cfg_err_resp;
wire                                       cfg_auto_flush_en;
wire     [7:0]                             cfg_auto_flush_timeout;
wire                                       cfg_link_timeout_en_n;
wire      [`LINK_TIMEOUT_PERIOD_WIDTH-1:0] cfg_link_timeout_period;
wire                                       cfg_ax_mstr_np_pass_p;
wire [1:0]                                 cfg_ax_mstr_ordr_p_event_sel;
wire                                       cfg_ax_ib_cpl_pass_p;
wire                                       cfg_ax_snp_en;
wire     [3:0]                                  cfg_mstr_arcache_mode;
wire     [3:0]                                  cfg_mstr_awcache_mode;
wire     [3:0]                                  cfg_mstr_arcache_value;
wire     [3:0]                                  cfg_mstr_awcache_value;
wire     [31:0]                                 cfg_aximstr_msg_addr_high;
wire     [31:0]                                 cfg_aximstr_msg_addr_low;

wire                                            cfg_memtype_value;
wire      [`FLT_Q_ADDR_WIDTH-3:0]               cfg_memtype_boundary;

// ATU outbound Region controls
wire      [5*ATU_OUT_MIN1-1:0]                  atu_reg_out_type;
wire      [3*ATU_OUT_MIN1-1:0]                  atu_reg_out_tc;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_td;
wire      [ATTR_WD*ATU_OUT_MIN1-1:0]            atu_reg_out_attr;
wire      [PF_WD*ATU_OUT_MIN1-1:0]              atu_reg_out_func_num;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_func_bypass;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_snp;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_dma_bypass;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_inhibit_payload;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_hdr_substitute_en;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_tag_substitute_en;
wire      [TAG_SIZE*ATU_OUT_MIN1-1:0]           atu_reg_out_tag;
wire      [8*ATU_OUT_MIN1-1:0]                  atu_reg_out_msg_code;
// Mode Settings
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_shift;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_invert;
// Region Enable
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_en;
// Base, Limit and Target Registers
wire      [ATU_REG_WD*ATU_OUT_MIN1-1:0]         atu_reg_out_base;
wire      [ATU_BASE_WD*ATU_OUT_MIN1-1:0]        atu_reg_out_upr_base;
wire      [ATU_REG_WD*ATU_OUT_MIN1-1:0]         atu_reg_out_limit;
wire      [ATU_REG_WD*ATU_OUT_MIN1-1:0]         atu_reg_out_lwr_trgt;
wire      [ATU_BASE_WD*ATU_OUT_MIN1-1:0]        atu_reg_out_upr_trgt;
wire      [ATU_REG_LWR_WD*ATU_OUT_MIN1-1:0]     atu_reg_out_lwr_trgt_lwr;
wire      [ATU_OUT_MIN1-1:0]                    atu_reg_out_incr_rgn_size;    // Maximum region size control bit

// ATU inbound Region controls
wire      [5*ATU_IN_MIN1 -1:0]                  atu_reg_in_type;
wire      [3*ATU_IN_MIN1 -1:0]                  atu_reg_in_tc;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_td;
wire      [ATTR_WD*ATU_IN_MIN1 -1:0]            atu_reg_in_attr;
wire      [PF_WD*ATU_IN_MIN1 -1:0]              atu_reg_in_func_num;
wire      [8*ATU_IN_MIN1 -1:0]                  atu_reg_in_msg_code;
wire      [3*ATU_IN_MIN1 -1:0]                  atu_reg_in_bar_num;
// Inbound field match enables
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_tc_match_en;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_td_match_en;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_attr_match_en;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_func_match_en;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_msgcode_match_en;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_single_addr_loc_en;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_msg_type_match_mode;
// Response and mode settings
wire      [2*ATU_IN_MIN1 -1:0]                  atu_reg_in_rsp_code;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_fuzzy;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_shift;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_invert;
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_bar_match;
// Region Enable
wire      [ATU_IN_MIN1 -1:0]                    atu_reg_in_en;
// Base, Limit and Target Registers
wire      [ATU_REG_WD*ATU_IN_MIN1 -1:0]         atu_reg_in_base;
wire      [ATU_BASE_WD*ATU_IN_MIN1 -1:0]        atu_reg_in_upr_base;
wire      [ATU_REG_WD*ATU_IN_MIN1 -1:0]         atu_reg_in_limit;
wire      [ATU_REG_WD*ATU_IN_MIN1 -1:0]         atu_reg_in_lwr_trgt;
wire      [ATU_BASE_WD*ATU_IN_MIN1 -1:0]        atu_reg_in_upr_trgt;
wire      [ATU_IN_MIN1-1:0]                     atu_reg_in_incr_rgn_size;    // Maximum region size control bit

wire    [NF-1:0]                    cfg_slot_pwr_limit_wr;
wire    [NF-1:0]                    cfg_eml_control;
wire    [(2*NF)-1:0]                cfg_pwr_ind;
wire    [(2*NF)-1:0]                cfg_atten_ind;
wire    [(64*NF)-1:0]               cfg_msi_addr;
wire    [(32*NF)-1:0]               cfg_msi_data;
wire    [NF-1:0]                    cfg_msi_64;
wire    [NF-1:0]                    cfg_msi_en;
wire    [63:0]                      msix_addr;
wire    [31:0]                      msix_data;
wire    [NF-1:0]                    cfg_msix_en;
wire    [(3*NF)-1:0]                cfg_multi_msi_en;
wire    [NF-1:0]                    cfg_msi_ext_data_en;
wire    [(RX_TLP_CXPL*64)-1:0]      rtlh_radm_ant_addr;
wire    [(RX_TLP_CXPL*16)-1:0]      rtlh_radm_ant_rid;
wire    [NF-1:0]                    cfg_msix_func_mask;
wire    [(11*NF)-1:0]               cfg_msix_table_size;
wire    [(3*NF)-1:0]                cfg_msix_table_bir;
wire    [(29*NF)-1:0]               cfg_msix_table_offset;
wire    [(3*NF)-1:0]                cfg_msix_pba_bir;
wire    [(29*NF)-1:0]               cfg_msix_pba_offset;
wire    [NF-1:0]                    cfg_vpd_int;
wire    [NF-1:0]                    cfg_flr_pf_active;
wire    [NF-1:0]                    app_flr_pf_done;
wire    [NF-1:0]                    radm_flr_pf_done;
wire    [NF-1:0]                    xadm_flr_pf_done;
wire    [NF-1:0]                    flr_pf_rst_n;

wire    [31:0]                      cfg_pwr_budget_data_reg;
wire    [PF_WD-1:0]                 cfg_pwr_budget_func_num;
wire    [7:0]                       cfg_pwr_budget_data_sel_reg;
wire    [NF-1:0]                    cfg_pwr_budget_sel;
wire    [7:0]                       cfg_slot_pwr_limit_val;
wire    [1:0]                       cfg_slot_pwr_limit_scale;
wire    [NF-1:0]                    cfg_upd_pmcsr;
wire    [NF-1:0]                    cfg_upd_req_id;                 // needs to support all 8 max allowed functions
wire    [NF-1:0]                    cfg_upd_aux_pm_en;
wire    [NF-1:0]                    cfg_pmstatus_clr;
wire    [(3*NF)-1:0]                cfg_max_rd_req_size;
wire    [(3*NF)-1:0]                cfg_func_spec_err;
wire    [PF_WD-1:0]                 cfg_max_func_num;
wire    [(8*NF)-1:0]                cfg_2ndbus_num;                 // configured primary bus number, it will be reserved during power down if PMC module is populated
wire    [(8*NF)-1:0]                cfg_subbus_num;                 // configured subordinary bus number
output  [NF-1:0]                    cfg_send_cor_err;
output  [NF-1:0]                    cfg_send_nf_err;
output  [NF-1:0]                    cfg_send_f_err;
output  [NF-1:0]                    cfg_int_disable;

// -----------------------------------------------------------------------------

wire    [NVC-1:0]                   xadm_had_enough_credit;
wire    [NVC-1:0]                   xadm_no_fc_credit;
wire    [NVC-1:0]                   rtlh_crd_not_rtn;
wire    [(FX_TLP*64)-1:0]           flt_cdm_addr;
wire    [(FX_TLP*NF)-1:0]           cfg_io_match;
wire    [(FX_TLP*NF)-1:0]           cfg_config_above_match;
wire    [(FX_TLP*NF)-1:0]           cfg_rom_match;
wire    [(FX_TLP*NF*6)-1:0]         cfg_bar_match;
wire    [(FX_TLP*NF)-1:0]           cfg_prefmem_match;
wire    [(FX_TLP*NF)-1:0]           cfg_mem_match;
wire    [(NF*6)-1:0]                cfg_bar_is_io;
wire    [`CX_PL_MULTILANE_CONTROL_WD-1:0] cfg_pl_multilane_control;

wire    [N_FLT_MASK-1:0]            cfg_filter_rule_mask;

wire                                cfg_fc_wdog_disable;

wire                                pme_to_ack_grt;
wire    [NF-1:0]                    pm_pme_grant;
wire                                pme_turn_off_grt;
wire    [NF-1:0]                    pm_xmt_to_ack;
wire    [NF-1:0]                    pm_xmt_pme;
wire    [NF-1:0]                    hp_pme;
wire    [NF-1:0]                    hp_int;
wire    [NF-1:0]                    hp_msi;
wire                                xtlh_xadm_halt;
wire                                xadm_cpl_halt;
wire                                xadm_notlp_pending;
wire                                xadm_idle;
wire                                xadm_all_type_infinite;
wire    [RX_TLP_CXPL-1:0]           rtlh_radm_dllp_err;
wire    [RX_TLP_CXPL-1:0]           rtlh_radm_ecrc_err;
wire    [RX_TLP_CXPL-1:0]           rtlh_radm_malform_tlp_err;
wire    [3*NVC-1:0]                 trgt0_radm_halt;
wire                                lbc_active;
wire    [NVC-1:0]                   radm_q_not_empty;
wire                                radm_slot_pwr_limit;
wire                                lbc_cdm_dbi;
wire                                lbc_cdm_dbi2;
wire                                lbc_cdm_unroll;
wire    [NF-1:0]                    lbc_xmt_cpl_ca;
wire                                rmlh_rcvd_err;
wire    [NVC-1:0]                   rtlh_fc_init_status;
wire                                rdlh_prot_err;
wire    [NF-1:0]                    surprise_down_err;
wire                                rdlh_bad_tlp_err;
wire                                rdlh_bad_dllp_err;
wire                                xdlh_replay_num_rlover_err;
wire                                xdlh_replay_timeout_err;
wire                                smlh_link_up;
wire                                smlh_req_rst_not;
wire                                link_req_rst_not;
wire                                xdlh_retrybuf_not_empty;
wire                                xdlh_retryram_halt;
wire                                smlh_in_rl0s;
wire                                smlh_in_l0s;
wire    [L2NL-1:0]                  smlh_lane_flip_ctrl;
wire                                rmlh_rcvd_eidle_set;
wire                                xdlh_nodllp_pending;
wire                                xdlh_no_acknak_dllp_pending;
wire                                xdlh_not_expecting_ack;
wire                                xdlh_xmt_pme_ack;
wire                                xdlh_last_pmdllp_ack;
wire                                xtlh_notlp_pending;
wire                                xtlh_data_parerr;
wire                                pm_xmt_asnak;
wire                                pm_xmt_turnoff;
wire                                pm_turnoff_timeout;
wire                                msg_gen_asnak_grt;
wire                                msg_gen_unlock_grant;
wire    [(NVC)-1:0]                 cfg_vc_enable;                  // Which VCs are enabled - VC0 is always enabled
wire    [(NVC*3)-1:0]               cfg_vc_struc_vc_id_map;         // VC Structure to VC ID mapping
wire    [23:0]                      cfg_vc_id_vc_struc_map;         // VC ID to VC Structure mapping
wire    [7:0]                       cfg_tc_enable;                  // Which TCs are enabled
wire    [23:0]                      cfg_tc_vc_map;                  // TC to VC Structure mapping
wire    [23:0]                      cfg_tc_struc_vc_map;            // TC to VC Structure mapping

wire  [3:0]                         xdlh_match_pmdllp;

// Retry buffer external RAM interface
// Depth of retry buffer
wire    [RBUF_PW -1:0]              retryram_xdlh_depth;
assign  retryram_xdlh_depth         = RBUF_DEPTH -1;                // this signal is defined to be the value of the top pointer of a RAM designed in our core

// Depth of retry buffer
wire    [SOTBUF_PW -1:0]            retrysotram_xdlh_depth;
assign  retrysotram_xdlh_depth      = SOTBUF_DP -1;                 // this signal is defined to be the value of the top pointer of a RAM designed in our core

wire                                radm_parerr;
wire                                rtlh_parerr;
wire                                radm_trgt0_pending;         // TLP enroute from RADM prevent DBI access
wire                                xadm_parerr_detected;
wire    [(NF*6)-1:0]                target_mem_map;                 // Each bit of this vector indicates which target receives memory transactions for that bar #
wire    [ NF-1:0]                   target_rom_map;                 // Each bit of this vector indicates which target receives rom    transactions for that bar #
wire                                inta_wire;
wire                                intb_wire;
wire                                intc_wire;
wire                                intd_wire;
wire                                cfg_2nd_reset;


wire                                radm_snoop_upd;
wire                                int_cfg_upd_req_id;
wire    [7:0]                       radm_snoop_bus_num;
wire    [4:0]                       radm_snoop_dev_num;
wire                                rtlh_fc_prot_err;
wire    [7:0]                       int_cfg_pbus_num;
wire    [4:0]                       int_cfg_pbus_dev_num;
parameter CRGB_ADDR_WIDTH = 16;
parameter CRGB_DATA_WIDTH = 32;
parameter CRGB_BE_WIDTH = 4;
//eDMA interface wires

//CRGB EDMA interface
wire    [CRGB_ADDR_WIDTH - 1 : 0]       crgb_address;
wire                                    crgb_rden;
wire                                    crgb_source;
wire    [CRGB_DATA_WIDTH - 1 : 0]       crgb_wr_data;
wire                                    crgb_wren;
wire                                    crgb_ack;
wire    [CRGB_DATA_WIDTH - 1:0]         crgb_rd_data;

//CDM-CRGB interface
wire    [CRGB_DATA_WIDTH - 1:0]         crgb_cdm_rdata;
wire                                    crgb_cdm_cs;
wire                                    crgb_cdm_ack;
wire    [CRGB_ADDR_WIDTH - 1:0]         crgb_cdm_addr;
wire    [CRGB_DATA_WIDTH - 1:0]         crgb_cdm_wdata;
wire    [CRGB_BE_WIDTH - 1:0]           crgb_cdm_wr;
wire                                    crgb_cdm_source;
wire    [(`CC_NUM_DMA_RD_CHAN+`CC_NUM_DMA_WR_CHAN-1):0] edma_int;
// Indicates to the received ompletion is the last one
wire                                    radm_trgt1_cpl_lookup_id_rlsd;
// Indicates non-posted TLP
wire                                    radm_trgt1_lookup_id_consmd;
//DMA Ram interface wires
wire    [DMA_CTX_RAM_DATA_WIDTH-1:0]    ram2edma_din;
wire    [DMA_CTX_RAM_ADDR_WIDTH-1:0]    edma2ram_addra;
wire    [DMA_CTX_RAM_ADDR_WIDTH-1:0]    edma2ram_addrb;
wire    [DMA_CTX_RAM_DATA_WIDTH-1:0]    edma2ram_dout;
wire                                    edma2ram_re;
wire                                    edma2ram_we;
wire [DMA_SEG_BUF_NW_ADDR_WIDTH-1:0]    edmarbuff2ram_addra;
wire [DMA_SEG_BUF_NW_ADDR_WIDTH-1:0]    edmarbuff2ram_addrb;
wire                                    edmarbuff2ram_re;
wire                                    edmarbuff2ram_we;


wire  [NF-1:0]        cfg_no_snoop_en;            // No Snoop enable
wire  [NF-1:0]        cfg_relax_order_en;           // relaxed ordering enable


wire    [16:0]                  xdlh_replay_timer;            // XDLH retry buffer replay timer it is routed to top-level to resolve multisim issues with hdl backdoor usage in VTB
wire    [11:0]                  xdlh_rbuf_pkt_cnt;            // XDLH packet counter it is routed to top-level to resolve multisim issues with hdl backdoor usage in VTB
// LTSSM timers routed to the top-level for verification usage
wire    [24:0]                  smlh_freq_multiplier;
wire    [24:0]                  smlh_fast_time_1ms;
wire    [24:0]                  smlh_fast_time_2ms;
wire    [24:0]                  smlh_fast_time_3ms;
wire    [24:0]                  smlh_fast_time_4ms;
wire    [24:0]                  smlh_fast_time_10ms;
wire    [24:0]                  smlh_fast_time_12ms;
wire    [24:0]                  smlh_fast_time_24ms;
wire    [24:0]                  smlh_fast_time_32ms;
wire    [24:0]                  smlh_fast_time_48ms;
wire    [24:0]                  smlh_fast_time_100ms;

// de-reference LTSSM timeouts in fast link mode from cxpl_defs.vh
assign smlh_freq_multiplier = `CX_FREQ_MULTIPLIER;
assign smlh_fast_time_1ms   = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_1MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_1MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_1MS << 4) :
                                                                      (`CX_FAST_TIME_1MS << 6) ;
assign smlh_fast_time_2ms   = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_2MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_2MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_2MS << 4) :
                                                                      (`CX_FAST_TIME_2MS << 6) ;
assign smlh_fast_time_3ms   = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_3MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_3MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_3MS << 4) :
                                                                      (`CX_FAST_TIME_3MS << 6) ;
assign smlh_fast_time_4ms   = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_4MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_4MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_4MS << 4) :
                                                                      (`CX_FAST_TIME_4MS << 6) ;
assign smlh_fast_time_10ms  = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_10MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_10MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_10MS << 4) :
                                                                      (`CX_FAST_TIME_10MS << 6) ;
assign smlh_fast_time_12ms  = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_12MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_12MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_12MS << 4) :
                                                                      (`CX_FAST_TIME_12MS << 6) ;
assign smlh_fast_time_24ms  = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_24MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_24MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_24MS << 4) :
                                                                      (`CX_FAST_TIME_24MS << 6) ;
assign smlh_fast_time_32ms  = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_32MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_32MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_32MS << 4) :
                                                                      (`CX_FAST_TIME_32MS << 6) ;
assign smlh_fast_time_48ms  = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_48MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_48MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_48MS << 4) :
                                                                      (`CX_FAST_TIME_48MS << 6) ;
assign smlh_fast_time_100ms = (cfg_fast_link_scaling_factor==2'b00) ? `CX_FAST_TIME_100MS :
                              (cfg_fast_link_scaling_factor==2'b01) ? (`CX_FAST_TIME_100MS << 2) :
                              (cfg_fast_link_scaling_factor==2'b10) ? (`CX_FAST_TIME_100MS << 4) :
                                                                      (`CX_FAST_TIME_100MS << 6) ;

wire                                    default_target;
wire                                    ur_ca_mask_4_trgt1;

//  MUX for CPCIE outputs
// ----------------------------------------------------------------------------



//  MUX for MPCIE outputs
// ----------------------------------------------------------------------------





// =============================================================================
reg    [3:0]    int_device_type;                    // internal device type. (can be change when crosslink is enabled)

 always @(*)
         int_device_type            = device_type;

 // Insert register in path to avoid feedback path between RADM input
 // (device_type) and output (radm_byp_addr)

 reg  [3:0]      device_type_reg; // registered device_type
 always @(posedge core_clk or negedge core_rst_n)
     if(!core_rst_n)
         device_type_reg            <= #(`TP) `CX_DEVICE_TYPE;
     else
         device_type_reg            <= #(`TP) device_type;    // device_type_reg gets valid type one cycle after reset, but this is ok for RADM block.

assign  msix_addr = 64'd0;
assign  msix_data = 32'd0;

assign  cfg_reset_assert            = (cfg_2nd_reset & !upstream_port) | cfg_plreg_reset;  // two resets from CDM. One is for RC mode only, it is the secondary bridge reset, the other one is for debug PL register.


assign  int_cfg_pbus_num            = Bget(cfg_pbus_num, cfg_upd_req_id);
assign  int_cfg_pbus_dev_num        = Qget(cfg_pbus_dev_num, cfg_upd_req_id);

 assign int_cfg_upd_req_id      = cfg_upd_req_id[0];

wire rtlh_overfl_err;
assign rtlh_overfl_err_nf = {NF{rtlh_overfl_err}};

 assign int_rtlh_ph_ca              = credit_mapping(radm_rtlh_ph_ca);
 assign int_rtlh_pd_ca              = radm_rtlh_pd_ca;
 assign int_rtlh_nph_ca             = credit_mapping(radm_rtlh_nph_ca);
 assign int_rtlh_npd_ca             = radm_rtlh_npd_ca;
 assign int_rtlh_cplh_ca            = credit_mapping(radm_rtlh_cplh_ca);
 assign int_rtlh_cpld_ca            = radm_rtlh_cpld_ca;


wire    [(NVC*8)-1:0]               cfg_fc_credit_ph;
wire    [(NVC*8)-1:0]               cfg_fc_credit_nph;
wire    [(NVC*8)-1:0]               cfg_fc_credit_cplh;
wire    [(NVC*12)-1:0]              cfg_fc_credit_pd;
wire    [(NVC*12)-1:0]              cfg_fc_credit_npd;
wire    [(NVC*12)-1:0]              cfg_fc_credit_cpld;             // (PL) Flow Control credits - Completion Data
wire    [(NVC*9)-1:0]               cfg_radm_q_mode;                // (PL) Queue Mode: CPL(BP/CT/SF), NP(BP/CT/SF), P(BP/CT/SF)
wire    [NVC-1:0]                   cfg_radm_order_rule;            // (PL) Order Selection: 0 - Strict Priority, 1 - Complies with Ordering Rule
wire    [15:0]                      cfg_order_rule_ctrl;            // cpl_pass_p_if_phalted[7:0], np_pass_p_if_phalted[7:0] one for each VC
wire                                cfg_radm_strict_vc_prior;       // (PL) VC Priority: 0 - Round Robin, 1 - Strict Priority
wire    [(NVC*3*`CX_RADM_SBUF_HDRQ_PW)-1:0] cfg_hq_depths;          // (PL) Indicates the depth of the header queues per type per vc
wire    [(NVC*3*`CX_RADM_SBUF_DATAQ_PW)-1:0]cfg_dq_depths;          // (PL) Indicates the depth of the data queues per type per vc




wire    [31:0]                      cfg_trgt_cpl_lut_delete_entry;  // trgt_cpl_lut delete one entry
wire                                cfg_clock_gating_ctrl;

// for multifunction device, bus and dev number are based on per func.
// Here the request ID is the request ID of a transaction request and a completer's ID if it is a completion

 assign client0_req_id              = get_req_id(cfg_pbus_num, cfg_pbus_dev_num, client0_tlp_func_num_i);
 assign client1_req_id              = get_req_id(cfg_pbus_num, cfg_pbus_dev_num, client1_tlp_func_num_i);
  assign client2_req_id             = get_req_id(cfg_pbus_num, cfg_pbus_dev_num, client2_tlp_func_num_i);




//
// muxes added for enabling lane flip functions
//
lane_flip
 #(
  .L2NL (L2NL)
) u_lane_flip (
    // ------------------ Inputs - Controls ------------------
    .core_clk                                       (core_clk),
    .core_clk_ug                                    (core_clk_ug),
    .core_rst_n                                     (core_rst_n),
    .pm_rx_lane_flip_en                             (pm_rx_lane_flip_en),
    .pm_tx_lane_flip_en                             (pm_tx_lane_flip_en),
    .pm_rx_pol_lane_flip_ctrl                       (pm_rx_pol_lane_flip_ctrl),

    // ------------------ Inputs - Rx Muxes ------------------
    .int_phy_mac_rxstandbystatus_i                  (int_phy_mac_rxstandbystatus),
    .int_phy_mac_rxdata_i                           (int_phy_mac_rxdata),
    .int_phy_mac_rxdatak_i                          (int_phy_mac_rxdatak),
    .int_phy_mac_rxdatavalid_i                      (int_phy_mac_rxdatavalid),
    .int_phy_mac_rxvalid_i                      (int_phy_mac_rxvalid),
    .int_phy_mac_rxelecidle_i                   (int_phy_mac_rxelecidle),
    .int_phy_mac_rxstatus_i                     (int_phy_mac_rxstatus),
    .int_phy_mac_phystatus_i                    (int_phy_mac_phystatus),

    // ------------------ Outputs - Rx Muxes ------------------
    .tmp_phy_mac_rxstandbystatus                    (tmp_phy_mac_rxstandbystatus),
    .tmp_phy_mac_rxdata                             (tmp_phy_mac_rxdata),
    .tmp_phy_mac_rxdatak                            (tmp_phy_mac_rxdatak),
    .tmp_phy_mac_rxdatavalid                        (tmp_phy_mac_rxdatavalid),
    .tmp_phy_mac_rxvalid                        (tmp_phy_mac_rxvalid),
    .tmp_phy_mac_rxelecidle                     (tmp_phy_mac_rxelecidle),
    .tmp_phy_mac_rxstatus                       (tmp_phy_mac_rxstatus),
    .tmp_phy_mac_phystatus                      (tmp_phy_mac_phystatus),

    // ------------------ Inputs - Tx Muxes ------------------
    .tmp_mac_phy_rxstandby                          (tmp_mac_phy_rxstandby),
    .tmp_xmlh_powerdown                             (tmp_xmlh_powerdown),
    .tmp_int_mac_phy_rate                           (tmp_int_mac_phy_rate),
    .tmp_mac_phy_txdata                             (tmp_mac_phy_txdata),
    .tmp_mac_phy_txdatak                            (tmp_mac_phy_txdatak),
    .tmp_mac_phy_txdetectrx_loopback                (tmp_mac_phy_txdetectrx_loopback),
    .tmp_ltssm_txelecidle                           (tmp_ltssm_txelecidle),
    .tmp_mac_phy_txcompliance                       (tmp_mac_phy_txcompliance),
    .tmp_mac_phy_rxpolarity                         (tmp_mac_phy_rxpolarity),
    .smlh_lanes_active                              (smlh_lanes_active),
    .smlh_rcvd_eidle_rxstandby                      (smlh_rcvd_eidle_rxstandby),


    // ------------------ Outputs - Tx Muxes ------------------
    .int_mac_phy_rxstandby_o                        (int_mac_phy_rxstandby),
    .int_xmlh_powerdown_o                           (int_xmlh_powerdown),
    .int_mac_phy_rate_o                             (int_mac_phy_rate),
    .int_mac_phy_txdata_o                           (int_mac_phy_txdata),
    .int_mac_phy_txdatak_o                          (int_mac_phy_txdatak),
    .int_mac_phy_txdetectrx_loopback_o              (int_mac_phy_txdetectrx_loopback),
    .int_ltssm_txelecidle_o                         (int_ltssm_txelecidle),
    .int_mac_phy_txcompliance_o                     (int_mac_phy_txcompliance),
    .int_mac_phy_rxpolarity_o                       (int_mac_phy_rxpolarity)
    ,
    .laneflip_lanes_active_o                        (laneflip_lanes_active),
    .laneflip_rcvd_eidle_rxstandby_o                (laneflip_rcvd_eidle_rxstandby)
); // u_lane_flip

// assign tmp_phy_mac_rxstandbystatus = int_phy_mac_rxstandbystatus; // no lane flip
// assign int_mac_phy_rxstandby = tmp_mac_phy_rxstandby; // no lane flip


 assign in_cxpl_phy_mac_rxdata              = tmp_phy_mac_rxdata;
 assign in_cxpl_phy_mac_rxdatak             = tmp_phy_mac_rxdatak;
 assign in_cxpl_phy_mac_rxvalid             = tmp_phy_mac_rxvalid;
 assign in_cxpl_phy_mac_rxelecidle          = tmp_phy_mac_rxelecidle;
 assign in_cxpl_phy_mac_rxstatus            = tmp_phy_mac_rxstatus;
 assign in_cxpl_phy_mac_phystatus           = tmp_phy_mac_phystatus;


assign  radm_pm_to_ack              = int_radm_pm_to_ack | pm_turnoff_timeout; // Turnoff timeout is treated as if TO ACK message is received.
// Adding in a freeze completion timer control per PM module's request
wire                                pm_freeze_cpl_timer;

//
// XADM Module
//

parameter WRR_ARB_WD = 8;

wire    [(8*WRR_ARB_WD)-1:0]        cfg_lpvc_wrr_weight;
wire    [63:0]                      int_cfg_lpvc_wrr_weight;
wire    [1:0]                       cfg_lpvc_wrr_phase;
wire    [2:0]                       cfg_lpvc;
wire    [2:0]                       cfg_vc_arb_sel;


wire                    int_radm_inta_asserted;
wire                    int_radm_intb_asserted;
wire                    int_radm_intc_asserted;
wire                    int_radm_intd_asserted;
assign                  radm_inta_asserted = int_radm_inta_asserted;
assign                  radm_intb_asserted = int_radm_intb_asserted;
assign                  radm_intc_asserted = int_radm_intc_asserted;
assign                  radm_intd_asserted = int_radm_intd_asserted;
assign cfg_lpvc_wrr_weight  = {int_cfg_lpvc_wrr_weight[(8*7+WRR_ARB_WD)-1:8*7],
                               int_cfg_lpvc_wrr_weight[(8*6+WRR_ARB_WD)-1:8*6],
                               int_cfg_lpvc_wrr_weight[(8*5+WRR_ARB_WD)-1:8*5],
                               int_cfg_lpvc_wrr_weight[(8*4+WRR_ARB_WD)-1:8*4],
                               int_cfg_lpvc_wrr_weight[(8*3+WRR_ARB_WD)-1:8*3],
                               int_cfg_lpvc_wrr_weight[(8*2+WRR_ARB_WD)-1:8*2],
                               int_cfg_lpvc_wrr_weight[(8*1+WRR_ARB_WD)-1:8*1],
                               int_cfg_lpvc_wrr_weight[(8*0+WRR_ARB_WD)-1:8*0]};
assign cfg_lpvc_wrr_phase   = cfg_vc_arb_sel[1:0];

wire int_trgt1_radm_halt;
assign trgt1_radm_halt_i = int_trgt1_radm_halt | ~trgt_lookup_empty;


// Since AXI_BRIDGE does the parity location different from the core's parity location, we will need to swap the parity location


assign radm_trgt1_data_w_par = radm_trgt1_data;
assign radm_trgt1_addr_w_par = radm_trgt1_addr;

assign radm_bypass_data_w_par = radm_bypass_data;
assign radm_bypass_addr_w_par = radm_bypass_addr;



wire int_radm_trgt1_hv;
wire int_radm_trgt1_dv;
wire int_radm_trgt1_eot;
// Mask pending request from radm NP queue when lookup ID's exhausted
assign int_radm_trgt1_hv  = radm_trgt1_hv_i & trgt_lookup_empty;
assign int_radm_trgt1_dv  = radm_trgt1_dv_i & trgt_lookup_empty;
assign int_radm_trgt1_eot = radm_trgt1_eot_i & trgt_lookup_empty;


wire    [FX_TLP-1:0]                int_radm_pm_pme;
assign radm_pm_pme          = |int_radm_pm_pme;
wire    [FX_TLP-1:0]                int_radm_correctable_err;           // RC Mode Only:
wire    [FX_TLP-1:0]                int_radm_nonfatal_err;              // RC Mode Only:
wire    [FX_TLP-1:0]                int_radm_fatal_err;                 // RC Mode Only:
assign radm_correctable_err = |int_radm_correctable_err;
assign radm_nonfatal_err    = |int_radm_nonfatal_err;
assign radm_fatal_err       = |int_radm_fatal_err;

wire    [FX_TLP*NF-1:0] cdm_radm_correctable_err;           // RC Mode Only:
wire    [FX_TLP*NF-1:0] cdm_radm_nonfatal_err;              // RC Mode Only:
wire    [FX_TLP*NF-1:0] cdm_radm_fatal_err;                 // RC Mode Only:
wire    [FX_TLP*NF-1:0] cdm_radm_pm_pme;                    // RC Mode Only:

assign cdm_radm_correctable_err = {NF{int_radm_correctable_err}};
assign cdm_radm_nonfatal_err    = {NF{int_radm_nonfatal_err}};
assign cdm_radm_fatal_err       = {NF{int_radm_fatal_err}};
assign cdm_radm_pm_pme          = {NF{int_radm_pm_pme}};

wire int_radm_trgt1_mem_type;

assign int_radm_trgt1_mem_type = ( radm_trgt1_addr >= {cfg_memtype_boundary,2'b00} ) ? ~cfg_memtype_value : cfg_memtype_value ;





  `AMBA_TOP
#(
  .ATU_OUT_REGIONS(ATU_OUT_REGIONS)
  ,.ATU_BASE_WD(ATU_BASE_WD)
  ,.ATU_REG_WD(ATU_REG_WD)
 )
 `AMBA_INST (
    .core_clk                       (core_clk),
    .core_rst_n                     (core_rst_n),
    .aux_clk_g                      (aux_clk_g),
    .aux_clk                        (pm_aux_clk),
    .mstr_aclk                      (mstr_aclk),
    .mstr_aresetn                   (mstr_aresetn),
    .mstr_aclk_ug                   (mstr_aclk_ug),
    .mstr_aclk_active               (mstr_aclk_active),
    .mstr_awid                      (mstr_awid),
    .mstr_awvalid                   (mstr_awvalid),
    .mstr_awaddr                    (mstr_awaddr),
    .mstr_awlen                     (mstr_awlen),
    .mstr_awsize                    (mstr_awsize),
    .mstr_awburst                   (mstr_awburst),
    .mstr_awlock                    (mstr_awlock),
    .mstr_awcache                   (mstr_awcache),
    .mstr_awprot                    (mstr_awprot),
    .mstr_awready                   (mstr_awready),
    .mstr_awmisc_info               (mstr_awmisc_info),
    .mstr_awmisc_info_last_dcmp_tlp (mstr_awmisc_info_last_dcmp_tlp),
    .mstr_awmisc_info_hdr_34dw      (mstr_awmisc_info_hdr_34dw),
    .mstr_awmisc_info_ido           (mstr_awmisc_info_ido),
     .mstr_awmisc_info_dma          (mstr_awmisc_info_dma),
    .mstr_awmisc_info_func_num      (mstr_awmisc_info_func_num),

    .mstr_wready                    (mstr_wready),
    .mstr_wdata                     (mstr_wdata),
    .mstr_wstrb                     (mstr_wstrb),
    .mstr_wlast                     (mstr_wlast),
    .mstr_wvalid                    (mstr_wvalid),
    .mstr_wid                       (mstr_wid),

    .mstr_bready                    (mstr_bready),
    .mstr_bid                       (mstr_bid),
    .mstr_bvalid                    (mstr_bvalid),
    .mstr_bresp                     (mstr_bresp),
    .mstr_bmisc_info_cpl_stat       (mstr_bmisc_info_cpl_stat),
    .mstr_arid                      (mstr_arid),
    .mstr_arvalid                   (mstr_arvalid),
    .mstr_araddr                    (mstr_araddr),
    .mstr_arlen                     (mstr_arlen),
    .mstr_arsize                    (mstr_arsize),
    .mstr_arburst                   (mstr_arburst),
    .mstr_arlock                    (mstr_arlock),
    .mstr_arcache                   (mstr_arcache),
    .mstr_arprot                    (mstr_arprot),
    .mstr_armisc_info               (mstr_armisc_info),
    .mstr_armisc_info_last_dcmp_tlp (mstr_armisc_info_last_dcmp_tlp),
    .mstr_armisc_info_ido           (mstr_armisc_info_ido),
    .mstr_armisc_info_dma           (mstr_armisc_info_dma),
    .mstr_armisc_info_func_num      (mstr_armisc_info_func_num),
    .mstr_arready                   (mstr_arready),

    .mstr_rready                    (mstr_rready),
    .mstr_rid                       (mstr_rid),
    .mstr_rvalid                    (mstr_rvalid),
    .mstr_rlast                     (mstr_rlast),
    .mstr_rdata                     (mstr_rdata),
    .mstr_rresp                     (mstr_rresp),
    .mstr_rmisc_info                (mstr_rmisc_info),
    .mstr_rmisc_info_cpl_stat       (mstr_rmisc_info_cpl_stat),
    .mstr_csysack                   (mstr_csysack),
    .mstr_cactive                   (mstr_cactive),
    .mstr_csysreq                   (mstr_csysreq),
    // Slave interfaces of AXI
    .slv_aclk                       (slv_aclk),
    .slv_aresetn                    (slv_aresetn),
    .slv_aclk_ug                    (slv_aclk_ug),
    .slv_aclk_active                (slv_aclk_active),
    .slv_awid                       (slv_awid),
    .slv_awaddr                     (slv_awaddr),
    .slv_awlen                      (slv_awlen),
    .slv_awsize                     (slv_awsize),
    .slv_awburst                    (slv_awburst),
    .slv_awlock                     (slv_awlock),
    .slv_awcache                    (slv_awcache),
    .slv_awprot                     (slv_awprot),
    .slv_awvalid                    (pm_slv_awvalid),
    .slv_awready                    (slv_awready),
    .slv_awmisc_info                (slv_awmisc_info),
    .slv_awmisc_info_hdr_34dw       (slv_awmisc_info_hdr_34dw),
    .slv_awmisc_info_p_tag          (slv_awmisc_info_p_tag),
    .slv_awmisc_info_atu_bypass     (slv_awmisc_info_atu_bypass),
    .slv_awmisc_info_ido            (slv_awmisc_info_ido),
    .slv_awmisc_info_func_num       (slv_awmisc_info_func_num),

    .slv_wready                     (slv_wready),
    .slv_wid                        (slv_wid),
    .slv_wdata                      (slv_wdata),
    .slv_wstrb                      (slv_wstrb),
    .slv_wlast                      (slv_wlast),
    .slv_wvalid                     (pm_slv_wvalid),

    .slv_bid                        (slv_bid),
    .slv_bresp                      (slv_bresp),
    .slv_bvalid                     (slv_bvalid),
    .slv_bready                     (slv_bready),
    .slv_bmisc_info                 (slv_bmisc_info),

    .slv_arid                       (slv_arid),
    .slv_araddr                     (slv_araddr),
    .slv_arlen                      (slv_arlen),
    .slv_arsize                     (slv_arsize),
    .slv_arburst                    (slv_arburst),
    .slv_arlock                     (slv_arlock),
    .slv_arcache                    (slv_arcache),
    .slv_arprot                     (slv_arprot),
    .slv_armisc_info                (slv_armisc_info),
    .slv_armisc_info_atu_bypass     (slv_armisc_info_atu_bypass),
    .slv_armisc_info_ido            (slv_armisc_info_ido),
    .slv_armisc_info_func_num       (slv_armisc_info_func_num),
    .slv_arvalid                    (pm_slv_arvalid),
    .slv_arready                    (slv_arready),

    .slv_rid                        (slv_rid),
    .slv_rdata                      (slv_rdata),
    .slv_rresp                      (slv_rresp),
    .slv_rlast                      (slv_rlast),
    .slv_rvalid                     (slv_rvalid),
    .slv_rmisc_info                 (slv_rmisc_info),
    .slv_rmisc_info_ido             (slv_rmisc_info_ido),
    .slv_rready                     (slv_rready),

    .slv_csysreq                    (slv_csysreq),
    .slv_csysack                    (slv_csysack),
    .slv_cactive                    (slv_cactive),

    // DBI Slave interfaces of AXI
    .dbi_clk                        (dbi_aclk),
    .dbi_rst_n                      (dbi_aresetn),
    .dbi_clk_ug                     (dbi_aclk_ug),
    .dbi_clk_active                 (dbi_aclk_active),
    .dbi_awid                       (dbi_awid),
    .dbi_awaddr                     (dbi_awaddr),
    .dbi_awlen                      (dbi_awlen),
    .dbi_awsize                     (dbi_awsize),
    .dbi_awburst                    (dbi_awburst),
    .dbi_awlock                     (dbi_awlock),
    .dbi_awcache                    (dbi_awcache),
    .dbi_awprot                     (dbi_awprot),
    .dbi_awvalid                    (pm_dbi_awvalid),
    .dbi_awready                    (dbi_awready),
    .dbi_wready                     (dbi_wready),
    .dbi_wid                        (dbi_wid),
    .dbi_wdata                      (dbi_wdata),
    .dbi_wstrb                      (dbi_wstrb),
    .dbi_wlast                      (dbi_wlast),
    .dbi_wvalid                     (pm_dbi_wvalid),

    .dbi_bid                        (dbi_bid),
    .dbi_bresp                      (dbi_bresp),
    .dbi_bvalid                     (dbi_bvalid),
    .dbi_bready                     (dbi_bready),

    .dbi_arid                       (dbi_arid),
    .dbi_araddr                     (dbi_araddr),
    .dbi_arlen                      (dbi_arlen),
    .dbi_arsize                     (dbi_arsize),
    .dbi_arburst                    (dbi_arburst),
    .dbi_arlock                     (dbi_arlock),
    .dbi_arcache                    (dbi_arcache),
    .dbi_arprot                     (dbi_arprot),
    .dbi_arvalid                    (pm_dbi_arvalid),
    .dbi_arready                    (dbi_arready),

    .dbi_rid                        (dbi_rid),
    .dbi_rdata                      (dbi_rdata),
    .dbi_rresp                      (dbi_rresp),
    .dbi_rlast                      (dbi_rlast),
    .dbi_rvalid                     (dbi_rvalid),
    .dbi_rready                     (dbi_rready),

    .dbi_csysreq                    (dbi_csysreq),
    .dbi_csysack                    (dbi_csysack),
    .dbi_cactive                    (dbi_cactive),
    .rstctl_mstr_flush_req          (rstctl_mstr_flush_req),
    .rstctl_slv_flush_req           (rstctl_slv_flush_req),
    .brdg_slv_flush_ack             (brdg_slv_flush_ack),
    .brdg_slv_xfer_pending          (brdg_slv_xfer_pending),
    .app_xfer_pending               (pm_app_xfer_pending),
    .radm_xfer_pending              (radm_xfer_pending),
    .brdg_dbi_xfer_pending          (brdg_dbi_xfer_pending),
    .cfg_msi_ctrl_en                (cfg_msi_ctrl_en),
    .cfg_msi_ctrl_addr              (cfg_msi_ctrl_addr),
    .msi_int_rcvd                   (msi_int_rcvd),
    .msi_int_data                   (msi_int_data),
    .current_data_rate              (pm_current_data_rate),
    .radm_bypass_tlp_abort          (radm_bypass_tlp_abort[0]),
    .radm_bypass_dllp_abort         (radm_bypass_dllp_abort[0]),
    .radm_bypass_data               (radm_bypass_data_i),
    .radm_bypass_dv                 (radm_bypass_dv[0]),
    .radm_bypass_hv                 (radm_bypass_hv[0]),
    .radm_bypass_dwen               (radm_bypass_dwen),
    .radm_bypass_eot                (radm_bypass_eot[0]),
    .radm_bypass_fmt                (radm_bypass_fmt[1:0]),
    .radm_bypass_type               (radm_bypass_type[4:0]),
    .radm_bypass_tc                 (radm_bypass_tc[2:0]),
    .radm_bypass_attr               (radm_bypass_attr[ATTR_WD-1:0]),
    .radm_bypass_reqid              (radm_bypass_reqid[15:0]),
    .radm_bypass_td                 (radm_bypass_td[0]),
    .radm_bypass_tag                (radm_bypass_tag[TAG_SIZE-1:0]),
    .radm_bypass_cpl_status         (radm_bypass_cpl_status[2:0]),
    .radm_bypass_poisoned           (radm_bypass_poisoned[0]),
    .radm_bypass_dw_len             (radm_bypass_dw_len[9:0]),
    .radm_bypass_addr               (radm_bypass_addr_i[`FLT_Q_ADDR_WIDTH-1:0]),
    .radm_bypass_cpl_last           (radm_bypass_cpl_last[0]),
    .radm_bypass_ecrc_err           (radm_bypass_ecrc_err[0]),
    .radm_bypass_func_num           (radm_bypass_func_num[PF_WD-1:0]),
    .radm_bypass_bcm                (radm_bypass_bcm[0]),
    .radm_bypass_byte_cnt           (radm_bypass_byte_cnt_i[11:0]),
    .radm_bypass_first_be           (radm_bypass_first_be[3:0]),
    .radm_bypass_last_be            (radm_bypass_last_be[3:0]),
    .radm_bypass_in_membar_range    (radm_bypass_in_membar_range[2:0]),
    .radm_bypass_io_req_in_range    (radm_bypass_io_req_in_range[0]),
    .radm_bypass_rom_in_range       (radm_bypass_rom_in_range[0]),
    .radm_bypass_cmpltr_id          (radm_bypass_cmpltr_id[15:0]),

    .radm_cpl_timeout               (radm_cpl_timeout),
    .radm_timeout_cpl_tc            (radm_timeout_cpl_tc),
    .radm_timeout_cpl_attr          (radm_timeout_cpl_attr),
    .radm_timeout_cpl_tag           (radm_timeout_cpl_tag),
    .radm_timeout_func_num          (radm_timeout_func_num),

    .radm_trgt1_hdr_uppr_bytes      ({{64-ADDR_WIDTH{1'b0}},radm_trgt1_hdr_uppr_bytes}),
    .radm_grant_tlp_type            (radm_grant_tlp_type_i),
    .radm_pend_cpl_so               (radm_pend_cpl_so),
    .radm_trgt1_vc_num              (radm_trgt1_vc_num_i),
    .radm_trgt1_hdr_uppr_bytes_valid (radm_trgt1_hdr_uppr_bytes_valid),
    .radm_trgt1_data                (radm_trgt1_data_i),
    .radm_trgt1_dwen                (radm_trgt1_dwen),
    .radm_trgt1_dv                  (int_radm_trgt1_dv),
    .radm_trgt1_hv                  (int_radm_trgt1_hv),
    .radm_trgt1_eot                 (int_radm_trgt1_eot),
    .radm_trgt1_dllp_abort          (radm_trgt1_dllp_abort),
    .radm_trgt1_tlp_abort           (radm_trgt1_tlp_abort),

    .radm_trgt1_fmt                 (radm_trgt1_fmt),
    .radm_trgt1_type                (radm_trgt1_type),
    .radm_trgt1_tc                  (radm_trgt1_tc),
    .radm_trgt1_attr                (radm_trgt1_attr),
    .radm_trgt1_mem_type            (int_radm_trgt1_mem_type),
    .radm_trgt1_reqid               (radm_trgt1_reqid),
    .radm_trgt1_tag                 (radm_trgt1_tag),
    .radm_trgt1_lookup_id           (trgt_lookup_id_i),
    .radm_trgt1_func_num            (radm_trgt1_func_num),
    .radm_trgt1_td                  (radm_trgt1_td),
    .radm_trgt1_poisoned            (radm_trgt1_poisoned),
    .radm_trgt1_dw_len              (radm_trgt1_dw_len),
    .radm_trgt1_first_be            (radm_trgt1_first_be),
    .radm_trgt1_cpl_status          (radm_trgt1_cpl_status),
    .radm_trgt1_cmpltr_id           (radm_trgt1_cmpltr_id),
    .radm_trgt1_cpl_last            (radm_trgt1_cpl_last),
    .trgt1_radm_pkt_halt            (trgt1_radm_pkt_halt),

    .radm_trgt1_addr                (radm_trgt1_addr_i),

    .radm_trgt1_rom_in_range        (radm_trgt1_rom_in_range),
    .radm_trgt1_io_req_in_range     (radm_trgt1_io_req_in_range),
    .radm_trgt1_in_membar_range     (radm_trgt1_in_membar_range),
    .radm_trgt1_last_be             (radm_trgt1_last_be),
    .trgt1_radm_halt                (int_trgt1_radm_halt),
    .brdg_trgt1_p_xfer_done         (brdg_trgt1_p_xfer_done),
    .client0_addr_align_en          (client0_addr_align_en),
    .client0_tlp_func_num           (client0_tlp_func_num),
    .client0_cpl_cmpltr_id          (client0_remote_req_id),
    .client0_cpl_status             (client0_cpl_status),
    .client0_cpl_bcm                (client0_cpl_bcm),
    .client0_cpl_byte_cnt           (client0_cpl_byte_cnt),
    .client0_tlp_dv                 (client0_tlp_dv),
    .client0_tlp_eot                (client0_tlp_eot),
    .client0_tlp_bad_eot            (client0_tlp_bad_eot),
    .client0_tlp_hv                 (client0_tlp_hv),
    .client0_tlp_fmt                (client0_tlp_fmt),
    .client0_tlp_type               (client0_tlp_type),
    .client0_tlp_td                 (client0_tlp_td),
    .client0_tlp_ep                 (client0_tlp_ep),
    .client0_tlp_tid                (client0_tlp_tid),
    .client0_tlp_attr               (client0_tlp_attr),
    .client0_tlp_atu_bypass         (client0_tlp_atu_bypass),
    .client0_tlp_byte_len           (client0_tlp_byte_len),
    .client0_tlp_byte_en            (client0_tlp_byte_en),
    .client0_tlp_tc                 (client0_tlp_tc),
    .client0_tlp_addr               (client0_tlp_addr[63:0]),
    .client0_tlp_data               (client0_tlp_data),
    .client0_tlp_dma                (client0_tlp_dma),
    .client0_tlp_dma_channel        (client0_tlp_dma_channel),
    .xadm_client0_halt              (xadm_client0_halt),
    .client0_cpl_lookup_id          (client0_cpl_lookup_id),
    .client1_addr_align_en          (client1_addr_align_en),
    .client1_tlp_func_num           (client1_tlp_func_num),
    .client1_cpl_cmpltr_id          (client1_remote_req_id),
    .client1_cpl_status             (client1_cpl_status),
    .client1_cpl_bcm                (client1_cpl_bcm),
    .client1_cpl_byte_cnt           (client1_cpl_byte_cnt),
    .client1_tlp_dv                 (client1_tlp_dv),
    .client1_tlp_eot                (client1_tlp_eot),
    .client1_tlp_bad_eot            (client1_tlp_bad_eot),
    .client1_tlp_hv                 (client1_tlp_hv),
    .client1_tlp_fmt                (client1_tlp_fmt),
    .client1_tlp_type               (client1_tlp_type),
    .client1_tlp_td                 (client1_tlp_td),
    .client1_tlp_ep                 (client1_tlp_ep),
    .client1_tlp_tid                (client1_tlp_tid),
    .client1_tlp_attr               (client1_tlp_attr),
    .client1_tlp_atu_bypass         (client1_tlp_atu_bypass),
    .client1_tlp_byte_len           (client1_tlp_byte_len),
    .client1_tlp_byte_en            (client1_tlp_byte_en),
    .client1_tlp_tc                 (client1_tlp_tc),
    .client1_tlp_addr               (client1_tlp_addr[63:0]),
    .client1_tlp_data               (client1_tlp_data),
    .client1_tlp_dma                (client1_tlp_dma),
    .client1_tlp_dma_channel        (client1_tlp_dma_channel),
    .xadm_client1_halt              (xadm_client1_halt),
    .client1_cpl_lookup_id          (client1_cpl_lookup_id),
    // Client2 interface
    .client2_cpl_lookup_id          (client2_cpl_lookup_id),
    .client2_addr_align_en          (client2_addr_align_en),
    .client2_tlp_byte_en            (client2_tlp_byte_en),
    .client2_remote_req_id          (client2_remote_req_id),
    .client2_cpl_status             (client2_cpl_status),
    .client2_cpl_bcm                (client2_cpl_bcm),
    .client2_cpl_byte_cnt           (client2_cpl_byte_cnt),
    .client2_tlp_dv                 (client2_tlp_dv),
    .client2_tlp_eot                (client2_tlp_eot),
    .client2_tlp_bad_eot            (client2_tlp_bad_eot),
    .client2_tlp_hv                 (client2_tlp_hv),
    .client2_tlp_fmt                (client2_tlp_fmt),
    .client2_tlp_type               (client2_tlp_type),
    .client2_tlp_tc                 (client2_tlp_tc),
    .client2_tlp_td                 (client2_tlp_td),
    .client2_tlp_ep                 (client2_tlp_ep),
    .client2_tlp_attr               (client2_tlp_attr),
    .client2_tlp_byte_len           (client2_tlp_byte_len),
    .client2_tlp_tid                (client2_tlp_tid),
    .client2_tlp_addr               (client2_tlp_addr[63:0]),
    .client2_tlp_data               (client2_tlp_data),
    .client2_tlp_func_num           (client2_tlp_func_num),
    .client2_tlp_atu_bypass         (client2_tlp_atu_bypass),
    .xadm_client2_halt              (xadm_client2_halt),
    // DBI interface
    .dbi_addr                       (slv_dbi_addr),
    .dbi_din                        (slv_dbi_din),
    .dbi_cs                         (slv_dbi_cs),
    .dbi_cs2                        (slv_dbi_cs2),
    .dbi_wr                         (slv_dbi_wr),
    .dbi_func_num                   (slv_dbi_func_num),
    .dbi_ack                        (slv_lbc_dbi_ack),
    .dbi_dout                       (slv_lbc_dbi_dout),
  // External RAM Interfaces
  // Inbound
  // Inbound Read Request Order RAM
    .ib_rreq_ordr_ram_addra         (ib_rreq_ordr_ram_addra ),
    .ib_rreq_ordr_ram_wea           (ib_rreq_ordr_ram_wea   ),
    .ib_rreq_ordr_ram_dina          (ib_rreq_ordr_ram_dina  ),
    .ib_rreq_ordr_ram_addrb         (ib_rreq_ordr_ram_addrb ),
    .ib_rreq_ordr_ram_enb           (ib_rreq_ordr_ram_enb   ),
    .ib_rreq_ordr_ram_doutb         (ib_rreq_ordr_ram_doutb ),
    // Inbound Read Request Clock Domain Crossing FIFO RAM
    .ib_rreq_c2a_cdc_ram_addra      (ib_rreq_c2a_cdc_ram_addra),
    .ib_rreq_c2a_cdc_ram_wea        (ib_rreq_c2a_cdc_ram_wea),
    .ib_rreq_c2a_cdc_ram_dina       (ib_rreq_c2a_cdc_ram_dina),
    .ib_rreq_c2a_cdc_ram_addrb      (ib_rreq_c2a_cdc_ram_addrb),
    .ib_rreq_c2a_cdc_ram_enb        (ib_rreq_c2a_cdc_ram_enb),
    .ib_rreq_c2a_cdc_ram_doutb      (ib_rreq_c2a_cdc_ram_doutb),
    // Inbound Write Request Clock Domain Crossing FIFO RAM
    .ib_wreq_c2a_cdc_ram_addra      (ib_wreq_c2a_cdc_ram_addra),
    .ib_wreq_c2a_cdc_ram_wea        (ib_wreq_c2a_cdc_ram_wea),
    .ib_wreq_c2a_cdc_ram_dina       (ib_wreq_c2a_cdc_ram_dina),
    .ib_wreq_c2a_cdc_ram_addrb      (ib_wreq_c2a_cdc_ram_addrb),
    .ib_wreq_c2a_cdc_ram_enb        (ib_wreq_c2a_cdc_ram_enb),
    .ib_wreq_c2a_cdc_ram_doutb      (ib_wreq_c2a_cdc_ram_doutb),
    // Inbound Master Completion Clock Domain Crossing FIFO RAM
    .ib_mcpl_a2c_cdc_ram_addra      (ib_mcpl_a2c_cdc_ram_addra),
    .ib_mcpl_a2c_cdc_ram_wea        (ib_mcpl_a2c_cdc_ram_wea),
    .ib_mcpl_a2c_cdc_ram_dina       (ib_mcpl_a2c_cdc_ram_dina),
    .ib_mcpl_a2c_cdc_ram_addrb      (ib_mcpl_a2c_cdc_ram_addrb),
    .ib_mcpl_a2c_cdc_ram_enb        (ib_mcpl_a2c_cdc_ram_enb),
    .ib_mcpl_a2c_cdc_ram_doutb      (ib_mcpl_a2c_cdc_ram_doutb),
    // // Inbound Master Completion Data Segment FIFO RAM
    .ib_mcpl_sb_ram_addra           (ib_mcpl_sb_ram_addra),
    .ib_mcpl_sb_ram_wea             (ib_mcpl_sb_ram_wea),
    .ib_mcpl_sb_ram_dina            (ib_mcpl_sb_ram_dina),
    .ib_mcpl_sb_ram_addrb           (ib_mcpl_sb_ram_addrb),
    .ib_mcpl_sb_ram_enb             (ib_mcpl_sb_ram_enb),
    .ib_mcpl_sb_ram_doutb           (ib_mcpl_sb_ram_doutb),
   // Outbound
   // Slave Non-Posted Write Set-Aside RAM // To do : change names
  .slv_npw_sab_ram_addra            (slv_npw_sab_ram_addra),
  .slv_npw_sab_ram_wea              (slv_npw_sab_ram_wea),
  .slv_npw_sab_ram_dina             (slv_npw_sab_ram_dina),
  .slv_npw_sab_ram_addrb            (slv_npw_sab_ram_addrb),
  .slv_npw_sab_ram_enb              (slv_npw_sab_ram_enb),
  .slv_npw_sab_ram_doutb            (slv_npw_sab_ram_doutb),
  // Slave Wrap Response Re-order Buffer
  // Outbound Non-Posted TLP Decomposer Header/Data FIFO RAM
  .ob_npdcmp_ram_addra              (ob_npdcmp_ram_addra),
  .ob_npdcmp_ram_wea                (ob_npdcmp_ram_wea),
  .ob_npdcmp_ram_dina               (ob_npdcmp_ram_dina),
  .ob_npdcmp_ram_addrb              (ob_npdcmp_ram_addrb),
  .ob_npdcmp_ram_enb                (ob_npdcmp_ram_enb),
  .ob_npdcmp_ram_doutb              (ob_npdcmp_ram_doutb),
  // Outbound Posted TLP Decomposer Header FIFO RAM
  .ob_pdcmp_hdr_ram_addra           (ob_pdcmp_hdr_ram_addra),
  .ob_pdcmp_hdr_ram_wea             (ob_pdcmp_hdr_ram_wea),
  .ob_pdcmp_hdr_ram_dina            (ob_pdcmp_hdr_ram_dina),
  .ob_pdcmp_hdr_ram_addrb           (ob_pdcmp_hdr_ram_addrb),
  .ob_pdcmp_hdr_ram_enb             (ob_pdcmp_hdr_ram_enb),
  .ob_pdcmp_hdr_ram_doutb           (ob_pdcmp_hdr_ram_doutb),
  // Outbound Posted TLP Decomposer Data FIFO RAM
  .ob_pdcmp_data_ram_addra          (ob_pdcmp_data_ram_addra),
  .ob_pdcmp_data_ram_wea            (ob_pdcmp_data_ram_wea),
  .ob_pdcmp_data_ram_dina           (ob_pdcmp_data_ram_dina),
  .ob_pdcmp_data_ram_addrb          (ob_pdcmp_data_ram_addrb),
  .ob_pdcmp_data_ram_enb            (ob_pdcmp_data_ram_enb),
  .ob_pdcmp_data_ram_doutb          (ob_pdcmp_data_ram_doutb),
  // Outbound Composer Segmented Buffer RAM
  .ob_ccmp_data_ram_addra          (ob_ccmp_data_ram_addra),
  .ob_ccmp_data_ram_wea            (ob_ccmp_data_ram_wea),
  .ob_ccmp_data_ram_dina           (ob_ccmp_data_ram_dina),
  .ob_ccmp_data_ram_addrb          (ob_ccmp_data_ram_addrb),
  .ob_ccmp_data_ram_enb            (ob_ccmp_data_ram_enb),
  .ob_ccmp_data_ram_doutb          (ob_ccmp_data_ram_doutb),
  // Outbound Completion CDC FIFO RAM
  .ob_cpl_c2a_cdc_ram_addra        (ob_cpl_c2a_cdc_ram_addra),
  .ob_cpl_c2a_cdc_ram_wea          (ob_cpl_c2a_cdc_ram_wea),
  .ob_cpl_c2a_cdc_ram_dina         (ob_cpl_c2a_cdc_ram_dina),
  .ob_cpl_c2a_cdc_ram_addrb        (ob_cpl_c2a_cdc_ram_addrb),
  .ob_cpl_c2a_cdc_ram_enb          (ob_cpl_c2a_cdc_ram_enb),
  .ob_cpl_c2a_cdc_ram_doutb        (ob_cpl_c2a_cdc_ram_doutb),
    //DMA Ram interface outputs
    .edma2ram_addra                 (edma2ram_addra),
    .edma2ram_we                    (edma2ram_we),
    .edma2ram_dout                  (edma2ram_dout),
    .edma2ram_addrb                 (edma2ram_addrb),
    .edma2ram_re                    (edma2ram_re),
    .ram2edma_din                   (ram2edma_din),
    //DMA read buffer interface
    .edmarbuff2ram_addra            (edmarbuff2ram_addra),
    .edmarbuff2ram_we               (edmarbuff2ram_we),
    .edmarbuff2ram_dout             (edmarbuff2ram_dout),
    .edmarbuff2ram_addrb            (edmarbuff2ram_addrb),
    .edmarbuff2ram_re               (edmarbuff2ram_re),
    .ram2edmarbuff_din              (ram2edmarbuff_din),
    .phy_type                       (pm_phy_type),
    //eDMA interface signals
    //crgb inputs
    .crgb_address                   (crgb_address),
    .crgb_rden                      (crgb_rden),
    .crgb_source                    (crgb_source),
    .crgb_wr_data                   (crgb_wr_data),
    .crgb_wren                      (crgb_wren),
    //crgb outputs
    .crgb_ack                       (crgb_ack),
    .crgb_rd_data                   (crgb_rd_data),
     //DMA Local Interrupt
    .edma_int                      (edma_int),
     // DMA Read/Write Channel transfer pending
    .edma_xfer_pending             (edma_xfer_pending),
    .radm_trgt1_cpl_lookup_id_rlsd  (radm_trgt1_cpl_lookup_id_rlsd),
    // Indicates non-posted TLP
    .radm_trgt1_lookup_id_consmd    (radm_trgt1_lookup_id_consmd),
    .cfg_slv_resp_err_map           (cfg_err_resp[15:10]),
    .cfg_ax_mstr_np_pass_p          (cfg_ax_mstr_np_pass_p),
    .cfg_ax_mstr_ordr_p_event_sel   (cfg_ax_mstr_ordr_p_event_sel),
    .cfg_ax_ib_cpl_pass_p           (cfg_ax_ib_cpl_pass_p),
    .cfg_ax_snp_en                  (cfg_ax_snp_en),
    .cfg_ob_rd_split_burst_en       (cfg_ob_rd_split_burst_en),
    .cfg_mstr_arcache_mode          (cfg_mstr_arcache_mode),
    .cfg_mstr_awcache_mode          (cfg_mstr_awcache_mode),
    .cfg_mstr_arcache_value         (cfg_mstr_arcache_value),
    .cfg_mstr_awcache_value         (cfg_mstr_awcache_value),
    .cfg_aximstr_msg_addr_high      (cfg_aximstr_msg_addr_high),
    .cfg_aximstr_msg_addr_low       (cfg_aximstr_msg_addr_low),
    .atu_reg_out_upr_base           (atu_reg_out_upr_base),
    .atu_reg_out_en                 (atu_reg_out_en),
    .atu_reg_out_type               (atu_reg_out_type),
    .atu_reg_out_base               (atu_reg_out_base),
    .atu_reg_out_limit              (atu_reg_out_limit),
    .atu_reg_out_invert             (atu_reg_out_invert),
    .atu_reg_out_func_num           (atu_reg_out_func_num),
    .atu_reg_out_func_bypass        (atu_reg_out_func_bypass),
    .atu_reg_out_snp                (atu_reg_out_snp),
    .cfg_err_resp_mode              (cfg_err_resp[4:0]),
    .cfg_max_rd_req_size            (cfg_max_rd_req_size),
    .cfg_max_payload_size           (cfg_max_payload_size)
); // amba bridge instance




DWC_pcie_edma_cdm_crgb

#(
    .INST (INST),
    .ADDR_WIDTH(CRGB_ADDR_WIDTH),
    .DATA_WIDTH(CRGB_DATA_WIDTH),
    .BE_WIDTH(CRGB_BE_WIDTH)
)
 u_DWC_pcie_edma_cdm_crgb (

     .clk                            (aux_clk_g),
    .reset_n                         (core_rst_n),
    //CRGB _ INTERFACE
    .crgb_addr                      (crgb_address),
    .crgb_re                        (crgb_rden),
    .crgb_we                        (crgb_wren),
    .crgb_dout                      (crgb_wr_data),
    .crgb_din                       (crgb_rd_data),

    .crgb_byte_en                   (/*NOT USED*/),
    .crgb_source                    (crgb_source),
    .crgb_ready                     (crgb_ack),

    //CRGB _ INTERFACE
    .cdm_cs                          (crgb_cdm_cs),
    .cdm_ack                         (crgb_cdm_ack),
    .cdm_addr                        (crgb_cdm_addr),
    .cdm_datain                      (crgb_cdm_wdata),
    .cdm_dataout                     (crgb_cdm_rdata),

    .cdm_wr                          (crgb_cdm_wr),
    .cdm_source                      (crgb_cdm_source)

 ); //DWC_pcie_edma_cdm_crgb




xadm

#(
    .INST (INST)
    ,
    .ATU_OUT_REGIONS (ATU_OUT_REGIONS),
    .ATU_BASE_WD (ATU_BASE_WD),
    .ATU_REG_WD (ATU_REG_WD)
) u_xadm (
    // ------ Inputs ------
    .core_clk                       (core_clk),
    .core_rst_n                     (core_rst_n),
    .rstctl_core_flush_req          (rstctl_core_flush_req),
    .cfg_max_payload_size           (cfg_highest_max_payload),
    .cfg_vc_enable                  (cfg_vc_enable),
    .cfg_vc_struc_vc_id_map         (cfg_vc_struc_vc_id_map),
    .cfg_tc_vc_map                  (cfg_tc_vc_map),
    .cfg_tc_struc_vc_map            (cfg_tc_struc_vc_map),
    .cfg_lpvc_wrr_weight            (cfg_lpvc_wrr_weight),
    .cfg_lpvc_wrr_phase             (cfg_lpvc_wrr_phase),
    .cfg_lpvc                       (cfg_lpvc),
    .cfg_ecrc_gen_en                (cfg_ecrc_gen_en),
    .cfg_trgt_cpl_lut_delete_entry  (cfg_trgt_cpl_lut_delete_entry),
//`ifdef CX_CPL_TO_RANGES_ENABLE
//    .cfg_cpl_timeout_range          (cfg_cpl_timeout_range),
//`endif
//    .cfg_cpl_timeout_disable        (cfg_cpl_timeout_disable),
    .xtlh_xadm_halt                 (xtlh_xadm_halt),
    .pm_bus_num                     (cfg_pbus_num),
    .pm_dev_num                     (cfg_pbus_dev_num),

    .xtranslated_addr_in_d          (xtranslated_addr_in_d),
    .xtranslated_type_in_d          (xtranslated_type_in_d),
    .xtranslated_func_in_d          (xtranslated_func_in_d),
    .xtranslate_enable              (xtranslate_enable),
    .x_addr_out                     (x_addr_out           ),
    .x_type_out                     (                     ),
    .x_fmt_out                      (x_fmt_out           ),
    .x_rid_out                      (x_rid_out),
    .x_dma_out                      (x_dma_out),
    .x_tag_out                      (x_tag_out),
    .x_atu_bypass_out               (x_atu_bypass_out),
    .xtranslated_inhibit_pyld_in    (xtranslated_inhibit_pyld_in),
    .xtranslated_inhibit_pyld_in_d  (xtranslated_inhibit_pyld_in_d),
    .xtranslated_tc_in_d            (xtranslated_tc_in_d),
    .xtranslated_td_in_d            (xtranslated_td_in_d),
    .xtranslated_attr_in_d          (xtranslated_attr_in_d),
    .xtranslated_tag_in_d           (xtranslated_tag_in_d),
    .xtranslated_msg_code_in_d      (xtranslated_msg_code_in_d),
    .app_flr_pf_done                (app_flr_pf_done),
    .xadm_flr_pf_done               (xadm_flr_pf_done),
    .client0_addr_align_en          (client0_addr_align_en_i),
    .client0_tlp_byte_en            (client0_tlp_byte_en_i),
    .client0_cpl_req_id             (client0_remote_req_id_i),
    .client0_cpl_status             (client0_cpl_status_i),
    .client0_cpl_bcm                (client0_cpl_bcm_i),
    .client0_cpl_byte_cnt           (client0_cpl_byte_cnt_i),
    .client0_req_id                 (client0_req_id_i),
    .client0_tlp_dv                 (client0_tlp_dv_i),
    .client0_tlp_hv                 (client0_tlp_hv_i),
    .client0_tlp_eot                (client0_tlp_eot_i),
    .client0_tlp_data               (client0_tlp_data_i),
    .client0_tlp_bad_eot            (client0_tlp_bad_eot_i),
    .client0_tlp_fmt                (client0_tlp_fmt_i),
    .client0_tlp_type               (client0_tlp_type_i),
    .client0_tlp_tc                 (client0_tlp_tc_i),
    .client0_tlp_td                 (client0_tlp_td_i),
    .client0_tlp_ep                 (client0_tlp_ep_i),
    .client0_tlp_attr               (client0_tlp_attr_i),
    .client0_tlp_byte_len           (client0_tlp_byte_len_i),
    .client0_tlp_tid                (client0_tlp_tid_i),
    .client0_tlp_addr               (client0_tlp_addr_i[63:0]),
// `ifdef CX_RASDP_EN
//     .client0_hdr_prot               (client0_hdr_prot_i),
// `endif // CX_RASDP_EN
    .client0_tlp_dma                (client0_tlp_dma_i),
    .client0_tlp_dma_channel        (client0_tlp_dma_channel_i),

     .client0_tlp_atu_bypass        (client0_tlp_atu_bypass_i),
    .client1_addr_align_en          (client1_addr_align_en_i),
    .client1_tlp_byte_en            (client1_tlp_byte_en_i),
    .client1_cpl_req_id             (client1_remote_req_id_i),
    .client1_cpl_status             (client1_cpl_status_i),
    .client1_cpl_bcm                (client1_cpl_bcm_i),
    .client1_cpl_byte_cnt           (client1_cpl_byte_cnt_i),
    .client1_req_id                 (client1_req_id_i),
    .client1_tlp_dv                 (client1_tlp_dv_i),
    .client1_tlp_hv                 (client1_tlp_hv_i),
    .client1_tlp_eot                (client1_tlp_eot_i),
    .client1_tlp_bad_eot            (client1_tlp_bad_eot_i),
    .client1_tlp_data               (client1_tlp_data_i),
    .client1_tlp_fmt                (client1_tlp_fmt_i),
    .client1_tlp_type               (client1_tlp_type_i),
    .client1_tlp_tc                 (client1_tlp_tc_i),
    .client1_tlp_td                 (client1_tlp_td_i),
    .client1_tlp_ep                 (client1_tlp_ep_i),
    .client1_tlp_attr               (client1_tlp_attr_i),
    .client1_tlp_byte_len           (client1_tlp_byte_len_i),
    .client1_tlp_tid                (client1_tlp_tid_i),
    .client1_tlp_addr               (client1_tlp_addr_i[63:0]),
// `ifdef CX_RASDP_EN
//     .client1_hdr_prot               (client1_hdr_prot_i),
// `endif // CX_RASDP_EN
    .client1_tlp_dma                (client1_tlp_dma_i),
    .client1_tlp_dma_channel        (client1_tlp_dma_channel_i),
     .client1_tlp_atu_bypass        (client1_tlp_atu_bypass_i),
    .client2_addr_align_en          (client2_addr_align_en_i),
    .client2_tlp_byte_en            (client2_tlp_byte_en_i),
    .client2_cpl_req_id             (client2_remote_req_id_i),
    .client2_cpl_status             (client2_cpl_status_i),
    .client2_cpl_bcm                (client2_cpl_bcm_i),
    .client2_cpl_byte_cnt           (client2_cpl_byte_cnt_i),
    .client2_req_id                 (client2_req_id_i),
    .client2_tlp_dv                 (client2_tlp_dv_i),
    .client2_tlp_hv                 (client2_tlp_hv_i),
    .client2_tlp_eot                (client2_tlp_eot_i),
    .client2_tlp_data               (client2_tlp_data_i),
    .client2_tlp_bad_eot            (client2_tlp_bad_eot_i),
    .client2_tlp_fmt                (client2_tlp_fmt_i),
    .client2_tlp_type               (client2_tlp_type_i),
    .client2_tlp_tc                 (client2_tlp_tc_i),
    .client2_tlp_td                 (client2_tlp_td_i),
    .client2_tlp_ep                 (client2_tlp_ep_i),
    .client2_tlp_attr               (client2_tlp_attr_i),
    .client2_tlp_byte_len           (client2_tlp_byte_len_i),
    .client2_tlp_tid                (client2_tlp_tid_i),
    .client2_tlp_addr               (client2_tlp_addr_i[63:0]),
//`ifdef CX_RASDP_EN
//    .client2_hdr_prot               (client2_hdr_prot_i),
//`endif // CX_RASDP_EN
    .client2_tlp_dma                (client2_tlp_dma_i),
    .client2_tlp_dma_channel        (client2_tlp_dma_channel_i),
     .client2_tlp_atu_bypass        (client2_tlp_atu_bypass_i),

    .lbc_cpl_hv                     (lbc_cpl_hv),
    .lbc_cpl_dv                     (lbc_cpl_dv),
    .lbc_cpl_data                   (lbc_cpl_data),
    .lbc_cpl_hdr                    (lbc_cpl_hdr),
    .lbc_cpl_eot                    (lbc_cpl_eot),
    //DE: Deadlock fix
    .lbc_deadlock_det               (lbc_deadlock_det),


    .msg_gen_hv                     (msg_gen_hv),
    .msg_gen_dv                     (msg_gen_dv),
    .msg_gen_eot                    (msg_gen_eot),
    .msg_gen_data                   (msg_gen_data),
    .msg_gen_hdr                    (msg_gen_hdr),

    .rdlh_link_down                 (rdlh_link_down),
    .rtlh_rfc_upd                   (rtlh_rfc_upd),
    .rtlh_rfc_data                  (rtlh_rfc_data),
    .rtlh_fc_init_status            (rtlh_fc_init_status),
    .pm_xtlh_block_tlp              (pm_xtlh_block_tlp),
    .pm_block_all_tlp               (pm_block_all_tlp),
    //.pm_l1_aspm_entr               (pm_l1_aspm_entr),
    .xtlh_xadm_restore_enable       (xtlh_xadm_restore_enable),
    .xtlh_xadm_restore_capture      (xtlh_xadm_restore_capture),
    .xtlh_xadm_restore_tc           (xtlh_xadm_restore_tc),
    .xtlh_xadm_restore_type         (xtlh_xadm_restore_type),
    .xtlh_xadm_restore_word_len     (xtlh_xadm_restore_word_len),

    .trgt1_radm_halt                (trgt1_radm_halt_i),
    .radm_trgt1_hv                  (radm_trgt1_hv_i),
    .radm_trgt1_eot                 (radm_trgt1_eot_i),
    .radm_trgt1_ecrc_err            (radm_trgt1_ecrc_err_i),
    .radm_trgt1_tlp_abort           (radm_trgt1_tlp_abort_i),
    .radm_trgt1_dllp_abort          (radm_trgt1_dllp_abort_i),
    .radm_trgt1_fmt                 (radm_trgt1_fmt_i),
    .radm_trgt1_type                (radm_trgt1_type_i),
    .radm_trgt1_tc                  (radm_trgt1_tc_i),
    .radm_trgt1_attr                (radm_trgt1_attr_i),
    .radm_trgt1_reqid               (radm_trgt1_reqid_i),
    .radm_trgt1_tag                 (radm_trgt1_tag_i),
    .radm_trgt1_dw_len              (radm_trgt1_dw_len_i),
    .radm_trgt1_first_be            (radm_trgt1_first_be_i),
    .radm_trgt1_last_be             (radm_trgt1_last_be_i),
    .radm_trgt1_addr                (radm_trgt1_addr_out_i[6:0]),
    .radm_trgt1_func_num            (radm_trgt1_func_num_i),
    .client0_cpl_lookup_id          (client0_cpl_lookup_id_i),
    .client1_cpl_lookup_id          (client1_cpl_lookup_id_i),
     .client2_cpl_lookup_id         (client2_cpl_lookup_id_i),
    .trgt_cpl_timeout               (trgt_cpl_timeout),
    .trgt_timeout_cpl_func_num      (trgt_timeout_cpl_func_num),
    .trgt_timeout_cpl_tc            (trgt_timeout_cpl_tc),
    .trgt_timeout_cpl_attr          (trgt_timeout_cpl_attr),
    .trgt_timeout_cpl_len           (trgt_timeout_cpl_len),
    .trgt_timeout_lookup_id         (trgt_timeout_lookup_id),
    .trgt_lookup_id                 (trgt_lookup_id_i),
    .trgt_lookup_empty              (trgt_lookup_empty),
    .trgt_cpl_lut_empty             (trgt_cpl_lut_empty),
        .current_data_rate          (pm_current_data_rate),
    .phy_type                       (pm_phy_type),
    .atu_reg_out_upr_base           (atu_reg_out_upr_base),
    .atu_reg_out_en                 (atu_reg_out_en),
    .atu_reg_out_type               (atu_reg_out_type),
    .atu_reg_out_inhibit_payload    (atu_reg_out_inhibit_payload),
    .atu_reg_out_tc                 (atu_reg_out_tc),
    .atu_reg_out_base               (atu_reg_out_base),
    .atu_reg_out_limit              (atu_reg_out_limit),
    .atu_reg_out_invert             (atu_reg_out_invert),
    // ------ Outputs ------
    .xadm_client0_halt              (xadm_client0_halt_i),
    .xadm_client1_halt              (xadm_client1_halt_i),
    .xadm_client2_halt              (xadm_client2_halt_i),
     // Indicates the received completion is the last one
    .radm_trgt1_cpl_lookup_id_rlsd  (radm_trgt1_cpl_lookup_id_rlsd),
     // Indicates non-posted TLP
    .radm_trgt1_lookup_id_consmd    (radm_trgt1_lookup_id_consmd),

    .xadm_msg_halt                  (xadm_msg_halt),
    .xadm_cpl_halt                  (xadm_cpl_halt),
    .xadm_xtlh_bad_eot              (xadm_xtlh_bad_eot),
    .xadm_xtlh_add_ecrc             (xadm_xtlh_add_ecrc),
    .xadm_xtlh_hv                   (xadm_xtlh_hv),
    .xadm_xtlh_soh          (xadm_xtlh_soh),
    .xadm_xtlh_hdr                  (xadm_xtlh_hdr),
    .xadm_xtlh_dwen                 (xadm_xtlh_dwen),
    .xadm_xtlh_dv                   (xadm_xtlh_dv),
    .xadm_xtlh_data                 (xadm_xtlh_data),
    .xadm_xtlh_vc                   (xadm_xtlh_vc),
    .xadm_xtlh_eot                  (xadm_xtlh_eot),
     .cfg_remote_max_bridge_tag    (int_cfg_remote_max_bridge_tag),
    .xadm_notlp_pending             (xadm_notlp_pending),
    .xadm_no_fc_credit              (xadm_no_fc_credit),
    .xadm_had_enough_credit         (xadm_had_enough_credit),
    .xadm_parerr_detected           (xadm_parerr_detected),
    .xadm_all_type_infinite         (xadm_all_type_infinite),
    .xadm_ph_cdts                   (xadm_ph_cdts),
    .xadm_pd_cdts                   (xadm_pd_cdts),
    .xadm_nph_cdts                  (xadm_nph_cdts),
    .xadm_npd_cdts                  (xadm_npd_cdts),
    .xadm_cplh_cdts                 (xadm_cplh_cdts),
    .xadm_cpld_cdts                 (xadm_cpld_cdts)
    ,
    .xadm_idle                      (xadm_idle)
);   // u_xadm

wire radm_clk_g;
wire radm_idle;
wire en_radm_clk_g;

assign en_radm_clk_g = cfg_clock_gating_ctrl ? !radm_idle : 1'b1;

//
// RADM module for DM application
//
radm_dm

#(INST) u_radm_dm (
    // ------- Inputs --------
    .core_clk                       (radm_clk_g),
    .core_rst_n                     (core_rst_n),
    .rstctl_core_flush_req          (rstctl_core_flush_req),
    .upstream_port                  (upstream_port),
    .app_req_retry_en               (app_req_retry_en),
    .cfg_rcb_128                    (cfg_rcb[0]),
    .cfg_pbus_dev_num               (cfg_pbus_dev_num),
    .cfg_pbus_num                   (cfg_pbus_num),
    .cfg_ecrc_chk_en                (cfg_ecrc_chk_en),
    .cfg_max_func_num               (cfg_max_func_num),
    .cfg_radm_q_mode                (cfg_radm_q_mode),
    .cfg_radm_order_rule            (cfg_radm_order_rule),
    .cfg_order_rule_ctrl            (cfg_order_rule_ctrl),
    .cfg_radm_strict_vc_prior       (cfg_radm_strict_vc_prior),
    .cfg_hq_depths                  (cfg_hq_depths),
    .cfg_dq_depths                  (cfg_dq_depths),
    .rtranslated_addr_in_d          (rtranslated_addr_in_d),
    .rtranslated_err_in_d           (rtranslated_err_in_d),
    .r_addr_out                     (r_addr_out           ),
    .r_func_out                     (r_func_out           ),
    .r_type_out                     (r_type_out           ),
    .r_bar_out                      (r_bar_out            ),
    .r_rombar_out                   (r_rombar_out         ),
    .r_tc_out                       (r_tc_out),
    .r_td_out                       (r_td_out),
    .r_attr_out                     (r_attr_out),
    .r_msgcode_out                  (r_msgcode_out),
    .flr_pf_rst_n                   (flr_pf_rst_n),
    .radm_flr_pf_done               (radm_flr_pf_done),
    .app_flr_pf_done                (app_flr_pf_done),
    .device_type                    (device_type_reg),
    .pm_radm_block_tlp              (pm_radm_block_tlp),
    .pm_freeze_cpl_timer            (pm_freeze_cpl_timer),
    .rtlh_radm_dv                   (rtlh_radm_dv),
    .rtlh_radm_hv                   (rtlh_radm_hv),
    .rtlh_radm_data                 (rtlh_radm_data),
    .rtlh_radm_hdr                  (rtlh_radm_hdr),
    .rtlh_radm_dwen                 (rtlh_radm_dwen),
    .rtlh_radm_eot                  (rtlh_radm_eot),
    .rtlh_radm_dllp_err             (rtlh_radm_dllp_err),
    .rtlh_radm_ecrc_err             (rtlh_radm_ecrc_err),
    .rtlh_radm_malform_tlp_err      (rtlh_radm_malform_tlp_err),
    .rtlh_radm_ant_addr             (rtlh_radm_ant_addr),
    .rtlh_radm_ant_rid              (rtlh_radm_ant_rid),

    .trgt0_radm_halt                (trgt0_radm_halt),
      .trgt1_radm_pkt_halt          (trgt1_radm_pkt_halt),
      .trgt1_radm_halt              (trgt1_radm_halt_i),
      .trgt1_p_xfer_done            (brdg_trgt1_p_xfer_done),
      .trgt1_np_xfer_done           (radm_trgt1_cpl_lookup_id_rlsd),

    // from xtlh for keeping track of completions and handling of
    // completions
    .xtlh_xmt_tlp_done              (xtlh_xmt_tlp_done),
    .xtlh_xmt_tlp_req_id            (xtlh_xmt_tlp_req_id),
    .xtlh_xmt_tlp_tag               (xtlh_xmt_tlp_tag),
    .xtlh_xmt_tlp_attr              (xtlh_xmt_tlp_attr),
    .xtlh_xmt_tlp_tc                (xtlh_xmt_tlp_tc),
    .xtlh_xmt_tlp_len_inbytes       (xtlh_xmt_tlp_len_inbytes),
    .xtlh_xmt_tlp_first_be          (xtlh_xmt_tlp_first_be),
    .xtlh_xmt_cfg_req               (xtlh_xmt_cfg_req),
    .xtlh_xmt_memrd_req             (xtlh_xmt_memrd_req),

    .cfg_bar_is_io                  (cfg_bar_is_io),
    .cfg_io_match                   (cfg_io_match),
    .cfg_bar_match                  (cfg_bar_match),
    .cfg_rom_match                  (cfg_rom_match),
    .cfg_tc_struc_vc_map            (cfg_tc_struc_vc_map),
    .cfg_config_above_match         (cfg_config_above_match),
    .cfg_prefmem_match              (cfg_prefmem_match),
    .cfg_mem_match                  (cfg_mem_match),
    .cfg_filter_rule_mask           (cfg_filter_rule_mask),
    .cfg_cpl_timeout_range          (cfg_cpl_timeout_range),
    .cfg_cpl_timeout_disable        (cfg_cpl_timeout_disable),

    .current_data_rate              (pm_current_data_rate),
    .phy_type                       (pm_phy_type),

    .target_mem_map                 (target_mem_map),
    .target_rom_map                 (target_rom_map),
    .pm_cpl_timer                   (pm_cpl_timer),


    .default_target                 (default_target),
    .ur_ca_mask_4_trgt1             (ur_ca_mask_4_trgt1),
    .radm_trgt1_hdr_uppr_bytes_valid_i (radm_trgt1_hdr_uppr_bytes_valid_atu),
    .translated_tlp_hdr_fmt         (translated_tlp_hdr_fmt),
    .atu_trgt1_addr                 (atu_trgt1_addr[ADDR_WIDTH-1:0]),

    // ---------------------- Outputs -----------------------------------
    .radm_idle                      (radm_idle),
    .flt_cdm_addr                   (flt_cdm_addr),

    .radm_rtlh_ph_ca                (radm_rtlh_ph_ca),
    .radm_rtlh_pd_ca                (radm_rtlh_pd_ca),
    .radm_rtlh_nph_ca               (radm_rtlh_nph_ca),
    .radm_rtlh_npd_ca               (radm_rtlh_npd_ca),
    .radm_rtlh_cplh_ca              (radm_rtlh_cplh_ca),
    .radm_rtlh_cpld_ca              (radm_rtlh_cpld_ca),
    .radm_qoverflow                 (radm_qoverflow),


    .radm_bypass_ecrc_err           (radm_bypass_ecrc_err_i),
    .radm_bypass_tlp_abort          (radm_bypass_tlp_abort_i),
    .radm_bypass_dllp_abort         (radm_bypass_dllp_abort_i),
    .radm_bypass_data               (radm_bypass_data_i),
    .radm_bypass_dv                 (radm_bypass_dv_i),
    .radm_bypass_hv                 (radm_bypass_hv_i),
    .radm_bypass_dwen               (radm_bypass_dwen_i),
    .radm_bypass_eot                (radm_bypass_eot_i),
    .radm_bypass_fmt                (radm_bypass_fmt_i),
    .radm_bypass_type               (radm_bypass_type_i),
    .radm_bypass_tc                 (radm_bypass_tc_i),
    .radm_bypass_attr               (radm_bypass_attr_i),
    .radm_bypass_reqid              (radm_bypass_reqid_i),
    .radm_bypass_tag                (radm_bypass_tag_i),
    .radm_bypass_func_num           (radm_bypass_func_num_i),
    .radm_bypass_cpl_status         (radm_bypass_cpl_status_i),
    .radm_bypass_td                 (radm_bypass_td_i),
    .radm_bypass_poisoned           (radm_bypass_poisoned_i),
    .radm_bypass_dw_len             (radm_bypass_dw_len_i),
    .radm_bypass_first_be           (radm_bypass_first_be_i),
    .radm_bypass_addr               (radm_bypass_addr_i),
    .radm_bypass_in_membar_range    (radm_bypass_in_membar_range_i),
    .radm_bypass_io_req_in_range    (radm_bypass_io_req_in_range_i),
    .radm_bypass_rom_in_range       (radm_bypass_rom_in_range_i),
    .radm_bypass_last_be            (radm_bypass_last_be_i),
    .radm_bypass_cpl_last           (radm_bypass_cpl_last_i),
    .radm_bypass_bcm                (radm_bypass_bcm_i),
    .radm_bypass_byte_cnt           (radm_bypass_byte_cnt_i),
    .radm_bypass_cmpltr_id          (radm_bypass_cmpltr_id_i),
    .radm_grant_tlp_type            (radm_grant_tlp_type_i),
    .radm_pend_cpl_so               (radm_pend_cpl_so),
    .radm_q_cpl_not_empty           (radm_q_cpl_not_empty),
    .radm_cpl_lut_valid             (radm_cpl_lut_valid_i),
    .radm_cpl_timeout               (radm_cpl_timeout_i),
    .radm_cpl_timeout_cdm           (radm_cpl_timeout_cdm_i),
    .radm_timeout_cpl_tc            (radm_timeout_cpl_tc_i),
    .radm_timeout_cpl_attr          (radm_timeout_cpl_attr_i),
    .radm_timeout_cpl_len           (radm_timeout_cpl_len_i),
    .radm_timeout_cpl_tag           (radm_timeout_cpl_tag_i),
    .radm_timeout_func_num          (radm_timeout_func_num_i),


    .radm_trgt0_dv                  (radm_trgt0_dv),
    .radm_trgt0_hv                  (radm_trgt0_hv),
    .radm_trgt0_hdr                 (radm_trgt0_hdr),
    .radm_trgt0_data                (radm_trgt0_data),
    .radm_trgt0_dwen                (radm_trgt0_dwen),
    .radm_trgt0_eot                 (radm_trgt0_eot),
    .radm_trgt0_abort               (radm_trgt0_abort),
    .radm_trgt0_ecrc_err            (),

    .radm_slot_pwr_limit            (radm_slot_pwr_limit),
    .radm_slot_pwr_payload          (radm_slot_pwr_payload),
    .radm_msg_payload               (radm_msg_payload),
    .radm_vendor_msg                (radm_vendor_msg),
    .radm_msg_unlock                (radm_msg_unlock),

    // all messages that core recived related to RC application
    .radm_inta_asserted             (int_radm_inta_asserted),
    .radm_intb_asserted             (int_radm_intb_asserted),
    .radm_intc_asserted             (int_radm_intc_asserted),
    .radm_intd_asserted             (int_radm_intd_asserted),
    .radm_inta_deasserted           (radm_inta_deasserted),
    .radm_intb_deasserted           (radm_intb_deasserted),
    .radm_intc_deasserted           (radm_intc_deasserted),
    .radm_intd_deasserted           (radm_intd_deasserted),
    .radm_correctable_err           (int_radm_correctable_err),
    .radm_nonfatal_err              (int_radm_nonfatal_err),
    .radm_fatal_err                 (int_radm_fatal_err),

    .radm_pm_pme                    (int_radm_pm_pme),
    .radm_pm_to_ack                 (int_radm_pm_to_ack),
    .radm_pm_turnoff                (radm_pm_turnoff),
    .radm_pm_asnak                  (radm_pm_asnak),
    .radm_msg_req_id                (radm_msg_req_id),
    .radm_unexp_cpl_err             (radm_unexp_cpl_err),
    .radm_rcvd_cpl_ur               (radm_rcvd_cpl_ur),
    .radm_rcvd_cpl_ca               (radm_rcvd_cpl_ca),
    .radm_q_not_empty               (radm_q_not_empty),
    .radm_cpl_pending               (radm_cpl_pending),

    .radm_trgt1_dv                  (radm_trgt1_dv_i),
    .radm_trgt1_hv                  (radm_trgt1_hv_i),
    .radm_trgt1_eot                 (radm_trgt1_eot_i),
    .radm_trgt1_hdr                 (radm_trgt1_hdr_i),
    .radm_trgt1_data                (radm_trgt1_data_i),
    .radm_trgt1_dwen                (radm_trgt1_dwen_i),
    .radm_trgt1_ecrc_err            (radm_trgt1_ecrc_err_i),
    .radm_trgt1_tlp_abort           (radm_trgt1_tlp_abort_i),
    .radm_trgt1_dllp_abort          (radm_trgt1_dllp_abort_i),
    .radm_trgt1_fmt                 (radm_trgt1_fmt_i),
    .radm_trgt1_type                (radm_trgt1_type_i),
    .radm_trgt1_tc                  (radm_trgt1_tc_i),
    .radm_trgt1_attr                (radm_trgt1_attr_i),
    .radm_trgt1_reqid               (radm_trgt1_reqid_i),
    .radm_trgt1_tag                 (radm_trgt1_tag_i),
    .radm_trgt1_func_num            (radm_trgt1_func_num_i),
    .radm_trgt1_cpl_status          (radm_trgt1_cpl_status_i),
    .radm_trgt1_td                  (radm_trgt1_td_i),
    .radm_trgt1_poisoned            (radm_trgt1_poisoned_i),
    .radm_trgt1_dw_len              (radm_trgt1_dw_len_i),
    .radm_trgt1_first_be            (radm_trgt1_first_be_i),
    .radm_trgt1_addr                (radm_trgt1_addr_out_i),
    .radm_trgt1_hdr_uppr_bytes      (radm_trgt1_hdr_uppr_bytes_i),
    .radm_trgt1_io_req_in_range     (radm_trgt1_io_req_in_range_i),
    .radm_trgt1_in_membar_range     (radm_trgt1_in_membar_range_i),
    .radm_trgt1_rom_in_range        (radm_trgt1_rom_in_range_i),
    .radm_trgt1_last_be             (radm_trgt1_last_be_i),
    .radm_trgt1_msgcode             (radm_trgt1_msgcode),
    .radm_trgt1_cpl_last            (radm_trgt1_cpl_last_i),
    .radm_trgt1_bcm                 (radm_trgt1_bcm_i),
    .radm_trgt1_byte_cnt            (radm_trgt1_byte_cnt_i),
    .radm_trgt1_cmpltr_id           (radm_trgt1_cmpltr_id_i),
    .radm_trgt1_vc_num              (radm_trgt1_vc_num_i),
    .radm_xfer_pending              (radm_xfer_pending),
    .radm_q_pending                 (radm_q_pending),
    .radm_trgt1_hdr_uppr_bytes_valid (radm_trgt1_hdr_uppr_bytes_valid_i),
    .radm_outq_pkt_hdr              (radm_outq_pkt_hdr),
    .radm_outq_halt_in              (radm_outq_halt_in),
    .radm_xlate_fmt                 (radm_xlate_fmt),
    .radm_hdr_log_valid             (radm_hdr_log_valid),
    .radm_hdr_log                   (radm_hdr_log),
    .radm_ecrc_err                  (radm_ecrc_err),
    .radm_mlf_tlp_err               (radm_mlf_tlp_err),
    .radm_rcvd_wreq_poisoned        (radm_rcvd_wreq_poisoned),
    .radm_rcvd_cpl_poisoned         (radm_rcvd_cpl_poisoned),
    .radm_rcvd_req_ur               (radm_rcvd_req_ur),
    .radm_rcvd_req_ca               (radm_rcvd_req_ca),
    .cdm_err_advisory               (cdm_err_advisory),

    .p_hdrq_addra                   (p_hdrq_addra),
    .p_hdrq_addrb                   (p_hdrq_addrb),
    .p_hdrq_datain                  (p_hdrq_datain),
    .p_hdrq_dataout                 (p_hdrq_dataout),
    .p_hdrq_ena                     (p_hdrq_ena),
    .p_hdrq_enb                     (p_hdrq_enb),
    .p_hdrq_wea                     (p_hdrq_wea),
    .p_hdrq_parerr                  (p_hdrq_parerr),
    .p_hdrq_par_chk_val             (p_hdrq_par_chk_val),
    .p_hdrq_parerr_out              (p_hdrq_parerr_out_int),
    .p_dataq_addra                  (p_dataq_addra),
    .p_dataq_addrb                  (p_dataq_addrb),
    .p_dataq_datain                 (p_dataq_datain),
    .p_dataq_dataout                (p_dataq_dataout),
    .p_dataq_ena                    (p_dataq_ena),
    .p_dataq_enb                    (p_dataq_enb),
    .p_dataq_wea                    (p_dataq_wea),
    .p_dataq_parerr                 (p_dataq_parerr),
    .p_dataq_par_chk_val            (p_dataq_par_chk_val),
    .p_dataq_parerr_out             (p_dataq_parerr_out_int),




    .radm_snoop_upd                 (radm_snoop_upd),
    .radm_snoop_bus_num             (radm_snoop_bus_num),
    .radm_snoop_dev_num             (radm_snoop_dev_num),


    .cfg_remote_rd_req_bridge_size  (int_cfg_remote_rd_req_bridge_size),

    .radm_parerr                    (radm_parerr),
    .radm_trgt0_pending             (radm_trgt0_pending)

   ,.pm_cpl_timer_decr              (pm_cpl_timer_decr),
    .pm_cpl_timeout_value           (pm_cpl_timeout_value)
);




// START_IO:DBI Signal Descriptions.
wire    [31:0]                      int_dbi_addr;
wire    [31:0]                      int_dbi_din;
wire                                int_dbi_cs;
wire                                int_dbi_cs2;
wire    [3:0]                       int_dbi_wr;
wire                                int_lbc_dbi_ack;
wire    [31:0]                      int_lbc_dbi_dout;

wire    [PF_WD-1:0]              int_dbi_func_num;                   // Function number of the DBI access


assign int_dbi_addr        = slv_dbi_addr;
assign int_dbi_din         = slv_dbi_din;
assign int_dbi_cs          = slv_dbi_cs;
assign int_dbi_cs2         = slv_dbi_cs2;
assign int_dbi_wr          = slv_dbi_wr;
assign int_dbi_func_num = slv_dbi_func_num;
assign slv_lbc_dbi_ack     = int_lbc_dbi_ack;
assign slv_lbc_dbi_dout    = int_lbc_dbi_dout;

//
// CDM Module (default configuration is TYPE 0 header type)
//



//
// Any changes made to u_cdm MUST also be made to u_cdm_b
//

cdm

#(
  .INST(INST)
  ,
  .CRGB_DATA_WIDTH(CRGB_DATA_WIDTH),
  .CRGB_ADDR_WIDTH(CRGB_ADDR_WIDTH),
  .CRGB_BE_WIDTH(CRGB_BE_WIDTH)

      ,
  .ATU_OUT_REGIONS (ATU_OUT_REGIONS),
  .ATU_IN_REGIONS (ATU_IN_REGIONS),
  .ATU_BASE_WD (ATU_BASE_WD),
  .ATU_REG_WD (ATU_REG_WD)
  ) u_cdm (
    // ------------- inputs --------------
    .core_clk                       (aux_clk_g),
    .non_sticky_rst_n               (non_sticky_rst_n),
    .sticky_rst_n                   (sticky_rst_n),
    .device_type                    (int_device_type),
    .phy_type                       (pm_phy_type),

    .lbc_cdm_addr                   (lbc_cdm_addr),
    .lbc_cdm_data                   (lbc_cdm_data),
    .lbc_cdm_cs                     (lbc_cdm_cs),
    .lbc_cdm_wr                     (lbc_cdm_wr),
    .lbc_cdm_dbi2                   (lbc_cdm_dbi2),
    .lbc_cdm_unroll                 (lbc_cdm_unroll),
    .lbc_cdm_dbi                    (lbc_cdm_dbi),
    .lbc_xmt_cpl_ca                 (lbc_xmt_cpl_ca),
    .sys_int                        (sys_int),                      // not applicable to RC
    .sys_aux_pwr_det                (pm_sys_aux_pwr_det),
    .sys_pre_det_chged              (sys_pre_det_chged),
    .sys_atten_button_pressed       (sys_atten_button_pressed),
    .sys_pwr_fault_det              (sys_pwr_fault_det),
    .sys_mrl_sensor_chged           (sys_mrl_sensor_chged),
    .sys_cmd_cpled_int              (sys_cmd_cpled_int),
    .sys_pre_det_state              (sys_pre_det_state),
    .sys_mrl_sensor_state           (sys_mrl_sensor_state),
    .sys_eml_interlock_engaged      (sys_eml_interlock_engaged),

    .phy_cfg_status                 (phy_cfg_status),
    .cxpl_debug_info                (cxpl_debug_info),
    .smlh_autoneg_link_width        (smlh_autoneg_link_width),
    .smlh_autoneg_link_sp           (smlh_autoneg_link_sp),
    .smlh_link_training_in_prog     (smlh_link_training_in_prog),
    .rmlh_rcvd_err                  (rmlh_rcvd_err),
    .xtlh_xmt_cpl_ca                (xtlh_xmt_cpl_ca),
    .xtlh_xmt_cpl_ur                (xtlh_xmt_cpl_ur),
    .xtlh_xmt_wreq_poisoned         (xtlh_xmt_wreq_poisoned),
    .xtlh_xmt_cpl_poisoned          (xtlh_xmt_cpl_poisoned),

    .radm_rcvd_wreq_poisoned        (radm_rcvd_wreq_poisoned),
    .radm_rcvd_cpl_poisoned         (radm_rcvd_cpl_poisoned),
    .radm_mlf_tlp_err               (radm_mlf_tlp_err),
    .radm_ecrc_err                  (radm_ecrc_err),
    .cdm_err_advisory               (cdm_err_advisory),
    .radm_hdr_log_valid             (radm_hdr_log_valid),
    .radm_hdr_log                   (radm_hdr_log),
    .radm_rcvd_req_ur               (radm_rcvd_req_ur),
    .radm_rcvd_req_ca               (radm_rcvd_req_ca),


    .rtlh_fc_prot_err               (rtlh_fc_prot_err),
    .rtlh_overfl_err                (rtlh_overfl_err_nf),
    .rtlh_fc_init_status            (rtlh_fc_init_status),

    .xal_xmt_cpl_ca                 ({NF{1'b0}}),
    .xal_rcvd_cpl_ca                ({NF{1'b0}}),
    .xal_rcvd_cpl_ur                ({NF{1'b0}}),
    .xal_perr                       ({NF{1'b0}}),
    .xal_serr                       ({NF{1'b0}}),
    .xal_set_trgt_abort_primary     ({NF{1'b0}}),
    .xal_set_mstr_abort_primary     ({NF{1'b0}}),
    .xal_pci_addr_perr              ({NF{1'b0}}),
    .rdlh_prot_err                  (rdlh_prot_err),
    .rdlh_bad_tlp_err               (rdlh_bad_tlp_err),
    .rdlh_bad_dllp_err              (rdlh_bad_dllp_err),
    .rdlh_link_up                   (rdlh_link_up),
    .xdlh_replay_num_rlover_err     (xdlh_replay_num_rlover_err),
    .xdlh_replay_timeout_err        (xdlh_replay_timeout_err),
    .smlh_link_up                   (smlh_link_up),
    .smlh_bw_mgt_status             (smlh_bw_mgt_status),
    .smlh_link_auto_bw_status       (smlh_link_auto_bw_status),
    .current_data_rate              (pm_current_data_rate),
    .smlh_clr_enter_compliance      (smlh_clr_enter_compliance),
    .smlh_tx_margin_rst             (smlh_tx_margin_rst),
    .smlh_core_rst_n_release_pulse  (smlh_core_rst_n_release_pulse),
    .smlh_dir_spd_chg_rising_edge   (smlh_dir_spd_chg_rising_edge),
    .mac_phy_txdeemph               (mac_phy_txdeemph_bus[0]),
    .smlh_dir_linkw_chg_rising_edge (smlh_dir_linkw_chg_rising_edge),
    .cfg_pwr_budget_data_reg        (cfg_pwr_budget_data_reg),
    .cfg_pwr_budget_func_num        (cfg_pwr_budget_func_num),

    .radm_cpl_pending               (radm_cpl_pending),
    .radm_rcvd_cpl_ca               (radm_rcvd_cpl_ca),
    .radm_rcvd_cpl_ur               (radm_rcvd_cpl_ur),
    .radm_cpl_timeout               (radm_cpl_timeout_cdm_i),
    .radm_timeout_func_num           (radm_timeout_func_num_i),
    .radm_unexp_cpl_err             (radm_unexp_cpl_err),
    .radm_set_slot_pwr_limit        ({NF{radm_slot_pwr_limit}}),
    .radm_slot_pwr_payload          (radm_slot_pwr_payload),

    .radm_msg_req_id                (radm_msg_req_id),
    .radm_pm_pme                    (cdm_radm_pm_pme),            // Only for RC

    .radm_correctable_err           (cdm_radm_correctable_err),   // Only for RC or SW
    .radm_nonfatal_err              (cdm_radm_nonfatal_err),      // Only for RC or SW
    .radm_fatal_err                 (cdm_radm_fatal_err),         // Only for RC or SW
    .xtlh_xadm_ph_cdts              (xadm_ph_cdts[7:0]),
    .xtlh_xadm_nph_cdts             (xadm_nph_cdts[7:0]),
    .xtlh_xadm_cplh_cdts            (xadm_cplh_cdts[7:0]),
    .xtlh_xadm_pd_cdts              (xadm_pd_cdts[11:0]),
    .xtlh_xadm_npd_cdts             (xadm_npd_cdts[11:0]),
    .xtlh_xadm_cpld_cdts            (xadm_cpld_cdts[11:0]),

    .radm_qoverflow                 (|radm_qoverflow),
    .radm_q_not_empty               (radm_q_not_empty[0]),
    .xdlh_retrybuf_not_empty        (xdlh_retrybuf_not_empty),
    .rtlh_crd_not_rtn               (rtlh_crd_not_rtn[0]),

    // aux power reserved signals
    .pm_status                      (pm_status),
    .pm_pme_en                      (pm_pme_en_split),
    .aux_pm_en                      (pm_aux_pm_en_split),
    .flt_cdm_addr                   (flt_cdm_addr),
    .pm_radm_block_tlp              (pm_radm_block_tlp),
    .msi_int_rcvd                   (msi_int_rcvd),
    .msi_int_data                   (msi_int_data),

    .app_flr_pf_done                (app_flr_pf_done),
    .radm_flr_pf_done               (radm_flr_pf_done),

    .xadm_flr_pf_done               (xadm_flr_pf_done),

    .pm_rcvd_as_req_l1              (pm_rcvd_as_req_l1),
    .pm_rcvd_pm_enter_l1            (pm_rcvd_pm_enter_l1),
    .xdlh_retry_req                 (xdlh_retry_req),

    .smlh_in_l0                     (smlh_in_l0),


    .radm_snoop_upd                 (radm_snoop_upd),
    .radm_snoop_bus_num             (radm_snoop_bus_num),
    .radm_snoop_dev_num             (radm_snoop_dev_num),


    .app_clk_pm_en                  (app_clk_pm_en),
    // -------------------------------- outputs -------------------------------------------------
    //
    .cfg_upd_aspm_ctrl              (cfg_upd_aspm_ctrl),
    .cfg_upd_aslk_pmctrl            (cfg_upd_aslk_pmctrl),
    .cfg_upd_pme_cap                (cfg_upd_pme_cap),
    .cfg_mem_match                  (cfg_mem_match),
    .cfg_prefmem_match              (cfg_prefmem_match),
    .cfg_config_above_match         (cfg_config_above_match),
    .cfg_io_match                   (cfg_io_match),
    .cfg_bar_match                  (cfg_bar_match),
    .cfg_bar_is_io                  (cfg_bar_is_io),
    .cfg_rom_match                  (cfg_rom_match),
    .cfg_l1sub_control              (cfg_l1sub_control),
    .cfg_l1sub_en                   (cfg_l1sub_en),
    .cfg_pl_l1sub_control           (cfg_pl_l1sub_control),
    .cfg_pl_l1_exit_mode            (cfg_pl_l1_exit_mode),
    .cfg_pl_l1_nowait_p1            (cfg_pl_l1_nowait_p1),
    .cfg_pl_l1_clk_sel              (cfg_pl_l1_clk_sel),
    .cfg_pl_aux_clk_freq            (cfg_pl_aux_clk_freq),
    .cfg_filter_rule_mask           (cfg_filter_rule_mask),

    .cdm_lbc_data                   (cdm_lbc_data),
    .cdm_lbc_ack                    (cdm_lbc_ack),

    .cfg_pbus_num                   (cfg_pbus_num),
    .cfg_pbus_dev_num               (cfg_pbus_dev_num),
    .cfg_2ndbus_num                 (cfg_2ndbus_num),
    .cfg_subbus_num                 (cfg_subbus_num),
    .cfg_aslk_pmctrl                (cfg_aslk_pmctrl),
    .cfg_clk_pm_en                  (cfg_clk_pm_en),

    .cfg_relax_ord_en               (cfg_relax_order_en),
    .cfg_no_snoop_en                (cfg_no_snoop_en),

    .cfg_ext_tag_en                 (cfg_ext_tag_en),
    .cfg_phantom_fun_en             (),
    .cfg_aux_pm_en                  (cfg_aux_pm_en),
    .cfg_max_rd_req_size            (cfg_max_rd_req_size),
    .cfg_bridge_crs_en              (),
    .cfg_rcb                        (cfg_rcb),
    .cfg_comm_clk_config            (cfg_comm_clk_config),
    .cfg_hw_autowidth_dis           (cfg_hw_autowidth_dis),
    .cfg_max_payload_size           (cfg_max_payload_size),
    .cfg_highest_max_payload        (cfg_highest_max_payload),
    .cfg_ack_freq                   (cfg_ack_freq),
    .cfg_ack_latency_timer          (cfg_ack_latency_timer),
    .cfg_replay_timer_value         (cfg_replay_timer_value),
    .cfg_fc_latency_value           (cfg_fc_latency_value),
    .cfg_other_msg_payload          (cfg_other_msg_payload),
    .cfg_other_msg_request          (cfg_other_msg_request),
    .cfg_corrupt_crc_pattern        (cfg_corrupt_crc_pattern),
    .cfg_scramble_dis               (cfg_scramble_dis),
    .cfg_n_fts                      (cfg_n_fts),
    .cfg_link_dis                   (cfg_link_dis),
    .cfg_link_retrain               (cfg_link_retrain),
    .cfg_lpbk_en                    (cfg_lpbk_en),
    .cfg_pipe_loopback              (cfg_pipe_loopback),
    .cfg_rxstatus_lane              (cfg_rxstatus_lane),
    .cfg_rxstatus_value             (cfg_rxstatus_value),
    .cfg_lpbk_rxvalid               (cfg_lpbk_rxvalid),
    .cfg_plreg_reset                (cfg_plreg_reset),
    .cfg_link_num                   (cfg_link_num),
    .cfg_forced_link_state          (cfg_forced_link_state),
    .cfg_forced_ltssm_cmd           (cfg_forced_ltssm_cmd),

    .cfg_force_en                   (cfg_force_en),
    .cfg_lane_skew                  (cfg_lane_skew),
    .cfg_deskew_disable             (cfg_deskew_disable),
    .cfg_imp_num_lanes              (cfg_imp_num_lanes),
    .cfg_elastic_buffer_mode        (cfg_elastic_buffer_mode),
    .cfg_flow_control_disable       (cfg_flow_control_disable),
    .cfg_acknack_disable            (cfg_acknack_disable),
    .cfg_link_capable               (cfg_link_capable),
    .cfg_eidle_timer                (),
    .cfg_skip_interval              (cfg_skip_interval),
    .cfg_link_rate                  (),
    .cfg_fast_link_mode             (int_cfg_fast_link_mode),
    .cfg_fast_link_scaling_factor   (cfg_fast_link_scaling_factor),
    .cfg_l0s_supported              (cfg_l0s_supported),
    .cfg_dll_lnk_en                 (cfg_dll_lnk_en),
    .cfg_soft_rst_n                 (),
    .cfg_2nd_reset                  (cfg_2nd_reset),
    .cfg_ecrc_gen_en                (cfg_ecrc_gen_en),
    .cfg_ecrc_chk_en                (cfg_ecrc_chk_en),
    .cfg_bar0_start                 (cfg_bar0_start),
    .cfg_bar0_limit                 (cfg_bar0_limit),
    .cfg_bar0_mask                  (cfg_bar0_mask),
    .cfg_bar1_start                 (cfg_bar1_start),
    .cfg_bar1_limit                 (cfg_bar1_limit),
    .cfg_bar1_mask                  (cfg_bar1_mask),
    .cfg_bar2_start                 (cfg_bar2_start),
    .cfg_bar2_limit                 (cfg_bar2_limit),
    .cfg_bar2_mask                  (cfg_bar2_mask),
    .cfg_bar3_start                 (cfg_bar3_start),
    .cfg_bar3_limit                 (cfg_bar3_limit),
    .cfg_bar3_mask                  (cfg_bar3_mask),
    .cfg_bar4_start                 (cfg_bar4_start),
    .cfg_bar4_limit                 (cfg_bar4_limit),
    .cfg_bar4_mask                  (cfg_bar4_mask),
    .cfg_bar5_start                 (cfg_bar5_start),
    .cfg_bar5_limit                 (cfg_bar5_limit),
    .cfg_bar5_mask                  (cfg_bar5_mask),
    .cfg_rom_mask                   (cfg_rom_mask),
    .cfg_mem_base                   (),
    .cfg_mem_limit                  (),
    .cfg_pref_mem_base              (),
    .cfg_pref_mem_limit             (),
    .cfg_exp_rom_start              (cfg_exp_rom_start),
    .cfg_exp_rom_limit              (cfg_exp_rom_limit),
    .cfg_io_limit_upper16           (cfg_io_limit_upper16),
    .cfg_io_base_upper16            (cfg_io_base_upper16),
    .cfg_io_base                    (cfg_io_base),
    .cfg_io_limit                   (cfg_io_limit),
    .cfg_hdr_type                   (),
    .cfg_ext_synch                  (cfg_ext_synch),
    .cfg_io_space_en                (cfg_io_space_en),
    .cfg_mem_space_en               (cfg_mem_space_en),
    .cfg_phy_control                (cfg_phy_control),
    .upstream_port                  (upstream_port),
    .switch_device                  (),
    .end_device                     (end_device),
    .rc_device                      (rc_device),
    .bridge_device                  (bridge_device),
    .cfg_upd_req_id                 (cfg_upd_req_id),
    .cfg_upd_pmcsr                  (cfg_upd_pmcsr),
    .cfg_upd_aux_pm_en              (cfg_upd_aux_pm_en),
    .cfg_pmstatus_clr               (cfg_pmstatus_clr),
    .cfg_pmstate                    (cfg_pmstate),
    .cfg_pme_en                     (cfg_pme_en),
    .cfg_pm_no_soft_rst             (cfg_pm_no_soft_rst),
    .cfg_bus_master_en              (cfg_bus_master_en),
    .cfg_ob_rd_split_burst_en       (cfg_ob_rd_split_burst_en),
    .cfg_msi_ctrl_en                (cfg_msi_ctrl_en),
    .cfg_msi_ctrl_addr              (cfg_msi_ctrl_addr),
    .msi_ctrl_io                    (msi_ctrl_io),
    .msi_ctrl_int                   (msi_ctrl_int),
    .msi_ctrl_int_vec               (msi_ctrl_int_vec),
    .cfg_err_resp                   (cfg_err_resp),
    .cfg_auto_flush_en              (cfg_auto_flush_en),
    .cfg_auto_flush_timeout         (cfg_auto_flush_timeout),
    .cfg_link_timeout_en_n          (cfg_link_timeout_en_n),
    .cfg_link_timeout_period        (cfg_link_timeout_period),
    .cfg_ax_mstr_np_pass_p          (cfg_ax_mstr_np_pass_p),
    .cfg_ax_mstr_ordr_p_event_sel   (cfg_ax_mstr_ordr_p_event_sel),
    .cfg_ax_ib_cpl_pass_p           (cfg_ax_ib_cpl_pass_p),
    .cfg_ax_snp_en                  (cfg_ax_snp_en),
    .cfg_mstr_arcache_mode          (cfg_mstr_arcache_mode),
    .cfg_mstr_awcache_mode          (cfg_mstr_awcache_mode),
    .cfg_mstr_arcache_value         (cfg_mstr_arcache_value),
    .cfg_mstr_awcache_value         (cfg_mstr_awcache_value),
    .cfg_aximstr_msg_addr_high      (cfg_aximstr_msg_addr_high),
    .cfg_aximstr_msg_addr_low       (cfg_aximstr_msg_addr_low),
    .cfg_memtype_value              (cfg_memtype_value),
    .cfg_memtype_boundary           (cfg_memtype_boundary),
// ATU outbound Region controls
    .atu_reg_out_type               (atu_reg_out_type),
    .atu_reg_out_tc                 (atu_reg_out_tc),
    .atu_reg_out_td                 (atu_reg_out_td),
    .atu_reg_out_attr               (atu_reg_out_attr),
    .atu_reg_out_func_num           (atu_reg_out_func_num),
    .atu_reg_out_func_bypass        (atu_reg_out_func_bypass),
    .atu_reg_out_snp                (atu_reg_out_snp),
    .atu_reg_out_dma_bypass         (atu_reg_out_dma_bypass),
    .atu_reg_out_inhibit_payload    (atu_reg_out_inhibit_payload),
    .atu_reg_out_hdr_substitute_en  (atu_reg_out_hdr_substitute_en),
    .atu_reg_out_tag_substitute_en  (atu_reg_out_tag_substitute_en),
    .atu_reg_out_tag                (atu_reg_out_tag),
    .atu_reg_out_msg_code           (atu_reg_out_msg_code),

// Mode Settings
    .atu_reg_out_shift              (atu_reg_out_shift),
    .atu_reg_out_invert             (atu_reg_out_invert),
// Region Enable
    .atu_reg_out_en                 (atu_reg_out_en),
// Base, Limit and Target Registers
    .atu_reg_out_base               (atu_reg_out_base),
    .atu_reg_out_upr_base           (atu_reg_out_upr_base),
    .atu_reg_out_limit              (atu_reg_out_limit),
    .atu_reg_out_lwr_trgt           (atu_reg_out_lwr_trgt),
    .atu_reg_out_upr_trgt           (atu_reg_out_upr_trgt),
    .atu_reg_out_lwr_trgt_lwr       (atu_reg_out_lwr_trgt_lwr),
    .atu_reg_out_incr_rgn_size      (atu_reg_out_incr_rgn_size),

// ATU inbound Region controls
    .atu_reg_in_type                (atu_reg_in_type),
    .atu_reg_in_tc                  (atu_reg_in_tc),
    .atu_reg_in_td                  (atu_reg_in_td),
    .atu_reg_in_attr                (atu_reg_in_attr),
    .atu_reg_in_func_num            (atu_reg_in_func_num),
    .atu_reg_in_msg_code            (atu_reg_in_msg_code),
    .atu_reg_in_bar_num             (atu_reg_in_bar_num),
// Inbound field match enables
    .atu_reg_in_tc_match_en         (atu_reg_in_tc_match_en),
    .atu_reg_in_td_match_en         (atu_reg_in_td_match_en),
    .atu_reg_in_attr_match_en       (atu_reg_in_attr_match_en),
    .atu_reg_in_func_match_en       (atu_reg_in_func_match_en),
    .atu_reg_in_msgcode_match_en    (atu_reg_in_msgcode_match_en),
    .atu_reg_in_single_addr_loc_en  (atu_reg_in_single_addr_loc_en),
    .atu_reg_in_msg_type_match_mode  (atu_reg_in_msg_type_match_mode),
// Response and mode settings
    .atu_reg_in_rsp_code            (atu_reg_in_rsp_code),
    .atu_reg_in_fuzzy               (atu_reg_in_fuzzy),
    .atu_reg_in_shift               (atu_reg_in_shift),
    .atu_reg_in_invert              (atu_reg_in_invert),
    .atu_reg_in_bar_match           (atu_reg_in_bar_match),
// Region Enable
    .atu_reg_in_en                  (atu_reg_in_en),
// Base, Limit and Target Registers
    .atu_reg_in_base                (atu_reg_in_base),
    .atu_reg_in_upr_base            (atu_reg_in_upr_base),
    .atu_reg_in_limit               (atu_reg_in_limit),
    .atu_reg_in_lwr_trgt            (atu_reg_in_lwr_trgt),
    .atu_reg_in_upr_trgt            (atu_reg_in_upr_trgt),
    .atu_reg_in_incr_rgn_size       (atu_reg_in_incr_rgn_size),
    .cfg_reg_serren                 (),
    .cfg_pme_cap                    (cfg_pme_cap),
    .cfg_l0s_entr_latency_timer     (cfg_l0s_entr_latency_timer),
    .cfg_l1_entr_latency_timer      (cfg_l1_entr_latency_timer),
    .cfg_l1_entr_wo_rl0s            (cfg_l1_entr_wo_rl0s),
    .cfg_isa_enable                 (),
    .cfg_vga_enable                 (),
    .cfg_vga16_decode               (),
    .cfg_send_cor_err               (cfg_send_cor_err),
    .cfg_send_nf_err                (cfg_send_nf_err),
    .cfg_send_f_err                 (cfg_send_f_err),
    .cfg_func_spec_err              (cfg_func_spec_err),
    .cfg_sys_err_rc                 (cfg_sys_err_rc),
    .cfg_aer_rc_err_int             (cfg_aer_rc_err_int),
    .cfg_aer_rc_err_msi             (cfg_aer_rc_err_msi),
    .cfg_aer_int_msg_num            (cfg_aer_int_msg_num),
    .cfg_pme_int                    (cfg_pme_int),
    .cfg_pme_msi                    (cfg_pme_msi),
    .cfg_pcie_cap_int_msg_num       (cfg_pcie_cap_int_msg_num),
    .cfg_cpl_timeout_range          (cfg_cpl_timeout_range),
    .cfg_cpl_timeout_disable        (cfg_cpl_timeout_disable),
    .cfg_lane_en                    (cfg_lane_en),
    .cfg_gen1_ei_inference_mode     (cfg_gen1_ei_inference_mode),
    .cfg_rxstandby_control          (cfg_rxstandby_control),
    .cfg_link_auto_bw_int           (cfg_link_auto_bw_int),
    .cfg_bw_mgt_int                 (cfg_bw_mgt_int),
    .cfg_gen2_n_fts                 (cfg_gen2_n_fts),
    .cfg_directed_speed_change      (cfg_directed_speed_change),
    .cfg_phy_txswing                (cfg_phy_txswing),
    .cfg_tx_compliance_rcv          (cfg_tx_compliance_rcv),
    .cfg_pcie_max_link_speed        (cfg_pcie_max_link_speed),
    .cfg_target_link_speed          (cfg_target_link_speed),
    .cfg_enter_compliance           (cfg_enter_compliance),
    .cfg_hw_auto_sp_dis             (cfg_hw_auto_sp_dis),
    .cfg_sel_de_emphasis            (cfg_sel_de_emphasis),
    .cfg_transmit_margin            (cfg_transmit_margin),
    .cfg_enter_mod_compliance       (cfg_enter_mod_compliance),
    .cfg_compliance_sos             (cfg_compliance_sos),
    .cfg_compliance_de_emphasis     (cfg_compliance_de_emphasis),
    .cfg_pwr_ind                    (cfg_pwr_ind),
    .cfg_atten_ind                  (cfg_atten_ind),
    .cfg_pwr_ctrler_ctrl            (cfg_pwr_ctrler_ctrl),
    .cfg_eml_control                (cfg_eml_control),
    .cfg_slot_pwr_limit_wr          (cfg_slot_pwr_limit_wr),
    .cfg_int_disable                (cfg_int_disable),
    .cfg_msi_addr                   (cfg_msi_addr),
    .cfg_msi_data                   (cfg_msi_data),
    .cfg_msi_64                     (cfg_msi_64),
    .cfg_msi_en                     (cfg_msi_en),
    .cfg_multi_msi_en               (cfg_multi_msi_en),
    .cfg_msi_ext_data_en            (cfg_msi_ext_data_en),
    .cfg_msix_en                    (cfg_msix_en),
    .cfg_msix_func_mask             (cfg_msix_func_mask),
    .cfg_vpd_int                    (cfg_vpd_int),
    .cfg_flr_pf_active              (cfg_flr_pf_active),
    .flr_pf_rst_n                   (flr_pf_rst_n),
    .cfg_pwr_budget_data_sel_reg    (cfg_pwr_budget_data_sel_reg),
    .cfg_pwr_budget_sel             (cfg_pwr_budget_sel),
    .set_slot_pwr_limit_val         (cfg_slot_pwr_limit_val),
    .set_slot_pwr_limit_scale       (cfg_slot_pwr_limit_scale),
    .cfg_vc_enable                  (cfg_vc_enable),
    .cfg_vc_struc_vc_id_map         (cfg_vc_struc_vc_id_map),
    .cfg_vc_id_vc_struc_map         (cfg_vc_id_vc_struc_map),
    .cfg_tc_enable                  (cfg_tc_enable),
    .cfg_tc_vc_map                  (cfg_tc_vc_map),
    .cfg_tc_struc_vc_map            (cfg_tc_struc_vc_map),
    .cfg_lpvc                       (cfg_lpvc),
    .cfg_vc_arb_sel                 (cfg_vc_arb_sel),
    .cfg_lpvc_wrr_weight            (int_cfg_lpvc_wrr_weight),
    .cfg_max_func_num               (cfg_max_func_num),
    .cfg_trgt_cpl_lut_delete_entry  (cfg_trgt_cpl_lut_delete_entry),
    .cfg_clock_gating_ctrl          (cfg_clock_gating_ctrl),
    .cfg_fc_credit_ph               (cfg_fc_credit_ph),
    .cfg_fc_credit_nph              (cfg_fc_credit_nph),
    .cfg_fc_credit_cplh             (cfg_fc_credit_cplh),
    .cfg_fc_credit_pd               (cfg_fc_credit_pd),
    .cfg_fc_credit_npd              (cfg_fc_credit_npd),
    .cfg_fc_credit_cpld             (cfg_fc_credit_cpld),
    .cfg_radm_q_mode                (cfg_radm_q_mode),
    .cfg_radm_order_rule            (cfg_radm_order_rule),
    .cfg_order_rule_ctrl            (cfg_order_rule_ctrl),
    .cfg_radm_strict_vc_prior       (cfg_radm_strict_vc_prior),
    .cfg_hq_depths                  (cfg_hq_depths),
    .cfg_dq_depths                  (cfg_dq_depths),
    .target_mem_map                 (target_mem_map),
    .target_rom_map                 (target_rom_map),
    .inta_wire                      (inta_wire),
    .intb_wire                      (intb_wire),
    .intc_wire                      (intc_wire),
    .intd_wire                      (intd_wire),
    .cfg_fc_wdog_disable            (cfg_fc_wdog_disable),
    .cfg_pl_multilane_control       (cfg_pl_multilane_control)
    ,
    .crgb_cdm_cs                    (crgb_cdm_cs),
    .crgb_cdm_ack                   (crgb_cdm_ack),
    .crgb_cdm_addr                  (crgb_cdm_addr),
    .crgb_cdm_rdata                 (crgb_cdm_rdata),
    .crgb_cdm_wdata                 (crgb_cdm_wdata),
    .crgb_cdm_wr                    (crgb_cdm_wr),
    .crgb_cdm_source                (crgb_cdm_source)



    ,
    .default_target                 (default_target),
    .ur_ca_mask_4_trgt1             (ur_ca_mask_4_trgt1)


    ,
    .cfg_ido_req_en                 (cfg_ido_req_en),
    .cfg_ido_cpl_en                 (cfg_ido_cpl_en)






    ,
    .cdm_hp_pme                     (hp_pme),
    .cdm_hp_int                     (hp_int),
    .cdm_hp_msi                     (hp_msi)
);  // u_cdm


assign radm_trgt1_addr_i = radm_trgt1_addr_out_i;




// Integrated Address Translation Unit

// Outbound Translation
atu_out
 #(
  .INST(INST),
  .ATU_OUT_REGIONS (ATU_OUT_REGIONS),
  .ATU_BASE_WD (ATU_BASE_WD),
  .ATU_REG_WD (ATU_REG_WD)
) u_atu_out(
    // ------------ Inputs ---------------
    .core_clk                       (core_clk),
    .non_sticky_rst_n               (non_sticky_rst_n),
// ATU outbound Region controls
    .atu_reg_out_type               (atu_reg_out_type),
    .atu_reg_out_tc                 (atu_reg_out_tc),
    .atu_reg_out_td                 (atu_reg_out_td),
    .atu_reg_out_attr               (atu_reg_out_attr),
    .atu_reg_out_func_num           (atu_reg_out_func_num),
    .atu_reg_out_func_bypass        (atu_reg_out_func_bypass),
    .atu_reg_out_dma_bypass         (atu_reg_out_dma_bypass),
    .atu_reg_out_inhibit_payload    (atu_reg_out_inhibit_payload),
    .atu_reg_out_hdr_substitute_en  (atu_reg_out_hdr_substitute_en),
    .atu_reg_out_tag_substitute_en  (atu_reg_out_tag_substitute_en),
    .atu_reg_out_tag                (atu_reg_out_tag),
    .atu_reg_out_msg_code           (atu_reg_out_msg_code),
// Mode Settings
    .atu_reg_out_shift              (atu_reg_out_shift),
    .atu_reg_out_invert             (atu_reg_out_invert),
// Region Enable
    .atu_reg_out_en                 (atu_reg_out_en),
// Base, Limit and Target Registers
    .atu_reg_out_base               (atu_reg_out_base),
    .atu_reg_out_upr_base           (atu_reg_out_upr_base),
    .atu_reg_out_limit              (atu_reg_out_limit),
    .atu_reg_out_lwr_trgt           (atu_reg_out_lwr_trgt),
    .atu_reg_out_upr_trgt           (atu_reg_out_upr_trgt),
    .atu_reg_out_lwr_trgt_lwr       (atu_reg_out_lwr_trgt_lwr),
    .atu_reg_out_incr_rgn_size      (atu_reg_out_incr_rgn_size),
    .x_addr_out                     (x_addr_out),
    .x_fmt_out                      (x_fmt_out),
    .x_rid_out                      (x_rid_out),
    .x_tag_out                      (x_tag_out),
    .x_dma_out                      (x_dma_out),
    .x_atu_bypass_out               (x_atu_bypass_out),

    // Outputs
    .xtranslated_addr_in_d          (xtranslated_addr_in_d),
    .xtranslated_type_in_d          (xtranslated_type_in_d),
    .xtranslated_inhibit_pyld_in    (xtranslated_inhibit_pyld_in),
    .xtranslated_inhibit_pyld_in_d  (xtranslated_inhibit_pyld_in_d),
    .xtranslated_tc_in_d            (xtranslated_tc_in_d),
    .xtranslated_td_in_d            (xtranslated_td_in_d),
    .xtranslated_attr_in_d          (xtranslated_attr_in_d),
    .xtranslated_func_in_d          (xtranslated_func_in_d),
    .xtranslated_tag_in_d           (xtranslated_tag_in_d),
    .xtranslated_msg_code_in_d      (xtranslated_msg_code_in_d),
    .xtranslate_enable              (xtranslate_enable)
);

generate
for (rx_tlp=0; rx_tlp<FX_TLP; rx_tlp = rx_tlp+1) begin : gen_atu_in
// Inbound Translation
atu_in

 #(
  .INST(INST),
  .ATU_IN_REGIONS (ATU_IN_REGIONS),
  .ATU_BASE_WD (ATU_BASE_WD),
  .ATU_REG_WD (ATU_REG_WD)
) u_atu_in(
// ------------ Inputs ---------------
    .core_clk                       (core_clk),
    .non_sticky_rst_n               (non_sticky_rst_n),

// ATU inbound Region controls
    .atu_reg_in_type                (atu_reg_in_type),
    .atu_reg_in_tc                  (atu_reg_in_tc),
    .atu_reg_in_td                  (atu_reg_in_td),
    .atu_reg_in_attr                (atu_reg_in_attr),
    .atu_reg_in_func_num            (atu_reg_in_func_num),
    .atu_reg_in_msg_code            (atu_reg_in_msg_code),
    .atu_reg_in_bar_num             (atu_reg_in_bar_num),
// Inbound field match enables
    .atu_reg_in_tc_match_en         (atu_reg_in_tc_match_en),
    .atu_reg_in_td_match_en         (atu_reg_in_td_match_en),
    .atu_reg_in_attr_match_en       (atu_reg_in_attr_match_en),
    .atu_reg_in_func_match_en       (atu_reg_in_func_match_en),
    .atu_reg_in_msgcode_match_en    (atu_reg_in_msgcode_match_en),
    .atu_reg_in_single_addr_loc_en  (atu_reg_in_single_addr_loc_en),
    .atu_reg_in_msg_type_match_mode (atu_reg_in_msg_type_match_mode),
// Response and mode settings
    .atu_reg_in_rsp_code            (atu_reg_in_rsp_code),
    .atu_reg_in_fuzzy               (atu_reg_in_fuzzy),
    .atu_reg_in_shift               (atu_reg_in_shift),
    .atu_reg_in_invert              (atu_reg_in_invert),
    .atu_reg_in_bar_match           (atu_reg_in_bar_match),
// Region Enable
    .atu_reg_in_en                  (atu_reg_in_en),
// Base, Limit and Target Registers
    .atu_reg_in_base                (atu_reg_in_base),
    .atu_reg_in_upr_base            (atu_reg_in_upr_base),
    .atu_reg_in_limit               (atu_reg_in_limit),
    .atu_reg_in_lwr_trgt            (atu_reg_in_lwr_trgt),
    .atu_reg_in_upr_trgt            (atu_reg_in_upr_trgt),
    .atu_reg_in_incr_rgn_size       (atu_reg_in_incr_rgn_size),

// TLP information from RADM
    .r_addr_out                     (r_addr_out[rx_tlp*64 +: 64]),
    .r_type_out                     (r_type_out[rx_tlp*5 +: 5]),
    .r_bar_out                      (r_bar_out[rx_tlp*3 +: 3]),
    .r_rombar_out                   (r_rombar_out[rx_tlp]),
    .r_tc_out                       (r_tc_out[rx_tlp*3 +: 3]),
    .r_td_out                       (r_td_out[rx_tlp]),
    .r_attr_out                     (r_attr_out[rx_tlp*ATTR_WD +: ATTR_WD]),
    .r_func_out                     (r_func_out[rx_tlp*8 +: 8]),
    .r_msgcode_out                  (r_msgcode_out[rx_tlp*8 +: 8]),
    .halt_in                        (1'b0),

    .cfg_bar0_mask                  (cfg_bar0_mask),
    .cfg_bar1_mask                  (cfg_bar1_mask),
    .cfg_bar2_mask                  (cfg_bar2_mask),
    .cfg_bar3_mask                  (cfg_bar3_mask),
    .cfg_bar4_mask                  (cfg_bar4_mask),
    .cfg_bar5_mask                  (cfg_bar5_mask),
    .cfg_rom_mask                   (cfg_rom_mask),

// Address translation outputs to RADM
    .rtranslated_addr_in_d          (rtranslated_addr_in_d[rx_tlp*64 +: 64]),
    .rtranslated_err_in_d           (rtranslated_err_in_d[rx_tlp*2 +: 2]),
    .atu_in_tlp_xlate               ()                            // Not required from this instance of atu_in
);
end
endgenerate

// Inbound Translation for Single Address Location regions only.  Address
// translation occurs after the RADM buffer queues for this feature.

/*----------------- Start of TLP Header unpacking for internal ATU post RADM Queue (u_single_location_atu_in) -----------------------------------*/

localparam UPPR_ADDR_WIDTH = (ADDR_WIDTH <= 64) ? 64-ADDR_WIDTH : 0;

// All TLP header filed info for u_single_location_atu_in is taken from
// radm_outq_mgr prior to its final pipeline.

wire [63:0]              radm_atu_addr_in;
wire [7:0]               radm_atu_trgt1_func_out;
wire [ADDR_WIDTH-1:0]    int_radm_outq_pkt_addr;            // hdr field addr
wire [ADDR_WIDTH-1:0]    radm_outq_pkt_addr;                // hdr field addr
wire [ADDR_WIDTH-1:0]    radm_outq_pkt_addr_tmp;            // hdr field addr
wire [3:0]               int_radm_outq_pkt_first_be;        // hdr field first_be
wire [3:0]               int_radm_outq_pkt_last_be;         // hdr field last_be

wire                     radm_outq_pkt_td;
wire                     radm_outq_pkt_rom_in_range;
wire [2:0]               radm_outq_pkt_in_membar_range;
wire [PF_WD-1:0]         radm_outq_pkt_func_num;
wire [TAG_SIZE-1:0]      radm_outq_pkt_tag;
wire [ATTR_WD-1:0]       radm_outq_pkt_attr;
wire [2:0]               radm_outq_pkt_tc;
wire [4:0]               radm_outq_pkt_type;
wire [1:0]               radm_outq_pkt_fmt;
wire [7:0]               radm_outq_pkt_msgcode;


assign radm_outq_pkt_fmt[1:0]                               = radm_outq_pkt_hdr[`RADM_Q_FMT_RANGE       ]; // completion hdr element
assign radm_outq_pkt_type[4:0]                              = radm_outq_pkt_hdr[`RADM_Q_TYPE_RANGE      ]; // completion hdr element
assign radm_outq_pkt_tc[2:0]                                = radm_outq_pkt_hdr[`RADM_Q_TC_RANGE        ]; // completion hdr element
assign radm_outq_pkt_attr                                   = radm_outq_pkt_hdr[`RADM_Q_ATTR_RANGE      ]; // completion hdr element
assign radm_outq_pkt_tag[TAG_SIZE-1:0]                      = radm_outq_pkt_hdr[`RADM_Q_TAG_RANGE       ]; // completion hdr element
assign radm_outq_pkt_func_num                               = radm_outq_pkt_hdr[`RADM_Q_FUNC_NMBR_RANGE ]; // for cfg transaction only
assign int_radm_outq_pkt_first_be[3:0]                        = radm_outq_pkt_hdr[`RADM_PQ_FRSTDW_BE_RANGE]; // completion hdr & TRGT0 control


assign radm_outq_pkt_msgcode = {int_radm_outq_pkt_last_be,int_radm_outq_pkt_first_be};

wire outq_pkt_cpl_type;
assign outq_pkt_cpl_type   = (({radm_outq_pkt_fmt,radm_outq_pkt_type} == `CPLLK) | ({radm_outq_pkt_fmt,radm_outq_pkt_type} == `CPLDLK)  ||
                           ({radm_outq_pkt_fmt,radm_outq_pkt_type} == `CPL) | ({radm_outq_pkt_fmt,radm_outq_pkt_type} == `CPLD));
assign int_radm_outq_pkt_addr   = outq_pkt_cpl_type ? {{(`FLT_Q_ADDR_WIDTH-`FLT_Q_CPL_LOWER_ADDR_WIDTH){1'b0}}, radm_outq_pkt_hdr[`RADM_PQ_CPL_LOWER_ADDR_RANGE]} :
                                                      ( radm_outq_pkt_hdr[ `RADM_PQ_ADDR_RANGE   ]);       // completion hdr & TRGT0 control
assign radm_outq_pkt_td       = outq_pkt_cpl_type ? radm_outq_pkt_hdr[`RADM_CPLQ_TD_RANGE] : radm_outq_pkt_hdr[ `RADM_PQ_TD_RANGE              ];

assign radm_outq_pkt_addr_tmp[`FLT_Q_ADDR_WIDTH-1:0] = int_radm_outq_pkt_addr[`FLT_Q_ADDR_WIDTH-1:0];

assign radm_outq_pkt_addr[`FLT_Q_ADDR_WIDTH-1:0]   = radm_outq_pkt_addr_tmp[`FLT_Q_ADDR_WIDTH-1:0];

assign radm_outq_pkt_rom_in_range    = radm_outq_pkt_hdr[ `RADM_PQ_ROM_IN_RANGE_RANGE];          // control
assign radm_outq_pkt_in_membar_range = radm_outq_pkt_hdr[ `RADM_PQ_IN_MEMBAR_RANGE_RANGE ];      // control
assign int_radm_outq_pkt_last_be[3:0]  = radm_outq_pkt_hdr[ `RADM_PQ_LSTDW_BE_RANGE        ];


assign radm_atu_trgt1_func_out = {{(8-PF_WD){1'b0}}, radm_outq_pkt_func_num};
assign radm_atu_addr_in = {{UPPR_ADDR_WIDTH{1'b0}}, radm_outq_pkt_addr};

/*----------------- End of TLP Header unpacking for internal ATU post RADM Queue (u_single_location_atu_in) ------------------------------------*/


atu_in

 #(
  .INST(INST),
  .ATU_IN_REGIONS (ATU_IN_REGIONS),
  .ATU_BASE_WD (ATU_BASE_WD),
  .ATU_REG_WD (ATU_REG_WD),
  .PRE_REGISTER (0),
  .POST_REGISTER (1),
  .ATU_PRE_RADM_Q (0)
) u_single_location_atu_in(
// ------------ Inputs ---------------
    .core_clk                       (core_clk),
    .non_sticky_rst_n               (non_sticky_rst_n),

// ATU inbound Region controls
    .atu_reg_in_type                (atu_reg_in_type),
    .atu_reg_in_tc                  (atu_reg_in_tc),
    .atu_reg_in_td                  (atu_reg_in_td),
    .atu_reg_in_attr                (atu_reg_in_attr),
    .atu_reg_in_func_num            (atu_reg_in_func_num),
    .atu_reg_in_msg_code            (atu_reg_in_msg_code),
    .atu_reg_in_bar_num             (atu_reg_in_bar_num),
// Inbound field match enables
    .atu_reg_in_tc_match_en         (atu_reg_in_tc_match_en),
    .atu_reg_in_td_match_en         (atu_reg_in_td_match_en),
    .atu_reg_in_attr_match_en       (atu_reg_in_attr_match_en),
    .atu_reg_in_func_match_en       (atu_reg_in_func_match_en),
    .atu_reg_in_msgcode_match_en    (atu_reg_in_msgcode_match_en),
    .atu_reg_in_single_addr_loc_en  (atu_reg_in_single_addr_loc_en),
    .atu_reg_in_msg_type_match_mode  (atu_reg_in_msg_type_match_mode),
// Response and mode settings
    .atu_reg_in_rsp_code            (atu_reg_in_rsp_code),
    .atu_reg_in_fuzzy               (atu_reg_in_fuzzy),
    .atu_reg_in_shift               (atu_reg_in_shift),
    .atu_reg_in_invert              (atu_reg_in_invert),
    .atu_reg_in_bar_match           (atu_reg_in_bar_match),
// Region Enable
    .atu_reg_in_en                  (atu_reg_in_en),
// Base, Limit and Target Registers
    .atu_reg_in_base                (atu_reg_in_base),
    .atu_reg_in_upr_base            (atu_reg_in_upr_base),
    .atu_reg_in_limit               (atu_reg_in_limit),
    .atu_reg_in_lwr_trgt            (atu_reg_in_lwr_trgt),
    .atu_reg_in_upr_trgt            (atu_reg_in_upr_trgt),
    .atu_reg_in_incr_rgn_size       (atu_reg_in_incr_rgn_size),

// TLP information from RADM
    .r_addr_out                     (radm_atu_addr_in),
    .r_type_out                     (radm_outq_pkt_type),
    .r_bar_out                      (radm_outq_pkt_in_membar_range),
    .r_rombar_out                   (radm_outq_pkt_rom_in_range),
    .r_tc_out                       (radm_outq_pkt_tc),
    .r_td_out                       (radm_outq_pkt_td),
    .r_attr_out                     (radm_outq_pkt_attr),
    .r_func_out                     (radm_atu_trgt1_func_out),
    .r_msgcode_out                  (radm_outq_pkt_msgcode),
    .halt_in                        (radm_outq_halt_in),
    .cfg_bar0_mask                  (cfg_bar0_mask),
    .cfg_bar1_mask                  (cfg_bar1_mask),
    .cfg_bar2_mask                  (cfg_bar2_mask),
    .cfg_bar3_mask                  (cfg_bar3_mask),
    .cfg_bar4_mask                  (cfg_bar4_mask),
    .cfg_bar5_mask                  (cfg_bar5_mask),
    .cfg_rom_mask                   (cfg_rom_mask),

// Address translation outputs to RADM
    .rtranslated_addr_in_d          (atu_trgt1_addr),
    .rtranslated_err_in_d           (),
    .atu_in_tlp_xlate               (radm_trgt1_hdr_uppr_bytes_valid_atu)
);

// When Address translation occurs in u_single_location_atu_in, then Fmt[0]
// is determined by the value of the Type field and the contents of the
// translated address field.

always @(*) begin : translate_fmt0
  if (radm_trgt1_hdr_uppr_bytes_valid_atu) begin
    translated_tlp_hdr_fmt0 =                               (radm_trgt1_type_i[4:1] == 4'b0000) ?  ~(atu_trgt1_addr[63:32] == 32'b0) :    //mem
                               (radm_trgt1_type_i[4:2] == 3'b011 ) ?  ~(atu_trgt1_addr[63:32] == 32'b0) :    //Atomic
                               (radm_trgt1_type_i[4:1] == 4'b0010) ?  1'b0                              :    //cfg 0 and 1
                               (radm_trgt1_type_i == 5'b00010)     ?  1'b0                              :    // I/O
                               radm_xlate_fmt[0];                                                          // unaltered after the RADM Queue
  end else begin
    translated_tlp_hdr_fmt0 = radm_xlate_fmt[0];
  end
end   // translate_fmt0

assign translated_tlp_hdr_fmt = {radm_xlate_fmt[1], translated_tlp_hdr_fmt0};




wire                pipe_aux_sync_p1_ack;
wire                adapted_block_phystatus;
wire                pm_block_phystatus;
wire                pm_phystatus_pending;
wire                pm_en_pulse_det;

//instance of pipe_adapter
pipe_adapter

#(
   .INST(INST),
   .NL(NL),
   .PHY_NB(PHY_NB)
) u_pipe_adapter (
    //inputs
    .clk                       (pipe_clk),
    .rst_n                     (core_rst_n),
    .phy_mac_phystatus         (phy_mac_phystatus),
    .aux_clk                   (pm_aux_clk),
    .mac_phy_txcompliance      (mac_phy_txcompliance),
    .pm_block_phystatus        (pm_block_phystatus),
    .pm_phystatus_pending      (pm_phystatus_pending),
    .pm_en_pulse_det           (pm_en_pulse_det),
    .cfg_trgt_l1sub            (cfg_l1sub_control[`CX_L1SUB_CONTROL_TRGT_L1SUB_RANGE]),
    .cfg_clk_pm_en             (cfg_clk_pm_en),
    .smlh_in_l1                (smlh_in_l1),
    .cfg_elastic_buffer_mode   (cfg_elastic_buffer_mode),
    .rate                      (tmp_mac_phy_rate),
    .powerdown                 (xmlh_powerdown),

    //outputs
    .pipe_powerdown            (adapted_pipe_mac_phy_powerdown),
    .pipe_width                (adapted_pipe_mac_phy_width),
    .pipe_pclk_rate            (adapted_pipe_mac_phy_pclk_rate)
    ,
    .pipe_aux_sync_p1_ack      (pipe_aux_sync_p1_ack),
    .pipe_block_phystatus      (adapted_block_phystatus)
); //pipe_adapter

assign pre_mac_phy_txdatavalid  = {NL{1'b1}}; // All pacing configs are in gen3/4, so set to 1 for Gen1/2 configs
assign lpbk_rxdatavalid_i = lpbk_rxdatavalid;

//
// CX-PL core for xN
//
cx_pl

#(INST) u_cx_pl (
    // ------------------------------- Inputs ------------------------------------
    .pm_block_phystatus             (adapted_block_phystatus),
    .pm_current_data_rate           (pm_current_data_rate),
    .core_clk                       (core_clk),
    .core_clk_ug                    (core_clk_ug),
    .core_rst_n                     (core_rst_n),
    .app_init_rst                   (pm_init_rst),                 // only applied to Downstream port
    .app_ltssm_enable               (pm_ltssm_enable),
    .rstctl_core_flush_req          (rstctl_core_flush_req),
    .phy_type                       (pm_phy_type),
    .cfg_endpoint                   (end_device),
    .cfg_root_compx                 (rc_device),
    .cfg_upstream_port              (upstream_port),
    .cfg_dll_lnk_en                 (cfg_dll_lnk_en),
    .cfg_ack_freq                   (cfg_ack_freq),
    .cfg_ack_latency_timer          (cfg_ack_latency_timer),
    .cfg_replay_timer_value         (cfg_replay_timer_value),
    .cfg_fc_latency_value           (cfg_fc_latency_value),
    .cfg_other_msg_payload          (cfg_other_msg_payload),
    .cfg_other_msg_request          (cfg_other_msg_request),
    .cfg_corrupt_crc_pattern        (cfg_corrupt_crc_pattern),
    .cfg_flow_control_disable       (cfg_flow_control_disable),
    .cfg_acknack_disable            (cfg_acknack_disable),
    .cfg_elastic_buffer_mode        (cfg_elastic_buffer_mode),
    .cfg_scramble_dis               (cfg_scramble_dis),
    .cfg_n_fts                      (cfg_n_fts),
    .cfg_link_dis                   (cfg_link_dis),
    .cfg_link_retrain               (pm_smlh_link_retrain),             // Control LTSSM to link recovery
    .cfg_lpbk_en                    (cfg_lpbk_en),
    .cfg_reset_assert               (cfg_reset_assert),
    .cfg_link_num                   (cfg_link_num),
    .cfg_forced_link_state          (cfg_forced_link_state),
    .cfg_forced_ltssm_cmd           (cfg_forced_ltssm_cmd),
    .cfg_force_en                   (cfg_force_en),
    .cfg_fast_link_mode             (cfg_fast_link_mode),
    .cfg_fast_link_scaling_factor   (cfg_fast_link_scaling_factor),
    .cfg_l0s_supported              (cfg_l0s_supported),
    .cfg_link_capable               (cfg_link_capable),
    .cfg_lane_skew                  (cfg_lane_skew),
    .cfg_deskew_disable             (cfg_deskew_disable),
    .cfg_imp_num_lanes              (cfg_imp_num_lanes),
    .cfg_skip_interval              (cfg_skip_interval),
    .cfg_ext_synch                  (cfg_ext_synch),
    .cfg_hw_autowidth_dis           (cfg_hw_autowidth_dis),
    .cfg_max_payload                (cfg_highest_max_payload),
    .cfg_vc_enable                  (cfg_vc_enable),
    .cfg_vc_struc_vc_id_map         (cfg_vc_struc_vc_id_map),
    .cfg_tc_struc_vc_map            (cfg_tc_struc_vc_map),
    .cfg_vc_id_vc_struc_map         (cfg_vc_id_vc_struc_map),
    .cfg_tc_enable                  (cfg_tc_enable),
    .cfg_fc_wdog_disable            (cfg_fc_wdog_disable),

    .cfg_fc_credit_ph               (cfg_fc_credit_ph),
    .cfg_fc_credit_nph              (cfg_fc_credit_nph),
    .cfg_fc_credit_cplh             (cfg_fc_credit_cplh),
    .cfg_fc_credit_pd               (cfg_fc_credit_pd),
    .cfg_fc_credit_npd              (cfg_fc_credit_npd),
    .cfg_fc_credit_cpld             (cfg_fc_credit_cpld),


    .phy_mac_rxdata                 (in_cxpl_phy_mac_rxdata),
    .phy_mac_rxdatak                (in_cxpl_phy_mac_rxdatak),
    .phy_mac_rxvalid                (in_cxpl_phy_mac_rxvalid),
    .phy_mac_rxstatus               (in_cxpl_phy_mac_rxstatus),
    .phy_mac_rxelecidle             (in_cxpl_phy_mac_rxelecidle),
    .phy_mac_phystatus              (in_cxpl_phy_mac_phystatus),
    .phy_mac_rxstandbystatus        (tmp_phy_mac_rxstandbystatus),
    .phy_mac_rxelecidle_noflip      (sqlchd_rxelecidle),
    .laneflip_lanes_active          (laneflip_lanes_active),
    .laneflip_rcvd_eidle_rxstandby  (laneflip_rcvd_eidle_rxstandby),


    .cfg_lane_en                    (cfg_lane_en),
    .cfg_gen1_ei_inference_mode     (cfg_gen1_ei_inference_mode),
    .cfg_rxstandby_control          (cfg_rxstandby_control),
    .phy_mac_rxdatavalid            (tmp_phy_mac_rxdatavalid),
    .cfg_pl_multilane_control       (cfg_pl_multilane_control),
    .sticky_rst_n                   (sticky_rst_n),
    .cfg_gen2_support               (cfg_gen2_support),
    .cfg_gen2_n_fts                 (cfg_gen2_n_fts),
    .cfg_enter_compliance           (cfg_enter_compliance),
    .cfg_sel_de_emphasis            (cfg_sel_de_emphasis),
    .cfg_transmit_margin            (cfg_transmit_margin),
    .cfg_enter_mod_compliance       (cfg_enter_mod_compliance),
    .cfg_compliance_sos             (cfg_compliance_sos),
    .cfg_compliance_de_emphasis     (cfg_compliance_de_emphasis),
    .cfg_pcie_max_link_speed        (cfg_pcie_max_link_speed),
    .cfg_target_link_speed          (cfg_target_link_speed),
    .cfg_directed_speed_change      (cfg_directed_speed_change),
    .cfg_phy_txswing                (cfg_phy_txswing),
    .cfg_tx_compliance_rcv          (cfg_tx_compliance_rcv),

    .radm_rtlh_ph_ca                (int_rtlh_ph_ca),
    .radm_rtlh_pd_ca                (int_rtlh_pd_ca),
    .radm_rtlh_nph_ca               (int_rtlh_nph_ca),
    .radm_rtlh_npd_ca               (int_rtlh_npd_ca),
    .radm_rtlh_cplh_ca              (int_rtlh_cplh_ca),
    .radm_rtlh_cpld_ca              (int_rtlh_cpld_ca),

    .xadm_xtlh_hv                   (xadm_xtlh_hv),
    .xadm_xtlh_soh                  (xadm_xtlh_soh),
    .xadm_xtlh_hdr                  (xadm_xtlh_hdr),
    .xadm_xtlh_dwen                 (xadm_xtlh_dwen),
    .xadm_xtlh_dv                   (xadm_xtlh_dv),
    .xadm_xtlh_data                 (xadm_xtlh_data),
    .xadm_xtlh_eot                  (xadm_xtlh_eot),
    .xadm_xtlh_bad_eot              (xadm_xtlh_bad_eot),
    .xadm_xtlh_add_ecrc             (xadm_xtlh_add_ecrc),
    .xadm_xtlh_vc                   (xadm_xtlh_vc),

    .pm_smlh_entry_to_l0s           (pm_smlh_entry_to_l0s),
    .pm_smlh_l0s_exit               (pm_smlh_l0s_exit),
    .pm_smlh_entry_to_l1            (pm_smlh_entry_to_l1),
    .pm_smlh_l1_exit                (pm_smlh_l1_exit),
    .pm_smlh_l23_exit               (pm_smlh_l23_exit),
    .pm_smlh_entry_to_l2            (pm_smlh_entry_to_l2),
    .pm_smlh_prepare4_l123          (pm_smlh_prepare4_l123),
    .pm_freeze_fc_timer             (pm_freeze_fc_timer),
    .pm_xtlh_block_tlp              (pm_xtlh_block_tlp),
    .pm_xdlh_req_ack                (pm_xdlh_req_ack),
    .pm_xdlh_enter_l1               (pm_xdlh_enter_l1),
    .pm_xdlh_enter_l23              (pm_xdlh_enter_l23),
    .pm_xdlh_actst_req_l1           (pm_xdlh_actst_req_l1),
    .xadm_all_type_infinite         (xadm_all_type_infinite),
    .pm_smlh_l1_2_latched           (pm_smlh_l1_2_latched),
    .pm_smlh_l1_n_latched           (pm_smlh_l1_n_latched),
    .cfg_l1sub_t_common_mode        (cfg_l1sub_t_common_mode),

    //  ------------------------------  Outputs --------------------------------
    .rtlh_radm_ant_addr             (rtlh_radm_ant_addr),
    .rtlh_radm_ant_rid              (rtlh_radm_ant_rid),
    .mac_phy_txdata                 (tmp_mac_phy_txdata),
    .mac_phy_txdatak                (tmp_mac_phy_txdatak),
    .mac_phy_txdetectrx_loopback    (tmp_mac_phy_txdetectrx_loopback),
    .mac_phy_txelecidle             (tmp_ltssm_txelecidle),
    .mac_phy_txcompliance           (tmp_mac_phy_txcompliance),
    .mac_phy_rxpolarity             (tmp_mac_phy_rxpolarity),
    .mac_phy_rxstandby              (tmp_mac_phy_rxstandby),
    .smlh_rcvd_eidle_rxstandby      (smlh_rcvd_eidle_rxstandby),
    .smlh_ltssm_state               (smlh_ltssm_state),
    .smlh_lanes_active              (smlh_lanes_active),
    .xmlh_powerdown                 (tmp_xmlh_powerdown),
    .smlh_autoneg_link_width        (smlh_autoneg_link_width),
    .smlh_training_rst_n            (training_rst_n),
    .smlh_autoneg_link_sp           (smlh_autoneg_link_sp),
    .smlh_link_training_in_prog     (smlh_link_training_in_prog),
    .smlh_link_up                   (smlh_link_up),
    .smlh_req_rst_not               (smlh_req_rst_not),
    .smlh_in_rl0s                   (smlh_in_rl0s),
    .smlh_in_l0s                    (smlh_in_l0s),
    .smlh_in_l0                     (smlh_in_l0),
    .smlh_in_l1                     (smlh_in_l1),
    .smlh_in_l1_p1                  (smlh_in_l1_p1),
    .smlh_in_l23                    (smlh_in_l23),
    .smlh_l123_eidle_timeout        (smlh_l123_eidle_timeout),
    .latched_rcvd_eidle_set         (latched_rcvd_eidle_set),
    .smlh_bw_mgt_status             (smlh_bw_mgt_status),
    .smlh_link_auto_bw_status       (smlh_link_auto_bw_status),
    .smlh_clr_enter_compliance      (smlh_clr_enter_compliance),
    .smlh_tx_margin_rst             (smlh_tx_margin_rst),
    .smlh_core_rst_n_release_pulse  (smlh_core_rst_n_release_pulse),
    .smlh_dir_spd_chg_rising_edge   (smlh_dir_spd_chg_rising_edge),
    .smlh_dir_linkw_chg_rising_edge (smlh_dir_linkw_chg_rising_edge),
    .smlh_ltssm_in_hotrst_dis_entry (smlh_ltssm_in_hotrst_dis_entry),
    .rmlh_rcvd_err                  (rmlh_rcvd_err),
    .rmlh_rcvd_eidle_set            (rmlh_rcvd_eidle_set),

    .rdlh_prot_err                  (rdlh_prot_err),
    .rdlh_bad_tlp_err               (rdlh_bad_tlp_err),
    .rdlh_bad_dllp_err              (rdlh_bad_dllp_err),
    .rdlh_rtlh_link_state           (rdlh_dlcntrl_state),
    .rdlh_rcvd_as_req_l1            (rdlh_rcvd_as_req_l1),
    .rdlh_rcvd_pm_enter_l1          (rdlh_rcvd_pm_enter_l1),
    .rdlh_rcvd_pm_enter_l23         (rdlh_rcvd_pm_enter_l23),
    .rdlh_rcvd_pm_req_ack           (rdlh_rcvd_pm_req_ack),
    .rdlh_link_up                   (rdlh_link_up),
    .rdlh_link_down                 (rdlh_link_down),

    
    .xdlh_replay_num_rlover_err     (xdlh_replay_num_rlover_err),
    .xdlh_replay_timeout_err        (xdlh_replay_timeout_err),
    .xdlh_retrybuf_not_empty        (xdlh_retrybuf_not_empty),
    .xdlh_nodllp_pending            (xdlh_nodllp_pending),
    .xdlh_no_acknak_dllp_pending    (xdlh_no_acknak_dllp_pending),
    .xdlh_not_expecting_ack         (xdlh_not_expecting_ack),
    .xdlh_xmt_pme_ack               (xdlh_xmt_pme_ack),
    .xdlh_last_pmdllp_ack           (xdlh_last_pmdllp_ack),

    .rtlh_radm_hv                   (rtlh_radm_hv),
    .rtlh_radm_hdr                  (rtlh_radm_hdr),
    .rtlh_radm_dwen                 (rtlh_radm_dwen),
    .rtlh_radm_dv                   (rtlh_radm_dv),
    .rtlh_radm_data                 (rtlh_radm_data),
    .rtlh_radm_eot                  (rtlh_radm_eot),
    .rtlh_radm_ecrc_err             (rtlh_radm_ecrc_err),
    .rtlh_radm_malform_tlp_err      (rtlh_radm_malform_tlp_err),
    .rtlh_radm_dllp_err             (rtlh_radm_dllp_err),
    .rtlh_parerr                    (rtlh_parerr),

    .rtlh_fc_init_status            (rtlh_fc_init_status),
    .rtlh_crd_not_rtn               (rtlh_crd_not_rtn),
    .rtlh_rfc_upd                   (rtlh_rfc_upd),
    .rtlh_rfc_data                  (rtlh_rfc_data),
    .xtlh_xadm_restore_enable       (xtlh_xadm_restore_enable),
    .xtlh_xadm_restore_capture      (xtlh_xadm_restore_capture),
    .xtlh_xadm_restore_tc           (xtlh_xadm_restore_tc),
    .xtlh_xadm_restore_type         (xtlh_xadm_restore_type),
    .xtlh_xadm_restore_word_len     (xtlh_xadm_restore_word_len),

    .xtlh_notlp_pending             (xtlh_notlp_pending),
    .xtlh_data_parerr               (xtlh_data_parerr),
    .xtlh_xmt_cpl_ca                (xtlh_xmt_cpl_ca),
    .xtlh_xmt_cpl_ur                (xtlh_xmt_cpl_ur),
    .xtlh_xmt_cpl_poisoned          (xtlh_xmt_cpl_poisoned),
    .xtlh_xmt_wreq_poisoned         (xtlh_xmt_wreq_poisoned),
    .xtlh_xadm_halt                 (xtlh_xadm_halt),
    // from xtlh for keeping track of completions and handling of
    // completions -- Only applied to End-point
    .xtlh_xmt_tlp_done              (xtlh_xmt_tlp_done),
    .xtlh_xmt_cfg_req               (xtlh_xmt_cfg_req),             // N/A for endpoint
    .xtlh_xmt_memrd_req             (xtlh_xmt_memrd_req),
    .xtlh_xmt_tlp_req_id            (xtlh_xmt_tlp_req_id),
    .xtlh_xmt_tlp_tag               (xtlh_xmt_tlp_tag),
    .xtlh_xmt_tlp_attr              (xtlh_xmt_tlp_attr),
    .xtlh_xmt_tlp_tc                (xtlh_xmt_tlp_tc),
    .xtlh_xmt_tlp_len_inbytes       (xtlh_xmt_tlp_len_inbytes),
    .xtlh_xmt_tlp_first_be          (xtlh_xmt_tlp_first_be),

    .mac_phy_rate                   (tmp_int_mac_phy_rate),
    .current_data_rate              (current_data_rate),
    .mac_phy_txdeemph               (int_mac_phy_txdeemph),
    .mac_phy_txmargin               (int_mac_phy_txmargin),
    .mac_phy_txswing                (int_mac_phy_txswing),

    // Retry buffer external RAM interface


    .xdlh_retryram_addr             (xdlh_retryram_addr),
    .xdlh_retryram_data             (xdlh_retryram_data),
    .xdlh_retryram_we               (xdlh_retryram_we),
    .xdlh_retryram_en               (xdlh_retryram_en),
    .xdlh_retryram_par_chk_val      (xdlh_retryram_par_chk_val),
    .xdlh_retryram_halt             (xdlh_retryram_halt),

    .retryram_xdlh_data             (retryram_xdlh_data),
    .retryram_xdlh_depth            (retryram_xdlh_depth),
    .retryram_xdlh_parerr           (retryram_xdlh_parerr),

    .xdlh_retrysotram_waddr         (xdlh_retrysotram_waddr),
    .xdlh_retrysotram_raddr         (xdlh_retrysotram_raddr),
    .xdlh_retrysotram_data          (xdlh_retrysotram_data),
    .xdlh_retrysotram_en            (xdlh_retrysotram_en),
    .xdlh_retrysotram_we            (xdlh_retrysotram_we),
    .xdlh_retrysotram_par_chk_val   (xdlh_retrysotram_par_chk_val),

    .retrysotram_xdlh_depth         (retrysotram_xdlh_depth),
    .retrysotram_xdlh_parerr        (retrysotram_xdlh_parerr),
    .retrysotram_xdlh_data          (retrysotram_xdlh_data),
    .rtlh_fc_prot_err               (rtlh_fc_prot_err),
    // signals for debug purpose
    .cxpl_debug_info                (cxpl_debug_info),
    .cxpl_debug_info_ei             (cxpl_debug_info_ei)
    ,
    .rtfcgen_ph_diff                (rtfcgen_ph_diff),
    .rtlh_overfl_err                (rtlh_overfl_err),
    .smlh_lane_flip_ctrl            (smlh_lane_flip_ctrl),
    .xdlh_retry_req                 (xdlh_retry_req)
    ,
    .smlh_link_in_training          (smlh_link_in_training),
    .xdlh_replay_timer              (xdlh_replay_timer),
    .xdlh_rbuf_pkt_cnt              (xdlh_rbuf_pkt_cnt),
    .smlh_fast_time_1ms             (smlh_fast_time_1ms),
    .smlh_fast_time_2ms             (smlh_fast_time_2ms),
    .smlh_fast_time_3ms             (smlh_fast_time_3ms),
    .smlh_fast_time_4ms             (smlh_fast_time_4ms),
    .smlh_fast_time_10ms            (smlh_fast_time_10ms),
    .smlh_fast_time_12ms            (smlh_fast_time_12ms),
    .smlh_fast_time_24ms            (smlh_fast_time_24ms),
    .smlh_fast_time_32ms            (smlh_fast_time_32ms),
    .smlh_fast_time_48ms            (smlh_fast_time_48ms),
    .smlh_fast_time_100ms           (smlh_fast_time_100ms)
    ,
    .xdlh_match_pmdllp              (xdlh_match_pmdllp)
);    // u_cx_pl

assign xmlh_powerdown = int_xmlh_powerdown;




// Assemble the PIPE control signals into a single bus to pass in/out of
// pipe_loopback module
parameter CTRL_WIDTH = 8;
// 1: rxelecidle
// 4: startblock, datavalid, syncheader(2 bits)

wire [CTRL_WIDTH-1:0] rxctrl;
wire [CTRL_WIDTH-1:0] txctrl;
wire [CTRL_WIDTH-1:0] lpbk_ctrl;

// Pack Normal mode receive control signals
assign rxctrl = {
    sqlchd_rxelecidle
    ,
    phy_mac_rxdatavalid
    };

// Pack loopback mode transmit control signals
assign txctrl = {
    int_phy_txelecidle
    ,
    pre_mac_phy_txdatavalid
    };
pipe_loopback

#(
    .INST (0), // uniquifying parameter for each port logic instance
    .NL (`CX_NL),
    .PHY_NB (`CX_PHY_NB),
    .CTRL_WIDTH (CTRL_WIDTH),// Control mux width varies with gen3 pipe i/f
    .PDWN_WIDTH (PDWN_WIDTH),// Width of powerdown input
    .RATE_WIDTH (RATE_WIDTH) // Width of powerdown input
) u_pipe_loopback
(
    .clk                            (pipe_clk),
    .rst_n                          (core_rst_n),

    // Control Inputs
    .cfg_pipe_loopback              (cfg_pipe_loopback),
    .cfg_rxstatus_lane              (cfg_rxstatus_lane),
    .cfg_rxstatus_value             (cfg_rxstatus_value),
    .cfg_lpbk_rxvalid               (cfg_lpbk_rxvalid),
    .ext_pipe_loopback              (1'b0),     // May be connected to test pin

    // PIPE RX Inputs
    .rxdata                         (phy_mac_rxdata),
    .rxdatak                        (phy_mac_rxdatak),
    .rxvalid                        (phy_mac_rxvalid),
    .rxctrl                         (rxctrl),
    .rxstatus                       (phy_mac_rxstatus),
    .phystatus                      (phy_mac_phystatus),

    // PIPE TX Inputs
    .txdata                         (pre_mac_phy_txdata),
    .txdatak                        (pre_mac_phy_txdatak),
    .txctrl                         (txctrl),
    .txdetectrx_loopback            (pre_mac_phy_txdetectrx_loopback),
    .powerdown                      (pm_int_phy_powerdown),
    .rate                           (pre_mac_phy_rate),

    // PIPE Outputs
    .lpbk_rxdata                    (lpbk_rxdata),
    .lpbk_rxdatak                   (lpbk_rxdatak),
    .lpbk_rxvalid                   (lpbk_rxvalid),
    .lpbk_ctrl                      (lpbk_ctrl),
    .lpbk_rxstatus                  (lpbk_rxstatus),
    .lpbk_phystatus                 (lpbk_phystatus)
);

// Unpack the loopback rx control signals
assign {
    lpbk_rxelecidle
    ,
    lpbk_rxdatavalid
    } = lpbk_ctrl;

//
// Note: Not all features applied to end-point application
//
parameter CX_SRC_NB = 4;
parameter CX_DST_NB = 1;
parameter CX_SRC_GEN2_MODE = 0;
parameter CX_SRC_GEN3_MODE = 2;
parameter CX_SRC_GEN4_MODE = 2;
parameter CX_DST_GEN2_MODE = 0;
parameter CX_DST_GEN3_MODE = 2;
parameter CX_DST_GEN4_MODE = 2;
parameter CX_SRC_FREQ = 3;
parameter CX_DST_FREQ = 3;

generate
for (lane=0; lane<NL; lane = lane+1) begin : gen_freq_step
  freq_step
  
  #(
    .INST          (INST),
    .SRC_NB        (CX_SRC_NB),
    .DST_NB        (CX_DST_NB),
    .SRC_GEN2_MODE (CX_SRC_GEN2_MODE),
    .SRC_GEN3_MODE (CX_SRC_GEN3_MODE),
    .SRC_GEN4_MODE (CX_SRC_GEN4_MODE),
    .DST_GEN2_MODE (CX_DST_GEN2_MODE),
    .DST_GEN3_MODE (CX_DST_GEN3_MODE),
    .DST_GEN4_MODE (CX_DST_GEN4_MODE),
    .SRC_FREQ      (CX_SRC_FREQ),
    .DST_FREQ      (CX_DST_FREQ),
    .MAC_INST      (1)
  ) u_freq_step(
    .pipe_clk                       (pipe_clk),
    .core_rst_n                     (core_rst_n),
    .pipe_rst_n                     (pipe_rst_n),
    .core_clk                       (core_clk),
    .core_clk_ug                    (core_clk_ug),
    .cfg_elastic_buffer_mode        (cfg_elastic_buffer_mode),
    .phy_mac_rxdata                 (lpbk_rxdata                         [(lane*PHY_NB*8)+(PHY_NB*8)-1:(lane*PHY_NB*8)]),
    .phy_mac_rxdatak                (lpbk_rxdatak                        [(lane*PHY_NB)+PHY_NB-1:(lane*PHY_NB)]),
    .phy_mac_rxvalid                (lpbk_rxvalid                        [lane]),
    .phy_mac_rxstatus               (lpbk_rxstatus                       [(lane*3)+3-1:(lane*3)]),
    .phy_mac_rxelecidle             (lpbk_rxelecidle                     [lane]),
    .phy_mac_phystatus              (lpbk_phystatus                      [lane]),
    .phy_mac_rxstandbystatus        (phy_mac_rxstandbystatus             [lane]),
    .phy_mac_rxdatavalid            (lpbk_rxdatavalid_i                  [lane]),
    .fstep_phy_mac_rxdata           (int_phy_mac_rxdata                  [(lane*NB*8)+(NB*8)-1:(lane*NB*8)]),
    .fstep_phy_mac_rxdatak          (int_phy_mac_rxdatak                 [(lane*NB)+NB-1:(lane*NB)]),
    .fstep_phy_mac_rxvalid          (int_phy_mac_rxvalid                 [lane]),
    .fstep_phy_mac_rxstatus         (int_phy_mac_rxstatus                [(lane*3)+3-1:(lane*3)]),
    .fstep_phy_mac_rxelecidle       (int_phy_mac_rxelecidle              [lane]),
    .fstep_phy_mac_phystatus        (int_phy_mac_phystatus               [lane]),
    .fstep_phy_mac_rxstandbystatus  (int_phy_mac_rxstandbystatus         [lane]),
    .fstep_phy_mac_rxdatavalid      (int_phy_mac_rxdatavalid             [lane]),
    .mac_phy_txdata                 (int_mac_phy_txdata                  [(lane*NB*8)+(NB*8)-1:(lane*NB*8)]),
    .mac_phy_txdatak                (int_mac_phy_txdatak                 [(lane*NB)+NB-1:(lane*NB)]),
    .mac_phy_txelecidle             (int_ltssm_txelecidle                [lane] ),
    .mac_phy_txdetectrx_loopback    (int_mac_phy_txdetectrx_loopback     [lane] ),
    .mac_phy_txcompliance           (int_mac_phy_txcompliance            [lane] ),
    .mac_phy_rxpolarity             (int_mac_phy_rxpolarity              [lane] ),
    .mac_phy_rxstandby              (int_mac_phy_rxstandby               [lane] ),
    .mac_phy_rate                   (int_mac_phy_rate),
    .mac_phy_txdeemph               (int_mac_phy_txdeemph),
    .mac_phy_txmargin               (int_mac_phy_txmargin),
    .mac_phy_txswing                (int_mac_phy_txswing),
    .mac_phy_powerdown              (pm_int_phy_powerdown                [3:0]),
    .fstep_mac_phy_txdata             (pre_mac_phy_txdata                  [(lane*PHY_NB*8)+(PHY_NB*8)-1:(lane*PHY_NB*8)]),
    .fstep_mac_phy_txdatak            (pre_mac_phy_txdatak                 [(lane*PHY_NB)+PHY_NB-1:(lane*PHY_NB)]),
    .fstep_mac_phy_txdetectrx_loopback(pre_mac_phy_txdetectrx_loopback     [lane] ),
    .fstep_mac_phy_txcompliance       (pre_mac_phy_txcompliance            [lane] ),
    .fstep_mac_phy_rxpolarity         (pre_mac_phy_rxpolarity              [lane] ),
    .fstep_mac_phy_rxstandby          (pre_mac_phy_rxstandby               [lane] ),
    .fstep_mac_phy_rate               (tmp_mac_phy_rate_bus                [(lane*2)+2-1:(lane*2)] ),
    .fstep_mac_phy_txdeemph           (mac_phy_txdeemph_bus                [(lane*2)+1:(lane*2)] ),
    .fstep_mac_phy_txmargin           (mac_phy_txmargin_bus                [(lane*3)+3-1:(lane*3)] ),
    .fstep_mac_phy_txswing            (mac_phy_txswing_bus                 [lane] ),
    .fstep_mac_phy_txelecidle         (int_mac_phy_txelecidle              [lane] )
);
end // for (lane=0; lane<NL; lane = lane+1) begin : gen_freq_step
endgenerate


 assign tmp_mac_phy_rate = tmp_mac_phy_rate_bus[1:0];
 assign pre_mac_phy_width = adapted_pipe_mac_phy_width;
 assign pre_mac_phy_pclk_rate = adapted_pipe_mac_phy_pclk_rate;

 assign pre_mac_phy_powerdown = adapted_pipe_mac_phy_powerdown;
 assign pre_mac_phy_txdeemph = mac_phy_txdeemph_bus[1:0];

 assign pre_mac_phy_txmargin = mac_phy_txmargin_bus[2:0];
 assign pre_mac_phy_txswing  = mac_phy_txswing_bus[0];

 assign pre_mac_phy_rate = tmp_mac_phy_rate[0];

// START_IO:DBI Signal Descriptions.
wire app_core_edma_bridge_xfer_pending;
pm_ctrl

#(  .INST           (INST),
    .PDWN_WIDTH     (PDWN_WIDTH),
    .NL             (NL),
    .PHY_NB         (PHY_NB),
    .TX_DEEMPH_WD   (TX_DEEMPH_WD),
    .PHY_RATE_WD    (RATE_WIDTH),
    .TX_DATA_WD     (TX_DATA_WD),
    .TX_DATAK_WD    (TX_DATAK_WD),
    .BUSNUM_WD      (BUSNUM_WD),
    .DEVNUM_WD      (DEVNUM_WD),
    .L2NL           (L2NL)
) u_pm_ctrl(
    //    ----------------- Inputs ----------------------
    .core_rst_n                     (core_rst_n),
    .cfg_upd_aspm_ctrl              (cfg_upd_aspm_ctrl),
    .cfg_upd_aslk_pmctrl            (cfg_upd_aslk_pmctrl),
    .link_req_rst_not               (link_req_rst_not),
    .app_clk_req_n                  (app_clk_req_n),
    .phy_clk_req_n                  (phy_clk_req_n),
    .cfg_upd_pme_cap                (cfg_upd_pme_cap),
    .aux_clk                        (aux_clk),
    .pwr_rst_n                      (pwr_rst_n),
    .cfg_elastic_buffer_mode        (1'b0),
    .rstctl_ltssm_enable            (rstctl_ltssm_enable),
    .rstctl_core_flush_req          (rstctl_core_flush_req),
    .upstream_port                  (upstream_port),
    .switch_device                  (1'b0),
    .xdlh_nodllp_pending            (xdlh_nodllp_pending),
    .xdlh_no_acknak_dllp_pending    (xdlh_no_acknak_dllp_pending),
    .xdlh_xmt_pme_ack               (xdlh_xmt_pme_ack),
    .xdlh_last_pmdllp_ack           (xdlh_last_pmdllp_ack),
    .rdlh_rcvd_as_req_l1            (rdlh_rcvd_as_req_l1),
    .rdlh_rcvd_pm_enter_l1          (rdlh_rcvd_pm_enter_l1),
    .rdlh_rcvd_pm_enter_l23         (rdlh_rcvd_pm_enter_l23),
    .rdlh_rcvd_pm_req_ack           (rdlh_rcvd_pm_req_ack),
    .smlh_link_up                   (smlh_link_up),
    .smlh_link_in_training          (smlh_link_in_training),
    .all_dwsp_in_l1                 (1'b0),
    .all_dwsp_in_rl0s               (1'b0),                         // Only for SW
    .upsp_in_rl0s                   (1'b0),                         // Only for SW
    .one_dwsp_exit_l1               (1'b0),
    .one_dwsp_exit_l23              (1'b0),
    .app_req_entr_l1                (app_req_entr_l1),
    .app_ready_entr_l23             (app_ready_entr_l23),
    .app_req_exit_l1                (app_req_exit_l1),
    .xdlh_not_expecting_ack         (xdlh_not_expecting_ack),
    .xtlh_had_enough_credit         (xadm_had_enough_credit),
    .smlh_in_l0                     (smlh_in_l0),
    .smlh_in_l0s                    (smlh_in_l0s),
    .smlh_in_rl0s                   (smlh_in_rl0s),
    .smlh_in_l1                     (smlh_in_l1),
    .smlh_in_l1_p1                  (smlh_in_l1_p1),
    .smlh_in_l23                    (smlh_in_l23),
    .smlh_l123_eidle_timeout        (smlh_l123_eidle_timeout),
    .latched_rcvd_eidle_set         (latched_rcvd_eidle_set),
    .sys_aux_pwr_det                (sys_aux_pwr_det),
    .xadm_notlp_pending             (xadm_notlp_pending),
    .xadm_idle                      (xadm_idle),
    .xtlh_notlp_pending             (xtlh_notlp_pending),
    .xtlh_no_fc_credit              (xadm_no_fc_credit),
    .cfg_aslk_pmctrl                (cfg_aslk_pmctrl),
    .cfg_l0s_entr_latency_timer     (cfg_l0s_entr_latency_timer),
    .cfg_l1_entr_latency_timer      (cfg_l1_entr_latency_timer),
    .cfg_l1_entr_wo_rl0s            (cfg_l1_entr_wo_rl0s),
    .all_dwsp_rcvd_toack_msg        (1'b0),
    .outband_pwrup_cmd              (outband_pwrup_cmd),
    .cfg_upd_pmcsr                  (cfg_upd_pmcsr),
    .cfg_upd_aux_pm_en              (cfg_upd_aux_pm_en),
    .cfg_pmstatus_clr               (cfg_pmstatus_clr),
    .cfg_pmstate                    (cfg_pmstate),
    .cfg_pme_en                     (cfg_pme_en),
    .cfg_aux_pm_en                  (cfg_aux_pm_en),
    .cfg_upd_req_id                 (int_cfg_upd_req_id),
    .cfg_pbus_dev_num               (int_cfg_pbus_dev_num),
    .cfg_pbus_num                   (int_cfg_pbus_num),
    .cfg_clk_pm_en                  (cfg_clk_pm_en),
    .radm_pm_turnoff                (radm_pm_turnoff),
    .radm_pm_asnak                  (radm_pm_asnak),
    .radm_pm_to_ack                 (int_radm_pm_to_ack),
    .apps_pm_xmt_turnoff            (apps_pm_xmt_turnoff),
    .apps_pm_xmt_pme                (apps_pm_xmt_pme),              // Only for upstream port
    .nhp_pme_det                    ({NF{1'b0}}),                   // Only for SW upstream
    .cfg_pme_cap                    (cfg_pme_cap),
    .phy_mac_rxelecidle             (phy_mac_rxelecidle),
    .current_data_rate              (current_data_rate),
    .aux_clk_active                 (aux_clk_active),
    .aux_sync_p1_ack                (pipe_aux_sync_p1_ack),
    .phy_mac_phystatus              (phy_mac_phystatus),
    .cfg_l1sub_control              (cfg_l1sub_control),
    .cfg_pl_l1sub_control           (cfg_pl_l1sub_control),
    .cfg_pl_l1_exit_mode            (cfg_pl_l1_exit_mode),
    .clkreq_in_n                    (clkreq_in_n),
    .pm_cpl_timer_decr              (pm_cpl_timer_decr),
    .pm_cpl_timeout_value           (pm_cpl_timeout_value),
    .cfg_pl_l1_nowait_p1            (cfg_pl_l1_nowait_p1),
    .cfg_pl_l1_clk_sel              (cfg_pl_l1_clk_sel),
    .cfg_pl_aux_clk_freq            (cfg_pl_aux_clk_freq),
    .pme_to_ack_grt                 (pme_to_ack_grt),
    .radm_trgt0_pending             (radm_trgt0_pending),
    .lbc_active                     (lbc_active),
    .pm_pme_grant                   (pm_pme_grant),
    .pme_turn_off_grt               (pme_turn_off_grt),
    .perst_n                        (perst_n),
    .app_core_edma_bridge_xfer_pending (app_core_edma_bridge_xfer_pending),
    .app_xfer_pending                  (app_xfer_pending),
    .slv_awvalid                    (slv_awvalid),
    .slv_arvalid                    (slv_arvalid),
    .slv_wvalid                     (slv_wvalid),
    .dbi_arvalid                    (dbi_arvalid),
    .dbi_awvalid                    (dbi_awvalid),
    .dbi_wvalid                     (dbi_wvalid),
    .brdg_dbi_xfer_pending          (brdg_dbi_xfer_pending),


    .mac_phy_powerdown              (pre_mac_phy_powerdown),
    .mac_phy_txelecidle             (int_mac_phy_txelecidle),
    // PHY interface signals
    .mac_phy_txdata                 (pre_mac_phy_txdata),
    .mac_phy_txdatak                (pre_mac_phy_txdatak),
    .mac_phy_txdetectrx_loopback    (pre_mac_phy_txdetectrx_loopback),
    .mac_phy_txcompliance           (pre_mac_phy_txcompliance),
    .mac_phy_rxpolarity             (pre_mac_phy_rxpolarity),
    .ltssm_rxpolarity               (tmp_mac_phy_rxpolarity),
    .mac_phy_width                  (pre_mac_phy_width),
    .mac_phy_pclk_rate              (pre_mac_phy_pclk_rate),
    .mac_phy_rxstandby              (pre_mac_phy_rxstandby),
    .mac_phy_rate                   (pre_mac_phy_rate),
    .mac_phy_txdeemph               (pre_mac_phy_txdeemph),
    .mac_phy_txmargin               (pre_mac_phy_txmargin),
    .mac_phy_txswing                (pre_mac_phy_txswing),
    .msg_gen_asnak_grt              (msg_gen_asnak_grt),

    .rx_lane_flip_en                (rx_lane_flip_en),
    .tx_lane_flip_en                (tx_lane_flip_en),
    .smlh_lane_flip_ctrl            (smlh_lane_flip_ctrl),

    .cfg_link_dis                   (cfg_link_dis),
    .cfg_link_retrain               (cfg_link_retrain),
    .cfg_lpbk_en                    (cfg_lpbk_en),
    .cfg_2nd_reset                  (cfg_2nd_reset),
    .cfg_plreg_reset                (cfg_plreg_reset),
    .app_init_rst                   (app_init_rst),
    .cfg_directed_speed_change      (cfg_directed_speed_change),
    .cfg_directed_width_change      (cfg_pl_multilane_control[6]),
    .ven_msg_req                    (ven_msg_req),
    .ven_msi_req                    (ven_msi_req),
    .app_ltr_msg_req                (1'b0),
    .app_unlock_msg                 (app_unlock_msg),
    .msg_gen_unlock_grant           (msg_gen_unlock_grant),
    .xdlh_match_pmdllp              (xdlh_match_pmdllp),

    // ----------------- Outputs -----------------------
    .pm_en_aux_clk_g                (en_aux_clk_g),
    .pm_ltssm_enable                (pm_ltssm_enable),
    .pm_current_data_rate           (pm_current_data_rate),
    .wake                           (wake),
    .clk_req_n                      (clk_req_n),
    .pm_smlh_entry_to_l0s           (pm_smlh_entry_to_l0s),
    .pm_smlh_entry_to_l1            (pm_smlh_entry_to_l1),
    .pm_smlh_entry_to_l2            (pm_smlh_entry_to_l2),
    .pm_smlh_prepare4_l123          (pm_smlh_prepare4_l123),
    .pm_smlh_l0s_exit               (pm_smlh_l0s_exit),
    .pm_smlh_l1_exit                (pm_smlh_l1_exit),
    .pm_smlh_l23_exit               (pm_smlh_l23_exit),
    .pm_xtlh_block_tlp              (pm_xtlh_block_tlp),
    .pm_block_all_tlp               (pm_block_all_tlp),
    .pm_l1_aspm_entr                (pm_l1_aspm_entr),
    .pm_radm_block_tlp              (pm_radm_block_tlp),
    .pm_xdlh_enter_l1               (pm_xdlh_enter_l1),
    .pm_xdlh_req_ack                (pm_xdlh_req_ack),
    .pm_xdlh_enter_l23              (pm_xdlh_enter_l23),
    .pm_xdlh_actst_req_l1           (pm_xdlh_actst_req_l1),
    .pm_freeze_fc_timer             (pm_freeze_fc_timer),
    .pm_freeze_cpl_timer            (pm_freeze_cpl_timer),
    .pm_req_dwsp_turnoff            (),
    .pm_xmt_asnak                   (pm_xmt_asnak),                 // N/A for endpoint
    .pm_xmt_turnoff                 (pm_xmt_turnoff),               // N/A for endpoint
    .pm_xmt_to_ack                  (pm_xmt_to_ack),
    .pm_xmt_pme                     (pm_xmt_pme),
    .pm_turnoff_timeout             (pm_turnoff_timeout),
    .pm_linkst_in_l0                (),
    .pm_linkst_in_l1                (pm_linkst_in_l1),
    .pm_linkst_in_l2                (pm_linkst_in_l2),
    .pm_linkst_l2_exit              (pm_linkst_l2_exit),
    .pm_linkst_in_l3                (),
    .pm_linkst_in_l0s               (pm_linkst_in_l0s),
    .pm_pme_en                      (pm_pme_en),
    .pm_status                      (pm_status),
    .pm_aux_pm_en                   (aux_pm_en),
    .pm_bus_num                     (pm_bus_num),
    .pm_dev_num                     (pm_dev_num),
    .pm_int_phy_powerdown           (pm_int_phy_powerdown),
    .pm_curnt_state                 (pm_curnt_state),
    .pm_req_sticky_rst              (pm_req_sticky_rst),
    .pm_req_core_rst                  (pm_req_core_rst),
    .pm_req_non_sticky_rst          (pm_req_non_sticky_rst),
    .pm_sel_aux_clk                 (pm_sel_aux_clk),
    .pm_req_phy_rst                 (pm_req_phy_rst),
    .pm_linkst_in_l1sub             (pm_linkst_in_l1sub),
    .pm_smlh_l1_2_latched           (pm_smlh_l1_2_latched),
    .pm_smlh_l1_n_latched           (pm_smlh_l1_n_latched),
    .pm_rcvd_as_req_l1              (pm_rcvd_as_req_l1),
    .pm_rcvd_pm_enter_l1            (pm_rcvd_pm_enter_l1),
    .pm_cpl_timer                   (pm_cpl_timer),
    .pm_master_state                (pm_master_state),
    .pm_slave_state                 (pm_slave_state),
    .phy_if_cpcie_powerdown         (mac_phy_powerdown),
    .phy_if_cpcie_txelecidle        (mac_phy_txelecidle),
    .pm_int_txelecidle              (int_phy_txelecidle),
    .pm_block_phystatus                 (pm_block_phystatus),
    .pm_phystatus_pending               (pm_phystatus_pending),
    .gasket_en_pulse_det                (pm_en_pulse_det),
    .phy_if_cpcie_pclkreq_n             (mac_phy_pclkreq_n),
    .phy_if_cpcie_txdata                (mac_phy_txdata),
    .phy_if_cpcie_txdatak               (mac_phy_txdatak),
    .phy_if_cpcie_txdetectrx_loopback   (mac_phy_txdetectrx_loopback),
    .phy_if_cpcie_txcompliance          (mac_phy_txcompliance),
    .phy_if_cpcie_rxpolarity            (mac_phy_rxpolarity),
    .phy_if_cpcie_width                 (mac_phy_width),
    .phy_if_cpcie_pclk_rate             (mac_phy_pclk_rate),
    .phy_if_cpcie_rxstandby             (mac_phy_rxstandby),
    .phy_if_cpcie_txdatavalid           (mac_phy_txdatavalid),
    .phy_if_cpcie_rate                  (mac_phy_rate),
    .phy_if_cpcie_txdeemph              (mac_phy_txdeemph),
    .phy_if_cpcie_txmargin              (mac_phy_txmargin),
    .phy_if_cpcie_txswing               (mac_phy_txswing),
    .phy_if_cpcie_phy_type              (pm_phy_type),
    .pm_pmstate                         (pm_dstate),
    .sqlchd_rxelecidle                  (sqlchd_rxelecidle),
    .pm_aux_clk_ft                      (pm_aux_clk),
    .pm_app_xfer_pending_ft             (pm_app_xfer_pending),
    .pm_sys_aux_pwr_det_ft              (pm_sys_aux_pwr_det),
    .pm_aux_clk_active_ft               (pm_aux_clk_active)
    ,
    .pm_slv_awvalid_ft                  (pm_slv_awvalid),
    .pm_slv_arvalid_ft                  (pm_slv_arvalid),
    .pm_slv_wvalid_ft                   (pm_slv_wvalid)
    ,
    .pm_dbi_arvalid_ft                  (pm_dbi_arvalid),
    .pm_dbi_awvalid_ft                  (pm_dbi_awvalid),
    .pm_dbi_wvalid_ft                   (pm_dbi_wvalid)
    ,
    .pm_pme_en_split                    (pm_pme_en_split),
    .pm_aux_pm_en_split                 (pm_aux_pm_en_split),
    .pm_init_rst                        (pm_init_rst),
    .pm_unlock_msg_req                  (pm_unlock_msg_req)
    ,
    .pm_rx_lane_flip_ctrl               (pm_rx_lane_flip_en),
    .pm_tx_lane_flip_ctrl               (pm_tx_lane_flip_en),
    .pm_rx_pol_lane_flip_ctrl           (pm_rx_pol_lane_flip_ctrl)
    ,
    .pm_smlh_link_retrain               (pm_smlh_link_retrain),
    .phy_if_elasticbuffermode           (mac_phy_elasticbuffermode)
);

// END_IO:DBI Signal Descriptions.
// The Local Bus Controller
lbc

#(INST) u_lbc (
    // -- inputs --
    .core_clk                       (aux_clk_g),
    .core_rst_n                     (core_rst_n),
    .cfg_pbus_num                   (cfg_pbus_num),
    .cfg_pbus_dev_num               (cfg_pbus_dev_num),
    .radm_dv                        (radm_trgt0_dv),
    .radm_hv                        (radm_trgt0_hv),
    .radm_hdr                       (radm_trgt0_hdr[RADM_P_HWD-1:0]),
    .radm_data                      (radm_trgt0_data[DW_WO_PAR-1:0]),
    .radm_eot                       (radm_trgt0_eot),
    .radm_abort                     (radm_trgt0_abort),
    .radm_trgt0_pending             (radm_trgt0_pending),

    // local bus interface with external registers
    .ext_lbc_ack                    (ext_lbc_ack),
    .ext_lbc_din                    (ext_lbc_din),
    // from cdm
    .cdm_lbc_din                    (cdm_lbc_data),
    .cdm_lbc_ack                    (cdm_lbc_ack),

   // from  XADM
    .xadm_cpl_halt                  (xadm_cpl_halt),

    //memory mapped device
    // external dbi interface designed for outband access
    .dbi_addr                       (int_dbi_addr),
    .dbi_din                        (int_dbi_din),
    .dbi_cs                         (int_dbi_cs),
    .dbi_cs2                        (int_dbi_cs2),
    .dbi_wr                         (int_dbi_wr),

    .dbi_func_num                   (int_dbi_func_num),


//----------- outputs -------------------------
    // external dbi interface designed for outband access
    .lbc_dbi_dout                   (int_lbc_dbi_dout),
    .lbc_dbi_ack                    (int_lbc_dbi_ack),

    // to XADM as completion request of device local bus read or write
    .lbc_cpl_hv                     (lbc_cpl_hv),
    .lbc_cpl_dv                     (lbc_cpl_dv),
    .lbc_cpl_hdr                    (lbc_cpl_hdr),
    .lbc_cpl_data                   (lbc_cpl_data),
    .lbc_cpl_eot                    (lbc_cpl_eot),

    .lbc_xmt_cpl_ca                 (lbc_xmt_cpl_ca),

    // local bus interface with cdm to read registers locally
    .lbc_cdm_addr                   (lbc_cdm_addr),
    .lbc_cdm_data                   (lbc_cdm_data),
    .lbc_cdm_cs                     (lbc_cdm_cs),
    .lbc_cdm_wr                     (lbc_cdm_wr),
    .lbc_cdm_dbi                    (lbc_cdm_dbi),
    .lbc_cdm_dbi2                   (lbc_cdm_dbi2),
    .lbc_cdm_unroll                 (lbc_cdm_unroll),

    // local bus interface with external registers
    .lbc_ext_addr                   (lbc_ext_addr),
    .lbc_ext_dout                   (lbc_ext_dout),
    .lbc_ext_cs                     (lbc_ext_cs),
    .lbc_ext_wr                     (lbc_ext_wr),
    .lbc_ext_rom_access             (lbc_ext_rom_access),
    .lbc_ext_io_access              (lbc_ext_io_access),
    .lbc_ext_bar_num                (lbc_ext_bar_num),





    //DE: Deadlock fix
    .pm_l1_aspm_entr                (pm_l1_aspm_entr),
    .lbc_deadlock_det               (lbc_deadlock_det),
    .rtfcgen_ph_diff                (rtfcgen_ph_diff),         //input

    // radm block interface control signal to allowback pressure applied to radm queues.
    .trgt0_radm_halt                (trgt0_radm_halt),
    .lbc_active                     (lbc_active)


); // lbc


// -----------------------------------------------------------------------------
// Message TLP Generation
// -----------------------------------------------------------------------------

msg_gen

#(INST) u_msg_gen(
// ---------- Inputs --------
    .core_rst_n                     (core_rst_n),
    .core_clk                       (core_clk),
    .device_type                    (int_device_type),
    .pm_xtlh_block_tlp              (pm_xtlh_block_tlp),
    .pm_pme                         (pm_xmt_pme),
    .pm_asnak                       (pm_xmt_asnak),                 // N/A for endpoint
    .pme_turn_off                   (pm_xmt_turnoff),               // N/A for endpoint
    .pme_to_ack                     (pm_xmt_to_ack),
    .send_cor_err                   (cfg_send_cor_err),
    .send_nf_err                    (cfg_send_nf_err),
    .send_f_err                     (cfg_send_f_err),
    .cfg_func_spec_err              (cfg_func_spec_err),
    .unlock                         (pm_unlock_msg_req),            // N/A for endpoint
    .inta_wire                      (inta_wire),
    .intb_wire                      (intb_wire),
    .intc_wire                      (intc_wire),
    .intd_wire                      (intd_wire),
//    .nhp_int                        ({NF{1'b0}}),                   // not used
    .cfg_bus_master_en              (cfg_bus_master_en),
    .cfg_slot_pwr_limit_wr          (cfg_slot_pwr_limit_wr[0]),     // N/A for endpoint
    .rdlh_link_up                   (rdlh_link_up),
    .pm_bus_num                     (pm_bus_num),
    .pm_dev_num                     (pm_dev_num),
    .cfg_pbus_num                   (cfg_pbus_num),
    .cfg_pbus_dev_num               (cfg_pbus_dev_num),
    .cfg_msi_addr                   (cfg_msi_addr),
    .cfg_msi_data                   (cfg_msi_data),
    .cfg_msi_64                     (cfg_msi_64),
    .cfg_multi_msi_en               (cfg_multi_msi_en),
//    .hp_msi_request                 ({NF{1'b0}}),                   // Only for SW Upstream
    .cfg_msix_en                    (cfg_msix_en),                  // N/A for RC
    .msix_addr                      (msix_addr),                    // N/A for RC
    .msix_data                      (msix_data),                    // N/A for RC
    .ven_msi_req                    (ven_msi_req),                  // N/A for RC
    .ven_msi_func_num               (ven_msi_func_num),              // N/A for RC

    .ven_msi_tc                     (ven_msi_tc),                   // N/A for RC
    .ven_msi_vector                 (ven_msi_vector),               // N/A for RC

    .xadm_msg_halt                  (xadm_msg_halt),
    .set_slot_pwr_limit_val         (cfg_slot_pwr_limit_val),
    .set_slot_pwr_limit_scale       (cfg_slot_pwr_limit_scale),

    .ven_msg_fmt                    (ven_msg_fmt),
    .ven_msg_type                   (ven_msg_type),
    .ven_msg_tc                     (ven_msg_tc),
    .ven_msg_td                     (ven_msg_td),
    .ven_msg_ep                     (ven_msg_ep),
    .ven_msg_attr                   (ven_msg_attr),
    .ven_msg_len                    (ven_msg_len),
    .ven_msg_func_num               (ven_msg_func_num),
    .ven_msg_tag                    (ven_msg_tag),
    .ven_msg_code                   (ven_msg_code),
    .ven_msg_data                   (ven_msg_data),
    .ven_msg_req                    (ven_msg_req),

    .pm_dstate                      (pm_dstate),


// ---------- Outputs --------
    .msg_gen_hv                     (msg_gen_hv),
    .msg_gen_dv                     (msg_gen_dv),
    .msg_gen_eot                    (msg_gen_eot),
    .msg_gen_data                   (msg_gen_data),
    .msg_gen_hdr                    (msg_gen_hdr),

    .ven_msg_grant                  (ven_msg_grant),
    .ven_msi_grant                  (ven_msi_grant),                // N/A for RC
    .pme_to_ack_grt                 (pme_to_ack_grt),
    .pm_pme_grant                   (pm_pme_grant),
    .pme_turn_off_grt               (pme_turn_off_grt)
    ,
    .msg_gen_asnak_grt              (msg_gen_asnak_grt),
    .msg_gen_unlock_grant           (msg_gen_unlock_grant)
); // msg_gen

// ----------------------------------------------------------------------
// Instantiate reset request control logic
// ----------------------------------------------------------------------

// Pending Status
wire   xfer_pending_int;
wire   xfer_pending_rst;


assign xfer_pending_int = brdg_slv_xfer_pending
                         || radm_q_pending
                         || radm_xfer_pending;

assign xfer_pending_rst = brdg_slv_xfer_pending
                         || brdg_dbi_xfer_pending
                         || edma_xfer_pending
                         || radm_q_pending
                         || radm_xfer_pending;

wire   core_xfer_pending;
assign core_xfer_pending = (|radm_cpl_lut_valid) || (|radm_q_not_empty)
                            || (!trgt_cpl_lut_empty)
; //TRGT_CPL_LUT_EN

assign app_core_edma_bridge_xfer_pending = pm_app_xfer_pending || core_xfer_pending
                         || edma_xfer_pending
                         || xfer_pending_int
;

  DWC_pcie_rst_ctl
  
 #(
  .GEN2_DYNAMIC_FREQ_VALUE     (GEN2_DYNAMIC_FREQ_VALUE)
  )
  u_rstctl
  (
  // Clocks and resets
  .core_clk                           (core_clk)
  ,.core_rst_n                        (core_rst_n)
  // Configuration interface
  ,.cfg_fast_link_mode                (cfg_fast_link_mode)
  ,.cfg_fast_link_scaling_factor      (cfg_fast_link_scaling_factor)
  ,.cfg_auto_flush_en                 (cfg_auto_flush_en)
  ,.cfg_auto_flush_timeout            (cfg_auto_flush_timeout)
  // Application Reset Control Interface
  ,.app_ltssm_enable                  (app_ltssm_enable)
  ,.rstctl_ltssm_enable               (rstctl_ltssm_enable)
  // Link Status Interface
  ,.smlh_ltssm_in_hotrst_dis_entry    (smlh_ltssm_in_hotrst_dis_entry)
  ,.smlh_req_rst_not                  (smlh_req_rst_not)
  ,.smlh_link_up                      (smlh_link_up)
  ,.rdlh_link_up                      (rdlh_link_up)
  // Link Timer Interface
  ,.cfg_link_timeout_en_n             (cfg_link_timeout_en_n)
  ,.cfg_link_timeout_period           (cfg_link_timeout_period)
  ,.current_data_rate                 (pm_current_data_rate)
  // Transfer Pending Interface
  ,.xfer_pending                      (xfer_pending_rst)
  // Flush Control Interface
  ,.rstctl_core_flush_req             (rstctl_core_flush_req)
  ,.rstctl_mstr_flush_req             (rstctl_mstr_flush_req)
  ,.rstctl_slv_flush_req              (rstctl_slv_flush_req)
  ,.flush_ack                         (brdg_slv_flush_ack)
  // Reset Request Interface
  ,.rstctl_req_rst_not                (link_req_rst_not)
  );




// ================================= Diagnostic Bus Assignment =================================================
// Diagnostic mechanism is designed in core by routing the important internal signals to application dynamically.
// Diagnostic mechanism is designed in core by taking control signals from application to insert a defined behavor of the core.
// Diagnotic status signals are groupped together from different layers of the core


 // Function to grab a byte from a bus
function [15:0] get_req_id;
input   [BUSNUM_WD -1:0]            bus_num;
input   [DEVNUM_WD -1:0]            dev_num;
input   [PF_WD-1:0]                 func_num;
integer                             i;
reg     [7:0]                       int_bus_num;
reg     [4:0]                       int_dev_num;
reg     [7:0]                       int_func_num;

begin
    int_bus_num = 0;
    int_dev_num = 0;
    int_func_num = 0;
    int_func_num[PF_WD-1:0]    = func_num[PF_WD-1:0]   ;
    int_bus_num = bus_num;
    int_dev_num = dev_num;
    get_req_id     = {int_bus_num, int_func_num[7:0]};
end
endfunction

// Function to grab a byte from a bus
function [7:0] Bget;
input   [(NF*8)-1:0]                vector;
input   [NF-1:0]                    onehot_index;
integer                             i;

begin
    Bget = vector[7:0];
    for(i=0;i<NF;i=i+1) begin
        if(onehot_index[i])
            Bget = vector[8*i +: 8];
    end
end
endfunction

// Function to grab a 5-bit slice from a bus
function [4:0] Qget;
input   [(NF*5)-1:0]                vector;
input   [NF-1:0]                    onehot_index;
integer                             i;

begin
    Qget = vector[4:0];
    for(i=0;i<NF;i=i+1) begin
        if(onehot_index[i])
            Qget = vector[5*i +: 5];
    end
end
endfunction


// Function to assign 1 bit radm_rtlh_*h_ca to multi-bits int_rtlh_*h_ca
function [DCA_WD*NVC-1:0] credit_mapping;
input   [NVC-1:0]                radm_h_ca;
integer                             i;

begin
    credit_mapping = 0;
    for(i=0;i<NVC;i=i+1) begin
            credit_mapping[i*DCA_WD] = radm_h_ca[i];
    end
end
endfunction

endmodule
