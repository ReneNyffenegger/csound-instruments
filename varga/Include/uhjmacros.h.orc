
/* Macros for 2D spatialization with UHJ format output (spat.h.orc is   */
/* required). This file should be included from the orchestra header,   */
/* after including spat.h.orc.                                          */
/* Written by Istvan Varga, May 2002                                    */

/* initialize global variables */

  ga0       init      0
  gaW       init      0
  gaX       init      0
  gaY       init      0

/* i-rate spatial macro */

#define SPAT1 #

$SPAT_H__base_i_($UNITDIST'2)

            vincr     ga0, a_
            vincr     gaW, a_1_
            vincr     gaX, a_2_
            vincr     gaY, a_3_

#

/* k-rate spatial macro */

#define SPAT1D #

$SPAT_H__base_k_($UNITDIST'2'2)

            vincr     ga0, a_
            vincr     gaW, a_1_
            vincr     gaX, a_2_
            vincr     gaY, a_3_

#

/* i-rate spatial macro with parameters in macro arguments */

#define SPAT2(SPAT2_ain'SPAT2_iaz'SPAT2_id) #

  a_        =  $SPAT2_ain
  i_az_     =  $SPAT2_iaz
  i_el_     =  0
  i_d_      =  $SPAT2_id

$SPAT_H__base_i_($UNITDIST'2)

            vincr     ga0, a_
            vincr     gaW, a_1_
            vincr     gaX, a_2_
            vincr     gaY, a_3_

#

/* k-rate spatial macro with parameters in macro arguments */

#define SPAT2D(SPAT2D_ain'SPAT2D_kaz'SPAT2D_kd) #

  a_        =  $SPAT2D_ain
  k_az_     =  $SPAT2D_kaz
  k_el_     =  0
  k_d_      =  $SPAT2D_kd

$SPAT_H__base_k_($UNITDIST'2'2)

            vincr     ga0, a_
            vincr     gaW, a_1_
            vincr     gaX, a_2_
            vincr     gaY, a_3_

#

/* 4-channel output (chn 1: left, chn 2: right, chn 3: mono, chn 4: dummy) */

#define OUT4CH(OUT4CH_ins) #

instr $OUT4CH_ins

  a_        =  ga0
  a_1_      =  gaW
  a_2_      =  gaX
  a_3_      =  gaY
  a_4_      =  0

            clear     ga0, gaW, gaX, gaY

$DECODE_UHJ

            outq      a_L_, a_R_, a_, a_4_

endin

#

/* 2+1 channel output */

#define OUT3CH(OUT3CH_ins'OUT3CH_ofl) #

instr $OUT3CH_ins

  a_        =  ga0
  a_1_      =  gaW
  a_2_      =  gaX
  a_3_      =  gaY
  a_4_      =  0

            clear     ga0, gaW, gaX, gaY

$DECODE_UHJ

            outs      a_L_, a_R_
            soundout  a_, $OUT3CH_ofl, 6

endin

#

