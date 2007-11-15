/* bass_06.orc - written by Istvan Varga, 2002 */

  sr        =  44100
  ksmps     =  10
  nchnls    =  1

  gibpm     =  140.0                              ; tempo

instr 1

  iatt      =  0.002                              ; attack time
  imaxamp   =  1.333                              ; max. amplitude at attack end
  idec      =  0.005                              ; decay time
  irel      =  0.05                               ; release time

  imaxfrq   =  4                                  ; max freq. / base frequency
  ifrqdec   =  0.0025                             ; freq. decay time

; ------------------------------------------------------------

  p3        =  p3 + irel                          ; extend note duration
  imaxamp   =  sqrt(imaxamp)

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; note frequency
  kcps      port      1, ifrqdec, imaxfrq
  kcps      =  kcps * icps                        ; frequency envelope

  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity
  aamp      linseg    0, iatt, imaxamp, idec, 1, p3-(iatt+idec+irel), 1, irel, 0, 1, 0
  aamp      =  iamp * aamp * aamp

  a1        oscili    1, kcps, 1, 0
  a2        phasor    kcps, 0.75

  a2        pareq     a2, kcps * 4.0, 0, 0.7071, 1 ; filters
  kffrq     expon     2093, (60 / gibpm) * 0.5, 1046.5
  a2        pareq     a2, kffrq, 0, 0.7071, 2

  a1        =  aamp * (a1 + a2 * 1.6) * 14000     ; mix and apply envelope

            out       a1

endin

