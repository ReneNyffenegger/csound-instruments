  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"

; sawtooth wave
  itmp      ftgen     301, 0, 16384, 7, 1, 16384, -1
$FGEN_128(l01'300'4096'301'1'sr/2)

instr 1

$M_NOTEPARM(0.05'0.02)
$CPS2FNUM(ifn'icps'300)

  alfo1     oscils    0.015 * icps, 8, 0
  alfoenv   linseg    0, 0.05, 1, 1, 1
  alfo1     =  alfo1 * alfoenv

  iphs1     rnd31     1, 0, 0
  ifrq1     rnd31     0.01 * icps, -0.3, 0
  iphs2     rnd31     1, 0, 0
  ifrq2     rnd31     0.01 * icps, -0.3, 0
  iphs3     rnd31     1, 0, 0
  ifrq3     rnd31     0.01 * icps, -0.3, 0
  iphs4     rnd31     1, 0, 0
  ifrq4     rnd31     0.01 * icps, -0.3, 0
  iphs5     rnd31     1, 0, 0
  ifrq5     rnd31     0.01 * icps, -0.3, 0
  iphs6     rnd31     1, 0, 0
  ifrq6     rnd31     0.01 * icps, -0.3, 0
  iphs7     rnd31     1, 0, 0
  ifrq7     rnd31     0.01 * icps, -0.3, 0
  iphs8     rnd31     1, 0, 0
  ifrq8     rnd31     0.01 * icps, -0.3, 0

  a1        oscili    1, icps + ifrq1, ifn, abs(iphs1)
  a2        oscili    1, icps + ifrq2, ifn, abs(iphs2)
  a3        oscili    1, icps + ifrq3, ifn, abs(iphs3)
  a4        oscili    1, icps + ifrq4, ifn, abs(iphs4)
  a5        oscili    1, icps + ifrq5 + alfo1, ifn, abs(iphs5)
  a6        oscili    1, icps + ifrq6 + alfo1, ifn, abs(iphs6)
  a7        oscili    1, icps + ifrq7 + alfo1, ifn, abs(iphs7)
  a8        oscili    1, icps + ifrq8 + alfo1, ifn, abs(iphs8)

  ax1       =  a1 + a2 + a3 + a4
  ax2       =  a5 + a6
  ax3       =  a7 + a8

  kffrq     port      icps * 4, 0.1, icps * 12    ; filter envelopes
  kffrq2    port      1, 0.003, 0.01
  kffrq     =  kffrq * kffrq2

  ax1       pareq     ax1, icps * 2, 0, 2, 1      ; filters
  ax1       pareq     ax1, kffrq, 0, 1, 2
  ax1       pareq     ax1, kffrq, 0, 1, 2

  ax2       pareq     ax2, icps * 2, 0, 2, 1
  ax2       pareq     ax2, kffrq, 0, 1, 2
  ax2       pareq     ax2, kffrq, 0, 1, 2

  ax3       pareq     ax3, icps * 2, 0, 2, 1
  ax3       pareq     ax3, kffrq, 0, 1, 2
  ax3       pareq     ax3, kffrq, 0, 1, 2

  aenv2     expon     1, 0.2, 0.5                 ; decay

  ax1       =  ax1 * (aenv * aenv) * aenv2 * iamp * 4000
  ax2       =  ax2 * (aenv * aenv) * aenv2 * iamp * 4000
  ax3       =  ax3 * (aenv * aenv) * aenv2 * iamp * 4000

$SPAT2(ax1'10'0.9)
$SPAT2(ax2'-40'0.9)
$SPAT2(ax3'60'0.9)

endin

$OUT3CH(90'"t3.pcm")

