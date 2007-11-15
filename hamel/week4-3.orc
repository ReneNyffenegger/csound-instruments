
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  istart    =  cpspch(p5)                         ; starting pitch
  ifin      =  cpspch(p5 - 1.00)                  ; end pitch octave down
  kgliss    line      istart, p3, ifin            ; line from 1200 to 400
  asig      oscil     p4, kgliss, 1               ; oscillator
            out       asig
endin


