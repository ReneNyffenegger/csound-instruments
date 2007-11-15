  sr        =  48000
  ksmps     =  2
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"

; window for osc 2
  itmp      ftgen     1, 0, 16384, 20, 3, 1
; LFO waveform for triangle distribution
  itmp      ftgen     4, 0, 256, 7,  0, 16, 0.134, 16, 0.293, 16, 0.5, 16, 1, 16, 0.5, 16, 0.293, 16, 0.134, 16, 0, 16, -0.134, 16, -0.293, 16, -0.5, 16, -1, 16, -0.5, 16, -0.293, 16, -0.134, 16, 0
; sawtooth wave
  itmp      ftgen     257, 0, 16384, 7, 1, 16384, -1
$FGEN_128(l1'256'4096'257'1'sr/2)

instr 1

/* ------------------------------------------------------------------------- */

  ivol      =  500                  /* volume                                   */
  ibpm      =  134                  /* tempo                                    */

/* ------------------------------------------------------------------------- */

  imx01     =  1.0                  /* OSC 1 mix                                */
  imx02     =  0.125                /* OSC 2 mix                                */

  iolps     =  8                    /* OSC 2 window overlap                     */
  iwsize    =  4                    /* OSC 2 window size                        */

  ifmd      =  0.02                 /* OSC 1,2 fm depth                         */

/* ------------------------------------------------------------------------- */

  ibtime    =  60/ibpm              /* beat time                                */

  imaxamp   =  1.0                  /* max. amplitude of envelope               */
  imaxt     =  4                    /* time in beats when max. amp. is reached  */

  iatt      =  0.005                /* attack time                              */
  irel      =  0.03                 /* release time                             */

/* ------------------------------------------------------------------------- */

  iEQ1fa    =  800                  /* EQ 1 frequency (Hz)                  */
  iEQ1fn    =  0                    /* EQ 1 frequency / note frequency      */
  iEQ1l     =  4.0                  /* EQ 1 level                           */
  iEQ1q     =  4.0                  /* EQ 1 Q                               */
  iEQ1m     =  0                    /* EQ 1 mode                            */

  iEQ2fa    =  1150                 /* EQ 2 frequency (Hz)                  */
  iEQ2fn    =  0                    /* EQ 2 frequency / note frequency      */
  iEQ2l     =  4.0                  /* EQ 2 level                           */
  iEQ2q     =  4.0                  /* EQ 2 Q                               */
  iEQ2m     =  0                    /* EQ 2 mode                            */

  iEQ3fa    =  2800                 /* EQ 3 frequency (Hz)                  */
  iEQ3fn    =  0                    /* EQ 3 frequency / note frequency      */
  iEQ3l     =  8.0                  /* EQ 3 level                           */
  iEQ3q     =  8.0                  /* EQ 3 Q                               */
  iEQ3m     =  0                    /* EQ 3 mode                            */

  iEQ4fa    =  12500                /* EQ 4 frequency (Hz)                  */
  iEQ4fn    =  0                    /* EQ 4 frequency / note frequency      */
  iEQ4l     =  4.0                  /* EQ 4 level                           */
  iEQ4q     =  4.0                  /* EQ 4 Q                               */
  iEQ4m     =  0                    /* EQ 4 mode                            */

  iEQ5fa    =  7000                 /* EQ 5 frequency (Hz)                  */
  iEQ5fn    =  0                    /* EQ 5 frequency / note frequency      */
  iEQ5l     =  4.0                  /* EQ 5 level                           */
  iEQ5q     =  0.7071               /* EQ 5 Q                               */
  iEQ5m     =  2                    /* EQ 5 mode                            */

  iLP1fa    =  0                    /* 1st order LP filter freq. (Hz)       */
  iLP1fn    =  4                    /* LP filter frequency / note frq.      */

/* ------------------------------------------------------------------------- */

  iazim1    =  -60                  /* azimuth 1                            */
  iazim2    =  -30                  /* azimuth 2                            */
  idist     =  1.0                  /* distance                             */

/* ------------------------------------------------------------------------- */

$S_NOTEPARM(irel'0.05)

; amp. envelopes

  aamp      linseg    0, iatt, 1, 1, 1            ; attack
  aamp2     =  aenv * aenv                        ; release
; attack 2 + decay
  aamp3     expseg    1, ibtime*imaxt, imaxamp, ibtime*imaxt, 1, 1, 1
  aamp      =  ivol * iamp * aamp * aamp2 * aamp3

  kcps      =  icps                               ; oscillator frequency
$CPS2FNUM(kfn'kcps'256)

  kwsize    =  iwsize / kcps                      ; grain duration

  kl1minf   =  0.01 * kcps                        ; LFO min. frequency
  kl1maxf   =  0.02 * kcps                        ; LFO max. frequency

; left channel

; osc 1

  a1        oscbnk    kcps, 0.0, kcps * ifmd, 0.0, 16, 0, kl1minf, kl1maxf, 0.0, 0.0, 128, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, kfn, 4, 0, 0, 0, 0

; osc 2

  a2        grain2    kcps, kcps * ifmd, kwsize, iolps, kfn, 1, -0.5, 0, 2

  a0L       =  a1 * imx01 + a2 * imx02

; right channel

; osc 1

  a1        oscbnk    kcps, 0.0, kcps * ifmd, 0.0, 16, 0, kl1minf, kl1maxf, 0.0, 0.0, 128, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, kfn, 4, 0, 0, 0, 0

; osc 2

  a2        grain2    kcps, kcps * ifmd, kwsize, iolps, kfn, 1, -0.5, 0, 2

  a0R       =  a1 * imx01 + a2 * imx02

  a0L       pareq     a0L, kcps * iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m  /* EQ */
  a0L       pareq     a0L, kcps * iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m
  a0L       pareq     a0L, kcps * iEQ3fn + iEQ3fa, iEQ3l, iEQ3q, iEQ3m
  a0L       pareq     a0L, kcps * iEQ4fn + iEQ4fa, iEQ4l, iEQ4q, iEQ4m
  a0L       pareq     a0L, kcps * iEQ5fn + iEQ5fa, iEQ5l, iEQ5q, iEQ5m

  a0R       pareq     a0R, kcps * iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m
  a0R       pareq     a0R, kcps * iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m
  a0R       pareq     a0R, kcps * iEQ3fn + iEQ3fa, iEQ3l, iEQ3q, iEQ3m
  a0R       pareq     a0R, kcps * iEQ4fn + iEQ4fa, iEQ4l, iEQ4q, iEQ4m
  a0R       pareq     a0R, kcps * iEQ5fn + iEQ5fa, iEQ5l, iEQ5q, iEQ5m

  a0L       tone      a0L, kcps * iLP1fn + iLP1fa        /* LP filter */
  a0R       tone      a0R, kcps * iLP1fn + iLP1fa

  a0L       =  a0L * aamp                   /* amp. envelope */
  a0R       =  a0R * aamp

; send to output

$SPAT2(a0L'iazim1'idist)
$SPAT2(a0R'iazim2'idist)

endin

$OUT3CH(90'"aaah1.pcm")

