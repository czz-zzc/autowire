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

//--------------------------------------------------------------------------
// $Id: //dwh/ethernet_iip/dev/ETHER_QOS_4_00A/src/rmii/DWC_eqos_rmii_mrt.v#3 $
// Release version :  4.00a
// Date             :        $Date: 2013/03/07 $
// File Version     :        $Revision: #3 $
//--                                                                        
//--------------------------------------------------------------------------
// MODULE:
// MRT (mrt.v)
//
// DESCRIPTION:
// RMII transmit module
// Converts the MII signals to RMII signals running at RMII (50 MHz) clock.
//--------------------------------------------------------------------------

module DWC_eqos_rmii_mrt (
             rst_clk_rmii_n,

             clk_rmii_i,

             mac_speed,

             mii_txen,
             mii_txd,

             rmii_txen,
             rmii_txd
           );

// -----------------------------------
// Input declarations.----------------
// -----------------------------------
input           rst_clk_rmii_n;  // Reset sync to clk_rmii_i.

input           clk_rmii_i;     // 50 MHz reference clock.

input           mac_speed;   // Speed selected input from MAC.

input           mii_txen;     // Tx Enable sync to MII_TxClk from MAC110 block.
input [3:0]     mii_txd;      // Tx Data sync to MII_TxClk from MAC110 block.

// -----------------------------------
// Output declarations.---------------
// -----------------------------------
output          rmii_txen;     // RMII Transmit Enable.
output [1:0]    rmii_txd;      // RMII Transmit data.

// -----------------------------------
// Reg declarations for outputs.------
// -----------------------------------
reg             rmii_txen;     // RMII Transmit Enable.
reg [1:0]       rmii_txd;      // RMII Transmit data.

// -----------------------------------
// Local declarations.----------------
// -----------------------------------
reg [3:0]       mod10;        // modulo 10 Counter.
reg             hi_dbit_en;    // Enable for Hi di-bit.

// -----------------------------------
// Defines used in the design.--------
// -----------------------------------

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           rmii_txen <= `L;
           rmii_txd  <= 2'b00;
        end
        else begin
           if (mii_txen == `H) begin
              rmii_txen <= `H;
              if (hi_dbit_en == `L)
                 rmii_txd <= mii_txd[1:0];
              else
                 rmii_txd <= mii_txd[3:2];
           end
           else begin
              rmii_txen <= `L;
              rmii_txd  <= 2'b00;
           end
        end
     end

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           hi_dbit_en <= `L;
           mod10     <= 4'b0000;
        end
        else begin
           if (mii_txen == `H) begin
              if (mac_speed == `H) begin
                 hi_dbit_en <= ~hi_dbit_en;
              end
              else begin
                 if (mod10 == 4'b1001) begin
                    hi_dbit_en <= ~hi_dbit_en;
                    mod10     <= 4'b0000;
                 end
                 else
//leda W484 off
//LMD: possible loss of carry/borrow in addition/subtraction
//LJ: The logic will increment mod10 to a maximum value of 4'b1001. 
//LJ: hence This can be ignored.
                    mod10 <= mod10 + 4'b0001;
//leda W484 on    
              end
           end
           else begin
              hi_dbit_en <= `L;
              mod10     <= 4'b0000;
           end
        end
     end

endmodule

///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                        End of file "mrt.v"                                //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
