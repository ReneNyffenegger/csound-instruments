sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
                    
          instr     202
kenv      linseg    0, .05, p4, p3-.1, p4*.8, .05, 0   ; ENVELOPE
aphase    phasor    p5                                 ; PHASES 0-1 p5 TIMES/SECOND
ilength   =         ftlen(p6)                          ; DETERMINE LENGTH OF f-TABLE
aphase    =         aphase*ilength                     ; STEP THROUGH ENTIRE TABLE
asig      tablei    aphase, p6                         ; READ TABLE NUMBER FROM p6
          out       asig*kenv                          ; IMPOSE ENVELOPE
          endin
