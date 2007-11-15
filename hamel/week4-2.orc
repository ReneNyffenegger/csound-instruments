
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
  kgliss    line      1200, p3, 400               ; line from 1200 to 400 
  asig      oscil     p4, kgliss, 1               ; oscillator
            out       asig                        
endin


