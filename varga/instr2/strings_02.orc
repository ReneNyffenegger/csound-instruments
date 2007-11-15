  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"
#include "fgen.h.orc"

; window for osc 2
  itmp      ftgen     2, 0, 16384, 20, 3, 1
; LFO waveform for triangle distribution
  itmp      ftgen     4, 0, 256, 7,  0, 16, 0.134, 16, 0.293, 16, 0.5, 16, 1, 16, 0.5, 16, 0.293, 16, 0.134, 16, 0, 16, -0.134, 16, -0.293, 16, -0.5, 16, -1, 16, -0.5, 16, -0.293, 16, -0.134, 16, 0
; sawtooth wave
  itmp      ftgen     257, 0, 16384, 7, 1, 16384, -1
$FGEN_128(l1'256'4096'257'1'sr/2)

instr 1

  irel      =  0.5                                ; attack / release time

$S_NOTEPARM(irel'0.1)

  iamp      =  iamp * 2400.0                      ; output volume

; envelopes

  kamp1     linseg    1, irel, 0, 1, 0
  kamp1     =  sqrt(abs(1 - kamp1 * kamp1 * kamp1 * kamp1))
  aamp1     interp    kamp1                       ; attack

  kcps      =  icps                               ; osc 1, 2 frequency
  iovrlp    =  10                                 ; osc 2 overlap
$CPS2FNUM(kfnum'kcps'256)       ; table numbers

#define OSCILLATOR #

; osc 1

  kl1minf   =  0.005 * kcps                       ; LFO min. frequency
  kl1maxf   =  0.01 * kcps                        ; LFO max. frequency

  a1        oscbnk    kcps, 0.0, kcps * 0.016, 0.0, 10, 0, kl1minf, kl1maxf, 0.0, 0.0, 128, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, kfnum, 4, 0, 0, 0, 0

  a1        tone      a1, kcps * 8.0

; osc 2

  kwsiz     =  4.0 / kcps                         ; grain duration
  a2        grain2    kcps, kcps * 0.016, kwsiz, iovrlp, kfnum, 2, -0.5, 0, 2

  a2x       tone      a2, 10000
  a2        =  a2 - a2x

  kffrq     limit     kcps * 32, 20, 10000
  a0        =  a1 + a2 * (400 / kcps)             ; mix output
  a0        pareq     a0, kffrq, 0, 1, 2          ; and resonant lowpass

  a0        =  a0 * aamp1 * (aenv * aenv) * iamp  ; output: a0

#

/* LEFT channel */

$OSCILLATOR
$SPAT2(a0'-60'2)

/* RIGHT channel */

$OSCILLATOR
$SPAT2(a0'60'2)

endin

/* ------ output instrument ------ */

$OUT3CH(90'"strings_02.pcm")

