/* synth string instrument - written by Istvan Varga, 2002 */

  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"
#include "ctrl.h.orc"

            massign   1, 2                        ; assign all channels to instr 2
            massign   2, 2
            massign   3, 2
            massign   4, 2
            massign   5, 2
            massign   6, 2
            massign   7, 2
            massign   8, 2
            massign   9, 2
            massign   10, 2
            massign   11, 2
            massign   12, 2
            massign   13, 2
            massign   14, 2
            massign   15, 2
            massign   16, 2

            pgmassign   0, 0                      ; disable program changes

  ga01      init      0
  ga02      init      0

  giEQmin   =  0.25                 /* resonant lowpass min. frequency / max.   */
                                /* frequency                                */

  itmp      ftgen     1, 0, 16384, 20, 3, 1       ; window
; LFO waveform
  itmp      ftgen     2, 0, 256, 7,  0, 16, 0.134, 16, 0.293, 16, 0.5, 16, 1, 16, 0.5, 16, 0.293, 16, 0.134, 16, 0, 16, -0.134, 16, -0.293, 16, -0.5, 16, -1, 16, -0.5, 16, -0.293, 16, -0.134, 16, 0

  itmp      ftgen     3, 0, 1024, 5, giEQmin, 512, 1, 512, giEQmin ; EQ frequency
  itmp      ftgen     4, 0, 257, 7, 0, 257, 1     ; EQ level, Q

  itmp      ftgen     5, 0, 16384, 20, 3, 1       ; window for granular synthesis

  itmp      ftgen     257, 0, 16384, 7, -1, 16384, 1 ; sawtooth wave
