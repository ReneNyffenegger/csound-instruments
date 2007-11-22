; TRIADS.ORC BY MARK DAL PORTO

; TRIAD COMPARISON ORCHESTRA USING DIFFERENT TUNINGS
; TUNINGS USED:  EQUAL, MEANTONE (QUARTER-COMMA), JUST, AND PYTHAGORAN

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1
  kenv      linen     10000, .05, p3, .1          ; SIMPLE ENVELOPE FOR EACH NOTE
  asig      oscili    kenv, p4, 1                 ; P4=FREQUENCY
            out       asig
endin                                             ; END OF INSTRUMENT AND ORCHESTRA
