  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"
#include "ctrl.h.orc"

; sawtooth wave
  itmp      ftgen     301, 0, 16384, 7, 1, 16384, -1
$FGEN_128(l01'300'4096'301'1'sr/2)

            zakinit   1, 2048                     ; allocate space for controllers

  ichn      =  1
l02:
            massign   ichn, 2                     ; assign all channels to instr 2
$M_CTRLINIT(0'ichn'24'96)               ; initialize controllers
$M_CTRLINIT(0'ichn'25'64)
$M_CTRLINIT(0'ichn'26'64)
$M_CTRLINIT(0'ichn'27'64)
$M_CTRLINIT(0'ichn'28'16)
  ichn      =  ichn + 1
if (ichn < 16.5) igoto l02

            pgmassign   0, 0                      ; disable program changes

  ga01      init      0
  ga02      init      0

instr 1

$M_CTRL0(0'1'24)                ; get controller data
$M_CTRL0(0'2'24)                ; filter frequency
$M_CTRL0(0'3'24)
$M_CTRL0(0'4'24)

$M_CTRL0(0'1'25)                ; filter resonance
$M_CTRL0(0'2'25)
$M_CTRL0(0'3'25)
$M_CTRL0(0'4'25)

$M_CTRL0(0'1'26)                ; distortion
$M_CTRL0(0'2'26)
$M_CTRL0(0'3'26)
$M_CTRL0(0'4'26)

$M_CTRL0(0'1'27)                ; azimuth
$M_CTRL0(0'2'27)
$M_CTRL0(0'3'27)
$M_CTRL0(0'4'27)

$M_CTRL0(0'1'28)                ; sound source separation
$M_CTRL0(0'2'28)
$M_CTRL0(0'3'28)
$M_CTRL0(0'4'28)

endin

instr 2

  ichn      midichn   
$M_NOTEPARM(0.05'0.02)
$CPS2FNUM(ifn'icps'300)

  iphs1     rnd31     1, 0, 0                     ; osc 1
  ifrq1     rnd31     1, 0, 0
  a1        oscili    1, icps * (1 + ifrq1 * 0.025), ifn, abs(iphs1)

  iphs2     rnd31     1, 0, 0                     ; osc 2
  ifrq2     rnd31     1, 0, 0
  a2        oscili    1, icps * (1 + ifrq2 * 0.025), ifn, abs(iphs2)

  iphs3     rnd31     1, 0, 0                     ; osc 3
  ifrq3     rnd31     1, 0, 0
  a3        oscili    1, icps * (1 + ifrq3 * 0.025), ifn, abs(iphs3)

  iphs4     rnd31     1, 0, 0                     ; osc 4
  ifrq4     rnd31     1, 0, 0
  a4        oscili    1, icps * (1 + ifrq4 * 0.025), ifn, abs(iphs4)

  iphs5     rnd31     1, 0, 0                     ; osc 5
  ifrq5     rnd31     1, 0, 0
  a5        oscili    1, icps * (1 + ifrq5 * 0.025), ifn, abs(iphs5)

  iphs6     rnd31     1, 0, 0                     ; osc 6
  ifrq6     rnd31     1, 0, 0
  a6        oscili    1, icps * (1 + ifrq6 * 0.025), ifn, abs(iphs6)

  iphs7     rnd31     1, 0, 0                     ; osc 7
  ifrq7     rnd31     1, 0, 0
  a7        oscili    1, icps * (1 + ifrq7 * 0.025), ifn, abs(iphs7)

  iphs8     rnd31     1, 0, 0                     ; osc 8
  ifrq8     rnd31     1, 0, 0
  a8        oscili    1, icps * (1 + ifrq8 * 0.025), ifn, abs(iphs8)

  a1        butterhp  a1 + a3 + a5 + a7, icps * 1.0
  a2        butterhp  a2 + a4 + a6 + a8, icps * 1.0

$Z_CTRLI(kffrq'0'ichn'24'0.02)
$Z_CTRLI(kfres'0'ichn'25'0.02)
$Z_CTRLI(kdist'0'ichn'26'0.02)

  kffrq     =  $MIDI2CPS(kffrq)                   ; resonant lowpass
  kfres     =  exp(log(10) * (kfres - 64) / 64)
  a1        pareq     a1, kffrq, 0, kfres, 2
  a2        pareq     a2, kffrq, 0, kfres, 2

  kdist     =  exp(log(10) * (kdist - 64) / 64)   ; add some distortion
  a1        =  taninv(a1 * kdist) / kdist
  a2        =  taninv(a2 * kdist) / kdist

  aenv2     linseg    0, 0.005, 1, 1, 1           ; attack

  a1        =  a1 * (aenv * aenv) * aenv2 * iamp * 2500
  a2        =  a2 * (aenv * aenv) * aenv2 * iamp * 2500

            vincr     ga01, a1
            vincr     ga02, a2

endin

instr 80

  a1        =  ga01
  a2        =  ga02
            clear     ga01, ga02

$Z_CTRL(kazim'0'2'27)
$Z_CTRL(kazmd'0'2'28)

  kazim     =  (kazim - 64) * 180 / 64            ; azimuth
  kazL      =  kazim - (kazmd * 90 / 127)
  kazR      =  kazim + (kazmd * 90 / 127)

$SPAT2D(a1'kazL'0.75)
$SPAT2D(a2'kazR'0.75)

endin

$OUT3CH(90'"synth_01.pcm")

