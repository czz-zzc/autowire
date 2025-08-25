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
// ---    $DateTime: 2013/05/31 07:47:35 $
// ---    $Revision: #6 $
// ---    $Id: //dwh/pcie_iip/main/fairbanks/design/include/pipe_defines.vh#6 $
// -------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////// 
//
//  pipe_defines.v
//
//  Configuration file for  PCS layer for PCI-Express Gen 3 PHY
//
//////////////////////////////////////////////////////////////////////////////

//-----------------------------------
// DO NOT EDIT BELOW THIS LINE
//-----------------------------------
 `define PIPE_DEFINES_V


// the clock to Q delay of flops
// should be ignored during sysnthesis
  `define CK_Q # 0.1 
// here are the data streams that are bit-reveresed received from PHY (Gen3) 
 `define EIEOS_START 18'b10_00000000_11111111
 `define REVERS_SKP_START_16BIT  16'b10_01010101_010101
 `define REVERS_SKP_16BIT  16'b0101_0101_0101_0101
 `define REVERS_E1_8BIT 8'h87

// K Codes
 `define KCODE_8B_COM 8'hBC // K28.5
 `define KCODE_8B_FTS 8'h3C // K28.1
 `define KCODE_8B_SDP 8'h5C // K28.2
 `define KCODE_8B_IDL 8'h7C //
 `define KCODE_8B_PAD 8'hF7 //
 `define KCODE_8B_STP 8'hFB //
 `define KCODE_8B_END 8'hFD //
 `define KCODE_8B_EDB 8'hFE //
 `define KCODE_8B_SKP 8'h1C // K28.0
 `define KCODE_8B_EIE 8'hFC // K28.7

 `define KCODE_10B_COM 10'h0FA // K28.5
 `define KCODE_10B_FTS 10'h0F9 // K28.1
 `define KCODE_10B_SDP 10'h0F5 // K28.2
 `define KCODE_10B_IDL 10'h0F3 // K28.3
 `define KCODE_10B_SKP 10'h0F4 // K28.0
 `define KCODE_10B_END 10'h2E8 // K29.7

// Gen3 syncheaders
 `define GEN3_2B_DATA_SYNC 2'b10
 `define GEN3_2B_OS_SYNC   2'b01
 `define GEN3_2B_DUM_SYNC   2'b11
 `define GEN3_2B_BODY_SYNC   2'b00
// Gen3 first byte of OSs 
 `define GEN3_8B_SKP       8'hAA
 `define GEN3_8B_TS1       8'h1E
 `define GEN3_8B_TS2       8'h2D
 `define GEN3_8B_EIEOS     8'h00
 `define GEN3_8B_EIOS      8'h66
 `define GEN3_8B_FTS       8'h55
 `define GEN3_8B_SDS       8'hE1
 `define GEN3_8B_CMPL      8'hFF
     

 
// Powerdown values
//
 `define PIPE_P0  2'b00
 `define PIPE_P0S 2'b01
 `define PIPE_P1  2'b10
 `define PIPE_P2  2'b11

// RxStatus codes
//
 `define PIPE_RXSTAT_DATA_OK   3'b000
 `define PIPE_RXSTAT_SKP_ADD   3'b001
 `define PIPE_RXSTAT_SKP_REM   3'b010
 `define PIPE_RXSTAT_RX_DET    3'b011
 `define PIPE_RXSTAT_8B10B_ERR 3'b100
 `define PIPE_RXSTAT_BUF_OFLOW 3'b101
 `define PIPE_RXSTAT_BUF_UFLOW 3'b110
 `define PIPE_RXSTAT_DISP_ERR  3'b111

 // Encodings for LOS filter settings
 //
 `define UP8_RX_LOS_FILT_NONE  2'b00
 `define UP8_RX_LOS_FILT_PCIE1 2'b01
 `define UP8_RX_LOS_FILT_PCIE2 2'b10
 `define UP8_RX_LOS_FILT_XAUI  2'b11

  

////////////////////////////////////////////////////////////////////////////// 

