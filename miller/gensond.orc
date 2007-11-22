;TEST OF GEN 1 CALLING SOUNDIN.5
;4/21/89

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1
;k1            randh     .3,10          ;AMP CONSTITUTES RANGE
  k1        linseg    p5,p3,p6                    ;SPEED OF SOUNDFILE READING
  a1        oscil     p4,k1,1
            out       a1
endin

instr          2
  k1        linseg    p5,p3,p6
  a1        oscil     p4,k1,2
            out       a1
endin
