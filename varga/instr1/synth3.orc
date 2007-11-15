  sr        =  48000
  kr        =  1000
  ksmps     =  48
  nchnls    =  2

#include "base_macros.h.orc"

instr 1

  icps      =  $MIDI2CPS(48)
$CPS2FNUM(ifn'icps'256)

; left channel

  a1        grain2    icps, icps * 0.015, 40 / icps, 50, 1, 2, -0.3, 0, 0
  a2        grain2    icps, icps * 0.020, 8 / icps, 30, ifn, 2, -0.3, 0, 0
  a3        grain2    icps, icps * 0.025, 2 / icps, 20, ifn, 2, -0.3, 0, 0

  a2        butterbp  a2, 10 * icps, 5 * icps
  a3        butterbp  a3, 16 * icps, 8 * icps

  a1        =  a1 + a2 * 0.15 + a3 * 0.05

  aL        butterlp  a1, 24 * icps

; right channel

  a1        grain2    icps, icps * 0.015, 40 / icps, 50, 1, 2, -0.3, 0, 0
  a2        grain2    icps, icps * 0.020, 8 / icps, 30, ifn, 2, -0.3, 0, 0
  a3        grain2    icps, icps * 0.025, 2 / icps, 20, ifn, 2, -0.3, 0, 0

  a2        butterbp  a2, 10 * icps, 5 * icps
  a3        butterbp  a3, 16 * icps, 8 * icps

  a1        =  a1 + a2 * 0.15 + a3 * 0.05

  aR        butterlp  a1, 24 * icps

            outs      aL * 1000, aR * 1000

endin

