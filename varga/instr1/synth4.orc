  sr        =  48000
  kr        =  1000
  ksmps     =  48
  nchnls    =  2

#include "base_macros.h.orc"

instr 1

  icps      =  $MIDI2CPS(24)
$CPS2FNUM(ifn'icps'256)

  a1        grain2    icps, 0, 24 / icps, 50, 1, 2, 0, 0, 0
  a2        grain2    icps, 0, 3 / icps, 30, ifn, 2, 0, 0, 0
  a3        grain2    icps, 0, 1 / icps, 20, ifn, 2, 0, 0, 0

  a2        butterlp  a2, 12 * icps
  a3        butterlp  a3, 24 * icps
  a2        =  a2 + a3 * 0.35

  a2        pareq     a2, 7 * icps, 0.7, 1, 1
  a2        pareq     a2, 6 * icps, 0.5, 1, 0
  a2        butterlp  a2, 12 * icps

  aL        =  600 * (a1 + a2 * 0.5)

  a1        grain2    icps, 0, 24 / icps, 50, 1, 2, 0, 0, 0
  a2        grain2    icps, 0, 3 / icps, 30, ifn, 2, 0, 0, 0
  a3        grain2    icps, 0, 1 / icps, 20, ifn, 2, 0, 0, 0

  a2        butterlp  a2, 12 * icps
  a3        butterlp  a3, 24 * icps
  a2        =  a2 + a3 * 0.35

  a2        pareq     a2, 7 * icps, 0.7, 1, 1
  a2        pareq     a2, 6 * icps, 0.5, 1, 0
  a2        butterlp  a2, 12 * icps

  aR        =  600 * (a1 + a2 * 0.5)

            outs      aL, aR

endin

