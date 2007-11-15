; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
  kenv      expon     1, p3, .0001                ; expon envelope
  asig      foscil    p4 * kenv, cpspch(p5), 1, 1.414, 2, 1 ; an fm bell 
  adel1     delay     asig, .2                    ; delay .2 seconds
  adel2     delay     asig, .4                    ; delay .4 seconds
  adel3     delay     asig, .6                    ; delay .6 seconds
  adel4     delay     asig, .8                    ; delay .8 seconds
  adel5     delay     asig, 1.0                   ; delay 1 seconds
  asig      =  asig + adel1*.9 + adel2 * .7 + adel3 * .5 + adel4*.3 + adel5 * .1
            out       asig
endin


