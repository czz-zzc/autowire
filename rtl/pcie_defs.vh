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
// ---    $DateTime: 2016/07/13 03:21:31 $
// ---    $Revision: #82 $
// ---    $Id: //dwh/pcie_iip/main/fairbanks/design/include/pcie_defs.vh#82 $
// -------------------------------------------------------------------------
// --- Module Description:
// -----------------------------------------------------------------------------
// ---
// --- This is the global definitions file for the Synopsys PCI-E core.
// ---
// ----------------------------------------------------------------------------


`define PCIE_DEFS

//------------------------------------------------------------------------------
// --- MACRO Definitions
//------------------------------------------------------------------------------

`define MRD32                       7'b0000000  // Memory Read Request 32b
`define MRD64                       7'b0100000  // Memory Read Request 64b
`define MRDLK32                     7'b0000001  // Memory Read Request-Locked 32b
`define MRDLK64                     7'b0100001  // Memory Read Request-Locked 64b
`define MWR32                       7'b1000000  // Memory Write Request 32b
`define MWR64                       7'b1100000  // Memory Write Request 64b
`define IORD                        7'b0000010  // IO Read Request
`define IOWR                        7'b1000010  // IO Write Request
`define CFGRD0                      7'b0000100  // Configuration Read Type 0
`define CFGWR0                      7'b1000100  // Configuration Write Type 0
`define CFGRD1                      7'b0000101  // Configuration Read Type 1
`define CFGWR1                      7'b1000101  // Configuration Write Type 1
`define MSG                         7'b0110???  // Message Request:r[2:0] specifies message routing mechanism
`define MSGD                        7'b1110???  // Message Request
`define MSGAS                       7'b0111???  // Message for Advanced Switching
`define MSGASD                      7'b1111???  // Message for Advanced Switching
`define CPL                         7'b0001010  // Completion without Data
`define CPLD                        7'b1001010  // Completion with Data
`define CPLLK                       7'b0001011  // Completion for Locked Memory Read
`define CPLDLK                      7'b1001011  // Completion for Locked Memory Read
`define FETCHADD32                  7'b1001100  // Atomic FetchAdd request 32b
`define FETCHADD64                  7'b1101100  // Atomic FetchAdd request 64b
`define SWAP32                      7'b1001101  // Atomic Swap request 32b
`define SWAP64                      7'b1101101  // Atomic Swap request 64b
`define CAS32                       7'b1001110  // Atomic Compare and Swap request 32b
`define CAS64                       7'b1101110  // Atomic Compare and Swap request 64b
`define MSG_4                       4'b0110
`define MSGD_4                      4'b1110
`define MSG_AS_4                    4'b0111
`define MSGD_AS_4                   4'b1111

`define FT_MRD                      5'b00000  // Memory Read Request
`define FT_MRDLK                    5'b00001  // Memory Read Request-Locked
`define FT_CPL                      5'b01010  // Completion
`define FT_CPLLK                    5'b01011  // Completion Locked

`define DC_FMT_WD                   2
`define DC_TYPE_WD                  5
`define DC_TC_WD                    3
`define DC_TAG_WD                   8
`define DC_CPL_BYTE_CNT_WD          12
`define DC_CPL_AT_WD                2
`define DC_CPL_ADDR_WD              64
`define DC_CPL_CMPLTR_ID_WD         16
`define DC_CPL_BYTE_EN_WD           8

