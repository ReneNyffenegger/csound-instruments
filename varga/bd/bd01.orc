  sr        =  48000
  ksmps     =  2
  nchnls    =  1

#include "base_macros.h.orc"

            seed      0

instr 1

  p3        =  p3 + 0.1

  icps      =  $MIDI2CPS(p4)
  ivel      limit     p5, 0, 127
  iamp      =  $VELOC2AMP(ivel)
  ifdec     =  0.025 * ((ivel / 127.0) * (ivel / 127.0) + 0.1072)

  kcps1     expon     1.0, ifdec, 0.5
  kcps2     expon     1.0, 0.32, 0.5
  kcps      =  (4.3333 * kcps1 + kcps2) * icps
  klpf      expon     1.0, 0.04, 0.5
  klpf2     expon     1.0, 0.0005, 0.5
  klpf2     =  klpf2 * 8.0
  kamp      port      1.0, 0.01, 0.5

  a1        oscili    1.0, kcps, 1, 0.25
  a1        limit     a1, -0.25, 0.25
  a1        tone      a1, kcps * (0.5 + klpf2)

  a2        unirand   2.0
  a3        unirand   2.0
  a2        =  (a2 - 1.0) * (a3 - 1.0)
  a_        tone      a2, 500.0
  a2        =  a2 - a_

  a1        butterlp  kamp * a1, 4.0 * (klpf + klpf2) * kcps
  a2        butterlp  kamp * a2, kcps
  a2        =  a2 * sqrt(klpf)
  a1        =  a1 + a2 * 1.0

  aenv      linseg    1.0, p3 - 0.1, 1.0, 0.05, 0.0, 1.0, 0.0

            out       a1 * iamp * aenv * 220000.0

endin

