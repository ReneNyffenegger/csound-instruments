instr   1106    ; PULSE TRAIN W/ AMP ENV.
  iinh      =  int(sr/2/p5)                       ; MAXIMUM NUMBER OF HARMONICS
  kenv      linen     p4, p6, p3, p7              ; ENVELOPE
  asig      buzz      kenv, p5, iinh, 1           ; OSCILLATOR
            out       asig                        ; OUTPUT
endin
