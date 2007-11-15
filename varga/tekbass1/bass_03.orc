/* bass_03.orc - formant filtered bass with bass drum. */
/*               Written by Istvan Varga, 2002         */

  sr        =  44100
  ksmps     =  10
  nchnls    =  1

  gibpm     =  144                                ; tempo

instr 1         /* bass */

  p3        =  p3 + 0.1                           ; extend duration for release

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; note frequency
  iamp      =  0.0039 + p5 * p5 / 16192           ; note amplitude

  aamp      linseg    1, p3 - 0.1, 1, 0.03, 0, 1, 0 ; release envelope

  kcps      =  icps                               ; oscillator frequency

  a1        phasor    kcps                        ; oscillator
  a2        phasor    kcps, 0.5
  a0        =  2 * (0.75 - (a1 + 0.5 * a2))       ; mix and correct DC offset

  atmp      delay1    a0                          ; differentiate signal
  atmp      =  a0 - atmp                          ; (highpass filter)
  atmp      =  atmp * sr / 44100                  ; and correct amp for sample rate

  kffrq1    expon     1, (60 / gibpm) / 4, 0.5    ; filter envelope
  kffrq2    port      1, 0.01, 0.5
  kffrq     =  kffrq1 * kffrq2 * 493.88

; resonant filter bank to simulate formants (bass "a" in this case)
  a1        butterbp  atmp * 200, (kffrq / 261.63) *  600.0,  60.0
  a2        butterbp  atmp *  90, (kffrq / 261.63) * 1040.0,  70.0
  a3        butterbp  atmp *  70, (kffrq / 261.63) * 2250.0, 110.0
  a4        butterbp  atmp *  70, (kffrq / 261.63) * 2450.0, 120.0
  a5        butterbp  atmp *  20, (kffrq / 261.63) * 2750.0, 130.0

  atmp      =  (a1 + a2 + a3 + a4 + a5) * 0.7

  atmp2     =  a0
  a0        pareq     a0 + atmp, kffrq, 0, 0.7071, 2 ; mix osc. output and filter
  a0        mirror    a0 * 3.0, -1, 1             ; add some distortion
  a0        =  a0 + atmp2 * 0.5                   ; mix oscillator output and
  a0        pareq     a0, kffrq * 8.0, 0, 0.7071, 2 ; lowpass again

            out       a0 * aamp * 12500

endin

instr 2         /* bass drum */

  p3        =  p3 + 0.025                         ; extend note length for release
  ibtime    =  60 / gibpm                         ; beat time
  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; base frequency

; oscillator frequency envelope
  kcps      port      icps, ibtime * 0.055, icps * 6

  a1        phasor    kcps                        ; square oscillator
  a2        phasor    kcps, 0.5
  a1        =  2 * (a2 - a1)

  kffrq     expon     1, ibtime * 0.17, 0.5       ; lowpass filter
  a1        pareq     a1, kffrq * 2 * kcps, 0, 0.7071, 2

  a2        linseg    0.12, 0.15 / icps, 1, 1, 1  ; attack
  a1        =  a1 * a2
  a2        =  1                                  ; attack transient
  a3        delay1    a2
  a2        delay     1 - a3, 0.11 / icps
  a2        pareq     a2, 1500, 0, 1.0, 2         ; lowpass filter
  a1        =  a1 - a2 * sqrt(sr) / 30            ; correct amplitude for sample rate

  a1        pareq     a1, icps, 0, 0.7071, 1      ; output highpass

  a2        linseg    1, p3 - 0.025, 1, 0.02, 0, 1, 0 ; release envelope
  a1        =  a1 * (a2 * a2)

            out       a1 * 22000 * iamp

endin

