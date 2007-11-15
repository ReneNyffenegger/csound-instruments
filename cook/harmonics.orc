  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Harmonic sweep generator.

  ilevl     =  p4*32768                           ; Output level
  ipitch    =  cpspch(p5)                         ; Pitch
  itabl1    =  p6                                 ; Start harmonic
  itabl2    =  p7                                 ; End harmonic
  idet      =  p8                                 ; Detune

  k1        line      1, p3, 0
  a1        oscili    .5, ipitch + idet, 50, -1
  a2        tablei    a1, itabl1, 1, .5
  a3        tablei    a1, itabl2, 1, .5
  aout      =  a2*k1 + a3*(1 - k1)
            out       aout*ilevl

endin
