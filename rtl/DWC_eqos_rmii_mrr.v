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
// $Id: //dwh/ethernet_iip/dev/ETHER_QOS_4_00A/src/rmii/DWC_eqos_rmii_mrr.v#4 $
// Release version :  4.00a
// Date             :        $Date: 2013/03/07 $
// File Version     :        $Revision: #4 $
//--                                                                        
//--------------------------------------------------------------------------
// MODULE:
// MRR (mrr.v)
//
// DESCRIPTION:
// RMII receive module
// Converts the RMII signals to MII signals running at MII (2.5/25 MHz) clock.
//--------------------------------------------------------------------------

module DWC_eqos_rmii_mrr (
             rst_clk_rmii_n,
             rst_clk_rx_n,

             clk_rmii_i,
             clk_rx_i,

             mac_speed,

             mii_txen,

             rmii_rxd,
             rmii_crsdv,

             mii_rxd,
             mii_rxdv,
             mii_crs,
             mii_col
           );

// -----------------------------------
// Input declarations.----------------
// -----------------------------------
input         rst_clk_rmii_n; // Reset sync to RMII reference clock.
input         rst_clk_rx_n;   // Reset sync to MII clock.

input         clk_rmii_i;    // 50 MHz RMII reference clock.
input         clk_rx_i;      // MII clock 2.5/25 MHz.

input         mac_speed;  // Speed selection signal.

input         mii_txen;    // MII transmit enable.

input  [1:0]  rmii_rxd;    // RMII receive di-bit.
input         rmii_crsdv;  // RMII carrier sense / data valid.

// -----------------------------------
// Output declarations.---------------
// -----------------------------------
output [3:0]  mii_rxd;  // MII Receive Data
output        mii_rxdv; // MII Receive data valid
output        mii_crs;  // MII Carrier Sense
output        mii_col;  // MII Collision Detected

// -----------------------------------
// Reg declarations for outputs.------
// -----------------------------------
wire          mii_crs;
wire          mii_col;

reg [3:0]     mii_rxd;
reg           mii_rxdv;

// -----------------------------------
// Local declarations.----------------
// -----------------------------------
wire          start_of_cs;
wire          end_of_cs;
wire          int2_en;
wire [1:0]    rxd_wire;
wire          start_cs_wire;
wire          mii_crs_int;

reg           cs_detected;
reg           crsdv_d;
reg           crsdv_2d;
reg [1:0]     rmiirx_state;
reg [1:0]     rxd_d;
reg [1:0]     rxd_2d;
reg [1:0]     int1_rxd_h;
reg [1:0]     int1_rxd_l;
reg           int1_rxdv;
reg [3:0]     int2_rxd;
reg           int2_rxdv;
reg           crs_en;
reg           int1_rxdv_d;
reg [3:0]     mod10;
reg           frame_detd;
reg           int2_en_d;
reg           int2_en2;
// Added last_nibble10 and last_nibble100 instead of last_nibble
reg           last_nibble10;
reg           last_nibble100;
reg           last_nibble_d;
// to register the start_cs_wire in case of rxd with non 2'b01 value 
// this register is cleared once the s/m move from idle state.
reg           start_cs_reg;
// to capture crsdv going low, that is missed by end_of_cs in s/m
reg           crsdv_down;

// -----------------------------------
// Defines used in the design.--------
// -----------------------------------
`define     S0        2'b00
`define     S1        2'b01
`define     S2        2'b10
`define     S3        2'b11

assign mii_crs  = mii_crs_int | mii_txen;

