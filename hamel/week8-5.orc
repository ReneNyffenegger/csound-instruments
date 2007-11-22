; ORQUESTRA FILE
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  asig      oscil     p4, cpspch(p5), 1           ; oscillator
  asig      envlpx    asig, .05, p3, .1, 2, .8, .01 ;function 2
            out       asig
endin

