  sr        =  48000
  ksmps     =  2
  nchnls    =  2

#include "base_macros.h.orc"
#include "spat.h.orc"

  ga0       init      0
            seed      0

instr 1

  icps0     =  $MIDI2CPS(50)
  icps1     =  2.0 * icps0

  kcps      port      icps0, 0.007, icps1
  kcpsx     =  kcps * $NOTE2FRQ(7)
  kfmd      port      0.0, 0.01, 0.7
  aenv1     expon     1.0, 0.03, 0.5
  kenv2     port      1.0, 0.008, 0.0
  aenv2     interp    kenv2
  aenv3     expon     1.0, 0.025, 0.5

  a_        oscili    1.0, kcps, 1
  a1        oscili    1.0, kcps * (1.0 + a_*kfmd), 1
  a_        oscili    1.0, kcpsx, 1
  a2        oscili    1.0, kcpsx * (1.0 + a_*kfmd), 1

  a3        unirand   2.0
  a3        =  a3 - 1.0
  a3        butterbp  a3, 5000, 7500
  a3        =  a3 * aenv2

  a0        =  a1 + a2*aenv3 + a3*1.0
  a0        =  a0 * aenv1

            vincr     ga0, a0*16000

endin

; ---- instr 90: stereo output ----

instr 90

  a_        =  ga0
            clear     ga0

  i_az_     =  -30
  i_el_     =  0
  i_d_      =  1.5
$PhseStereo

            outs      a_L_, a_R_

endin