assign mii_crs_int  = (~crs_en) ? rmii_crsdv : `L;

// start_of_cs should be idle state 
assign start_of_cs = (crsdv_2d == `L && crsdv_d == `H && rmiirx_state == `S0);
// assign end_of_cs  = (crsdv_2d == `H && crsdv_d == `L && rmii_crsdv == `L);
// end_of_cs should be in nibble boundary, i.e the second di-bit of the RMII_RXD
assign end_of_cs  = (crsdv_2d == `H && crsdv_d == `L && rmii_crsdv == `L &&
                        (mac_speed || !int2_en2)); 
assign mii_col  = mii_txen && mii_crs_int;
assign int2_en  = (mac_speed) ? `H : (mod10 == 4'b1001);
assign rxd_wire = mac_speed ? rxd_2d : rxd_d;
assign start_cs_wire = mac_speed ? cs_detected : start_of_cs;


     // Synchronizing rmii_crsdv with RMII Clock.
     always @(`DWC_EQOS_RMII_RST_MODE) begin
       if (!rst_clk_rmii_n) begin
         crsdv_d  <= 1'b0;
         crsdv_2d <= 1'b0;
         int1_rxdv_d <= 1'b0;
         int2_en_d <= 1'b0;
         last_nibble_d <= 1'b0; 
         start_cs_reg <= 1'b0; 
       end
       else begin
         crsdv_d  <= rmii_crsdv;
         crsdv_2d <= crsdv_d;
         int1_rxdv_d <= int1_rxdv;
         int2_en_d <= int2_en;
         last_nibble_d <= (mac_speed) ? last_nibble100 : last_nibble10; 
                                       // last nibble of the frame 
         // this is cleared once the s/m move on from idel state and always
         // state 'S2 is next to follow after `S0
         if (rmiirx_state == `S2)
           start_cs_reg <= 1'b0;
         else if (start_cs_wire) 
           start_cs_reg <= 1'b1;
       end
     end

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           crs_en  <= `L;
        end
        else begin
           if (crsdv_d == `H && rmii_crsdv == `L) begin
              crs_en  <= `H;
           end
           else if (crsdv_d == `L && rmii_crsdv == `L) begin
              crs_en  <= `L;
           end
        end
     end

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           rxd_d  <= 2'b00;
           rxd_2d <= 2'b00;
        end
        else begin
           rxd_d  <= rmii_rxd;
           rxd_2d <= rxd_d;
        end
     end

     // Synchronize MII: rxd and rxdv w.r.t MII clock.
     always @(`DWC_EQOS_RX_RST_MODE) begin
        if(!rst_clk_rx_n) begin
           mii_rxdv <= `L;
           mii_rxd  <= 4'h0;
        end
        else begin
           mii_rxdv <= int2_rxdv;
           mii_rxd  <= int2_rxd;
        end
     end

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           last_nibble100 <= `L;
        end
        else begin
           if (rmiirx_state == `S3 & last_nibble100 == `L)
              last_nibble100 <= `H;
           else
              last_nibble100 <= `L;
        end
     end

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           last_nibble10 <= `L;
        end
        else begin
           if (rmiirx_state == `S3 & last_nibble10 == `L && !rmii_crsdv & int2_en)
             // last_nibble10 only when RMII_CRS_DV is low, not when when toggle
              last_nibble10 <= `H;
           else
              last_nibble10 <= `L;
        end
     end

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           int2_en2 <= `L;
        end
        else begin
           if (int2_en & ~mac_speed) begin 
           // toggle for every int2_en in 10Mbps
              int2_en2 <= ~int2_en2;
           end
           else if (start_of_cs) begin
              int2_en2 <= `H;
           end
           else if (mac_speed == `H & last_nibble_d == `H & 
              last_nibble100 == `L) 
              int2_en2 <= `L;
           else if (mac_speed == `L & last_nibble_d == `H & 
              last_nibble10 == `L & !rmii_crsdv) 
              int2_en2 <= `L;
        end
     end


     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           int2_rxd  <= 4'h0;
           int2_rxdv <= `L;
        end
        else begin
           if (int1_rxdv == `H && (int2_en == `H && int2_en2 == `L && 
               mac_speed == `L) || 
              (mod10 == 4'b0001 && mac_speed == `H)) begin
              int2_rxd  <= {int1_rxd_h,int1_rxd_l};
              int2_rxdv <= int1_rxdv;
           end
           else if (int1_rxdv == `L) begin
              if ((mac_speed == `L && int2_en_d == `H) || 
                 mac_speed == `H) begin 
                 int2_rxd  <= 4'h0;
                 int2_rxdv <= `L;
              end
           end
        end
     end

     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           mod10     <= 4'h0;
           frame_detd <= `L;
        end
        else begin
           if (int1_rxdv == `H || frame_detd == `H) begin
              if ((mac_speed == `L && mod10 == 4'b1001) || 
                  (mac_speed == `H && mod10 == 4'b0001)) begin
                 mod10     <= 4'b0000;
                 frame_detd <= `L;
              end
              else begin
//leda W484 off
//LMD: possible loss of carry/borrow in addition/subtraction
//LJ: The logic will increment mod10 to a maximum value of 4'b1001. 
//LJ: hence This warning can be ignored.
                 mod10     <= mod10 + 4'b0001;
//leda W484 on		 
                 frame_detd <= `H;
              end
           end
           else if (int1_rxdv_d == `L) begin
              mod10 <= 4'b0000;
           end
        end
     end

     // Receive state machine to latch the High and Low di-bits from
     // the RMII interface.
     always @(`DWC_EQOS_RMII_RST_MODE) begin
        if(!rst_clk_rmii_n) begin
           cs_detected  <= `L;
           int1_rxd_h  <= 2'b00;
           int1_rxd_l  <= 2'b00;
           int1_rxdv   <= `L;
           rmiirx_state <= `S0;
           crsdv_down  <= `L;
        end
        else begin
           case (rmiirx_state)
              `S0: begin
                 // Delay the deassertion of int1_rxdv signal.
                 if (int1_rxdv == `H) begin
                    if (int2_en == `H) begin
                       int1_rxdv   <= `L;
                       int1_rxd_h  <= 2'b00;
                       int1_rxd_l  <= 2'b00;
                    end
                 end
                 // Wait for the begining of preamble.
                 // even if the start_cs_wire comes the s/m hunts for preamble pattern
                 // 2'b01, until then the signal is registered in start_cs_reg
                 else if ((start_cs_wire || start_cs_reg) && rxd_wire == 2'b01) begin
                       int1_rxd_l  <= rxd_wire;
                       rmiirx_state <= `S2;
                       int1_rxdv   <= `H;
                 end
                 // Wait for the begining of carrier sense.
                 else if (start_of_cs == `H) begin
                    cs_detected <= `H;
                 end
                 // False carrier detected.
                 else if (end_of_cs==`H) begin
                    cs_detected <= `L;
                 end
                 crsdv_down <= `L;
              end
              `S1: begin
                 if (end_of_cs==`H || (!crsdv_d && crsdv_down)) begin
                    rmiirx_state <= `S3;
                    cs_detected  <= `L;
                    int1_rxd_l  <= rxd_wire;  
                 end
                 else if (int2_en == `H) begin
                    int1_rxd_l  <= rxd_wire;
                    rmiirx_state <= `S2;
                    crsdv_down  <= `L;
                 end
              end
              `S2: begin
                 if (end_of_cs==`H) begin
                    int1_rxd_h  <= rxd_wire;
                    rmiirx_state <= `S3;
                    cs_detected  <= `L;
                 end

                 else if (int2_en == `H) begin
                    int1_rxd_h  <= rxd_wire;
                    rmiirx_state <= `S1;
                    if (!crsdv_d) 
                      crsdv_down <= `H;
                    else
                      crsdv_down <= `L;
                 end
              end
              default: begin    //S3 state
                 if ((mac_speed & last_nibble100) || 
                     (!mac_speed & last_nibble10)) begin
                    rmiirx_state <= `S0;
                    int1_rxdv   <= `L;
                    int1_rxd_h  <= 2'b00;
                    int1_rxd_l  <= 2'b00;
                 end
                // in BASE10 mode only, This is to support the CRS_DV, RMII spec of CRS_DV 
                // toggle as 2.5 MHz clock
                 else if (~mac_speed && rmii_crsdv && int2_en) begin 
                   int1_rxd_h  <= rxd_wire;
                   rmiirx_state <= `S1;
                 end
              end
           endcase
        end
     end
endmodule

///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                        End of file "mrr.v"                                //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