//==============================================================================
// --- DLLP Encodings
`define ACK                         8'b00000000
`define NAK                         8'b00010000
`define DATA_LINK_FEATURE           8'b00000010
`define PM_ENTER_L1                 8'b00100000
`define PM_ENTER_L23                8'b00100001
`define PM_AS_REQ_L0                8'b00100010
`define PM_AS_REQ_L1                8'b00100011
`define PM_REQ_ACK                  8'b00100100
`define INITFC1_P                   5'b01000
`define INITFC1_NP                  5'b01010
`define INITFC1_CPL                 5'b01100
`define INITFC2_P                   5'b11000
`define INITFC2_NP                  5'b11010
`define INITFC2_CPL                 5'b11100
`define UPDFC_P                     5'b10000
`define UPDFC_NP                    5'b10010
`define UPDFC_CPL                   5'b10100
// Defines for MR-IOV
// Synopsys does not currently support these
// However they need to be recognised to avoid deadlock scenarios; 
// e.g. when Data Link Feature is enabled - we need to abort DL Feature if an MR-IOV is received
`define MRIOV_MRINIT                8'b00000001
`define MRIOV_MRINITFC1             5'b01110
`define MRIOV_MRINITFC2             5'b11110
`define MRIOV_MRUPDATEFC            5'b10110

// Defines for Max_Payload_Size encoding
`define DC_MAX_PYLD_SIZE_ENC_WD 3
`define DC_MAX_PYLD_SIZE_128_BYTES_ENC   3'b000
`define DC_MAX_PYLD_SIZE_256_BYTES_ENC   3'b001
`define DC_MAX_PYLD_SIZE_512_BYTES_ENC   3'b010
`define DC_MAX_PYLD_SIZE_1024_BYTES_ENC  3'b011
`define DC_MAX_PYLD_SIZE_2048_BYTES_ENC  3'b100
`define DC_MAX_PYLD_SIZE_4096_BYTES_ENC  3'b101

// Defines used for flow control initialization
`define P_TYPE                      2'b00
`define NP_TYPE                     2'b01
`define CPL_TYPE                    2'b10

// PHY layer SYMBOL
`define  COMMA_8B                   8'hBC
`define  SKIP_8B                    8'h1C
`define  EIDLE_8B                   8'h7C
`define  K237_8B                    8'hF7
`define  K287_8B                    8'hFC
`define  D215_8B                    8'hB5
`define  D102_8B                    8'h4A
`define  FTS_8B                     8'h3C
`define  D102_8B                    8'h4A
`define  D215_8B                    8'hB5
`define  TS1_8B                     8'h4A
`define  TS2_8B                     8'h45
`define  PAD_8B                     8'hF7
`define  SDP_8B                     8'h5C
`define  STP_8B                     8'hFB
`define  EDB_8B                     8'hFE
`define  END_8B                     8'hFD
// temp value
`define  INV_TS1_8B                 8'hB5
`define  INV_TS2_8B                 8'hBA
`define  S_TS1_8B                   8'hF5
`define  S_N_TS1_8B                 8'h0A

`define  SKIP_10B_NEG               10'b0010_111100     // K28.0(-)
`define  SKIP_10B_POS               10'b1101_000011     // K28.0(+)
`define  COMMA_10B_NEG              10'b0101_111100     // K28.5(-)
`define  COMMA_10B_POS              10'b1010_000011     // K28.5(+)

