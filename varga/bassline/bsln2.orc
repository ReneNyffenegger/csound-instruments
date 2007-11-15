/* bsln2.orc - written by Istvan Varga */
  sr        =  44100
  ksmps     =  1
  nchnls    =  1

instr 1

  p3        =  p3 + 0.15                          ; expand note duration

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; oscillator frequency
  iamp      =  0.0039 + p5 * p5 / 16192           ; amplitude
  ifrq1     =  440 * exp(log(2) * (p6 - 69) / 12) ; filter start freq.
  kamp      linseg    1, p3-0.15, 1, 0.025, 0, 1, 0

  kcps      port      icps, 0.005, icps*0.5
  knumh     =  sr/(3*kcps)

  kffrq     port      0, 0.448, ifrq1

  a1        buzz      sr/(6.6667*3.14159265), kcps, knumh, 1, 0.0
  a1        tone      a1, 10

  a1x       butterbp  a1, kffrq, icps*1.0
  a1y       butterlp  a1, kffrq

  a1        =  (a1x * kffrq/52 + a1y)*iamp

  a1        limit     a1*2, -1, 1

  a1x       butterlp  a1, kffrq*2.0
  a1        =  a1*0.5 + a1x*0.5

  a1        =  a1 * kamp * 24000

            out       a1

endin


