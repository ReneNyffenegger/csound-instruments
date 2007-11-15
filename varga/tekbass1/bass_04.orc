/* bass_04.orc - sawtooth with resonant filter and distortion */
/*               Written by Istvan Varga, 2002                */

  sr        =  44100
  ksmps     =  10
  nchnls    =  1

; sawtooth wave
  itmp      ftgen     1, 0, 3, 2, 1, 0, -1

instr 1

  p3        =  p3 + 0.1                           ; extend duration for release

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; note frequency
  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity
  aenv      linseg    1, p3 - 0.1, 1, 0.05, 0, 1, 0 ; release envelope

  ifn       =  1                                  ; oscillator
  a1        oscili    iamp * 2, icps, ifn

  k1        expon     8, 0.12, 4                  ; filter frequency envelope
  kffrq     =  k1 * icps

  a1        butterbp  a1, icps * 2, icps * 4      ; bandpass
  a1        pareq     a1, kffrq, 0, k1 * 0.5, 2   ; resonant lowpass

  a1        =  taninv(a1 * abs(a1))               ; distortion
  a1        pareq     a1, icps, 0, 1.0, 1         ; resonant highpass
  a1        =  a1 * (aenv * aenv)                 ; apply release envelope

            out       a1 * 20000                  ; scale and output

endin