// MSG TLP codes
`define ASSERT_INTA                 8'b00100000
`define ASSERT_INTB                 8'b00100001
`define ASSERT_INTC                 8'b00100010
`define ASSERT_INTD                 8'b00100011
`define DEASSERT_INTA               8'b00100100
`define DEASSERT_INTB               8'b00100101
`define DEASSERT_INTC               8'b00100110
`define DEASSERT_INTD               8'b00100111
`define LTR_MSG_CODE                8'b00010000
`define PM_ACTIVE_STATE_NAK         8'b00010100
`define PM_PME                      8'b00011000
`define PME_TURN_OFF                8'b00011001
`define PME_TO_ACK                  8'b00011011
`define OBFF                        8'b00010010
`define ERR_COR                     8'b00110000
`define ERR_NF                      8'b00110001
`define ERR_F                       8'b00110011
`define UNLOCK                      8'b00000000
`define SET_SLOT_PWR_LIMIT          8'b01010000
`define ATTENTION_INDICATOR_ON      8'b01000001
`define ATTENTION_INDICATOR_BLINK   8'b01000011
`define ATTENTION_INDICATOR_OFF     8'b01000000
`define POWER_INDICATOR_ON          8'b01000101
`define POWER_INDICATOR_BLINK       8'b01000111
`define POWER_INDICATOR_OFF         8'b01000100
`define ATTENTION_BUTTON_PRESSED    8'b01001000
`define LATENCY_TOLERANCE_REPORTING 8'b00010000
`define INVALIDATE_REQUEST          8'b00000001
`define INVALIDATE_COMPLETION       8'b00000010
`define VENDOR_TYPE0                8'b01111110
`define VENDOR_TYPE1                8'b01111111
`define FRS_TYPE                    5'b10000
`define DRS_TYPE                    5'b10100
`define FRS_TC                      3'b000
`define DRS_TC                      3'b000
`define LN_TC                       3'b000
`define PTM_TC                      3'b000
`define PCISIG_ID                   16'h0001
`define FRS_SUBTYPE                 8'b00001001
`define DRS_SUBTYPE                 8'b00001000
`define LN_SUBTYPE                  8'b00000000
`define PTM_REQ_TYPE                8'b01010010
`define PTM_RES_TYPE                8'b01010011

`define PRS_REQ_TYPE                8'b00000100
`define PRG_RES_TYPE                8'b00000101

// Device Types
`define PCIE_EP                     4'b0000
`define PCIE_EP_LEGACY              4'b0001
`define PCIE_RC                     4'b0100
`define PCIE_SW_UP                  4'b0101
`define PCIE_SW_DOWN                4'b0110
`define PCIE_PCIX                   4'b0111
`define PCIX_PCIE                   4'b1000

// Completion Status
`define DC_CPL_STATUS_WD 3                           // Completion status field width
`define SU_CPL_STATUS               3'b000
`define CA_CPL_STATUS               3'b100
`define CRS_CPL_STATUS              3'b010
`define UR_CPL_STATUS               3'b001

// Credit Widths
`define HDR_CD                      8
`define DATA_CD                     12

// Timeout values
`define PME_TIMEOUT_IDX             25  // 2^25 symbol times = Approximately 134 ms
`define CPL_TIMEOUT_IDX             18  // 2^18 symbol times = Approximately 1 ms

// PHY Power States
`define P0                          2'b00
`define P0S                         2'b01
`define P1                          2'b10
`define P2                          2'b11
`define PH8ALL                      2'b10
`define PH8RX                       2'b11

// Data Rates
`define GEN1_RATE                   2'b00  // Gen1 = 2.5 GT/s
`define GEN2_RATE                   2'b01  // Gen2 = 5.0 GT/s
`define GEN3_RATE                   2'b10  // Gen3 = 8.0 GT/s
`define GEN4_RATE                   2'b11  // Gen4 = 16.0 GT/s

`define GEAR1_RATE                  2'b00  // HS-Gear1 = 1248 MT/s(Rate-A) , 1457.6 MT/s(Rate-B)
`define GEAR2_RATE                  2'b01  // HS-Gear2 = 2496 MT/s(Rate-A) , 2915.2 MT/s(Rate-B)
`define GEAR3_RATE                  2'b10  // HS-Gear3 = 4992 MT/s(Rate-A) , 5830.4 MT/s(Rate-B)

// Link Speed
`define GEN1_LINK_SP                4'b0001
`define GEN2_LINK_SP                4'b0010
`define GEN3_LINK_SP                4'b0011
`define GEN4_LINK_SP                4'b0100

`define GEAR1_2_LINK_SP             4'b0001
`define GEAR3_LINK_SP               4'b0010

`define RATEA_SERIES                2'b01
`define RATEB_SERIES                2'b10

// Mac Mode
`define PHY_TYPE_CPCIE              1'b0
`define PHY_TYPE_MPCIE              1'b1

