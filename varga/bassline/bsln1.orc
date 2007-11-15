  sr        =  44100
  ksmps     =  2
  nchnls    =  1

instr 1

  p3        =  p3 + 0.15                          ; expand note duration

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; oscillator frequency
  iamp      =  0.0039 + p5 * p5 / 16192           ; amplitude
  ifrq1     =  440 * exp(log(2) * (p6 - 69) / 12) ; filter start freq.

  kamp      linseg    1, p3-0.15, 1, 0.025, 0, 1, 0 ; release envelope

  kcps      port      icps, 0.005, icps*0.5       ; osc. frequency
  knumh     =  sr/(2*kcps)

  kffrq     port      0, 60/150, ifrq1            ; filter frequency

  a1        phasor    kcps                        ; oscillator
  a1        =  1 - 2 * a1

  a1x       butterbp  a1, kffrq, icps * 1.0       ; filters
  a1x       =  a1x * (2 + kffrq / kcps)           ; correct amplitude
  a1        =  a1x + a1 * (p7 < 0.5 ? 0.5 : 0.25)
  a1        butterlp  a1, kffrq

  a1        =  taninv(a1 * (p7 < 0.5 ? 2.5 : 4.0) * iamp) ; distortion

if (p7 < 0.5) goto l1                             ; skip EQ if disabled

  keqf      limit     kffrq * 4, 10, sr * 0.48    ; EQ frequency
  a1        pareq     a1 * 0.4, keqf, 4.0, 1.0, 2

;klpf   limit kffrq * 12, 10, sr * 0.48 ; output lowpass frequency
;a1     butterlp a1, klpf

l1:
  a1        =  a1 * kamp * 20000

            out       a1

endin

