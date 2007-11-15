/* bass_05.orc - written by Istvan Varga, 2002 */

  sr        =  44100
  ksmps     =  10
  nchnls    =  1

#define Osc01(XNUM) #

  itmp      rnd31     1, 0, 0                     ; add random variation
  iamp$XNUM       =  iamp$XNUM * (1               + itmp  * iAMd) ; to amplitude,
  ifrq$XNUM       rnd31 1   , 0, 0
  ifrq$XNUM       =  1  + ifrq$XNUM * iFMd        ; frequency,
  kfrq$XNUM       =  kfrq   * ifrq$XNUM
  itmp      rnd31     1, 0, 0
  iphs$XNUM       wrap  iphs$XNUM + itmp          * iPMd, 0, 1 ; and start phase

  atmp      phasor    kfrq$XNUM, iphs$XNUM        ; sawtooth oscillator
            vincr     a0, iamp$XNUM * 2 * (0.5 - atmp)

#

instr 1

  iphs00    =  0.0                                ; start phase 0
  iphs01    =  0.4                                ; start phase 1
  iphs02    =  0.25                               ; start phase 2
  iphs03    =  0.75                               ; start phase 3
  iphs04    =  0.0                                ; start phase 4
  iphs05    =  0.125                              ; start phase 5
  iphs06    =  0.25                               ; start phase 6
  iphs07    =  0.375                              ; start phase 7
  iphs08    =  0.5                                ; start phase 8
  iphs09    =  0.625                              ; start phase 9
  iphs10    =  0.75                               ; start phase 10
  iphs11    =  0.875                              ; start phase 11
  iphs12    =  0.0                                ; start phase 12
  iphs13    =  0.25                               ; start phase 13
  iphs14    =  0.5                                ; start phase 14
  iphs15    =  0.75                               ; start phase 15

  iamp00    =  1.0                                ; amplitude 0
  iamp01    =  -1.0                               ; amplitude 1
  iamp02    =  0.5                                ; amplitude 2
  iamp03    =  0.5                                ; amplitude 3
  iamp04    =  0.125                              ; amplitude 4
  iamp05    =  0.125                              ; amplitude 5
  iamp06    =  -0.125                             ; amplitude 6
  iamp07    =  0.125                              ; amplitude 7
  iamp08    =  0.125                              ; amplitude 8
  iamp09    =  0.125                              ; amplitude 9
  iamp10    =  -0.125                             ; amplitude 10
  iamp11    =  0.125                              ; amplitude 11
  iamp12    =  0.125                              ; amplitude 12
  iamp13    =  0.125                              ; amplitude 13
  iamp14    =  -0.125                             ; amplitude 14
  iamp15    =  0.125                              ; amplitude 15

  iatt      =  0.005                              ; attack time
  irel      =  0.1                                ; release time

  iFMd      =  0.01                               ; random frequency variation (0..1)
  iPMd      =  0.005                              ; random phase variation (0..1)
  iAMd      =  0.05                               ; random amplitude variation (0..1)

; -------------------------------------------------------------

  p3        =  p3 + irel                          ; extend note duration

  icps      =  440.0 * exp(log(2) * (p4 - 69) / 12) ; note frequency

  kcps      port      1, 0.01, 0.5                ; oscillator frequency
  kfrq      =  kcps * icps                        ; envelope

  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity
; amp. envelope (attack, release)
  aamp      linseg    0, iatt, 1, p3 - (iatt + irel), 1, irel, 0, 1, 0
  aamp      =  aamp * aamp

  itmp      rnd31     1, 0, 14                    ; set random seed

  a0        =  0                                  ; initialize acccumulator

$Osc01(00)
$Osc01(01)
$Osc01(02)
$Osc01(03)
$Osc01(04)
$Osc01(05)
$Osc01(06)
$Osc01(07)
$Osc01(08)
$Osc01(09)
$Osc01(10)
$Osc01(11)
$Osc01(12)
$Osc01(13)
$Osc01(14)
$Osc01(15)

  atmp2     tone      a0, 1500                    ; filters
  atmp      =  a0 - atmp2
  a0        =  a0 - 4 * atmp
  atmp      butterlp  a0, icps * 2
  a0        =  a0 - 2 * atmp
  a0        butterlp  a0, 3000
  a0        =  taninv(a0 * 0.7 * iamp) * 20000    ; distortion

  a0        pareq     a0, 5000, 0, 0.6, 2         ; output lowpass

            out       a0 * aamp

endin