$FGEN_128(l1'256'4096'257'1'sr/2)

instr 2

/* ------------------------------------------------------------------------- */

  ivol      =  20000                /* volume                                   */
  ibpm      =  150                  /* tempo                                    */

/* ------------------------------------------------------------------------- */

  iolp1     =  20                   /* oscillator bank overlap                  */

  iLFOf0a   =  0                    /* LFO min. frequency (in Hz)               */
  iLFOf0n   =  0.005                /* LFO min. frequency / note frequency      */
  iLFOf1a   =  0                    /* LFO max. frequency (in Hz)               */
  iLFOf1n   =  0.01                 /* LFO max. frequency / note frequency      */

  ifmd      =  0.015                /* LFO to oscillator frequency depth        */
                                /* (also grain frequency variation)         */
  iEQmxfa   =  16000                /* resonant lowpass max. frequency (in Hz)  */
  iEQmxfn   =  0                    /* resonant lowpass max. frq. / note freq.  */
                                /* (for min. frequency, see giEQmin above)  */
  iEQ_Q     =  1.0                  /* lowpass resonance (0.7071: not resonant) */

  iolp2     =  10                   /* granular synthesis overlap (0: disable)  */
  imx02     =  0.01                 /* granular synth output level              */

  igdura    =  0                    /* grain duration (in seconds)              */
  igdurn    =  2.0                  /* grain duration * note frequency          */

/* ------------------------------------------------------------------------- */

  ibtime    =  60/ibpm              /* beat time                                */

  imaxamp   =  1.4                  /* max. amplitude of envelope               */
  imaxt     =  3.0                  /* time in beats when max. amp. is reached  */

  iatt      =  ibtime * 2.00        /* attack time                              */
  irel      =  ibtime * 2.00        /* release time                             */

/* ------------------------------------------------------------------------- */

; filters for oscillator bank

  iEQ1fa    =  1000                 /* EQ 1 frequency (Hz)                  */
  iEQ1fn    =  0                    /* EQ 1 frequency / note frequency      */
  iEQ1l     =  1.0                  /* EQ 1 level                           */
  iEQ1q     =  0.7071               /* EQ 1 Q                               */
  iEQ1m     =  0                    /* EQ 1 mode                            */

  iLP1fa    =  0                    /* 1st order LP filter freq. (Hz)       */
  iLP1fn    =  6.0                  /* LP filter frequency / note frq.      */
  iLP1l     =  0.111                /* 1st order LP filter level at sr/2    */

; filters for granular synth

  iEQ2fa    =  1000                 /* EQ 2 frequency (Hz)                  */
  iEQ2fn    =  0                    /* EQ 2 frequency / note frequency      */
  iEQ2l     =  1.0                  /* EQ 2 level                           */
  iEQ2q     =  0.7071               /* EQ 2 Q                               */
  iEQ2m     =  0                    /* EQ 2 mode                            */

  iEQ3fa    =  5000                 /* EQ 3 frequency (Hz)                  */
  iEQ3fn    =  0                    /* EQ 3 frequency / note frequency      */
  iEQ3l     =  0.0                  /* EQ 3 level                           */
  iEQ3q     =  0.7071               /* EQ 3 Q                               */
  iEQ3m     =  2                    /* EQ 3 mode                            */

; output filters

  iEQ4fa    =  1000                 /* EQ 4 frequency (Hz)                  */
  iEQ4fn    =  0                    /* EQ 4 frequency / note frequency      */
  iEQ4l     =  1.0                  /* EQ 4 level                           */
  iEQ4q     =  0.7071               /* EQ 4 Q                               */
  iEQ4m     =  0                    /* EQ 4 mode                            */

/* ------------------------------------------------------------------------- */

; get note parameters

$M_NOTEPARM(irel'0.02)

; correct oscillator amplitudes for overlap

  imx01     =  1 / sqrt(iolp1)
  imx02     =  imx02 / sqrt(iolp2)

/* ---------------- envelopes ---------------- */

; polyphonic pressure
  kaft      polyaft   inote, 0, 127
$INTERP_K(kaft'0.01)
  kaft      =  $VELOC2AMP(kaft)
; aamp1 = attack + aftertouch
  kamp1     linseg    1, iatt, 0, 1, 0
  kamp1     =  sqrt(abs(1 - (kamp1 * kamp1 * kamp1 * kamp1)))
  aamp1     interp    kamp1 * kaft
; aamp2 = attack2 + decay
  aamp2     expseg    1, ibtime * imaxt, imaxamp, ibtime * imaxt, 1, 1, 1
; amp. envelope
  aamp      =  ivol * iamp * aamp1 * aamp2 * aenv * aenv

  kcps      cpsmidib  2                           ; note frequency

; ftable number
$CPS2FNUM(kfn'kcps'256)

/* ---------------- oscillators ---------------- */

/* oscillator bank */

  klfof1    =  iLFOf0a + kcps * iLFOf0n           ; LFO min. frequency
  klfof2    =  iLFOf1a + kcps * iLFOf1n           ; LFO max. frequency

  kEQmaxf   =  iEQmxfa + kcps * iEQmxfn           ; resonant lowpass max. freq.

; left channel

  a0L       oscbnk    kcps, 0.0, kcps * ifmd, 0.0, iolp1, 0, klfof1, klfof2, 0.0, 0.0, 144, 0.0, kEQmaxf, 0.0, 0.0, iEQ_Q, iEQ_Q, 5, kfn, 2, 0, 3, 4, 4

; right channel

  a0R       oscbnk    kcps, 0.0, kcps * ifmd, 0.0, iolp1, 0, klfof1, klfof2, 0.0, 0.0, 144, 0.0, kEQmaxf, 0.0, 0.0, iEQ_Q, iEQ_Q, 5, kfn, 2, 0, 3, 4, 4

/* granular synth */

if (iolp2 < 0.5) goto l01                         ; skip if disabled

  kgdur     =  igdura + (igdurn / kcps)           ; grain duration
  kampx     =  sr / (6.28 * kcps)                 ; correct amplitude for differentiation

; left channel

  a1L       grain2    kcps, kcps * ifmd, kgdur, iolp2, kfn, 5, -0.5, 0, 2
; differentiate
  atmp      delay1    a1L
  a1L       =  kampx * (a1L - atmp)

; right channel

  a1R       grain2    kcps, kcps * ifmd, kgdur, iolp2, kfn, 5, -0.5, 0, 2
; differentiate
  atmp      delay1    a1R
  a1R       =  kampx * (a1R - atmp)

l01:

/* ---------------- filters ---------------- */

  a0L       pareq     a0L, kcps * iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m  /* EQ */
  a0R       pareq     a0R, kcps * iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m

  a0Lx      tone      a0L, kcps * iLP1fn + iLP1fa        /* 1st order lowpass */
  a0Rx      tone      a0R, kcps * iLP1fn + iLP1fa
  a0L       =  imx01 * (a0L * iLP1l + a0Lx * (1 - iLP1l))
  a0R       =  imx01 * (a0R * iLP1l + a0Rx * (1 - iLP1l))

if (iolp2 < 0.5) goto l02                         ; skip these if granular synthesis
                                        ; is disabled
; equalizers for granular synth

  a1L       pareq     a1L, kcps * iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m
  a1R       pareq     a1R, kcps * iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m

  a1L       pareq     a1L, kcps * iEQ3fn + iEQ3fa, iEQ3l, iEQ3q, iEQ3m
  a1R       pareq     a1R, kcps * iEQ3fn + iEQ3fa, iEQ3l, iEQ3q, iEQ3m

            vincr     a0L, a1L * imx02            ; mix granular signal to output
            vincr     a0R, a1R * imx02

l02:

  a0L       pareq     a0L, kcps * iEQ4fn + iEQ4fa, iEQ4l, iEQ4q, iEQ4m  /* output */
  a0R       pareq     a0R, kcps * iEQ4fn + iEQ4fa, iEQ4l, iEQ4q, iEQ4m  /* EQ     */

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

$OUT3CH(90'"strings_03.pcm")

