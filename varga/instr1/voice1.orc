  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "spat.h.orc"
#include "formant_table.include.orc"

  gibpm     =  150                                ; tempo
  gibtime   =  60 / gibpm                         ; beat time
  ga01      init      0

instr 1

$S_NOTEPARM(0.1'0.2)
$CPS2FNUM(ifn'icps'256)
  iamp      =  iamp * 7.0e7

  a1        grain2    icps, icps * 0.02, 60 / icps, 32, ifn, 1, -0.3, 1, 8

  a_0_      =  a1
  a_1_      =  a1
  a_2_      =  a1
  a_3_      =  a1
  a_4_      =  a1

$FORMANTVALUE(2'p6)
$FORMANTFILTER2(1'2)

  a1        =  a_0_ + a_1_ + a_2_ + a_3_ + a_4_

  a2        grain2    icps, icps * 0.02, 5 / icps, 16, ifn, 1, -0.3, 2, 8

  a2        butterbp  a2, 12000, 6000
  a2        butterbp  a2, 12000, 6000

  aenv11    linseg    0, 0.02, 1, 1, 1
  aenv12    linseg    0, 0.005, 1, 1, 1
  aenv2     =  aenv * aenv

  a1        =  (a1 * aenv11 + a2 * aenv12 * 0.002) * aenv2 * iamp

  ga01      =  ga01 + a1

endin

instr 90

  a0        =  ga01
  ga01      =  0

  aL        =  0
  aR        =  0

  a_        =  a0
  i_az_     =  -50
  i_el_     =  0
  i_d_      =  2.0
$UHJ_Stereo
            vincr     aL, a_L_
            vincr     aR, a_R_

  a_        delayr    gibtime                     ; echo
            delayw    a_ * 0.5 + a0 * 0.33
  i_az_     =  50
$UHJ_Stereo
            vincr     aL, a_L_
            vincr     aR, a_R_

            outs      aL, aR

endin

