; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  ivar      =  10000                              ; ivar set to 10000
  k5        linseg    0, .25, 1, .25, .3, .5, .7, .5, .2, .75, .9, .75, .1 ; a complex linseg (3 sec.)
  k5        =  k5 * ivar                          ; scale the amplitude of the envelope
  asig      oscil     k5, cpspch(p5), 1           ; sine wave oscilator
            out       asig                        ; mono output 
endin