//==============================================================================
// Gen3 defines

// Sync header
`define SYNC_INV0_BLOCK 2'b00
`define SYNC_OS_BLOCK   2'b01
`define SYNC_DATA_BLOCK 2'b10
`define SYNC_INV3_BLOCK 2'b11
`define BASYNC_OS_BLOCK   2'b01
`define BASYNC_DATA_BLOCK 2'b10

// Static Gen3 Tokens
`define LIDLE_TOKEN 8'h0
// SDP 2 Bytes
`define SDP_TOKEN_0 8'hf0
`define SDP_TOKEN_1 8'hac
// EDS 1DW
`define EDS_TOKEN_0 8'h1f
`define EDS_TOKEN_1 8'h80
`define EDS_TOKEN_2 8'h90
`define EDS_TOKEN_3 8'h00
// EDB 1 DW
`define EDB_TOKEN_0 8'hc0
`define EDB_TOKEN_1 8'hc0
`define EDB_TOKEN_2 8'hc0
`define EDB_TOKEN_3 8'hc0

// 128b/130b Framing Symbols
`define STP_4B  4'hf
`define EDS_32B 32'h0090801f
`define EDB_32B 32'hc0c0c0c0
`define SDP_16B 16'hacf0
`define IDL_32B 32'h00000000

// OS SYMBOL 0 used to identify the Ordered Set
`define TS1_SYM_0    8'h1e
`define TS2_SYM_0    8'h2d
`define FTS_SYM_0    8'h55
`define EIOS_SYM_0   8'h66
`define EIEOS_SYM_0  8'h00
`define EIEOS_SYM_1  8'hff
`define SDS_SYM_0    8'he1
`define SDS_SYM_1    8'h55
`define SKP_SYM_0    8'haa
`define SKP_END_SYM  8'he1
`define SKP_END_CTL_SYM  8'h78

// Equalization
`define DEFAULT_EQ_PSET 4'b0100 // P4

// ---------------- AMBA register constants -------------------

//Enable the AMBA order manager watchdog register enable default value
`define DC_AMBA_ORDRMGR_WDOG_EN 1
//Sets the AMBA order manager watchdog initial value. The timer granularity is 2 us.
`define DC_AMBA_ORDRMGR_WDOG 4095
`define DC_AMBA_ORDRMGR_WDOG_DEFAULT 16'd4095

// ---------------- RAS Interface -----------------------------
`define AXI_IN_RQ_NR_COUNTERS 16
`define AXI_IN_CPL_NR_COUNTERS 8
`define AXI_OUT_RQ_NR_COUNTERS 23
`define AXI_OUT_CPL_NR_COUNTERS 5
`define DMA_OUTBOUND_COUNTERS 6
`define DMA_INBOUND_COUNTERS 11

`define RASDP_BRIDGE_RAM1_PULSE_INDEX 3
`define RASDP_BRIDGE_RAM2_PULSE_INDEX 4
`define RASDP_BRIDGE_RAM3_PULSE_INDEX 24
`define RASDP_BRIDGE_RAM4_PULSE_INDEX 25
`define RASDP_BRIDGE_RAM5_PULSE_INDEX 26
`define RASDP_BRIDGE_RAM6_PULSE_INDEX 35
`define RASDP_BRIDGE_RAM7_PULSE_INDEX 27
`define RASDP_BRIDGE_RAM8_PULSE_INDEX 33
`define RASDP_BRIDGE_RAM9_PULSE_INDEX 34
`define RASDP_BRIDGE_RAM10_PULSE_INDEX 49
`define RASDP_BRIDGE_RAM11_PULSE_INDEX 50
`define RASDP_BRIDGE_RAM12_PULSE_INDEX 51
`define RASDP_DMA_RAM13_PULSE_INDEX 67
`define RASDP_DMA_RAM14_PULSE_INDEX 68


 //==============================================================================


