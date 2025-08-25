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
// ---    $DateTime: 2016/02/18 14:50:28 $
// ---    $Revision: #115 $
// ---    $Id: //dwh/pcie_iip/main/fairbanks/design/include/adm_defs.vh#115 $
// -------------------------------------------------------------------------
// --- Module Description:
// ---
// --- This file contains ADM implementation-specific defines
// ---
// -----------------------------------------------------------------------------

//
// This file assumes cxpl_defs.vh has been included
//
 `define ADM_DEFS
// Recieve queue sizing

// FC Update Factor from the Spec. NOTE: These are based on MAX link width and MAX MTU
 `define PCIE_FC_UPD_FACTOR       ((NL == 32) ? ((`CX_MAX_MTU < 512) ? 30 : 20 ) :  (NL == 16) ? ((`CX_MAX_MTU < 512) ? 30 : 20 ) :  (NL == 12) ? ((`CX_MAX_MTU < 512) ? 30 : 20 ) :  (NL ==  8) ? ((`CX_MAX_MTU < 512) ? 25 : 10 ) :  (NL ==  4) ? ((`CX_MAX_MTU < 512) ? 14 : 10 ) :  (NL ==  2) ? ((`CX_MAX_MTU < 512) ? 14 : 10 ) :  (NL ==  1) ? ((`CX_MAX_MTU < 512) ? 14 : 10 ) :  -1 )


// Calculate latency in symbol times for doing an update (our queue depth needs to be deep enough to handle it)
// Here the user can adjust the effective internal delay to increase the depth (unis are symbol times)
 `define CX_FC_LATENCY_LIMIT    ((`CX_RADM_MAXPKT  * `PCIE_FC_UPD_FACTOR/10)/NL + `CX_INTERNAL_DELAY)

// HDR MAP                                             | MEM/IO | CFG | MSG | CPL |
 `define HDR_DW1_FMT_RANGE              6:5   // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_TYPE_RANGE             4:0   // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_TC_RANGE              14:12  // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_TD_RANGE              23:23  // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_EP_RANGE              22:22  // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_ATTR_RANGE            21:20  // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_LN_RANGE               9:9   // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_DW_LENGTH_MSB_RANGE   17:16  // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW1_DW_LENGTH_LSB_RANGE   31:24  // HDR:  |   X    |  X  |  X  |  X  |
 `define HDR_DW2_REQID_RANGE           15:0   // HDR:  |   X    |  X  |  X  |     |
 // `define HDR_DW2_TAG_RANGE             23:16  // HDR:  |   X    |  X  |  X  |     |
 `define HDR_DW2_LSTDW_BE_RANGE        31:28  // HDR:  |   X    |  X  |     |     |
 `define HDR_DW2_FRSTDW_BE_RANGE       27:24  // HDR:  |   X    |  X  |     |     |
 `define HDR_DW3_ADDR_BYTE0_RANGE      31:24  // HDR:  |   X    |     |     |     |
 `define HDR_DW3_ADDR_BYTE1_RANGE      23:16  // HDR:  |   X    |     |     |     |
 `define HDR_DW3_ADDR_BYTE2_RANGE      15:8   // HDR:  |   X    |     |     |     |
 `define HDR_DW3_ADDR_BYTE3_RANGE       7:0   // HDR:  |   X    |     |     |     |
 `define HDR_DW4_ADDR_BYTE0_RANGE      31:24  // HDR:  |   X    |     |     |     |
 `define HDR_DW4_ADDR_BYTE1_RANGE      23:16  // HDR:  |   X    |     |     |     |
 `define HDR_DW4_ADDR_BYTE2_RANGE      15:8   // HDR:  |   X    |     |     |     |
 `define HDR_DW4_ADDR_BYTE3_RANGE       7:0   // HDR:  |   X    |     |     |     |
 `define HDR_DW2_CMPLTR_ID_MSB_RANGE    7:0   // HDR:  |        |     |     |  X  |
 `define HDR_DW2_CMPLTR_ID_LSB_RANGE   15:8   // HDR:  |        |     |     |  X  |
 `define HDR_DW2_CPL_STATUS_RANGE      21:23  // HDR:  |        |     |     |  X  |
 `define HDR_DW2_BCM_RANGE             20:20  // HDR:  |        |     |     |  X  |
 `define HDR_DW2_BYTE_CNT_MSB_RANGE    19:16  // HDR:  |        |     |     |  X  |
 `define HDR_DW2_BYTE_CNT_LSB_RANGE    31:24  // HDR:  |        |     |     |  X  |
 `define HDR_DW3_CPL_REQID_RANGE       15:0   // HDR:  |        |     |     |  X  |
 // `define HDR_DW3_CPL_TAG_RANGE         23:16  // HDR:  |        |     |     |  X  |
 `define HDR_DW3_CPL_LOWER_ADDR_RANGE  30:24  // HDR:  |        |     |     |  X  |
 `define HDR_DW2_MSG_CODE_RANGE        31:24  // HDR:  |        |     |  X  |     |
 `define HDR_DW3_BUS_NMBR_RANGE         7:0   // HDR:  |        |  X  |     |     |
 `define HDR_DW3_DEV_NMBR_RANGE        15:11  // HDR:  |        |  X  |     |     |
 `define HDR_DW3_FUNC_NMBR_RANGE       10:8   // HDR:  |        |  X  |     |     |
 `define HDR_DW3_EXT_REG_NMBR_RANGE    19:16  // HDR:  |        |  X  |     |     |
 `define HDR_DW3_REG_NMBR_RANGE        31:26  // HDR:  |        |  X  |     |     |


 `define FLT_VALID_NP_TYPE             3'b000  // ENCODED VALID type
 `define FLT_VALID_P_TYPE              3'b001
 `define FLT_VALID_UR_NP_TYPE          3'b010
 `define FLT_VALID_UR_P_TYPE           3'b011

 `define FLT_DESTINATION_TRASH         2'b00  // ENCODED VALID type
 `define FLT_DESTINATION_TRGT0         2'b01
 `define FLT_DESTINATION_TRGT1         2'b10
 `define FLT_DESTINATION_CPL           2'b11

 `define XADM_CPL_GRANT                0
 `define XADM_MSG_GRANT                1
 `define XADM_CLIENT0_GRANT            2
 `define XADM_CLIENT1_GRANT            3
 `define XADM_CLIENT2_GRANT            4
 `define RADM_OUTSIDE_MEMBAR          3'b111   // encoding for MEMBAR

`define FLT_Q_DESTINATION_FO       0
`define FLT_Q_FMT_FO              `FLT_Q_DESTINATION_FO         +    `FLT_Q_DESTINATION_WIDTH
`define FLT_Q_TYPE_FO             `FLT_Q_FMT_FO                 +    `FLT_Q_FMT_WIDTH
`define FLT_Q_TC_FO               `FLT_Q_TYPE_FO                +    `FLT_Q_TYPE_WIDTH
`define FLT_Q_ATTR_FO             `FLT_Q_TC_FO                  +    `FLT_Q_TC_WIDTH
`define FLT_Q_LN_FO               `FLT_Q_ATTR_FO                +    `FLT_Q_ATTR_WIDTH
`define FLT_Q_REQID_FO            `FLT_Q_LN_FO                  +    `FLT_Q_LN_WIDTH
`define FLT_Q_TAG_FO              `FLT_Q_REQID_FO               +    `FLT_Q_REQID_WIDTH
`define FLT_Q_FUNC_NMBR_FO        `FLT_Q_TAG_FO                 +    `FLT_Q_TAG_WIDTH
`define FLT_Q_CPL_STATUS_FO       `FLT_Q_FUNC_NMBR_FO           +    `FLT_Q_FUNC_NMBR_WIDTH
`define FLT_Q_VF_FO               `FLT_Q_CPL_STATUS_FO          +    `FLT_Q_CPL_STATUS_WIDTH
`define FLT_Q_PRFX_FO             `FLT_Q_VF_FO                  +    `FLT_Q_VF_WIDTH
`define FLT_Q_DW_LENGTH_FO        `FLT_Q_PRFX_FO                +    `FLT_Q_PRFX_WIDTH
`define FLT_Q_IN_MEMBAR_RANGE_FO  `FLT_Q_DW_LENGTH_FO           +    `FLT_Q_DW_LENGTH_WIDTH
`define FLT_Q_ROM_IN_RANGE_FO     `FLT_Q_IN_MEMBAR_RANGE_FO     +    `FLT_Q_IN_MEMBAR_RANGE_WIDTH
`define FLT_Q_IO_REQ_IN_RANGE_FO  `FLT_Q_ROM_IN_RANGE_FO        +    `FLT_Q_ROM_IN_RANGE_WIDTH
`define FLT_Q_FRSTDW_BE_FO        `FLT_Q_IO_REQ_IN_RANGE_FO     +    `FLT_Q_IO_REQ_IN_RANGE_WIDTH
`define FLT_Q_ADDR_FO             `FLT_Q_FRSTDW_BE_FO           +    `FLT_Q_FRSTDW_BE_WIDTH  //  overloaded with device number/bus_number
`define FLT_Q_BYTE_CNT_FO         `FLT_Q_ADDR_FO                +    `FLT_Q_ADDR_WIDTH
`define FLT_Q_CMPLTR_ID_FO        `FLT_Q_BYTE_CNT_FO            +    `FLT_Q_BYTE_CNT_WIDTH
`define FLT_Q_BCM_FO              `FLT_Q_CMPLTR_ID_FO           +    `FLT_Q_CMPLTR_ID_WIDTH
`define FLT_Q_CPL_LOWER_ADDR_FO   `FLT_Q_BCM_FO                 +    `FLT_Q_BCM_WIDTH
`define FLT_Q_TD_FO               `FLT_Q_CPL_LOWER_ADDR_FO      +    `FLT_Q_CPL_LOWER_ADDR_WIDTH
`define FLT_Q_EP_FO               `FLT_Q_TD_FO                  +    `FLT_Q_TD_WIDTH
`define FLT_Q_CPL_LAST_FO         `FLT_Q_EP_FO                  +    `FLT_Q_EP_WIDTH
`define FLT_Q_LSTDW_BE_FO         `FLT_Q_CPL_LAST_FO            +    `FLT_Q_CPL_LAST_WIDTH
`define FLT_Q_VALID_TYPE_FO       `FLT_Q_LSTDW_BE_FO            +    `FLT_Q_LSTDW_BE_WIDTH

`define FLT_Q_DEV_NMBR_FO         `FLT_Q_FRSTDW_BE_FO           +    `FLT_Q_FRSTDW_BE_WIDTH  + 32-13//  overloaded with address
`define FLT_Q_BUS_NMBR_FO         `FLT_Q_DEV_NMBR_FO            +    `FLT_Q_DEV_NMBR_WIDTH          //  overloaded with address

`define FLT_Q_HDR_RSVD_DW0_FO     `FLT_Q_VALID_TYPE_FO          +    `FLT_Q_VALID_TYPE_WIDTH
`define FLT_Q_HDR_RSVD_DW2_FO     `FLT_Q_HDR_RSVD_DW0_FO        +    `FLT_Q_HDR_RSVD_DW0_WIDTH

`define FLT_Q_DESTINATION_RANGE       `FLT_Q_DESTINATION_WIDTH      + `FLT_Q_DESTINATION_FO       -1 : `FLT_Q_DESTINATION_FO
`define FLT_Q_FMT_RANGE               `FLT_Q_FMT_WIDTH              + `FLT_Q_FMT_FO               -1 : `FLT_Q_FMT_FO
`define FLT_Q_TYPE_RANGE              `FLT_Q_TYPE_WIDTH             + `FLT_Q_TYPE_FO              -1 : `FLT_Q_TYPE_FO
`define FLT_Q_TC_RANGE                `FLT_Q_TC_WIDTH               + `FLT_Q_TC_FO                -1 : `FLT_Q_TC_FO
`define FLT_Q_ATTR_RANGE              `FLT_Q_ATTR_WIDTH             + `FLT_Q_ATTR_FO              -1 : `FLT_Q_ATTR_FO
`define FLT_Q_REQID_RANGE             `FLT_Q_REQID_WIDTH            + `FLT_Q_REQID_FO             -1 : `FLT_Q_REQID_FO
`define FLT_Q_TAG_RANGE               `FLT_Q_TAG_WIDTH              + `FLT_Q_TAG_FO               -1 : `FLT_Q_TAG_FO
`define FLT_Q_FUNC_NMBR_RANGE         `FLT_Q_FUNC_NMBR_WIDTH        + `FLT_Q_FUNC_NMBR_FO         -1 : `FLT_Q_FUNC_NMBR_FO
`define FLT_Q_CPL_STATUS_RANGE        `FLT_Q_CPL_STATUS_WIDTH       + `FLT_Q_CPL_STATUS_FO        -1 : `FLT_Q_CPL_STATUS_FO
`define FLT_Q_PRFX_RANGE              `FLT_Q_PRFX_WIDTH             + `FLT_Q_PRFX_FO              -1 : `FLT_Q_PRFX_FO
`define FLT_Q_DW_LENGTH_RANGE         `FLT_Q_DW_LENGTH_WIDTH        + `FLT_Q_DW_LENGTH_FO         -1 : `FLT_Q_DW_LENGTH_FO
  `define FLT_Q_IN_MEMBAR_RANGE_RANGE `FLT_Q_IN_MEMBAR_RANGE_WIDTH  + `FLT_Q_IN_MEMBAR_RANGE_FO   -1 : `FLT_Q_IN_MEMBAR_RANGE_FO
  `define FLT_Q_ROM_IN_RANGE_RANGE    `FLT_Q_ROM_IN_RANGE_WIDTH     + `FLT_Q_ROM_IN_RANGE_FO      -1 : `FLT_Q_ROM_IN_RANGE_FO
`define FLT_Q_IO_REQ_IN_RANGE_RANGE   `FLT_Q_IO_REQ_IN_RANGE_WIDTH  + `FLT_Q_IO_REQ_IN_RANGE_FO   -1 : `FLT_Q_IO_REQ_IN_RANGE_FO
`define FLT_Q_FRSTDW_BE_RANGE         `FLT_Q_FRSTDW_BE_WIDTH        + `FLT_Q_FRSTDW_BE_FO         -1 : `FLT_Q_FRSTDW_BE_FO
`define FLT_Q_ADDR_RANGE              `FLT_Q_ADDR_WIDTH             + `FLT_Q_ADDR_FO              -1 : `FLT_Q_ADDR_FO

`define FLT_Q_BYTE_CNT_RANGE          `FLT_Q_BYTE_CNT_WIDTH         + `FLT_Q_BYTE_CNT_FO          -1 : `FLT_Q_BYTE_CNT_FO
`define FLT_Q_CMPLTR_ID_RANGE         `FLT_Q_CMPLTR_ID_WIDTH        + `FLT_Q_CMPLTR_ID_FO         -1 : `FLT_Q_CMPLTR_ID_FO
`define FLT_Q_BCM_RANGE               `FLT_Q_BCM_WIDTH              + `FLT_Q_BCM_FO               -1 : `FLT_Q_BCM_FO
`define FLT_Q_CPL_LOWER_ADDR_RANGE    `FLT_Q_CPL_LOWER_ADDR_WIDTH   + `FLT_Q_CPL_LOWER_ADDR_FO    -1 : `FLT_Q_CPL_LOWER_ADDR_FO

`define FLT_Q_TD_RANGE                `FLT_Q_TD_WIDTH               + `FLT_Q_TD_FO                -1 : `FLT_Q_TD_FO
`define FLT_Q_EP_RANGE                `FLT_Q_EP_WIDTH               + `FLT_Q_EP_FO                -1 : `FLT_Q_EP_FO
`define FLT_Q_CPL_LAST_RANGE          `FLT_Q_CPL_LAST_WIDTH         + `FLT_Q_CPL_LAST_FO          -1 : `FLT_Q_CPL_LAST_FO
`define FLT_Q_LSTDW_BE_RANGE          `FLT_Q_LSTDW_BE_WIDTH         + `FLT_Q_LSTDW_BE_FO          -1 : `FLT_Q_LSTDW_BE_FO
`define FLT_Q_VALID_TYPE_RANGE        `FLT_Q_VALID_TYPE_WIDTH       + `FLT_Q_VALID_TYPE_FO        -1 : `FLT_Q_VALID_TYPE_FO
`define FLT_Q_HDR_RSVD_DW0_RANGE      `FLT_Q_HDR_RSVD_DW0_WIDTH     + `FLT_Q_HDR_RSVD_DW0_FO      -1 : `FLT_Q_HDR_RSVD_DW0_FO
`define FLT_Q_HDR_RSVD_DW2_RANGE      `FLT_Q_HDR_RSVD_DW2_WIDTH     + `FLT_Q_HDR_RSVD_DW2_FO      -1 : `FLT_Q_HDR_RSVD_DW2_FO

`define FLT_Q_DWADDR_RANGE            `FLT_Q_ADDR_WIDTH             + `FLT_Q_ADDR_FO              -1 : `FLT_Q_ADDR_FO+2
`define FLT_Q_BUS_NMBR_RANGE          `FLT_Q_BUS_NMBR_WIDTH         + `FLT_Q_BUS_NMBR_FO          -1 : `FLT_Q_BUS_NMBR_FO               // overloaded with address
`define FLT_Q_DEV_NMBR_RANGE          `FLT_Q_DEV_NMBR_WIDTH         + `FLT_Q_DEV_NMBR_FO          -1 : `FLT_Q_DEV_NMBR_FO               // overloaded with address
`define FLT_T0Q_BUS_NMBR_RANGE        `FLT_Q_BUS_NMBR_WIDTH         + `FLT_Q_BUS_NMBR_FO          -1 -7 : `FLT_Q_BUS_NMBR_FO -7         // overloaded with address, and compressed for TRGT0
`define FLT_T0Q_DEV_NMBR_RANGE        `FLT_Q_DEV_NMBR_WIDTH         + `FLT_Q_DEV_NMBR_FO          -1 -7 : `FLT_Q_DEV_NMBR_FO -7         // overloaded with address, and compressed for TRGT0
`define FLT_T0Q_LSTDW_BE_RANGE        `FLT_Q_LSTDW_BE_WIDTH         + `FLT_Q_ADDR_FO              -1 +5+2 : `FLT_Q_ADDR_FO +5+2
`define FLT_T0Q_DW_LENGTH_RANGE       `FLT_Q_DW_LENGTH_WIDTH        + `FLT_Q_ADDR_FO -1 +5+2+ `FLT_Q_LSTDW_BE_WIDTH :`FLT_Q_ADDR_FO+5+2+ `FLT_Q_LSTDW_BE_WIDTH


 `define RADM_Q_DESTINATION_RANGE     `FLT_Q_DESTINATION_RANGE     // RADM COMMON
 `define RADM_Q_FMT_RANGE             `FLT_Q_FMT_RANGE             // RADM COMMON
 `define RADM_Q_TYPE_RANGE            `FLT_Q_TYPE_RANGE            // RADM COMMON
 `define RADM_Q_TC_RANGE              `FLT_Q_TC_RANGE              // RADM COMMON
 `define RADM_Q_ATTR_RANGE            `FLT_Q_ATTR_RANGE            // RADM COMMON
 `define RADM_Q_REQID_RANGE           `FLT_Q_REQID_RANGE           // RADM COMMON
 `define RADM_Q_TAG_RANGE             `FLT_Q_TAG_RANGE             // RADM COMMON
 `define RADM_Q_FUNC_NMBR_RANGE       `FLT_Q_FUNC_NMBR_RANGE       // RADM COMMON
 `define RADM_Q_CPL_STATUS_RANGE      `FLT_Q_CPL_STATUS_RANGE      // RADM COMMON
 `define RADM_Q_PRFX_RANGE            `FLT_Q_PRFX_RANGE

`define RTLH_DATA0_RANGE    ((DW+DATA_PAR_WD)>>1)-1:0
`define RTLH_DATA1_RANGE    (DW+DATA_PAR_WD)-1:((DW+DATA_PAR_WD)>>1)
`define FILT_HDR1_RANGE     (2*(HW+RX_HDR_PROT_WD))-1:HW+RX_HDR_PROT_WD
`define FILT_HDR0_RANGE     HW+RX_HDR_PROT_WD-1:0
`define FILT_DATA1_RANGE    (2*(DW+DATA_PAR_WD))-1:DW+DATA_PAR_WD
`define FILT_DATA0_RANGE    DW+DATA_PAR_WD-1:0
`define FILT_PRFX0_RANGE    (32*`CX_NPRFX + `CX_RX_PRFX_PAR_WD)-1:0
`define FILT_PRFX1_RANGE    (2*(32*`CX_NPRFX + `CX_RX_PRFX_PAR_WD))-1:(32*`CX_NPRFX + `CX_RX_PRFX_PAR_WD)

  `define RAS_HDR_BUS_PREFIX flt_q_header

   // TRGT0 && TRGTG1

  `define CPL_GEN_EXCLUSIVE_WIDTH 0

//Note: When CX_HEADER_RSVD_ENABLE is defined in in the following, then upper most bit is assigned 1'b0. This bit will be unused, but the number 
// of bits added to he header width must match that in the define for RADM_CPLQ_HDR_SELECT (= 9). (FLT_Q_HDR_RSVD_DW2_RANGE is 1 bit wide).

`define RADM_PQ_HDR_SELECT          ( { `RAS_HDR_BUS_PREFIX[`FLT_Q_LSTDW_BE_RANGE ], `RAS_HDR_BUS_PREFIX[`FLT_Q_CPL_LAST_RANGE ], `RAS_HDR_BUS_PREFIX[`FLT_Q_EP_RANGE],  `RAS_HDR_BUS_PREFIX[`FLT_Q_TD_RANGE],  `RAS_HDR_BUS_PREFIX[`FLT_Q_ADDR_RANGE],  `RAS_HDR_BUS_PREFIX[`FLT_Q_FRSTDW_BE_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_IO_REQ_IN_RANGE_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_ROM_IN_RANGE_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_IN_MEMBAR_RANGE_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_DW_LENGTH_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_CPL_STATUS_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_FUNC_NMBR_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_TAG_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_REQID_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_ATTR_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_TC_RANGE],   `RAS_HDR_BUS_PREFIX[ `FLT_Q_TYPE_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_FMT_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_DESTINATION_RANGE] } )




  `define RADM_NPQ_HDR_SELECT               `RADM_PQ_HDR_SELECT

  `define RADM_PQ_DW_LENGTH_FO            `FLT_Q_COMMON_WIDTH
  `define RADM_PQ_IN_MEMBAR_RANGE_FO    ( `RADM_PQ_DW_LENGTH_FO        + `FLT_Q_DW_LENGTH_WIDTH       )
  `define RADM_PQ_ROM_IN_RANGE_FO       ( `RADM_PQ_IN_MEMBAR_RANGE_FO  + `FLT_Q_IN_MEMBAR_RANGE_WIDTH )
  `define RADM_PQ_IO_REQ_IN_RANGE_FO    ( `RADM_PQ_ROM_IN_RANGE_FO     + `FLT_Q_ROM_IN_RANGE_WIDTH    )
  `define RADM_PQ_FRSTDW_BE_FO          ( `RADM_PQ_IO_REQ_IN_RANGE_FO  + `FLT_Q_IO_REQ_IN_RANGE_WIDTH )
  `define RADM_PQ_ADDR_FO               ( `RADM_PQ_FRSTDW_BE_FO        + `FLT_Q_FRSTDW_BE_WIDTH       ) //
  `define RADM_PQ_BYTE_CNT_FO             `RADM_PQ_FRSTDW_BE_FO                                         // CPL fields, Shared starts at frstdw
  `define RADM_PQ_CMPLTR_ID_FO          ( `RADM_PQ_BYTE_CNT_FO         + `FLT_Q_BYTE_CNT_WIDTH        ) // CPL fields, Shared starts at frstdw
  `define RADM_PQ_BCM_FO                ( `RADM_PQ_CMPLTR_ID_FO        + `FLT_Q_CMPLTR_ID_WIDTH       ) // CPL fields, Shared starts at frstdw
  `define RADM_PQ_CPL_LOWER_ADDR_FO     ( `RADM_PQ_BCM_FO              + `FLT_Q_BCM_WIDTH             ) // CPL fields, Shared starts at frstdw
  `define RADM_PQ_TD_FO                 ( `RADM_PQ_ADDR_FO             + `FLT_Q_ADDR_WIDTH            )
  `define RADM_PQ_TH_FO                 ( `RADM_PQ_TD_FO               + `FLT_Q_TD_WIDTH              )
  `define RADM_PQ_EP_FO                 ( `RADM_PQ_TH_FO               + `FLT_Q_TH_WIDTH              )
  `define RADM_PQ_AT_FO                 ( `RADM_PQ_EP_FO               + `FLT_Q_EP_WIDTH              )
  `define RADM_PQ_CPL_LAST_FO           ( `RADM_PQ_AT_FO               + `FLT_Q_AT_WIDTH              )
  `define RADM_PQ_LSTDW_BE_FO           ( `RADM_PQ_CPL_LAST_FO         + `FLT_Q_CPL_LAST_WIDTH        )
  `define RADM_PQ_HDR_RSVD_DW0_FO       ( `RADM_PQ_LSTDW_BE_FO         + `FLT_Q_LSTDW_BE_WIDTH        )
  `define RADM_PQ_HDR_RSVD_DW2_FO       ( `RADM_PQ_HDR_RSVD_DW0_FO     + `FLT_Q_HDR_RSVD_DW0_WIDTH    )

  `define RADM_PQ_DEV_NMBR_FO           ( `RADM_PQ_ADDR_FO             + 32-13                        ) // subranges within address
  `define RADM_PQ_BUS_NMBR_FO           ( `RADM_PQ_DEV_NMBR_FO         + `FLT_Q_DEV_NMBR_WIDTH        ) // subranges within address
  `define RADM_PQ_UNSC_LSTDW_BE_FO      ( `RADM_PQ_ADDR_FO + 5+2                                      ) // overload with addr
  `define RADM_PQ_UNSC_DW_LENGTH_FO     ( `RADM_PQ_UNSC_LSTDW_BE_FO  + `FLT_Q_LSTDW_BE_WIDTH          ) // overload with addr

  `define RADM_PQ_DW_LENGTH_RANGE           `RADM_PQ_DW_LENGTH_FO             + `FLT_Q_DW_LENGTH_WIDTH         - 1 : `RADM_PQ_DW_LENGTH_FO
  `define RADM_PQ_IN_MEMBAR_RANGE_RANGE     `RADM_PQ_IN_MEMBAR_RANGE_FO       + `FLT_Q_IN_MEMBAR_RANGE_WIDTH   - 1 : `RADM_PQ_IN_MEMBAR_RANGE_FO
  `define RADM_PQ_ROM_IN_RANGE_RANGE        `RADM_PQ_ROM_IN_RANGE_FO          + `FLT_Q_ROM_IN_RANGE_WIDTH      - 1 : `RADM_PQ_ROM_IN_RANGE_FO
  `define RADM_PQ_IO_REQ_IN_RANGE_RANGE     `RADM_PQ_IO_REQ_IN_RANGE_FO       + `FLT_Q_IO_REQ_IN_RANGE_WIDTH   - 1 : `RADM_PQ_IO_REQ_IN_RANGE_FO
  `define RADM_PQ_FRSTDW_BE_RANGE           `RADM_PQ_FRSTDW_BE_FO             + `FLT_Q_FRSTDW_BE_WIDTH         - 1 : `RADM_PQ_FRSTDW_BE_FO
  `define RADM_PQ_ADDR_RANGE                `RADM_PQ_ADDR_FO                  + `FLT_Q_ADDR_WIDTH              - 1 : `RADM_PQ_ADDR_FO
  `define RADM_PQ_BUS_NMBR_RANGE            `RADM_PQ_BUS_NMBR_FO              + `FLT_Q_BUS_NMBR_WIDTH          - 1 : `RADM_PQ_BUS_NMBR_FO
  `define RADM_PQ_DEV_NMBR_RANGE            `RADM_PQ_DEV_NMBR_FO              + `FLT_Q_DEV_NMBR_WIDTH          - 1 : `RADM_PQ_DEV_NMBR_FO
  `define RADM_PQ_BYTE_CNT_RANGE            `RADM_PQ_BYTE_CNT_FO              + `FLT_Q_BYTE_CNT_WIDTH          - 1 : `RADM_PQ_BYTE_CNT_FO
  `define RADM_PQ_CMPLTR_ID_RANGE           `RADM_PQ_CMPLTR_ID_FO             + `FLT_Q_CMPLTR_ID_WIDTH         - 1 : `RADM_PQ_CMPLTR_ID_FO
  `define RADM_PQ_BCM_RANGE                 `RADM_PQ_BCM_FO                   + `FLT_Q_BCM_WIDTH               - 1 : `RADM_PQ_BCM_FO
  `define RADM_PQ_CPL_LOWER_ADDR_RANGE      `RADM_PQ_CPL_LOWER_ADDR_FO        + `FLT_Q_CPL_LOWER_ADDR_WIDTH    - 1 : `RADM_PQ_CPL_LOWER_ADDR_FO
  `define RADM_PQ_TD_RANGE                  `RADM_PQ_TD_FO                    + `FLT_Q_TD_WIDTH                - 1 : `RADM_PQ_TD_FO
  `define RADM_PQ_EP_RANGE                  `RADM_PQ_EP_FO                    + `FLT_Q_EP_WIDTH                - 1 : `RADM_PQ_EP_FO
  `define RADM_PQ_CPL_LAST_RANGE            `RADM_PQ_CPL_LAST_FO              + `FLT_Q_CPL_LAST_WIDTH          - 1 : `RADM_PQ_CPL_LAST_FO
  `define RADM_PQ_LSTDW_BE_RANGE            `RADM_PQ_LSTDW_BE_FO              + `FLT_Q_LSTDW_BE_WIDTH          - 1 : `RADM_PQ_LSTDW_BE_FO
  `define RADM_PQ_HDR_RSVD_DW0_RANGE        `RADM_PQ_HDR_RSVD_DW0_FO          + `FLT_Q_HDR_RSVD_DW0_WIDTH      - 1 : `RADM_PQ_HDR_RSVD_DW0_FO
  `define RADM_PQ_HDR_RSVD_DW2_RANGE        `RADM_PQ_HDR_RSVD_DW2_FO          + `FLT_Q_HDR_RSVD_DW2_WIDTH      - 1 : `RADM_PQ_HDR_RSVD_DW2_FO

  `define RADM_NPQ_DW_LENGTH_RANGE          `RADM_PQ_DW_LENGTH_RANGE
  `define RADM_NPQ_IN_MEMBAR_RANGE_RANGE    `RADM_PQ_IN_MEMBAR_RANGE_RANGE
  `define RADM_NPQ_ROM_IN_RANGE_RANGE       `RADM_PQ_ROM_IN_RANGE_RANGE
  `define RADM_NPQ_IO_REQ_IN_RANGE_RANGE    `RADM_PQ_IO_REQ_IN_RANGE_RANGE
  `define RADM_NPQ_FRSTDW_BE_RANGE          `RADM_PQ_FRSTDW_BE_RANGE
  `define RADM_NPQ_ADDR_RANGE               `RADM_PQ_ADDR_RANGE
  `define RADM_NPQ_BUS_NMBR_RANGE           `RADM_PQ_BUS_NMBR_RANGE
  `define RADM_NPQ_DEV_NMBR_RANGE           `RADM_PQ_DEV_NMBR_RANGE
  `define RADM_NPQ_BYTE_CNT_RANGE           `RADM_PQ_BYTE_CNT_RANGE
  `define RADM_NPQ_CMPLTR_ID_RANGE          `RADM_PQ_CMPLTR_ID_RANGE
  `define RADM_NPQ_BCM_RANGE                `RADM_PQ_BCM_RANGE
  `define RADM_NPQ_CPL_LOWER_ADDR_RANGE     `RADM_PQ_CPL_LOWER_ADDR_RANGE
  `define RADM_NPQ_TD_RANGE                 `RADM_PQ_TD_RANGE
  `define RADM_NPQ_EP_RANGE                 `RADM_PQ_EP_RANGE
  `define RADM_NPQ_CPL_LAST_RANGE           `RADM_PQ_CPL_LAST_RANGE
  `define RADM_NPQ_LSTDW_BE_RANGE           `RADM_PQ_LSTDW_BE_RANGE
  `define RADM_PQ_UNSC_DW_LENGTH_RANGE      `RADM_PQ_DW_LENGTH_RANGE
  `define RADM_PQ_UNSC_LSTDW_BE_RANGE       `RADM_PQ_LSTDW_BE_RANGE
  `define RADM_NPQ_UNSC_DW_LENGTH_RANGE     `RADM_PQ_UNSC_DW_LENGTH_RANGE
  `define RADM_NPQ_UNSC_LSTDW_BE_RANGE      `RADM_PQ_UNSC_LSTDW_BE_RANGE



`define RADM_CPLQ_HDR_SELECT   ( { {`RADM_P_HWD{1'b0}}} | { `RAS_HDR_BUS_PREFIX[`FLT_Q_CPL_LAST_RANGE ], `RAS_HDR_BUS_PREFIX[`FLT_Q_EP_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_TD_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_CPL_LOWER_ADDR_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_BCM_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_CMPLTR_ID_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_BYTE_CNT_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_IO_REQ_IN_RANGE_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_ROM_IN_RANGE_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_IN_MEMBAR_RANGE_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_DW_LENGTH_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_CPL_STATUS_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_FUNC_NMBR_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_TAG_RANGE], `RAS_HDR_BUS_PREFIX[`FLT_Q_REQID_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_ATTR_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_TC_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_TYPE_RANGE], `RAS_HDR_BUS_PREFIX[ `FLT_Q_FMT_RANGE],  `RAS_HDR_BUS_PREFIX[ `FLT_Q_DESTINATION_RANGE] } )

`define RADM_CPLQ_DW_LENGTH_FO                                            `FLT_Q_COMMON_WIDTH
`define RADM_CPLQ_IN_MEMBAR_RANGE_FO    ( `RADM_CPLQ_DW_LENGTH_FO       + `FLT_Q_DW_LENGTH_WIDTH        )
`define RADM_CPLQ_ROM_IN_RANGE_FO       ( `RADM_CPLQ_IN_MEMBAR_RANGE_FO + `FLT_Q_IN_MEMBAR_RANGE_WIDTH  )
`define RADM_CPLQ_IO_REQ_IN_RANGE_FO    ( `RADM_CPLQ_ROM_IN_RANGE_FO    + `FLT_Q_ROM_IN_RANGE_WIDTH     )
`define RADM_CPLQ_BYTE_CNT_FO           ( `RADM_CPLQ_IO_REQ_IN_RANGE_FO + `FLT_Q_IO_REQ_IN_RANGE_WIDTH  )
`define RADM_CPLQ_CMPLTR_ID_FO          ( `RADM_CPLQ_BYTE_CNT_FO        + `FLT_Q_BYTE_CNT_WIDTH         )
`define RADM_CPLQ_BCM_FO                ( `RADM_CPLQ_CMPLTR_ID_FO       + `FLT_Q_CMPLTR_ID_WIDTH        )
`define RADM_CPLQ_CPL_LOWER_ADDR_FO     ( `RADM_CPLQ_BCM_FO             + `FLT_Q_BCM_WIDTH              )
`define RADM_CPLQ_TD_FO                 ( `RADM_CPLQ_CPL_LOWER_ADDR_FO  + `FLT_Q_CPL_LOWER_ADDR_WIDTH   )
`define RADM_CPLQ_EP_FO                 ( `RADM_CPLQ_TD_FO              + `FLT_Q_TD_WIDTH               )
`define RADM_CPLQ_CPL_LAST_FO           ( `RADM_CPLQ_EP_FO              + `FLT_Q_EP_WIDTH               )

`define RADM_CPLQ_DW_LENGTH_RANGE        `RADM_CPLQ_DW_LENGTH_FO        + `FLT_Q_DW_LENGTH_WIDTH        -1 : `RADM_CPLQ_DW_LENGTH_FO
`define RADM_CPLQ_IN_MEMBAR_RANGE_RANGE  `RADM_CPLQ_IN_MEMBAR_RANGE_FO  + `FLT_Q_IN_MEMBAR_RANGE_WIDTH  -1 : `RADM_CPLQ_IN_MEMBAR_RANGE_FO
`define RADM_CPLQ_ROM_IN_RANGE_RANGE     `RADM_CPLQ_ROM_IN_RANGE_FO     + `FLT_Q_ROM_IN_RANGE_WIDTH     -1 : `RADM_CPLQ_ROM_IN_RANGE_FO
`define RADM_CPLQ_IO_REQ_IN_RANGE_RANGE  `RADM_CPLQ_IO_REQ_IN_RANGE_FO  + `FLT_Q_IO_REQ_IN_RANGE_WIDTH  -1 : `RADM_CPLQ_IO_REQ_IN_RANGE_FO
`define RADM_CPLQ_BYTE_CNT_RANGE         `RADM_CPLQ_BYTE_CNT_FO         + `FLT_Q_BYTE_CNT_WIDTH         -1 : `RADM_CPLQ_BYTE_CNT_FO
`define RADM_CPLQ_CMPLTR_ID_RANGE        `RADM_CPLQ_CMPLTR_ID_FO        + `FLT_Q_CMPLTR_ID_WIDTH        -1 : `RADM_CPLQ_CMPLTR_ID_FO
`define RADM_CPLQ_BCM_RANGE              `RADM_CPLQ_BCM_FO              + `FLT_Q_BCM_WIDTH              -1 : `RADM_CPLQ_BCM_FO
`define RADM_CPLQ_CPL_LOWER_ADDR_RANGE   `RADM_CPLQ_CPL_LOWER_ADDR_FO   + `FLT_Q_CPL_LOWER_ADDR_WIDTH   -1 : `RADM_CPLQ_CPL_LOWER_ADDR_FO
`define RADM_CPLQ_TD_RANGE               `RADM_CPLQ_TD_FO               + `FLT_Q_TD_WIDTH               -1 : `RADM_CPLQ_TD_FO
`define RADM_CPLQ_EP_RANGE               `RADM_CPLQ_EP_FO               + `FLT_Q_EP_WIDTH               -1 : `RADM_CPLQ_EP_FO
`define RADM_CPLQ_CPL_LAST_RANGE         `RADM_CPLQ_CPL_LAST_FO         + `FLT_Q_CPL_LAST_WIDTH         -1 : `RADM_CPLQ_CPL_LAST_FO



///////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////  XADM Structures ////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
// Define HDR structure. It contains all of the information needed to generate a TLP
// First declare the fields of the structure
`define   SF_HDR_TLP_ADDR                64 // OVERLOADED with MSG_PYLD
`define   SF_HDR_TLP_MSG_PYLD_DW0        32 // OVERLOADED with ADDR
`define   SF_HDR_TLP_MSG_PYLD_DW1        32 // OVERLOADED with ADDR
`define   SF_HDR_TLP_FMT                 2
`define   SF_HDR_TLP_TYPE                5
`define   SF_HDR_TLP_TC                  3
`define   SF_HDR_TLP_TD                  1
`define   SF_HDR_TLP_EP                  1
`define   SF_HDR_TLP_LN                  `CX_LN_VALUE // When LN is enabled, the LN field is 1 bit
`define   SF_HDR_TLP_ATTR                2 + `CX_IDO_ENABLE_VALUE // When IDO is enabled, the ATTR field is 3 bits
`define   SF_HDR_TLP_BYTE_LEN            13
`define   SF_HDR_TLP_TAG                 `CX_TAG_SIZE
`define   SF_HDR_REQ_ID                  16
`define   SF_HDR_FUN_NUM                 3
`define   SF_HDR_CPL_BYTE_CNT            12
`define   SF_HDR_CPL_BCM                 1
`define   SF_HDR_CPL_STATUS              3
`define   SF_HDR_CPL_REQ_ID              16
`define   SF_HDR_BYTE_EN                 8  // OVERLOADED with MSG_CODE
`define   SF_HDR_TLP_MSG_CODE            8  // OVERLOADED with BYTE_EN
`define   SF_HDR_ADDR_ALIGN_EN                   1  // address align enable

// Now declare the structure as a collection of these fields
`define ST_HDR  (`SF_HDR_TLP_ADDR + `SF_HDR_TLP_FMT + `SF_HDR_TLP_TYPE + `SF_HDR_TLP_TC + `SF_HDR_TLP_TD + `SF_HDR_TLP_EP + `SF_HDR_TLP_ATTR + `SF_HDR_TLP_LN + `SF_HDR_TLP_BYTE_LEN + `SF_HDR_TLP_TAG + `SF_HDR_REQ_ID + `SF_HDR_CPL_BYTE_CNT + `SF_HDR_CPL_BCM + `SF_HDR_CPL_STATUS + `SF_HDR_CPL_REQ_ID +  `SF_HDR_BYTE_EN  + `SF_HDR_ADDR_ALIGN_EN)

// Now calculate the (bit)offset of (the least significant bit of) each field in the structure
`define  FO_HDR_TLP_ADDR          0
`define  FO_HDR_TLP_MSG_PYLD_DW0  `FO_HDR_TLP_ADDR           +  `SF_HDR_TLP_MSG_PYLD_DW0 // OVERLOADED with ADDR
`define  FO_HDR_TLP_MSG_PYLD_DW1  `FO_HDR_TLP_MSG_PYLD_DW0   +  `SF_HDR_TLP_MSG_PYLD_DW1 // OVERLOADED with ADDR
`define  FO_HDR_TLP_FMT           `FO_HDR_TLP_ADDR           +  `SF_HDR_TLP_ADDR         // OVERLOADED with MSG_PYLD
`define  FO_HDR_TLP_TYPE          `FO_HDR_TLP_FMT            +  `SF_HDR_TLP_FMT
`define  FO_HDR_TLP_TC            `FO_HDR_TLP_TYPE           +  `SF_HDR_TLP_TYPE
`define  FO_HDR_TLP_LN            `FO_HDR_TLP_TC             +  `SF_HDR_TLP_TC
`define  FO_HDR_TLP_TD            `FO_HDR_TLP_LN             +  `SF_HDR_TLP_LN
`define  FO_HDR_TLP_EP            `FO_HDR_TLP_TD             +  `SF_HDR_TLP_TD
`define  FO_HDR_TLP_ATTR          `FO_HDR_TLP_EP             +  `SF_HDR_TLP_EP
`define  FO_HDR_TLP_BYTE_LEN      `FO_HDR_TLP_ATTR           +  `SF_HDR_TLP_ATTR
`define  FO_HDR_TLP_TAG           `FO_HDR_TLP_BYTE_LEN       +  `SF_HDR_TLP_BYTE_LEN
`define  FO_HDR_REQ_ID            `FO_HDR_TLP_TAG            +  `SF_HDR_TLP_TAG
`define  FO_HDR_FUN_NUM           `FO_HDR_TLP_TAG            +  `SF_HDR_TLP_TAG
`define  FO_HDR_CPL_BYTE_CNT      `FO_HDR_REQ_ID             +  `SF_HDR_REQ_ID
`define  FO_HDR_CPL_BCM           `FO_HDR_CPL_BYTE_CNT       +  `SF_HDR_CPL_BYTE_CNT
`define  FO_HDR_CPL_STATUS        `FO_HDR_CPL_BCM            +  `SF_HDR_CPL_BCM
`define  FO_HDR_CPL_REQ_ID        `FO_HDR_CPL_STATUS         +  `SF_HDR_CPL_STATUS
`define  FO_HDR_BYTE_EN           `FO_HDR_CPL_REQ_ID         +  `SF_HDR_CPL_REQ_ID      // OVERLOADED with MSG_CODE
`define  FO_HDR_TLP_MSG_PYLD      `FO_HDR_CPL_REQ_ID         +  `SF_HDR_TLP_MSG_CODE    // OVERLOADED with BYTE_EN
`define  FO_HDR_ADDR_ALIGN_EN     `FO_HDR_BYTE_EN            +  `SF_HDR_BYTE_EN

// Now define the "Access" primitives.
`define     F_HDR_TLP_ADDR           `FO_HDR_TLP_ADDR             +  `SF_HDR_TLP_ADDR        -1:`FO_HDR_TLP_ADDR         // OVER LOADED with MSG_PYLD
`define     F_HDR_TLP_MSG_PYLD_DW0   `FO_HDR_TLP_ADDR             +  `SF_HDR_TLP_MSG_PYLD_DW0-1:`FO_HDR_TLP_ADDR         // OVER LOADED with ADDR
`define     F_HDR_TLP_MSG_PYLD_DW1   `FO_HDR_TLP_MSG_PYLD_DW0     +  `SF_HDR_TLP_MSG_PYLD_DW1-1:`FO_HDR_TLP_MSG_PYLD_DW0 // OVER LOADED with ADDR

`define     F_HDR_TLP_FMT            `FO_HDR_TLP_FMT              +  `SF_HDR_TLP_FMT         -1:`FO_HDR_TLP_FMT
`define     F_HDR_TLP_TYPE           `FO_HDR_TLP_TYPE             +  `SF_HDR_TLP_TYPE        -1:`FO_HDR_TLP_TYPE
`define     F_HDR_TLP_TC             `FO_HDR_TLP_TC               +  `SF_HDR_TLP_TC          -1:`FO_HDR_TLP_TC
`define     F_HDR_TLP_TD             `FO_HDR_TLP_TD               +  `SF_HDR_TLP_TD          -1:`FO_HDR_TLP_TD
`define     F_HDR_TLP_EP             `FO_HDR_TLP_EP               +  `SF_HDR_TLP_EP          -1:`FO_HDR_TLP_EP
`define     F_HDR_TLP_ATTR           `FO_HDR_TLP_ATTR             +  `SF_HDR_TLP_ATTR        -1:`FO_HDR_TLP_ATTR
`define     F_HDR_TLP_ATTR_SN_RO     `FO_HDR_TLP_ATTR             +  2                       -1:`FO_HDR_TLP_ATTR
`define     F_HDR_TLP_ATTR_IDO       `FO_HDR_TLP_ATTR+2           +  1                       -1:`FO_HDR_TLP_ATTR+2
`define     F_HDR_TLP_BYTE_LEN       `FO_HDR_TLP_BYTE_LEN         +  `SF_HDR_TLP_BYTE_LEN    -1:`FO_HDR_TLP_BYTE_LEN
`define     F_HDR_TLP_TAG            `FO_HDR_TLP_TAG              +  `SF_HDR_TLP_TAG         -1:`FO_HDR_TLP_TAG
`define     F_HDR_REQ_ID             `FO_HDR_REQ_ID               +  `SF_HDR_REQ_ID          -1:`FO_HDR_REQ_ID
`define     F_HDR_FUN_NUM            `FO_HDR_FUN_NUM              +  `SF_HDR_FUN_NUM         -1:`FO_HDR_FUN_NUM
`define     F_HDR_CPL_BYTE_CNT       `FO_HDR_CPL_BYTE_CNT         +  `SF_HDR_CPL_BYTE_CNT    -1:`FO_HDR_CPL_BYTE_CNT
`define     F_HDR_CPL_BCM            `FO_HDR_CPL_BCM              +  `SF_HDR_CPL_BCM         -1:`FO_HDR_CPL_BCM
`define     F_HDR_CPL_STATUS         `FO_HDR_CPL_STATUS           +  `SF_HDR_CPL_STATUS      -1:`FO_HDR_CPL_STATUS
`define     F_HDR_CPL_REQ_ID         `FO_HDR_CPL_REQ_ID           +  `SF_HDR_CPL_REQ_ID      -1:`FO_HDR_CPL_REQ_ID
`define     F_HDR_BYTE_EN            `FO_HDR_BYTE_EN              +  `SF_HDR_BYTE_EN         -1:`FO_HDR_BYTE_EN        // OVER LOADED with MSG_CODE
`define     F_HDR_TLP_MSG_CODE       `FO_HDR_BYTE_EN              +  `SF_HDR_TLP_MSG_CODE    -1:`FO_HDR_BYTE_EN        // OVER LOADED with BYTE_EN
`define     F_HDR_ADDR_ALIGN_EN      `FO_HDR_ADDR_ALIGN_EN        +  `SF_HDR_ADDR_ALIGN_EN   -1:`FO_HDR_ADDR_ALIGN_EN

`define CX_FLT_MASK_PRS_DROP                23   // 0 - Allow PRS Message to pass through
                                                 // 1 - Drop PRS silently 

`define CX_FLT_UNMASK_TD                    22   // 0 - Disable unmask TD bit if CX_STRIP_ECRC_ENABLE
                                                 // 1 - Enable unmask TD bit if CX_STRIP_ECRC_ENABLE

`define CX_FLT_UNMASK_UR_POIS_TRGT0         21   // 0 - Disable unmask CX_FLT_MASK_UR_POIS with TRGT0 destination
                                                 // 1 - Enable unmask CX_FLT_MASK_UR_POIS with TRGT0 destination

`define CX_FLT_MASK_LN_VENMSG1_DROP         20   // 0 - allow LN message to pass through
                                                 // 1 - Drop LN Messages silently

`define CX_FLT_MASK_HANDLE_FLUSH            19   // 0 - Disable Core Filter to handle flush request
                                                 // 1 - Enable Core Filter to handle flush request
`define CX_FLT_MASK_DABORT_4UCPL            18   // 0 - Enable DLLP abort for unexpected CPL
                                                 // 1 - Do not enable DLLP abort for unexpected CPL
`define CX_FLT_MASK_VENMSG1_DROP            17   // 0 - Drop Vendor MSG Type 1 silently
                                                 // 1 - Do not Drop MSG (pass to TRGT1 interface)
`define CX_FLT_MASK_VENMSG0_DROP            16   // 0 - Drop Vendor MSG Type 0 and considered as a UR
                                                 // 1 - Do not Drop MSG (pass to TRGT1 interface)
`define CX_FLT_MASK_RC_CFG_DISCARD          15   // 0 - For RADM RC filter to not allow CFG transaction being received
                                                 // 1 - For RADM RC filter to allow CFG transaction being received
`define CX_FLT_MASK_RC_IO_DISCARD           14   // 0 - For RADM RC filter to not allow IO transaction being received
                                                 // 1 - For RADM RC filter to allow IO transaction being received
`define CX_FLT_MASK_MSG_DROP                13   // 0 - Drop MSG TLP (except for Vendor MSG)
                                                 // 1 - Do not Drop MSG (except for Vendor MSG)
`define CX_FLT_MASK_CPL_ECRC_DISCARD        12   // 0 - DISCARD TLPs with ECRC Errors for CPL type
                                                 // 1 - ALLOW TLPs with ECRC Errors to be passed up for CPL type

`define CX_FLT_MASK_ECRC_DISCARD            11   // 0 - DISCARD TLPs with ECRC Errors
                                                 // 1 - ALLOW TLPs with ECRC Errors to be passed up

`define CX_FLT_MASK_CPL_LEN_MATCH           10   // 0 - enforce length match for rcvd CPL TLPs; infraction result in cpl_abort, and possibly AER of unexp_cpl_err
                                                 // 1 - MASK    length match for rcvd CPL TLPs;

`define CX_FLT_MASK_CPL_ATTR_MATCH           9   // 0 - enforce attribute     match for rcvd CPL TLPs; infraction result in cpl_abort, and possibly AER of unexp_cpl_err,cpl_rcvd_ur,cpl_rcvd_ca
                                                 // 1 - MASK    attribute     match for rcvd CPL TLPs;

`define CX_FLT_MASK_CPL_TC_MATCH             8   // 0 - enforce Traffic Class match for rcvd CPL TLPs; infraction result in cpl_abort, and possibly AER of unexp_cpl_err,cpl_rcvd_ur,cpl_rcvd_ca
                                                 // 1 - MASK    Traffic Class match for rcvd CPL TLPs;

`define CX_FLT_MASK_CPL_FUNC_MATCH           7   // 0 - enforce function      match for rcvd CPL TLPs; infraction result in cpl_abort, and possibly AER of unexp_cpl_err,cpl_rcvd_ur,cpl_rcvd_ca
                                                 // 1 - MASK    function      match for rcvd CPL TLPs;

`define CX_FLT_MASK_CPL_REQID_MATCH          6   // 0 - enforce Req. Id       match for rcvd CPL TLPs; infraction result in cpl_abort, and possibly AER of unexp_cpl_err,cpl_rcvd_ur,cpl_rcvd_ca
                                                 // 1 - MASK    Req. Id       match for rcvd CPL TLPs;

`define CX_FLT_MASK_CPL_TAGERR_MATCH         5   // 0 - enforce Tag Error     Rules for rcvd CPL TLPs; infraction result in cpl_abort, and possibly AER of unexp_cpl_err,cpl_rcvd_ur,cpl_rcvd_ca
                                                 // 1 - MASK    Tag Error     Rules for rcvd CPL TLPs;

`define CX_FLT_MASK_LOCKED_RD_AS_UR          4   // 0 - Treat locked Read TLPs as UR for EP; Supported for RC
                                                 // 1 - Treat locked Read TLPs as Supported for EP; UR for RC

`define CX_FLT_MASK_CFG_TYPE1_REQ_AS_UR      3   // 0 - Treat CFG type1 TLPs as UR for EP; Supported for RC
                                                 // 1 - Treat CFG type1 TLPs as Supported for EP; UR for RC


`define CX_FLT_MASK_UR_OUTSIDE_BAR           2   // 0 - Treat out-of-bar TLPs as UR;
                                                 // 1 - Treat out-of-bar TLPs as Supported Requests

`define CX_FLT_MASK_UR_POIS                  1   // 0 - Treat poisoned TLPs as UR;
                                                 // 1 - Treat poisined TLPs as Supported Requests

`define CX_FLT_MASK_UR_FUNC_MISMATCH         0   // 0 - Treat Function MisMatched TLPs as UR
                                                 // 1 - Treat Function MisMatched TLPs as Supported


// Define parameters for target completion lookup
`define   SF_CPL_HDR_ATTR                2
`define   SF_CPL_HDR_TC                  3
`define   SF_CPL_HDR_TAG                 `CX_TAG_SIZE
`define   SF_CPL_HDR_BYTECOUNT           12
`define   SF_CPL_HDR_ALIGNMENT           7
`define   SF_CPL_HDR_REQID               16
`define   SF_CPL_HDR_PF                  `CX_NFUNC_WD
`define   SF_CPL_HDR_AT                  2
`define   TRGT_CPL_LUT_ENTRY_WD   (`SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT + `SF_CPL_HDR_ALIGNMENT + `SF_CPL_HDR_REQID + `SF_CPL_HDR_PF)

`define   TCTF_ATTRIBUTE       `SF_CPL_HDR_ATTR -1 : 0
`define   TCTF_TRAFFICCLASS    `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC -1 : `SF_CPL_HDR_ATTR 
`define   TCTF_TAG             `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG -1 : `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC
`define   TCTF_BYTECOUNT       `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT -1 : `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG
`define   TCTF_ALIGNMENT       `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT +`SF_CPL_HDR_ALIGNMENT -1 : `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT
`define   TCTF_REQID           `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT +`SF_CPL_HDR_ALIGNMENT +`SF_CPL_HDR_REQID -1 : `SF_CPL_HDR_ATTR  + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT + `SF_CPL_HDR_ALIGNMENT
`define   TCTF_PF              `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT +`SF_CPL_HDR_ALIGNMENT +`SF_CPL_HDR_REQID + `SF_CPL_HDR_PF -1 : `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT + `SF_CPL_HDR_ALIGNMENT + `SF_CPL_HDR_REQID
`define   TCTF_AT              `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT +`SF_CPL_HDR_ALIGNMENT +`SF_CPL_HDR_REQID + `SF_CPL_HDR_PF + `SF_CPL_HDR_AT -1 : `SF_CPL_HDR_ATTR + `SF_CPL_HDR_TC + `SF_CPL_HDR_TAG + `SF_CPL_HDR_BYTECOUNT + `SF_CPL_HDR_ALIGNMENT + `SF_CPL_HDR_REQID + `SF_CPL_HDR_PF

// --------------------------------------------------------------------
// - FAST_CPL_TIMEOUT
//    Paramter values below must be focred into the RTL from the TB
//    for test.
//
// - Table values below are true for CX_TIMEOUT_GRANULARITY==2
//
//   +-----------+---------------+---------------+
//   |   RANGE   |    NORMAL     |     FAST      |
//   +-----------+---------------+---------------+
//   |    N/A    |    8ms-12ms   |   64us-96us   |
//   | DF(0000)  |   28ms-44ms   |  128us-160us  |
//   |  A(0001)  |   65us-99us   |   64us-96us   |
//   |  A(0010)  |    4ms-6ms    |   64us-96us   |
//   |  B(0101)  |   28ms-44ms   |  128us-160us  |
//   |  B(0110)  |   86ms-131ms  |  256us-384us  |
//   |  C(1001)  |  260ms-390ms  |  512us-768us  |
//   |  C(1010)  |   1.8s-2.8s   |  512us-768us  |
//   |  D(1101)  |   5.4s-8.2s   |  512us-768us  |
//   |  D(1110)  |    38s-58s    |  512us-768us  |
//   +-----------+---------------+---------------+
//
// --------------------------------------------------------------------

// FAST CPL TIMER VALUES
`define  FAST_CX_CPL_BASE_TIMER_VALUE              (32'h2000   / `CX_FREQ_MULTIPLIER)
`define  FAST_CX_CPL_BASE_TIMER_VALUE_32           (32'h1000   / `CX_FREQ_MULTIPLIER)
`define  FAST_CM_CPL_BASE_TIMER_VALUE_RATEA        (32'h1000   / `CX_FREQ_MULTIPLIER)
`define  FAST_CM_CPL_BASE_TIMER_VALUE_RATEB        (32'h1300   / `CX_FREQ_MULTIPLIER)
// FAST RANGE VALUES
`define  FAST_CX_CPL_BASE_TIMER_VALUE1  32'h2
`define  FAST_CX_CPL_BASE_TIMER_VALUE2  32'h3
`define  FAST_CX_CPL_BASE_TIMER_VALUE3  32'h3
`define  FAST_CX_CPL_BASE_TIMER_VALUE4  32'h3
`define  FAST_CX_CPL_BASE_TIMER_VALUE5  32'h2
`define  FAST_CX_CPL_BASE_TIMER_VALUE6  32'h2
`define  FAST_CX_CPL_BASE_TIMER_VALUE7  32'h2

// -------------------------------------------------
// Beneath are the 3 parameters that are used to select completion time out value
// According to spec, the timer value can be 50us < timer < 50ms. Spec. suggested a good value of 10 ms
// Application can select the desired completion timeout value to its desired goal.
// Implementation notes:  1. The granularity has to be greater than 2
//                        2. The width of the scaled timer has to be greater than MAX_TAG.
// The granularity is set for per tag timer. Default has 2 bits per tag to keep track of how many times of base timer has been expired
// When default granularity is set to 2, then equation for completion_timeout_timer is as following:
// (CX_CPL_BASE_TIMER_VALUE * 2) < completion_timeout_value < (CX_CPL_BASE_TIMER_VALUE * 3)
// When default granularity is set to 3, then equation for completion_timeout_timer is as following:
// (CX_CPL_BASE_TIMER_VALUE * 6) < completion_timeout_value < (CX_CPL_BASE_TIMER_VALUE * 7)
// etc....
// Since CX_CPL_BASE_TIMER_TW = 20, then it is set to around 4 ms timeout
// Therefore, the default setting is set at 8ms < completion_timeout_vallue < 12 ms. To be around 10 ms timer

`define  CX_TIMEOUT_GRANULARITY   2     // granularity for a pertag completion timer, the Min has to be 2. If it is set below 2, then the risk is to have ~0 timeout

// Completion timer value scaled down by dividing the granularity. Minimum has to be greater than `CX_LUT_PTR_WIDTH (completion lookup table pointer width). Default here is set to 4 ms
`define  CX_CPL_BASE_TIMER_VALUE              (32'h10_0000 / `CX_FREQ_MULTIPLIER) // For Base PCIe
`define  CM_CPL_BASE_TIMER_VALUE_RATEA        (32'h7_FD00  / `CX_FREQ_MULTIPLIER) // For M-PCIe Rate-A
`define  CM_CPL_BASE_TIMER_VALUE_RATEB        (32'h9_5400  / `CX_FREQ_MULTIPLIER) // For M-PCIe Rate-B
`define  CX_CPL_BASE_TIMER_TW                 ((`CX_FREQ_VALUE == 0) ?  21 : (`CX_FREQ_VALUE == 1) ?  20 : 19 )
`define  CX_CPL_BASE_TIMER_VALUE1             32'h40
`define  CX_CPL_BASE_TIMER_VALUE2             32'h8
`define  CX_CPL_BASE_TIMER_VALUE3             32'h4
`define  CX_CPL_BASE_TIMER_VALUE4             32'h4
`define  CX_CPL_BASE_TIMER_VALUE5             32'h8
`define  CX_CPL_BASE_TIMER_VALUE6             32'h4
`define  CX_CPL_BASE_TIMER_VALUE7             32'h8

`define  CX_TRGT_CPL_BASE_TIMER_VALUE         (32'h10_0000 / `CX_FREQ_MULTIPLIER) // For Base PCIe
`define  CM_TRGT_CPL_BASE_TIMER_VALUE_RATEA   (32'h7_FD00  / `CX_FREQ_MULTIPLIER) // For M-PCIe Rate-A
`define  CM_TRGT_CPL_BASE_TIMER_VALUE_RATEB   (32'h9_5400  / `CX_FREQ_MULTIPLIER) // For M-PCIe Rate-B
`define  CX_TRGT_CPL_BASE_TIMER_TW            ((`CX_FREQ_VALUE == 0) ?  21 : (`CX_FREQ_VALUE == 1) ?  20 : 19 )
// Beneath are the parameters that are used to size the completion timer on aux_clk
`define CX_CPL_BASE_TIMER_VALUE_US (((`CX_CPL_BASE_TIMER_VALUE)*(`CX_FREQ_MULTIPLIER)*4)/1024) // the cpl base timer period expressed in microseconds, value (in us) = value (in clocks) * Gen1 clock period / 1024, currently can be either 32us (TO_RANGES_ENABLE) or 4096us





// -------------------------------------------------

// -------------------------------------------------
// Beneath are the 2 parameters that allows application to chose its PME timer out timer. The timer is designed to be within 100ms (+50%, -5%).
// 16ms for a 4 ns clock , it is strongly suggested to use this value. If intended to mod this value, please read below carefully.
`define CX_PME_BASE_TIMER_WD                      ((`CX_FREQ_VALUE == 0) ?  22 : (`CX_FREQ_VALUE == 1) ?  21 : 20)
`define CX_PME_BASE_TIMER_TIMEOUT_VALUE           {`CX_PME_BASE_TIMER_WD{1'b1}}         // when timer reach all 1, it will time out as current setting.
`define CX_PME_PRESCALE_TIMER_WD                  4                                     // this parameter controls the prescale timer per function.
`define CX_PME_PRESCALE_TIMEOUT_VALUE             8                                     // this parameter controls the prescale timer timeout value
`define CX_PME_BASETIMER_4MS                      (`CX_PME_BASE_TIMER_WD-1)             // this parameter provides a timer index to timeout at4-8ms. this value is heavily related with CX_PME_BASE_TIMER_WD.
`define CM_PME_BASETIMER_4MS_RATEA                (32'hF_F972  / `CX_FREQ_MULTIPLIER)   // For M-PCIe Rate-A
`define CM_PME_BASETIMER_4MS_RATEB                (32'h12_A843 / `CX_FREQ_MULTIPLIER)   // For M-PCIe Rate-B
`define CM_PME_BASE_TIMER_TIMEOUT_VALUE_RATEA    `CM_PME_BASETIMER_4MS_RATEA*2          // For M-PCIe Rate-A
`define CM_PME_BASE_TIMER_TIMEOUT_VALUE_RATEB    `CM_PME_BASETIMER_4MS_RATEB*2          // For M-PCIe Rate-B

// The Total PME value is caculated based on the equation = 2**22 * 4ns * 7 < timeout < 2**22 * 4ns * 8
// as a default, the value is set to 112 ms to 128 ms

// -------------------------------------------------

