/* bass_02.orc - organ-like bass with bass drum. */
/*               Written by Istvan Varga, 2002   */

  sr        =  44100
  ksmps     =  10
  nchnls    =  1

  gibpm     =  140                                ; tempo

instr 1         /* bass */

  iatt      =  0.002                              ; attack time
  imaxamp   =  1.333                              ; max. amplitude at attack end
  idec      =  0.005                              ; decay time
  irel      =  0.02                               ; release time

  imaxfrq   =  2.0                                ; max freq. / base frequency
  ifrqdec   =  0.0025                             ; freq. decay time

; ------------------------------------------------------------

  p3        =  p3 + irel                          ; extend note duration by release
  imaxamp   =  sqrt(imaxamp)                      ; square root to correct aamp * aamp

  icps      =  440.0*exp(log(2.0)*(p4-69.0)/12.0) ; note frequency
; oscillator frequency envelopes
  kcps      port      1, ifrqdec, imaxfrq
  kcps2     port      1, 0.0002, 16
  kcps      =  kcps * icps * kcps2

  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity -> amplitude
; amplitude envelope (attack, decay, sustain, release)
  aamp      linseg    0, iatt, imaxamp, idec, 1, p3-(iatt+idec+irel), 1, irel, 0, 1, 0
  aamp      =  iamp * aamp * aamp

  a1        oscili    aamp * 17000, kcps, 1, 0    ; oscillator

  kffrq     port      0, (60 / gibpm) * 0.5, icps * 8.0 ; lowpass filter envelopes
  kffrq2    port      0, 0.0005, 10000
  a1        pareq     a1, 5000, 16.0, 0.7071, 2   ; boost high frqs first
  a1        pareq     a1, kffrq + kffrq2, 0, 0.7071, 2 ; then lowpass

            out       a1

endin

instr 2         /* simple bass drum */

  p3        =  p3 + 0.025                         ; extend note length for release
  ibtime    =  60 / gibpm                         ; beat time
  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; base frequency

  kcps      port      icps * 0.75, ibtime * 0.07, icps * 5.3333 ; oscillator
  kcps2     port      1, ibtime * 0.003, 4        ; frequency
  kcps      =  kcps * kcps2                       ; envelope

  a1        phasor    kcps                        ; square oscillator
  a2        phasor    kcps, 0.5
  a1        =  2 * (a2 - a1)

  kffrq     expon     1, ibtime * 0.5, 0.5        ; lowpass filter
  kffrq2    expseg    4, ibtime * 0.01, 2, 1, 2
  a1        pareq     a1, kffrq * kffrq2 * kcps, 0, 0.7071, 2

  a1        pareq     a1, icps, 0, 0.8, 1         ; output highpass

  a2        linseg    0.2, ibtime * 0.05, 1.57, 1, 1.57 ; attack
  a1        =  a1 * sin(a2)
  a2        linseg    1, p3 - 0.025, 1, 0.02, 0, 1, 0 ; release envelope
  a1        =  a1 * (a2 * a2)

            out       a1 * 24000 * iamp

endin

