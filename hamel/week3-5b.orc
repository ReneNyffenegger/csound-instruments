; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
  ivar      =  10000                              ; ivar set to 10000
  k2        expon     1, p3, .0001                ; moves exponentially from 1 to (almost 0) in p3
  k2        =  k2 * ivar                          ; scale the amplitude of the envelope
  asig      oscil     k2, cpspch(p5), 1           ; sine wave oscilator
            out       asig                        ; mono output 
endin


