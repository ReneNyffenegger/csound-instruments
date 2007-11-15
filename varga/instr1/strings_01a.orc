  sr        =  48000
  ksmps     =  64
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"

            massign   1, 1
            massign   2, 1
            massign   3, 1
            massign   4, 1
            massign   5, 1
            massign   6, 1
            massign   7, 1
            massign   8, 1
            massign   9, 1
            massign   10, 1
            massign   11, 1
            massign   12, 1
            massign   13, 1
            massign   14, 1
            massign   15, 1
            massign   16, 1

            pgmassign   0, 0

  ga01      init      0
  ga02      init      0

  itmp      ftgen     1, 0, 16384, 20, 3, 1       ; window
; LFO waveform
  itmp      ftgen     2, 0, 256, 7,  0, 16, 0.134, 16, 0.293, 16, 0.5, 16, 1, 16, 0.5, 16, 0.293, 16, 0.134, 16, 0, 16, -0.134, 16, -0.293, 16, -0.5, 16, -1, 16, -0.5, 16, -0.293, 16, -0.134, 16, 0
  itmp      ftgen     3, 0, 1024, 5, 0.0625, 512, 1, 512, 0.0625 ; EQ frequency
  itmp      ftgen     4, 0, 257, 7, 0, 257, 1     ; EQ level, Q

  itmp      ftgen     257, 0, 16384, 7, -1, 16384, 1 ; sawtooth wave
