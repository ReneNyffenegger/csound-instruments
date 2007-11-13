  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   405             
  k1        oscil     5, 1, 1                     ; GENERATE THE VIBRATO IN k-rate!
  a1        oscil     32000, 440+k1, 1            ; USE IT ON AN OSCILATOR
            out       a1                          ; AND PLAY THE RESULT
endin
