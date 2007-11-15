  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "spat.h.orc"

instr 1

$NOTEPARAMS(0.2)

  kcps      expon     1, 0.022, 0.5
  kcps      =  4.3333 * kcps * icps + icps

  a1        phasor    kcps
  a2        phasor    kcps, 0.5
  a1        =  a1 - a2

  kffrq     expon     1, 0.07, 0.5
  kffrq2    expon     1, 0.01, 0.5
  kffrq     =  (kffrq + kffrq2) * kcps
  a1        pareq     a1, kffrq, 0, 0.7071, 2

  a1        =  taninv(a1 * 20)

  a1        pareq     a1, kcps * 6, 2, 1, 2
  a1        pareq     a1, icps * 1.25, 2.5, 1, 0

  a2        linseg    1, ilnth, 1, 0.01, 0, 1, 0
  a1        =  a1 * a2 * iamp * 4500 + (1/1e24)

  a_1_, a_2_, a_3_, a_4_  spat3di                 a1, 0, 0.6, 0,  1.0, 225, 2

$DECODE_UHJ

            outs      a_L_, a_R_

endin

