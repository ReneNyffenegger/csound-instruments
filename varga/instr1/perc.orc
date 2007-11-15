  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"

  gafx1     init      0
  gafx2     init      0
  gafx3     init      0
  gafx4     init      0

  gixtime   =  0.2                                ; extra time in seconds
  givol     =  0.5                                ; global volume
  giqual    =  32                                 ; interpolation quality
  gidelq    =  32                                 ; delay quality

instr 1

;ifn    =  p4
  ifn       notnum    
  ifn       =  int(ifn + 100.5)                   ; parameter table

  ifn2      table     0, ifn                      ; input table
  ivol      table     1, ifn                      ; volume
  idel      table     2, ifn                      ; delay (seconds)
  iazim     table     3, ifn                      ; azimuth (degrees)
  idist     table     4, ifn                      ; distance (meters)
  itrns     table     5, ifn                      ; transpose (semitones)
  iatt      table     6, ifn                      ; attack time (seconds)
  idec      table     7, ifn                      ; decay time (seconds)
  isus      table     8, ifn                      ; sustain level
  irel      table     9, ifn                      ; release time (seconds)
  ieq1f     table     10, ifn                     ; EQ1 frequency (Hz)
  ieq1l     table     11, ifn                     ; EQ1 level
  ieq1q     table     12, ifn                     ; EQ1 Q
  ieq1m     table     13, ifn                     ; EQ1 mode
  ieq2f     table     14, ifn                     ; EQ2 frequency (Hz)
  ieq2l     table     15, ifn                     ; EQ2 level
  ieq2q     table     16, ifn                     ; EQ2 Q
  ieq2m     table     17, ifn                     ; EQ2 mode
  ifx1      table     18, ifn                     ; effect 1 send
  ifx2      table     19, ifn                     ; effect 2 send
  ifx3      table     20, ifn                     ; effect 3 send
  ifx4      table     21, ifn                     ; effect 4 send

$M_NOTEPARM(irel'gixtime)

  isr0      =  ftsr(ifn2)                         ; sample rate of input table
  isr0      =  (isr0 < 0.5 ? 44100 : isr0)

; oscillator
  itrns     =  $NOTE2FRQ(itrns) * (isr0 / sr)
  a1        lphasor   itrns
  a1        limit     a1, 0, ftlen(ifn2) - 16
  a0        tablexkt  a1, ifn2, itrns, giqual, 0, 0, 0

; equalizer
  a0        pareq     a0, ieq1f, ieq1l, ieq1q, ieq1m
  a0        pareq     a0, ieq2f, ieq2l, ieq2q, ieq2m

; envelopes
  iatt      limit     iatt, 1.1 / sr, 100
  idec      limit     idec, 1.1 / sr, 100
  a1        linseg    0, iatt, 1, 1, 1
  a2        expseg    1, iatt, 1, idec, isus, 1, isus

  iamp      =  iamp * ivol * givol

  a1        =  a0 * a1 * a2 * (aenv * aenv) * iamp
  a0        delay     a1, idel

; send signal for effects
            vincr     gafx1, a0 * ifx1
            vincr     gafx2, a0 * ifx2
            vincr     gafx3, a0 * ifx3
            vincr     gafx4, a0 * ifx4

; spatialize and send to output

$SPAT2(a0'iazim'idist)

endin

/* instr 11: effect 1 (chorus 1) */

instr 11

  a0        =  gafx1

  adel1     oscils    0.005, 0.1, 0.00, 2
  adel2     oscils    0.005, 0.1, 0.25, 2

  atmp      delayr    0.05

  a1        deltapx   adel1 + 0.020, gidelq
  a2        deltapx   adel2 + 0.020, gidelq

            delayw    a0

$SPAT2(a1'-90'4)
$SPAT2(a2' 90'4)

            clear     gafx1

endin

/* instr 12: effect 2 (chorus 2) */

instr 12

  a0        =  gafx2

  adel3     oscils    0.005, 0.1, 0.50, 2
  adel4     oscils    0.005, 0.1, 0.75, 2

  atmp      delayr    0.05

  a3        deltapx   adel3 + 0.035, gidelq
  a4        deltapx   adel4 + 0.035, gidelq

            delayw    a0

$SPAT2(a3' 60'4)
$SPAT2(a4'-60'4)

            clear     gafx2

endin

/* instr 13: effect 3 */

instr 13

            clear     gafx3

endin

/* instr 14: effect 4 */

instr 14

            clear     gafx4

endin

/* output instrument */

$OUT3CH(90'"/dev/null")