$FGEN_128(l1'256'4096'257'1'sr/2)

instr 1

/* ------------------------------------------------------------------------- */

  ivol      =  1700                 /* volume                                   */
  ibpm      =  142                  /* tempo                                    */

/* ------------------------------------------------------------------------- */

  imx01     =  5.6                  /* OSC 1 mix                                */
  imx02     =  0.0                  /* OSC 2 mix                                */
  iolp1     =  40                   /* OSC 1 overlap                            */

  iolps     =  1                    /* OSC 2 window overlap                     */
  iwsize    =  4                    /* OSC 2 window size * osc. frequency       */

  ifmd      =  0.02                 /* OSC 1,2 fm depth                         */

/* ------------------------------------------------------------------------- */

  ibtime    =  60/ibpm              /* beat time                                */

  imaxamp   =  1.4                  /* max. amplitude of envelope               */
  imaxt     =  3.0                  /* time in beats when max. amp. is reached  */

  iatt      =  ibtime * 2.00        /* attack time                              */
  irel      =  ibtime * 2.00        /* release time                             */

/* ------------------------------------------------------------------------- */

  iEQ1fa    =  1000                 /* EQ 1 frequency (Hz)                  */
  iEQ1fn    =  0                    /* EQ 1 frequency / note frequency      */
  iEQ1l     =  1.0                  /* EQ 1 level                           */
  iEQ1q     =  0.7071               /* EQ 1 Q                               */
  iEQ1m     =  0                    /* EQ 1 mode                            */

  iEQ2fa    =  1000                 /* EQ 2 frequency (Hz)                  */
  iEQ2fn    =  0                    /* EQ 2 frequency / note frequency      */
  iEQ2l     =  1.0                  /* EQ 2 level                           */
  iEQ2q     =  0.7071               /* EQ 2 Q                               */
  iEQ2m     =  0                    /* EQ 2 mode                            */

  iEQ3fa    =  1000                 /* EQ 3 frequency (Hz)                  */
  iEQ3fn    =  0                    /* EQ 3 frequency / note frequency      */
  iEQ3l     =  1.0                  /* EQ 3 level                           */
  iEQ3q     =  0.7071               /* EQ 3 Q                               */
  iEQ3m     =  0                    /* EQ 3 mode                            */

  iEQ4fa    =  12500                /* EQ 4 frequency (Hz)                  */
  iEQ4fn    =  0                    /* EQ 4 frequency / note frequency      */
  iEQ4l     =  0                    /* EQ 4 level                           */
  iEQ4q     =  2.8                  /* EQ 4 Q                               */
  iEQ4m     =  2                    /* EQ 4 mode                            */

  iLP1fa    =  0                    /* 1st order LP filter freq. (Hz)       */
  iLP1fn    =  4.0                  /* LP filter frequency / note frq.      */

/* ------------------------------------------------------------------------- */

; get note parameters

$M_NOTEPARM(irel'0.02)

; correct oscillator amplitudes for overlap

  imx01     =  imx01 / sqrt(iolp1)
  imx02     =  imx02 / sqrt(iolps)

; attack
  kamp1     linseg    1, iatt, 0, 1, 0
  kamp1     =  sqrt(abs(1 - (kamp1 * kamp1 * kamp1 * kamp1)))
  aamp1     interp    kamp1
; attack2 + decay
  aamp2     expseg    1, ibtime * imaxt, imaxamp, ibtime * imaxt, 1, 1, 1
; amp. envelope
  aamp      =  ivol * iamp * aamp1 * aamp2 * aenv * aenv

  kcps      cpsmidib  2                           ; note frequency

; ftable number
$CPS2FNUM(kfn'kcps'256)

  kdens     =  (kcps / iwsize) * iolps              /* grain parameters */
  kwsize    =  iwsize / kcps

/* oscillators */

  klfof1    =  kcps * 0.005                       ; LFO min. frequency
  klfof2    =  kcps * 0.01                        ; LFO max. frequency

; left channel

  a0L       grain3    kcps, 0.5, kcps * ifmd, 0.5, kwsize, kdens, iolps + 1, kfn, 1, -0.5, 0, 0, 2
  a0L       butterlp  a0L, 2000

  atmp      oscbnk    kcps, 0.0, kcps * ifmd, 0.0, iolp1, 0, klfof1, klfof2, 0.0, 0.0, 144, 0.0, 16000.0, 0.0, 0.0, 0.7071, 0.7071, 5, kfn, 2, 0, 3, 4, 4

  a0L       =  a0L * imx02 + atmp * imx01

; right channel

  a0R       grain3    kcps, 0.5, kcps * ifmd, 0.5, kwsize, kdens, iolps + 1, kfn, 1, -0.5, 0, 0, 2
  a0R       butterlp  a0R, 2000

  atmp      oscbnk    kcps, 0.0, kcps * ifmd, 0.0, iolp1, 0, klfof1, klfof2, 0.0, 0.0, 144, 0.0, 16000.0, 0.0, 0.0, 0.7071, 0.7071, 5, kfn, 2, 0, 3, 4, 4

  a0R       =  a0R * imx02 + atmp * imx01

  a0L       pareq     a0L, kcps * iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m  /* EQ */
  a0L       pareq     a0L, kcps * iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m
  a0L       pareq     a0L, kcps * iEQ3fn + iEQ3fa, iEQ3l, iEQ3q, iEQ3m
  a0L       pareq     a0L, kcps * iEQ4fn + iEQ4fa, iEQ4l, iEQ4q, iEQ4m

  a0R       pareq     a0R, kcps * iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m
  a0R       pareq     a0R, kcps * iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m
  a0R       pareq     a0R, kcps * iEQ3fn + iEQ3fa, iEQ3l, iEQ3q, iEQ3m
  a0R       pareq     a0R, kcps * iEQ4fn + iEQ4fa, iEQ4l, iEQ4q, iEQ4m

  a0Lx      tone      a0L, kcps * iLP1fn + iLP1fa        /* LP filter */
  a0Rx      tone      a0R, kcps * iLP1fn + iLP1fa
  a0L       =  a0L * 0.125 + a0Lx
  a0R       =  a0R * 0.125 + a0Rx

  a0L       =  a0L * aamp                   /* amp. envelope */
  a0R       =  a0R * aamp

            vincr     ga01, a0L                 /* send to output */
            vincr     ga02, a0R

endin

instr 80

  a1        =  ga01
  a2        =  ga02
            clear     ga01, ga02

$SPAT2(a1'-60'6.0)
$SPAT2(a2'60'6.0)

endin

$OUT3CH(90'"strings_01.pcm")

