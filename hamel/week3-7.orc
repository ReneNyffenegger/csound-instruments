; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0

instr 1

  kenv      line      1, p3, 0                    ; envelope - ramp from 1 to 0
  asig      oscil     p4 * kenv, cpspch(p5), 1    ; audio oscilator
            out       asig 
endin


