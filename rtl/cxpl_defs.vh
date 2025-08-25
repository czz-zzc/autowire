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
// ---  RCS information:
// ---    $DateTime: 2016/06/30 09:50:44 $
// ---    $Revision: #138 $
// ---    $Id: //dwh/pcie_iip/main/fairbanks/design/include/cxpl_defs.vh#138 $
// -------------------------------------------------------------------------
// --- Module Description:
// ---
// --- This file contains CX-PL implementation-specific defines
// ---
// -----------------------------------------------------------------------------

// PCIE spec definitions here


    `define CXPL_DEFS

    // This constant can be used to pad at the start of packets.
    `define CRC_PASSTHRU 32'h6DD90A9D

        `define TP 0.25   // RTL Design Clock to Q output delay (simulator safety)

    `define TBTP 1   // Testbench Clock to Q output delay (simulator safety)


    //
    // Define three technology speeds for configuring core options (additional pipeline stages)
    //
    `define CX_QMODE_STORE_N_FWD        0
    `define CX_QMODE_CUT_THROUGH        1
    `define CX_QMODE_BYPASS             2


    // Now, define parameters that are derived user configuration
    //

    `define CX_UNUSED_RESPONSE          32'b0    // Value device responds with on reads to unused addresses

    // XDLH
    `define ACK_TIMER_WIDTH             14
    `define FC_UPD_FREQ                 12'hEA6 // Flow Control update freq      (30 us)

    // Our L0s exit time in symbol times (if there are other factors beyond NFTS+1SKP, add them into CX_RBUF_ADJUST)
    `define CX_RX_L0S_ADJUST    ((`CX_NFTS+1)*8'd4)
    `define CX_TXL0S_ADJUST     16'd64   // TBD - What is the best estimate for partner's TX L0s Exit time

    //
    // Technology specific parameters
    //


    // LTSSM States
    `define S_DETECT_QUIET              6'h00
    `define S_DETECT_ACT                6'h01
    `define S_POLL_ACTIVE               6'h02
    `define S_POLL_COMPLIANCE           6'h03
    `define S_POLL_CONFIG               6'h04
    `define S_PRE_DETECT_QUIET          6'h05
    `define S_DETECT_WAIT               6'h06
    `define S_CFG_LINKWD_START          6'h07
    `define S_CFG_LINKWD_ACEPT          6'h08
    `define S_CFG_LANENUM_WAIT          6'h09
    `define S_CFG_LANENUM_ACEPT         6'h0A
    `define S_CFG_COMPLETE              6'h0B
    `define S_CFG_IDLE                  6'h0C
    `define S_RCVRY_LOCK                6'h0D
    `define S_RCVRY_SPEED               6'h0E
    `define S_RCVRY_RCVRCFG             6'h0F
    `define S_RCVRY_IDLE                6'h10
    `define S_RCVRY_EQ0                 6'h20
    `define S_RCVRY_EQ1                 6'h21
    `define S_RCVRY_EQ2                 6'h22
    `define S_RCVRY_EQ3                 6'h23
    `define S_L0                        6'h11
    `define S_L0S                       6'h12
    `define S_L123_SEND_EIDLE           6'h13
    `define S_L1_IDLE                   6'h14
    `define S_L2_IDLE                   6'h15
    `define S_L2_WAKE                   6'h16
    `define S_DISABLED_ENTRY            6'h17
    `define S_DISABLED_IDLE             6'h18
    `define S_DISABLED                  6'h19
    `define S_LPBK_ENTRY                6'h1A
    `define S_LPBK_ACTIVE               6'h1B
    `define S_LPBK_EXIT                 6'h1C
    `define S_LPBK_EXIT_TIMEOUT         6'h1D
    `define S_HOT_RESET_ENTRY           6'h1E
    `define S_HOT_RESET                 6'h1F

    // MPCIE
    `define S_CFG_START                 6'h27
    `define S_CFG_SOFTWARE              6'h30
    `define S_CFG_UPDATE                6'h28
    `define S_CFG_CONFIRM               6'h29
    `define S_CFG_EXIT_TO_DETECT        6'h2A
    `define S_RCVRY_ENTRY               6'h24
    `define S_RCVRY_RECONFIG            6'h25
    `define S_RCVRY_COMPLETE            6'h2F
    `define S_RCVRY_EXIT_TO_DETECT      6'h26
    `define S_L1_ENTRY                  6'h2B
    `define S_L1_EXIT                   6'h2C
    `define S_L2_ENTRY                  6'h2D
    `define S_MPTST                     6'h2E

    // Data Link Layer states
    `define S_DL_INACTIVE               2'b00
    `define S_DL_FC_INIT                2'b01
    `define S_DL_FEATURE                2'b10
    `define S_DL_ACTIVE                 2'b11

    // MPCIE LTSSM Internal main state - 4bit
    `define M_DETECT                    4'h0 // Detect.
    `define M_CFG                       4'h2 // Configuration.
    `define M_RCVRY                     4'h3 // Recovery.
    `define M_L0                        4'h4 // L0.
    `define M_L1                        4'h6 // L1.
    `define M_L2                        4'h7 // L2.
    `define M_DISABLED                  4'h8 // Disabled.
    `define M_LPBKMST                   4'h9 // LoopbackMaster.
    `define M_LPBKSLV                   4'hA // LoopbackSlave.
    `define M_HOT_RESETMST              4'hB // HotReset(Master).
    `define M_HOT_RESETSLV              4'hC // HotReset(Slave).
    `define M_MPTST                     4'hD // MPhyTest.

    // MPCIE LTSSM Internal Sub States - Main: 4bit + Sub: 3bit = 7bit
    `define MS_DETECT_QUIET             {4'h0,3'h0} // Detect.Quiet.
    `define MS_DETECT_ACT               {4'h0,3'h1} // Detect.Active.
    `define MS_CFG_START                {4'h2,3'h0} // Config.Start.
    `define MS_CFG_SOFTWARE             {4'h2,3'h5} // Config.Software.
    `define MS_CFG_UPDATE               {4'h2,3'h1} // Config.Update.
    `define MS_CFG_CONFIRM              {4'h2,3'h2} // Config.Confirm.
    `define MS_CFG_COMPLETE             {4'h2,3'h3} // Config.Complete.
    `define MS_CFG_IDLE                 {4'h2,3'h4} // Config.Idle.
    `define MS_CFG_EXIT_TO_DETECT       {4'h2,3'h7} // Config.ExitToDetect.
    `define MS_RCVRY_ENTRY              {4'h3,3'h0} // Recovery.Entry.
    `define MS_RCVRY_RECONFIG           {4'h3,3'h1} // Recovery.ReConfig.
    `define MS_RCVRY_COMPLETE           {4'h3,3'h2} // Recovery.Complete.
    `define MS_RCVRY_IDLE               {4'h3,3'h3} // Recovery.Idle.
    `define MS_RCVRY_EXIT_TO_DETECT     {4'h3,3'h7} // Recovery.ExitToDetect.
    `define MS_L0                       {4'h4,3'h0} // L0.
    `define MS_L0S                      {4'h4,3'h2} // L0 (TX is in STALL).
    `define MS_L123_SEND_EIDLE          {4'h4,3'h1} // L0 (to L123 EIOS send).
    `define MS_L1_ENTRY                 {4'h6,3'h0} // L1.Entry.
    `define MS_L1_IDLE                  {4'h6,3'h1} // L1.Idle.
    `define MS_L1_EXIT                  {4'h6,3'h2} // L1.Exit.
    `define MS_L2_ENTRY                 {4'h7,3'h0} // L2.Entry.
    `define MS_L2_IDLE                  {4'h7,3'h1} // L2.Idle.
    `define MS_DISABLED_ENTRY           {4'h8,3'h0} // Disabled(Entry).
    `define MS_DISABLED_IDLE            {4'h8,3'h1} // Disabled(Idle).
    `define MS_DISABLED                 {4'h8,3'h2} // Disabled.
    `define MS_LPBKMST_ENTRY            {4'h9,3'h0} // LoopbackMaster.Entry.
    `define MS_LPBKMST_ACTIVE           {4'h9,3'h1} // LoopbackMaster.Active.
    `define MS_LPBKMST_EXIT             {4'h9,3'h2} // LoopbackMaster.Exit.
    `define MS_LPBKSLV_ENTRY            {4'hA,3'h0} // LoopbackSlave.Entry.
    `define MS_LPBKSLV_ACTIVE           {4'hA,3'h1} // LoopbackSlave.Active.
    `define MS_LPBKSLV_EXIT             {4'hA,3'h2} // LoopbackSlave.Exit.
    `define MS_LPBK_EXIT_TIMEOUT                    //
    `define MS_HOT_RESETMST_ENTRY       {4'hB,3'h0} // HotReset(Master Entry).
    `define MS_HOT_RESETMST             {4'hB,3'h1} // HotReset(Maste).
    `define MS_HOT_RESETSLV             {4'hC,3'h1} // HotReset(Slave).
    `define MS_MPTST                    {4'hD,3'h0} // MPhyTest.

    // MPCIE LTSSM Internal Sub2 States - Main: 4bit + Sub: 3bit + Sub2: 3bit = 10bit
    // Detect.Quiet
    `define MSS_DETQUIDIS               {4'h0,3'h0,3'h0} // Wait phystatus deassert and app_ltssm_enable.
    `define MSS_DETQUITH8               {4'h0,3'h0,3'h1} // Wait Thibern8 timer.
    `define MSS_DETQUIH8SLP             {4'h0,3'h0,3'h2} // TX-LANE(0) : HIBERN8 to SLEEP transition.
    // Detect.Active
    `define MSS_DETACTSLP               {4'h0,3'h1,3'h0} // Wait DIF-N on RX-LANE(0).
    `define MSS_DETACTTACT              {4'h0,3'h1,3'h1} // Wait Tactivate timer.
    `define MSS_DETACTENTH8             {4'h0,3'h1,3'h2} // 24ms timeout to Detect.Quiet.
    // Config.Start
    `define MSS_CFSTSLPLB               {4'h2,3'h0,3'h0} // TX-LANE(0) : SLEEP to PWM-BURST transition.
    `define MSS_CFSTRRAP                {4'h2,3'h0,3'h1} // RRAP phase.
    `define MSS_CFSTRRAPDSPTGT          {4'h2,3'h0,3'h4} // Downstream port is RRAP target.
    `define MSS_CFSTENTH8               {4'h2,3'h0,3'h3} // TX-LANE(0) : PWM-BURST to SLEEP/STALL transition. RCT (Enter HIBERN8).
    // `define MSS_CFST2D                  {4'h2,3'h0,3'h7} // 2ms timeout or not receive RRAP, transition to Detect.Quiet.
    // Config.Software
    `define MSS_CFSWRRAP                {4'h2,3'h5,3'h0} // RRAP phase.
    `define MSS_CFSWRRAPDSPTGT          {4'h2,3'h5,3'h3} // Downstream port is RRAP target.
    `define MSS_CFSWENTH8               {4'h2,3'h5,3'h2} // TX-LANE(0) : PWM-BURST to SLEEP/STALL transition. RCT (Enter HIBERN8).
    // Config.Update
    `define MSS_CFUDTTH8                {4'h2,3'h1,3'h0} // Wait Thibern8 timer.
    `define MSS_CFUDTH8STL              {4'h2,3'h1,3'h1} // All configured TX-LANEs : HIBERN8 to STALL transition.
    `define MSS_CFUDTTACT               {4'h2,3'h1,3'h2} // Wait Tactivate timer.
    // Config.Confirm
    `define MSS_CFCFMSTLHB              {4'h2,3'h2,3'h0} // All configured TX-LANEs : STALL to HS-BURST transition.
    `define MSS_CFCFMTS1                {4'h2,3'h2,3'h1} // Transmit TS1 OS.
    // Config.Complete
    `define MSS_CFCMPTS2                {4'h2,3'h3,3'h0} // Transmit TS2 OS.
    // Config.Idle
    `define MSS_CFIDLIDL                {4'h2,3'h4,3'h0} // Transmit Idle symbol.
    // Config.ExitToDetect
    `define MSS_CFE2DEI                 {4'h2,3'h7,3'h0} // Transmit EI OS.
    `define MSS_CFE2DENTH8              {4'h2,3'h7,3'h2} // All configured TX-LANEs : HS-BURST to STALL transition. RCT (Enter HIBERN8).
    // Recovery.Entry
    `define MSS_RECENTTS1BWC0           {4'h3,3'h0,3'h0} // Transmit TS1 OS w/LinkBandWidthChange=0b
    `define MSS_RECENTTS1BWC1           {4'h3,3'h0,3'h1} // Transmit TS1 OS w/LinkBandWidthChange=1b
    `define MSS_RECENTSTLHB             {4'h3,3'h0,3'h2} // All configured TX-LANEs : STALL to HS-BURST transition.
    // Recovery.ReConfig
    `define MSS_RECRCFTS2BWCCF1DSP      {4'h3,3'h1,3'h0} // [For Downstream port] Transmit TS2 OS w/LinkBandwidthChange=1b,LinkBandwidthChangeConfirm=1b.
    `define MSS_RECRCFTS2BWCCF0DSP      {4'h3,3'h1,3'h1} // [For Downstream port] Transmit TS2 OS w/LinkBandwidthChange=1b,LinkBandwidthChangeConfirm=0b.
    `define MSS_RECRCFTS2BWCCF0USP      {4'h3,3'h1,3'h2} // [For Upstream port] Transmit TS2 OS w/LinkBandwidthChange=1b,LinkBandwidthChangeConfirm=0b.
    `define MSS_RECRCFTS2BWCCF1USP      {4'h3,3'h1,3'h3} // [For Upstream port] Transmit TS2 OS w/LinkBandwidthChange=1b,LinkBandwidthChangeConfirm=1b.
    // Recovery.Complete
    `define MSS_RECCMPTS2               {4'h3,3'h2,3'h0} // Transmit TS2 OS.
    // Recovery.Idle
    `define MSS_RECIDLIDL               {4'h3,3'h3,3'h0} // Transmit Idle symbol.
    `define MSS_RECIDLEI                {4'h3,3'h3,3'h1} // Transmit EI OS.
    `define MSS_RECIDLENTH8             {4'h3,3'h3,3'h2} // RCT (Enter HIBERN8).
    `define MSS_RECIDLH8STL             {4'h3,3'h3,3'h3} // HIBERN8 to STALL transition when timeout
    `define MSS_RECIDLSTLHB             {4'h3,3'h3,3'h4} // STALL to HS-BURST transition when timeout
    // Recovery.ExitToDetect
    `define MSS_RECE2DEI                {4'h3,3'h7,3'h0} // Transmit EI OS.
    `define MSS_RECE2DENTH8             {4'h3,3'h7,3'h2} // All configured TX-LANEs : STALL to HS-BURST transition. RCT (Enter HIBERN8).
    // L0
    `define MSS_L0IDL                   {4'h4,3'h0,3'h0} // Normal operation.
    `define MSS_L0L123EIRXWAITDSP       {4'h4,3'h1,3'h0} // Wait RX EIOS or RX STALL on DSP
    `define MSS_L0L123EISEND            {4'h4,3'h1,3'h1} // Transmit EI OS.
    `define MSS_L0L123EIRXWAITUSP       {4'h4,3'h1,3'h2} // Wait RX EIOS or RX STALL on USP
    `define MSS_L0L123EITOB             {4'h4,3'h1,3'h3} // To Recovery.
    `define MSS_L0SEI                   {4'h4,3'h2,3'h0} // Transmit EI OS for TX STALL transition.
    `define MSS_L0STLENT                {4'h4,3'h2,3'h1} // All configured TX-LANEs : HS-BURST to STALL transition.
    `define MSS_L0STLNOCFG              {4'h4,3'h2,3'h5} // Wait STALL No Config Time.
    `define MSS_L0STLIDL                {4'h4,3'h2,3'h2} // All TX-LANEs are in STALL.
    `define MSS_L0STLEXIT               {4'h4,3'h2,3'h3} // All configured TX-LANEs : STALL to HS-BURST transition.
    `define MSS_L0SCOM4SKP              {4'h4,3'h2,3'h4} // Transmit COMx4 + SKP OS.
    // L1
    `define MSS_L1ENTENTH8              {4'h6,3'h0,3'h1} // All configured TX-LANEs : HS-BURST to STALL transition. RCT (Enter HIBERN8).
    `define MSS_L1IDLTH8                {4'h6,3'h1,3'h0} // Wait Thibern8 timer.
    `define MSS_L1IDLIDL                {4'h6,3'h1,3'h1} // Low power state.
    `define MSS_L1EXITH8STL             {4'h6,3'h2,3'h0} // All configured TX-LANEs : HIBERN8 to STALL transition.
    `define MSS_L1EXITTACT              {4'h6,3'h2,3'h1} // Wait Tactivate timer.
    // L2
    `define MSS_L2ENTENTH8              {4'h7,3'h0,3'h1} // All configured TX-LANEs : HS-BURST to STALL transition. RCT (Enter HIBERN8).
    `define MSS_L2IDLDSP                {4'h7,3'h1,3'h1} // Low power state.
    `define MSS_L2IDLUSP                {4'h7,3'h1,3'h2} // Low power state.
    // Disabled
    `define MSS_DISTS1                  {4'h8,3'h0,3'h0} // Transmit TS1 OS w/Disable Link = 1b.
    `define MSS_DISEI                   {4'h8,3'h1,3'h0} // Transmit EI OS.
    `define MSS_DISENTH8                {4'h8,3'h1,3'h2} // All configured TX-LANEs : HS-BURST to STALL transition. RCT (Enter HIBERN8).
    `define MSS_DISTODETDSP             {4'h8,3'h2,3'h0} // Wait Thibern8 timer.
    `define MSS_DISTODETUSP             {4'h8,3'h2,3'h1} // Wait DIF-N.
    // Loopback
    `define MSS_LBKMSTENTTS1            {4'h9,3'h0,3'h0} // Transmit TS1 OS w/Loopback = 1b.
    `define MSS_LBKMSTENTRXSTL          {4'h9,3'h0,3'h1} // Wait DIF-N.
    `define MSS_LBKMSTENTTOB            {4'h9,3'h0,3'h2} // All configured TX-LANEs : HS-BURST to STALL transition.
    `define MSS_LBKMSTENTTSAVECFG       {4'h9,3'h0,3'h3} // Wait LINK_MIN_SAVE_CONFIG_TIME.
    `define MSS_LBKMSTENTSTLHB          {4'h9,3'h0,3'h4} // All configured TX-LANEs : STALL to HS-BURST transition.
    `define MSS_LBKMSTENTTXSKP          {4'h9,3'h0,3'h5} // Transmit COM + SKP OS.
    `define MSS_LBKMSTACT               {4'h9,3'h1,3'h0} // Loopback Master is active.
    `define MSS_LBKMSTEXITEI            {4'h9,3'h2,3'h0} // Transmit EI OS.
    `define MSS_LBKMSTEXITENTH8         {4'h9,3'h2,3'h3} // RCT (Enter HIBERN8).
    `define MSS_LBKSLVENTTS1            {4'hA,3'h0,3'h0} // Transmit TS1 OS w/Loopback = 1b.
    `define MSS_LBKSLVENTTOB            {4'hA,3'h0,3'h1} // All configured TX-LANEs : HS-BURST to STALL transition.
    `define MSS_LBKSLVENTRXCOM          {4'hA,3'h0,3'h2} // Wait COM.
    `define MSS_LBKSLVENTSTLHB          {4'hA,3'h0,3'h3} // All configured TX-LANEs : STALL to HS-BURST transition.
    `define MSS_LBKSLVACT               {4'hA,3'h1,3'h0} // Loopback Slave is active.
    `define MSS_LBKSLVEXITENTH8         {4'hA,3'h2,3'h2} // RCT (Enter HIBERN8).
    // Hot Reset
    `define MSS_HOTMSTENTTS1            {4'hB,3'h0,3'h0} // Transmit TS1 OS w/HotReset=1b.
    `define MSS_HOTMSTHLD               {4'hB,3'h1,3'h0} // Transmit TS1 OS w/HotReset=1b.
    `define MSS_HOTMSTEI                {4'hB,3'h1,3'h1} // Transmit EI OS.
    `define MSS_HOTMSTENTH8             {4'hB,3'h1,3'h3} // All configured TX-LANEs : HS-BURST to STALL transition. RCT (Enter HIBERN8).
    `define MSS_HOTSLVTS1               {4'hC,3'h1,3'h0} // Transmit TS1 OS w/HotReset=1b.
    `define MSS_HOTSLVEI                {4'hC,3'h1,3'h1} // Transmit EI OS.
    `define MSS_HOTSLVENTH8             {4'hC,3'h1,3'h3} // All configured TX-LANEs : HS-BURST to STALL transition. RCT (Enter HIBERN8).
    // MphyTest
    `define MSS_MPTSTIDL                {4'hD,3'h0,3'h0} // MPhyTest mode.
    `define MSS_MPTSTMSTTOB             {4'hD,3'h0,3'h1} // All configured TX-LANEs : HS-BURST to STALL transition.
    `define MSS_MPTSTTACT               {4'hD,3'h0,3'h2} // Wait Tactivate timer.
    `define MSS_MPTSTTLINERST           {4'hD,3'h0,3'h3} // Wait Tlinerst timer.
    `define MSS_MPTSTSLVTOB             {4'hD,3'h0,3'h4} // All configured TX-LANEs : HS-BURST to STALL transition.
    // Enter to Hibern8 state
    `define SSS_IDLE                    3'h0
    `define SSS_RCTRX                   3'h2
    `define SSS_TTXRCTH8                3'h3
    `define SSS_RCTTX                   3'h4
    // Rx L0 STALL state
    `define RS_STALL_NON                2'b00
    `define RS_STALL_ENTRY              2'b01
    `define RS_STALL_IDLE               2'b10

    // PHY TX command
    `define SEND_IDLE                   4'h1
    `define SEND_EIDLE                  4'h2
    `define XMT_IN_EIDLE                4'h3
    `define SEND_RCVR_DETECT_SEQ        4'h5
    `define SEND_TS1                    4'h6
    `define SEND_TS2                    4'h7
    `define COMPLIANCE_PATTERN          4'h8
    `define SEND_SDS                    4'h9
    `define SEND_BEACON                 4'ha
    `define SEND_N_FTS                  4'hb
    `define NORM                        4'hc
    `define SEND_SKP                    4'hd
    `define MOD_COMPL_PATTERN           4'h4
    `define SEND_EIES                   4'he
    `define SEND_EIES_SYM               4'hf

     // Required command for Adapter
    `define RPA_CMD_PHY_INITIAL         3'b000
    `define RPA_CMD_EXIT_H8ALL          3'b001
    `define RPA_CMD_ENTRY_BURST         3'b010
    `define RPA_CMD_EXIT_BURST          3'b011
    `define RPA_CMD_ENTRY_H8RX          3'b100
    `define RPA_CMD_ENTRY_H8TX          3'b101

    // Gen1, 1 UI=0.4ns; Gen2, 1 UI=0.2ns; Gen3, 1 UI=0.125ns, Gen4, 1 UI=0.0625.
    // Convert time values to clock cycle
    // Note there are ALWAYS 20UI per cycle in 2s and 10UI per cycle in 1s for Gen1 rate
    // for Gen2 rate, 20UI vs 1s, 40UI vs 2s, 80 UI vs 4s
    // for 128/130 encoding, 8UI per cycle in 1s (have to consider 8GT/s data rate)
    // so for Gen3, 32UI vs 1s, 64UI vs 2s, 128UI vs 4s
    //
    //  CX_FREQ         |  CX_FREQ_VALUE    |  CX_FREQ_MULTIPLIER | Sness (for Dynamic Width)
    //                  |                   |                     |    Gen1 Gen2 Gen3 Gen4
    //  3 (FREQ_62_5)   |      2            |       4             |     4    8    16   32   (N/A)
    //  2 (FREQ_125)    |      1            |       2             |     2    4    8    16   (N/A to Gen4)
    //  1 (FREQ_250)    |      0            |       1             |     1    2    4    8
    //
    `define     CX_TIME_GEN4_50UI       ((`CX_FREQ_VALUE == 0) ?  3'd1   : (`CX_FREQ_VALUE == 1) ?  3'd1  : 3'd1 )
    `define     CX_TIME_GEN3_50UI       ((`CX_FREQ_VALUE == 0) ?  3'd2   : (`CX_FREQ_VALUE == 1) ?  3'd1  : 3'd1 )
    `define     CX_TIME_GEN2_50UI       ((`CX_FREQ_VALUE == 0) ?  3'd3   : (`CX_FREQ_VALUE == 1) ?  3'd2  : 3'd1 )
    `define     CX_TIME_GEN1_50UI       ((`CX_FREQ_VALUE == 0) ?  3'd7   : (`CX_FREQ_VALUE == 1) ?  3'd4  : 3'd2 )
    `define     CX_XMT_TIME_GEN4_50UI   `CX_TIME_GEN4_50UI
    `define     CX_XMT_TIME_GEN3_50UI   `CX_TIME_GEN3_50UI
    `define     CX_XMT_TIME_GEN2_50UI   `CX_TIME_GEN2_50UI
    `define     CX_XMT_TIME_GEN1_50UI   `CX_TIME_GEN1_50UI

    `define     CX_TIME_GEN2_1280UI     ((`CX_FREQ_VALUE == 0) ?  25'd64   : (`CX_FREQ_VALUE == 1) ?  25'd32   : 25'd16 )
    `define     CX_TIME_GEN1_1280UI     (2'd2  * `CX_TIME_GEN2_1280UI)
    `define     CX_TIME_GEN3_DF_1280UI  ((`CX_FREQ_VALUE == 0) ?  25'd160  : (`CX_FREQ_VALUE == 1) ?  25'd80   : 25'd40 ) // 1280 x 0.125ns = 160ns = 160ns / 1ns(per core_clk) = 160 clocks for `CX_FREQ_VALUE == 0
    `define     CX_TIME_GEN3_1280UI     ((`CX_FREQ_VALUE == 0) ?  25'd40   : (`CX_FREQ_VALUE == 1) ?  25'd20   : 25'd10 )
    `define     CX_TIME_GEN4_1280UI     ((`CX_FREQ_VALUE == 0) ?  25'd20   : (`CX_FREQ_VALUE == 1) ?  25'd10   : 25'd5 )

    `define     CX_TIME_GEN2_2000UI     ((`CX_FREQ_VALUE == 0) ?  25'd100  : (`CX_FREQ_VALUE == 1) ?  25'd50   : 25'd25 )
    `define     CX_TIME_GEN1_2000UI     (2'd2 * `CX_TIME_GEN2_2000UI)
    `define     CX_TIME_GEN3_DF_2000UI  ((`CX_FREQ_VALUE == 0) ?  25'd250  : (`CX_FREQ_VALUE == 1) ?  25'd125  : 25'd63 ) // 2000 x 0.125ns = 250ns = 250ns / 1ns(per core_clk) = 250 clocks for `CX_FREQ_VALUE == 0
    `define     CX_TIME_GEN3_2000UI     ((`CX_FREQ_VALUE == 0) ?  25'd63   : (`CX_FREQ_VALUE == 1) ?  25'd32   : 25'd16 )
    `define     CX_TIME_GEN4_2000UI     ((`CX_FREQ_VALUE == 0) ?  25'd32   : (`CX_FREQ_VALUE == 1) ?  25'd16   : 25'd8 )

    `define     CX_TIME_GEN2_16000UI    (6'd8  * `CX_TIME_GEN2_2000UI)
    `define     CX_TIME_GEN1_16000UI    (6'd8  * `CX_TIME_GEN1_2000UI)
    `define     CX_TIME_GEN3_DF_16000UI ((`CX_FREQ_VALUE == 0) ?  25'd2000 : (`CX_FREQ_VALUE == 1) ?  25'd1000 : 25'd500 ) // 16000 x 0.125 = 2000ns = 2000ns / 1ns(per core_clk) = 2000 clocks for `CX_FREQ_VALUE == 0
    `define     CX_TIME_GEN3_16000UI    ((`CX_FREQ_VALUE == 0) ?  25'd500  : (`CX_FREQ_VALUE == 1) ?  25'd250  : 25'd125 )
    `define     CX_TIME_GEN4_16000UI    ((`CX_FREQ_VALUE == 0) ?  25'd250  : (`CX_FREQ_VALUE == 1) ?  25'd125  : 25'd63 )

    `define     CX_TIME_GEN2_4680UI     ((`CX_FREQ_VALUE == 0) ?  25'd234  : (`CX_FREQ_VALUE == 1) ?  25'd117  : 25'd59 )
    `define     CX_TIME_GEN1_4680UI     ((`CX_FREQ_VALUE == 0) ?  25'd468  : (`CX_FREQ_VALUE == 1) ?  25'd234  : 25'd117 )
    `define     CX_TIME_GEN3_DF_4680UI  ((`CX_FREQ_VALUE == 0) ?  25'd585  : (`CX_FREQ_VALUE == 1) ?  25'd293  : 25'd147 ) // 4680 x 0.125ns = 585ns = 585ns / 1ns(per core_clk) = 585 clocks for `CX_FREQ_VALUE == 0
    `define     CX_TIME_GEN3_4680UI     ((`CX_FREQ_VALUE == 0) ?  25'd147  : (`CX_FREQ_VALUE == 1) ?  25'd74   : 25'd37 )
    `define     CX_TIME_GEN4_4680UI     ((`CX_FREQ_VALUE == 0) ?  25'd74   : (`CX_FREQ_VALUE == 1) ?  25'd37   : 25'd19 )

    `define     CX_TIME_20NS            (4'd8  / `CX_FREQ_MULTIPLIER)        // 8 x 4ns (1s) = 32ns; (8/2) x 8ns (2s) = 32ns; (8/4) x 16ns (4s) = 32ns. don't use 5.
    `define     CX_TIME_40NS            (25'd12 / `CX_FREQ_MULTIPLIER)        // changed from 10 to 12 for CX_FREQ_MULTIPLIER = 4
    `define     CX_TIME_800NS           (25'd20 * `CX_TIME_40NS)

    `define     CX_TIME_1US             (25'h100 / `CX_FREQ_MULTIPLIER)       // TBD: Use binary values (~6% bigger than decimal)
    `define     CX_TIME_6US             (6'd6  * `CX_TIME_1US)
    `define     CX_TIME_128US           (8'd128* `CX_TIME_1US) - 1'b1

    `define     CX_TIME_1MS             (25'h40000 / `CX_FREQ_MULTIPLIER)    // TBD: Use binary values (~6% bigger than decimal)
    `define     CX_TIME_2MS             (6'd2  * `CX_TIME_1MS)
    `define     CX_TIME_3MS             (6'd3  * `CX_TIME_1MS)
    `define     CX_TIME_4MS             (6'd4  * `CX_TIME_1MS)
    `define     CX_TIME_10MS            (6'd10 * `CX_TIME_1MS)
    `define     CX_TIME_12MS            (6'd12 * `CX_TIME_1MS)
    `define     CX_TIME_24MS            (6'd24 * `CX_TIME_1MS)
    `define     CX_TIME_32MS            (6'd32 * `CX_TIME_1MS)
    `define     CX_TIME_48MS            (6'd48 * `CX_TIME_1MS)
    `define     CX_TIME_100MS           (7'd100 * `CX_TIME_1MS)

    // --------------------------------------------------------
    // C-PCIe LTSSM timeouts in fast link mode
    // --------------------------------------------------------
    // Define a short millisecond to speed simulation
    `define     CX_FAST_TIME_1MS        (25'h100 / `CX_FREQ_MULTIPLIER) // ~ 1us      
    `define     CX_FAST_TIME_2MS        (6'd2    * `CX_FAST_TIME_1MS)   // ~ 2us
    `define     CX_FAST_TIME_3MS        (6'd3    * `CX_FAST_TIME_1MS)   // ~ 3us
    `define     CX_FAST_TIME_4MS        (6'd4    * `CX_FAST_TIME_1MS)   // ~ 4us
    `define     CX_FAST_TIME_10MS       (6'd10   * `CX_FAST_TIME_1MS)   // ~ 10us
    `define     CX_FAST_TIME_12MS       (6'd12   * `CX_FAST_TIME_1MS)   // etc.
    `define     CX_FAST_TIME_24MS       (6'd24   * `CX_FAST_TIME_1MS)
    `define     CX_FAST_TIME_48MS       (6'd48   * `CX_FAST_TIME_1MS)
    `define     CX_FAST_TIME_32MS       (6'd32   * `CX_FAST_TIME_1MS)
    `define     CX_FAST_TIME_100MS      (7'd100  * `CX_FAST_TIME_1MS)

    `define     CX_TIME_GEN3_131US      ((`CX_NB == 1) ? 17'h1FFFF  : (`CX_NB == 2) ? 17'hFFFF  : (`CX_NB == 4) ? 17'h7FFF  : 17'h3FFF)
    `define     CX_TIME_GEN3_2MS        ((`CX_NB == 1) ? 25'h1EA000 : (`CX_NB == 2) ? 21'hF5000 : (`CX_NB == 4) ? 21'h7A800 : 21'h3D400)
    `define     CX_FAST_TIME_GEN3_2MS   ((`CX_NB == 1) ? 21'h800    : (`CX_NB == 2) ? 21'h400   : (`CX_NB == 4) ? 21'h200   : 21'h100)
    `define     CX_TIME_GEN3_1US        ((`CX_NB == 1) ? 11'h400    : (`CX_NB == 2) ? 11'h200   : (`CX_NB == 4) ? 11'h100   : 11'h80)
    `define     CX_TIME_GEN3_500NS      ((`CX_NB == 1) ? 10'h28A    : (`CX_NB == 2) ? 10'h145   : (`CX_NB == 4) ? 10'hA2    : 10'h51)

    // TLP VECTOR POSITION
    `define     CX_ECRC_ERR_POS        0
    `define     CX_MALF_ERR_POS        1
    `define     CX_CPL_POIS_ERR_POS    2
    `define     CX_WRREQ_POIS__ERR_POS 3

    // MPCIE
    `define     CM_COUNT_HS_RATEA       40'd8012 // ps
    `define     CM_COUNT_HS_RATEB       40'd6860 // ps
    `define     CM_COUNT_LSG1_3MBPS     20'd3333*`CM_LSG1_NB // ns
    `define     CM_COUNT_LSG1_4MBPS     20'd2500*`CM_LSG1_NB // ns
    `define     CM_COUNT_LSG1_5MBPS     20'd2000*`CM_LSG1_NB // ns
    `define     CM_COUNT_LSG1_6MBPS     20'd1666*`CM_LSG1_NB // ns
    `define     CM_COUNT_LSG1_7MBPS     20'd1428*`CM_LSG1_NB // ns
    `define     CM_COUNT_LSG1_8MBPS     20'd1250*`CM_LSG1_NB // ns
    `define     CM_COUNT_LSG1_9MBPS     20'd1111*`CM_LSG1_NB // ns

    // MPCIE Control I/F
    `define     CM_TX_ATTR               0
    `define     CM_RX_ATTR               1
    `define     CM_CB_ATTR               2

    // Not Fast Timer - 1 = 1 ms
    `define     CM_TIME_2MS_MPCIE        10'd2
    `define     CM_TIME_24MS_MPCIE       10'd24
    `define     CM_TIME_63MS_MPCIE       10'd63
    `define     CM_TIME_200MS_MPCIE      10'd200
    `define     CM_TIME_TLINERST_MPCIE   10'd3

    // Fast Time - 1 = 1 us
    `define     CM_FAST_TIME_2MS_MPCIE       10'd30   //
    `define     CM_FAST_TIME_24MS_MPCIE      10'd1000 //
    `define     CM_FAST_TIME_63MS_MPCIE      10'd1000 //
    `define     CM_FAST_TIME_200MS_MPCIE     10'd1000 //
    `define     CM_FAST_TIME_TLINERST_MPCIE  10'd30   //

    `define     CM_TIME_TXRCT_TO_H8_HS 10'd1
    `define     CM_TIME_TXRCT_TO_H8_LS 10'd400

    // Core S-ness
    `define     CX_1S                   4'b0001
    `define     CX_2S                   4'b0010
    `define     CX_4S                   4'b0100
    `define     CX_8S                   4'b1000

    // Number of symbols (bytes) per clock cycle for datak
    `define     CX_NBK                   (`CX_NB)

    // Assertion and message support
    `define MSGMAX                      300
    `define VECTORMAX                   1024
    `define SEVERITY_FATAL              4'h0
    `define SEVERITY_ERROR              4'h1
    `define SEVERITY_WARN               4'h2
    `define SEVERITY_NOTE               4'h3
    `define SEVERITY_DEBUG              4'h4

    `define CX_N_FLT_MASK               5'd24           // Filter Rule mask size (max: 48)

    `define CX_GEN3_MIN_TLP_LEN         11'h5           // Minimum TLP Length is 5 DW.
                                                        // STP Token  = 1 DW
                                                        // TLP Header = 3 DW (min)
                                                        // LCRC       = 1 DW

    // Token Finder States
    `define TKF_S_IDL                   9'b000000001    // Idle
    `define TKF_S_EDS                   9'b000000010    // End of Data Stream
    `define TKF_S_EDB                   9'b000000100    // End of Bad TLP
    `define TKF_S_DDP                   9'b000001000    // Data DLLP
    `define TKF_S_END                   9'b000010000    // End of TLP
    `define TKF_S_SDP                   9'b000100000    // Start DLLP
    `define TKF_S_STP                   9'b001000000    // Start TLP
    `define TKF_S_DTP                   9'b010000000    // Data TLP
    `define TKF_S_aEDB                  9'b100000000    // Anticipated End of TLP
    `define TKF_S_NDV                   9'b000000000    // No data valid

    // one hot encoding bit positions
    `define TKF_S_IDL_BIT               0
    `define TKF_S_EDS_BIT               1
    `define TKF_S_EDB_BIT               2
    `define TKF_S_DDP_BIT               3
    `define TKF_S_END_BIT               4
    `define TKF_S_SDP_BIT               5
    `define TKF_S_STP_BIT               6
    `define TKF_S_DTP_BIT               7
    `define TKF_S_aEDB_BIT              8

    `ifndef SYNTHESIS
    `define CX_SIM                      1               // Enable Simulation services

    // Debugging support

    `define CX_STDIN                    0
    `define CX_STDOUT                   1
    `define CX_STDERR                   2

    `define CX_DEBUG_LEVEL              9               // Debug verbosity 0-9 (9 is most verbose)
    `define CX_DEBUG_FILE               "stdout"        // Control what file debug is printed to

    `define CX_ASSERT                                   // Control assertions
    `define CX_ASSERT_LEVEL             9               // Control what assertions are printed (0-9)
    `define CX_ASSERT_FILE              "stdout"        // Control what file assertions are printed to

    `define CX_COVER_LEVEL              9               // Control what coverage results are printed (0-9)
    `define CX_COVER_FILE               "stdout"        // Control what file results are printed to

    `define CX_MONITOR_LEVEL            9               // Control what monitors are active (0-9)
    `define CX_MONITOR_FILE             "stdout"        // Control what file monitors are printed to

    `endif // SYNTHESIS

    // -------------------------------------------------
    // Beneath are the parameters used to allow customer to program a FC watch dog timer expiration value.
    // This is a prescaled timer. the minimum base timer is 8 us.
    // so default is set to 30*8us = 240us +, - 8 us. The spec. limit is 200 us (-0%, +50%).

    `define CX_SCALED_WDOG_TIMER_EXP_VALUE  5'b11110   // scaled watch dog timer expiration value
    `define CX_SCALED_WDOG_TIMER_PTR_WD     5          // scaled watch dog timer pointer width defined in cxpl_defs.vh
    // -------------------------------------------------

   `define CX_RADM_DIAG_STATUS_BUS_WD   ((`CX_NHQ*(17 + (`CX_NW *32) + `CX_NW + 128)) + ((`CX_NHQ == 2) ? 1 : 0))
   `define CX_XADM_DIAG_STATUS_BUS_WD   (((`CX_NCLIENTS + 2) * 3) + ((`CX_NCLIENTS + 2) * `CX_NVC))
   `define CX_CDM_DIAG_STATUS_BUS_WD    (3 + 32 + 32 +`CX_NFUNC +4 + `CX_NFUNC + (9*`CX_NFUNC) + `CX_NVC + 9 + `CX_DEVNUM_WD + `CX_BUSNUM_WD)
   `define CX_PM_DIAG_STATUS_BUS_WD     (`CX_NVC + `CX_NVC + 4 + 3)
   `define CX_RTLH_DIAG_STATUS_BUS_WD   15 * ( (`CX_NW == 16) ? 4 : (`CX_NW == 8) ? 2 : 1 )
   `define CX_CXPL_DIAG_STATUS_BUS_WD 1 + 1 + 1 + 1 + 1 + 1 \
                                    + 1 + 1 + 2 + 1 + `CX_NL + `CX_NW \
                                    + `CX_NW + `CX_NW + `CX_NW + `CX_NW + 1 + `CX_NW + (32*`CX_NW) \
                                    + `CX_NW + `CX_NW + 1 \
                                    + 1 + 1 + 1 \
                                    + 1 + 1 + 12 + 1 \
                                    + 1 + 1 + 12 \
                                    + `CX_NW + `CX_NW + `CX_NW + `TRGT_DATA_PROT_WD+(32*`CX_NW) + 1 + 1 + 1 \
                                    + ( (`CX_NW > 2) ? `CX_NW : 1) + ( (`CX_NW > 2) ? `CX_NW : 1) + ( (`CX_NW > 2) ? `CX_NW : 1) \
                                    + (32*`CX_NW) + 1 + `CX_RTLH_DIAG_STATUS_BUS_WD
    //   rmlh_inskip_rcv, rmlh_ts_rcv_err, rmlh_ts1_rcvd, rmlh_ts2_rcvd, rmlh_ts_lane_num_is_k237, rmlh_deskew_alignment_err,
    // + rmlh_ts_link_num_is_k237, rmlh_rcvd_lane_rev, rmlh_rcvd_idle, rmlh_rcvd_eidle_set, rmlh_lanes_rcving, rmlh_rdlh_nak,
    // + rmlh_rdlh_dllp_start, rmlh_rdlh_tlp_start, rmlh_rdlh_pkt_end, rmlh_rdlh_pkt_edb, rmlh_rdlh_pkt_dv, rmlh_rdlh_pkt_err,rmlh_rdlh_pkt_data
    // + rdlh_rtlh_tlp_sot, rdlh_rtlh_tlp_eot, rdlh_rtlh_tlp_dv,
    // + xdlh_xmlh_start_link_retrain, rtlh_req_link_retrain, cfg_link_retrain,
    // + rdlh_xdlh_rcvd_nack, rdlh_xdlh_rcvd_ack, rdlh_xdlh_rcvd_acknack_seqnum, rdlh_xdlh_req2send_ack,
    // + rdlh_xdlh_req2send_ack_due2dup, rdlh_xdlh_req2send_nack, rdlh_xdlh_req_acknack_seqnum,
    // + xdlh_xmlh_eot, xdlh_xmlh_stp, xdlh_xmlh_sdp, xdlh_xmlh_data, xmlh_xdlh_halt, lcrc_err_asserted, ecrc_err_asserted,
    // + xtlh_xdlh_sot, xtlh_xdlh_eot, xtlh_xdlh_badeot,
    // + xtlh_xdlh_data, xdlh_xtlh_halt, rtlh_diag_status

    //
    //
    //
    //**********************************
    // IMPORTANT PLEASE READ THIS NOTE
    //**********************************
    //
    //
    // IF you change anything that changes CX_DIAG_STATUS_BUS_WD then ........
    //
    // The description for diag_status_bus MUST be updated in pkg_script/cC_plugin/DatabookToolBox.tcl
    //
    // This description is a LIVE description. Any omissions will impact the live IP-XACT code.
    // 


   `define CX_DIAG_STATUS_BUS_WD   (`CX_RADM_DIAG_STATUS_BUS_WD + `CX_XADM_DIAG_STATUS_BUS_WD + `CX_CDM_DIAG_STATUS_BUS_WD + `CX_PM_DIAG_STATUS_BUS_WD + `CX_CXPL_DIAG_STATUS_BUS_WD)




   `define CX_CXPL_DIAG_CONTROL_BUS_WD  2  // 1 for ECRC, 1 for LCRC
   `define CX_DIAG_CONTROL_BUS_WD       (`CX_CXPL_DIAG_CONTROL_BUS_WD + 1)  // 1 for fast link mode


    //
    // number of bits to create a variable in range 0..n-1
    //
    //  n            | `CX_LOGBASE2(n)
    // --------------|-----------------------------------------------
    //  1..2         | 1
    //  3..4         | 2
    //  5..8         | 3
    //  9..16        | 4
    //  17..32       | 5
    //  33..64       | 6
    //  65..128      | 7
    //  129..256     | 8
    //  257..512     | 9
    //  513..1024    | 10
    //  1025..2048   | 11
    //  2049..4096   | 12
    //  4097..8192   | 13
    //  8193..16384  | 14
    //  16385..32768 | 15
    //  32769...     | 16
    //
    `define CX_LOGBASE2(n) (((n)>32768) ? 16 : (((n)>16384) ? 15 : (((n)>8192) ? 14 : (((n)>4096) ? 13 : (((n)>2048) ? 12 : (((n)>1024) ? 11 : (((n)>512) ? 10 : (((n)>256) ? 9 : (((n)>128) ? 8 : (((n)>64) ? 7 : (((n)>32) ? 6 : (((n)>16) ? 5 : (((n)>8) ? 4 : (((n)>4) ? 3 : (((n)>2) ? 2 : (((n)>1) ? 1 : 1))))))))))))))))

   // rmlh_pkt_finder Range Defines
   // Upper DWORD of Datapath consists of
   // 1s = 4 bytes = {`BYTE3, `BYTE2, `BYTE1, `BYTE0}
   // 2s = 2 words = {`WORD1, `WORD0}
   `define BYTE3 DW_MAX - 1  : DW_MAX - 8
   `define BYTE2 DW_MAX - 9  : DW_MAX - 16
   `define BYTE1 DW_MAX - 17 : DW_MAX - 24
   `define BYTE0 DW_MAX - 25 : DW_MAX - 32
   `define WORD1 DW_MAX - 1  : DW_MAX - 16
   `define WORD0 DW_MAX - 17 : DW_MAX - 32
   `define CX_PL_GEN3_CONTROL_WD        10  // number of bits in the control bus coming out of the Port Logic Gen3 Control Register
   `define CX_PL_GEN3_EQ_CONTROL_WD     25 // number of bits in the control bus coming out of the Port Logic Gen3 EQ Control Register
   `define CX_PL_GEN4_CONTROL_WD        5  // number of bits in the control bus coming out of the Port Logic Gen3 Control Register
   `define CX_PL_GEN4_EQ_CONTROL_WD     25 // number of bits in the control bus coming out of the Port Logic Gen4 EQ Control Register
   `define CX_DIR_CHANGE_CONTROL_WD     18 // number of bits in the control bus coming out of the Port Logic Gen3 Direction Change Control Register
   `define CX_GEN4_DIR_CHANGE_CONTROL_WD 18 // number of bits in the control bus coming out of the Port Logic Gen4 Direction Change Control Register
   `define CX_PL_MULTILANE_CONTROL_WD   8  // number of bits in the control bus coming out of the Multi Lane Control Register
   `define CX_L1SUB_CONTROL_WD          22 // number of bits in the control bus coming out of the L1 Substates Ext Capability Register
   `define CX_L1SUB_CONTROL_T_COMM_MODE_RANGE   21:14 // t_common_mode bit field
   `define CX_L1SUB_CONTROL_TRGT_L1SUB_RANGE    13:12 // target L1 substate bit field
   `define CX_L1SUB_CONTROL_T_POWER_ON_RANGE    11:0 // t_power_on range
   `define CX_PL_L1SUB_CONTROL_WD       8 // number of bits in the control bus coming out of the L1 Substates Register in Port Logic
   `define CX_PL_AUX_CLK_FREQ_WD        10
   `define CX_INFO_EI_WD                16
   `define CX_PASID_CONTROL_WD           3 // number of bits in the control bus coming out of the L1 Substates Ext Capability Register
   `define CX_TS_FIELD_CONTROL_WD       56 // number of bits in the control bus coming out of the TS field, {sym7,6,5,4,3,2,1}

   // macros used to select the appropriate operation mode in the various instances of the lcrc block
   `define CX_RDLH 0
   `define CX_RTLH 1
   `define CX_XTLH 2
   `define CX_XDLH 3

    `define ECC_ZERO_VALUE 0

// temporary settings below are needed to restore formal equivalence after partial integ from 512b branch
    // form eq settings required by rmlh

    // form eq settings required by rdlh

    // form eq settings required by rtlh

    // form eq settings required by xtlh

    // form eq settings required by xdlh
        `define LCRC_FORMAL_EQUIVALENCE_1
    // needed for all datapath widths because 128b module is always compiled
    `define XDLH_TLP_GEN_128B_FORMAL_EQUIVALENCE_0 // datasize logic
        `define XDLH_CONTROL_128B_FORMAL_EQUIVALENCE_0 // pad logic for 128b was rewritten using 256b code



