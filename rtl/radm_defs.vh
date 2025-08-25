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
// ---    $DateTime: 2015/04/03 12:50:10 $
// ---    $Revision: #39 $
// ---    $Id: //dwh/pcie_iip/main/fairbanks/design/include/radm_defs.vh#39 $
// -------------------------------------------------------------------------
// --- Module Description:
// ---
// --- This file contains New ADM implementation-specific defines
// ---
// -----------------------------------------------------------------------------

//
// This file assumes cxpl_defs.vh has been included
//
     `define RADM_DEFS

    `define CX_STORE_N_FWD          3'b001
    `define CX_CUT_THROUGH          3'b010
    `define CX_BYPASS               3'b100

    `define RADM_RD_PRIORITY_EN     0


    // +++ Order Queue +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // bit 0 - TLP has payload
    // bit 1-12 TLP Length [9:0]  RADM_ORDQ_TLP_LENGTH_WD=11
    //   `define RADM_ORDQ_TLP_LENGTH_WD  11

    // bit 1 (optional) - TLP's destination is target0 - not here if TRGT1_POPULATE is undefined
        `define RADM_ORDQ_TRGT0_WD  1
        `define RADM_ORDQ_TLP_ABORT_WD  1
        `define RADM_ORDQ_1CYCLE_WD 0
        `define RADM_ORDQ_2QUEUE_WD 0
    // bit 2 (optional) - TLP has relaxed order bit set - not here if Relaxed Ordering is not supported
    // Only for CPL queue.  P & NP doesn't care.
        `define RADM_ORDQ_CPL_RLXORD_WD 1
        `define RADM_ORDQ_RLXORD_WD     0

    // bit 3-4 (optional) - TLP's clump number - not here if only strict priority
    // Need 2 bits for Posted queue and 1 bit for NP/CPL
        `define RADM_ORDQ_P_CLUMP_WD_VC0    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC0   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC0  2

        `define RADM_ORDQ_P_CLUMP_WD_VC1    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC1   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC1  2

        `define RADM_ORDQ_P_CLUMP_WD_VC2    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC2   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC2  2

        `define RADM_ORDQ_P_CLUMP_WD_VC3    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC3   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC3  2

        `define RADM_ORDQ_P_CLUMP_WD_VC4    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC4   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC4  2

        `define RADM_ORDQ_P_CLUMP_WD_VC5    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC5   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC5  2

        `define RADM_ORDQ_P_CLUMP_WD_VC6    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC6   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC6  2

        `define RADM_ORDQ_P_CLUMP_WD_VC7    2
        `define RADM_ORDQ_NP_CLUMP_WD_VC7   2
        `define RADM_ORDQ_CPL_CLUMP_WD_VC7  2

    // Bit offsets
    `define RADM_ORDQ_PYLD_OFFSET       0
    `define RADM_ORDQ_TRGT0_OFFSET      (`RADM_ORDQ_PYLD_OFFSET + 1)
    `define RADM_ORDQ_TLP_ABORT_OFFSET  (`RADM_ORDQ_TRGT0_OFFSET + `RADM_ORDQ_TRGT0_WD)
    `define RADM_ORDQ_1CYCLE_OFFSET     (`RADM_ORDQ_TLP_ABORT_OFFSET + `RADM_ORDQ_TLP_ABORT_WD)
    `define RADM_ORDQ_2QUEUE_OFFSET     (`RADM_ORDQ_1CYCLE_OFFSET + `RADM_ORDQ_1CYCLE_WD)
    `define RADM_ORDQ_RLXORD_OFFSET     (`RADM_ORDQ_2QUEUE_OFFSET + `RADM_ORDQ_2QUEUE_WD)
    `define RADM_ORDQ_P_CLUMP_OFFSET    (`RADM_ORDQ_RLXORD_OFFSET + `RADM_ORDQ_RLXORD_WD + 1) : (`RADM_ORDQ_RLXORD_OFFSET + `RADM_ORDQ_RLXORD_WD)
    `define RADM_ORDQ_NP_CLUMP_OFFSET   (`RADM_ORDQ_RLXORD_OFFSET + `RADM_ORDQ_RLXORD_WD + 1) : (`RADM_ORDQ_RLXORD_OFFSET + `RADM_ORDQ_RLXORD_WD)
    `define RADM_ORDQ_CPL_CLUMP_OFFSET  (`RADM_ORDQ_RLXORD_OFFSET + `RADM_ORDQ_CPL_RLXORD_WD + 1) : (`RADM_ORDQ_RLXORD_OFFSET + `RADM_ORDQ_CPL_RLXORD_WD)

    // Calculate the Order Queue width based on what signals need to be included
    `define CX_P_ORDQ_WD_VC0        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC0)
    `define CX_NP_ORDQ_WD_VC0       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC0)
    `define CX_CPL_ORDQ_WD_VC0      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC0)

    `define CX_P_ORDQ_WD_VC1        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC1)
    `define CX_NP_ORDQ_WD_VC1       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC1)
    `define CX_CPL_ORDQ_WD_VC1      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC1)

    `define CX_P_ORDQ_WD_VC2        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC2)
    `define CX_NP_ORDQ_WD_VC2       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC2)
    `define CX_CPL_ORDQ_WD_VC2      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC2)

    `define CX_P_ORDQ_WD_VC3        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC3)
    `define CX_NP_ORDQ_WD_VC3       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC3)
    `define CX_CPL_ORDQ_WD_VC3      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC3)

    `define CX_P_ORDQ_WD_VC4        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC4)
    `define CX_NP_ORDQ_WD_VC4       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC4)
    `define CX_CPL_ORDQ_WD_VC4      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC4)

    `define CX_P_ORDQ_WD_VC5        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC5)
    `define CX_NP_ORDQ_WD_VC5       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC5)
    `define CX_CPL_ORDQ_WD_VC5      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC5)

    `define CX_P_ORDQ_WD_VC6        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC6)
    `define CX_NP_ORDQ_WD_VC6       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC6)
    `define CX_CPL_ORDQ_WD_VC6      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC6)

    `define CX_P_ORDQ_WD_VC7        (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_P_CLUMP_WD_VC7)
    `define CX_NP_ORDQ_WD_VC7       (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_RLXORD_WD + `RADM_ORDQ_NP_CLUMP_WD_VC7)
    `define CX_CPL_ORDQ_WD_VC7      (1 + `RADM_ORDQ_TLP_ABORT_WD +`RADM_ORDQ_TRGT0_WD + `RADM_ORDQ_1CYCLE_WD + `RADM_ORDQ_2QUEUE_WD + `RADM_ORDQ_CPL_RLXORD_WD + `RADM_ORDQ_CPL_CLUMP_WD_VC7)
    // +++ END of Order Queue ++++++++++++++++++++++++++++++++++++++++++++++++++++++

