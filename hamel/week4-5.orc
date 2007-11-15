

; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  ktrem     oscil     .01 * p4, 8, 1              ; tremolo at 8 times per second
  asig      oscil     p4 + ktrem, cpspch(p5), 1   ; audio oscillator
            out       asig
endin

