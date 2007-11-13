  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   412                             
  k1        line      .5, p3, 1                   ; GENERATE AN ENVELOPE
  a1        oscil     32000, 440/k1, 1            ; APPLY IT ON AN OSCILATOR
            out       a1                          ; AND PLAY THE RESULT
endin
